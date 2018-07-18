CREATE DEFINER=`root`@`%` PROCEDURE `SNAPReportGrouping`(in date_range int(5))
BEGIN 

DECLARE col  INT;
DECLARE mcol INT; 
SET @dv = 'DROP VIEW IF EXISTS Aetna.`Report_in_publication_GroupAfter`';
SET @str =  "CREATE VIEW Aetna.`Report_in_publication_GroupAfter` as SELECT
	`r`.`pid`               AS `pid`,
	e.`Region` AS `Region`,
	`p`.`Newspaper_Name`    AS `Publication`,
	date_format(`r`.`date`,'%m/%e/%Y')    AS `Insertion date`,
	`p`.`Material_Deadline` AS `Material Deadline Range`,
	date_format(`d`.`Material_Deadline`, '%m/%e, %l:%i %p') AS `Material Deadline`, 
	GROUP_CONCAT(`e`.`id` SEPARATOR ';') AS `eid`,
	COUNT(*) AS `Total Event`,
	SUBSTRING_INDEX(GROUP_CONCAT(CONCAT_WS('\n', `e`.`detail`, CONCAT(r.`gdate`,', ',r.`gtime`)) SEPARATOR ';'), ';', 1) AS `Meeting Priority 1`,
	"; 

TRUNCATE `report_by_id_group`;

-- add same time same address different date 
INSERT INTO `report_by_id_group`
SELECT
r.`pid`,
r.`id`,
r.`insertion_date`, 
CONCAT_WS(',',r.`id`, GROUP_CONCAT(e.`id` ORDER BY e.`Event_Date` SEPARATOR ',')) AS `Group_Event`, 
CONCAT_WS(', ', date_format(r.`Event_Date`,'%m/%e'), GROUP_CONCAT(date_format(e.`Event_Date`,'%m/%e') ORDER BY e.`Event_Date` SEPARATOR ', ' )) AS `Group_Date`,
e.`Event_Time`
FROM `distinct_report` r , `distinct_report` e
WHERE r.`insertion_date` = e.`insertion_date` AND e.`Venue_Address1` = r.`Venue_Address1`
AND e.`Event_Time` = r.`Event_Time`  AND e.`pid` = r.`pid`
AND  e.`Event_Date` BETWEEN (r.`Event_Date` + INTERVAL 1 DAY) AND (r.`Event_Date` + INTERVAL date_range DAY)  
GROUP BY r.`insertion_date`, e.`Venue_Address1`, e.`Event_Time`, r.`pid`, r.`id`;

-- add same date same address different time 
INSERT INTO `report_by_id_group`
SELECT
r.`pid`,
r.`id`,
r.`insertion_date`,  
GROUP_CONCAT(r.`id` ORDER BY `Event_DateTime` ),
date_format(r.`Event_Date`,'%m/%e'), 
GROUP_CONCAT(r.`Event_Time` ORDER BY `Event_DateTime` SEPARATOR ' & ' )
FROM `distinct_report` r
GROUP BY r.`Venue_Address1`,r.`Venue_State`, r.`insertion_date`, r.`Event_Date`, r.`pid` HAVING COUNT(*) > 1 ;


-- add the others
INSERT INTO `report_by_id_group`

SELECT 
d.`pid`, d.`sfid`, d.`date`, d.`sfid`, date_format(`event_latest`.`Event_Date`,'%m/%e'), `event_latest`.`Event_Time` FROM `report_by_id_unique` d
LEFT JOIN `event_latest`
ON d.`sfid` = `event_latest`.`id`
WHERE (d.`pid`, d.`sfid`, d.`date` )
NOT IN 
(
(SELECT
r.`pid`,
r.`id`,
r.`insertion_date` 
FROM `distinct_report` r 
LEFT JOIN `distinct_report` e
ON r.`insertion_date`  = e.`insertion_date` AND e.`Venue_Address1` = r.`Venue_Address1`
AND e.`Event_Time` = r.`Event_Time`  AND e.`pid` = r.`pid`
AND  e.`Event_Date` BETWEEN (r.`Event_Date` + INTERVAL 1 DAY) AND (r.`Event_Date` + INTERVAL date_range DAY)  
WHERE e.`id` IS  NOT NULL
GROUP BY r.`pid`,
r.`id`,
r.`insertion_date` ))
AND (d.`pid`, d.`sfid`, d.`date` ) NOT IN (
(SELECT
r1.`pid`, 
e1.`id`,
r1.`insertion_date` 
FROM `distinct_report` r1 
LEFT JOIN `distinct_report` e1
ON r1.`insertion_date`  = e1.`insertion_date` AND e1.`Venue_Address1` = r1.`Venue_Address1`
AND e1.`Event_Time` = r1.`Event_Time`  AND e1.`pid` = r1.`pid`
AND  e1.`Event_Date` BETWEEN (r1.`Event_Date` + INTERVAL 1 DAY) AND (r1.`Event_Date` + INTERVAL date_range DAY)  
WHERE e1.`id` IS  NOT NULL ))
AND (d.`pid`, d.`sfid`, d.`date` ) NOT IN
(
SELECT
r1.`pid`, 
r1.`id`,
r1.`insertion_date` 
FROM `distinct_report` r1 ,
(
SELECT r.`Venue_Address1`,r.`Venue_State`, r.`insertion_date`, r.`Event_Date`, r.`pid`
FROM `distinct_report` r
GROUP BY r.`Venue_Address1`,r.`Venue_State`, r.`insertion_date`, r.`Event_Date`, r.`pid` HAVING COUNT(*) > 1 
) d
WHERE r1.`Venue_Address1` =  d.`Venue_Address1`
AND r1.`Venue_State` = d.`Venue_State`
AND r1.`insertion_date` = d.`insertion_date`
AND r1.`Event_Date` =d.`Event_Date`
AND r1.`pid` =  d.`pid`)
GROUP BY d.`date` , d.`pid`, d.`sfid`;


set mcol :=  (select COUNT(*)  
	FROM (((`Aetna`.`report_by_id_group` `r`
	LEFT JOIN `Aetna`.`aetna_print_publication` `p`
	ON ((`r`.`pid` = `p`.`id`)))
	LEFT JOIN `Aetna`.`event_by_day` `e`
	ON ((`r`.`eid` = `e`.`id`)))
	LEFT JOIN `Aetna`.`publication_by_day` `d`
	ON (((`d`.`pid` = `r`.`pid`)
	AND (`d`.`date` = `r`.`date`))))
	GROUP BY `r`.`date`,`r`.`pid`
	ORDER BY COUNT(*) DESC LIMIT 1) ;
set col := 1;
-- START LOOP 
WHILE col  < mcol DO
	SET  @str = CONCAT(@str,"  IF(LENGTH(SUBSTRING_INDEX(GROUP_CONCAT(`e`.`detail`  SEPARATOR ';'), ';', "
	,col,")) -  LENGTH(GROUP_CONCAT(`e`.`detail`  SEPARATOR ';')) != 0 ,
	SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(CONCAT_WS('\n', `e`.`detail`, CONCAT(r.`gdate`,', ',r.`gtime`))  SEPARATOR ';'), ';', ",col+1,"), ';' , -1),'') AS `Meeting Priority "
	,col+1,"`,
	");
	SET  col = col + 1; 
END WHILE;

set @str = concat(@str," date_format(`d`.`Space_Deadline`, '%m/%e, %l:%i %p') AS `Space Deadline`,
null as `Newspaper Specs`,
null as `Insertion Format`,
null as `Insertion Cost`,
null as `Benefit Bullets`,
null as `Product Creative/NVN Co-brand`,
null as `TFNs`,
null as `Meeting/Non-Meeting`
FROM (((`Aetna`.`report_by_id_group` `r`
LEFT JOIN `Aetna`.`aetna_print_publication` `p`
ON ((`r`.`pid` = `p`.`id`)))
LEFT JOIN `Aetna`.`event_by_day` `e`
ON ((`r`.`eid` = `e`.`id`)))
LEFT JOIN `Aetna`.`publication_by_day` `d`
ON (((`d`.`pid` = `r`.`pid`)
AND (`d`.`date` = `r`.`date`))))
GROUP BY `r`.`date`,`r`.`pid`
ORDER BY `r`.`pid`");

PREPARE dstmt FROM @dv;
EXECUTE dstmt; 
PREPARE cvstmt FROM @str;
EXECUTE cvstmt;

END