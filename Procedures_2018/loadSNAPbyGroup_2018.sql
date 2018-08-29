CREATE DEFINER=`asharma`@`%` PROCEDURE `loadSNAPbyGroup_2018`(
	IN `date_range` INT,
	IN `SNAP_client` VARCHAR(50)































)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN

DECLARE col INT;
DECLARE mcol INT;

SET @dvEvent = 'TRUNCATE `event_latest_2018`';

select date_range,SNAP_client;

SET @cvEvemt = "Insert into AetnaPrint_2018.event_latest_2018  SELECT
`d`.`id` AS `id`,
str_to_date(concat(`d`.`Event_Date`, ' ', `d`.`Event_Time`),
'%Y-%m-%d %h:%i %p') AS `Event_DateTime`,
`d`.`SSM_Seminar_Nbr` AS `Seminar_Number`,
`d`.`Event_Date` AS `Event_Date`,
trim(leading '0' from `d`.`Event_Time`) AS `Event_Time`,
`d`.`Event_Type` AS `Event_Type`,
`d`.`Lead_Brand` AS `Lead_Brand`,
`d`.`Market` AS `Market`,
`d`.`Presentation_Language` AS `Presentation_Language`,
`d`.`Region` AS `Region`,
`d`.`Venue_Address1` AS `Venue_Address1`,
`d`.`Venue_Address2` AS `Venue_Address2`,
`d`.`Venue_City` AS `Venue_City`,
`d`.`Venue_County` AS `Venue_County`,
`d`.`Venue_Name` AS `Venue_Name`,
`d`.`Venue_State` AS `Venue_State`

from
`aetna_print_events_2018` `d`

where

((`d`.`Event_Type` = 'Formal')
and (`d`.`Event_Date` >= '2018-10-01')
and (`d`.`Lead_Brand` = '";
SET @cvEvemt = concat(@cvEvemt, SNAP_client);
SET @cvEvemt = concat(@cvEvemt, "')
and (lcase(`d`.`Presentation_Language`) = 'english'))");

PREPARE dstmt FROM @dvEvent;
EXECUTE dstmt;
PREPARE cvstmt FROM @cvEvemt;
EXECUTE cvstmt;

SET @dv = 'DROP VIEW IF EXISTS AetnaPrint_2018.`Report_in_publication`';
SET @str =  "CREATE VIEW AetnaPrint_2018.`Report_in_publication` as SELECT
r.pid AS `pid`,
e.Region AS `Region`,
e.Lead_Brand as `Lead_Brand`,
group_concat(distinct(e.`Market`)) as `Market`,
`p`.`PublicationName`    AS `Publication`,
date_format(`r`.`date`,'%m/%e/%Y')    AS `Insertion date`,
`p`.`MaterialDeadline` AS `Material Deadline Range`,
date_format(`d`.`Material_Deadline`, '%m/%e, %l:%i %p') AS `Material Deadline`, 
GROUP_CONCAT(`e`.`id` SEPARATOR ';') AS `eid`,
COUNT(*) AS `Total Event`,
SUBSTRING_INDEX(GROUP_CONCAT(concat(`e`.`detail`, '\n', e.`Group_Date`, ', ', e.`Event_Time`) SEPARATOR ';'), ';', 1) AS `Meeting Priority 1`,
"; 



-- update the top 3 ranking for publication in same State and same county
CALL `UpdatePublicationRanking`;

/*
--------REFRESH DAY1,2,3,4 TABLE--------------
--------Reload data from multiple event-------
*/
-- update multupleevent table
call `SNAPUpdateMultipleEvent`(date_range);


TRUNCATE `event_by_day_group_2018`;
INSERT INTO `event_by_day_group_2018`
select `m`.`id` AS `id`,
`d1`.`Event_Date` AS `Event_Date`,
str_to_date(concat(`d1`.`Event_Date`,' ',`d1`.`Event_Time`),'%Y-%m-%d %h:%i %p') AS `Event_DateTime`,
`d1`.`Venue_County` AS `Venue_County`,
`d`.`Lead_Brand` AS `Lead_Brand`,
`d1`.`Seminar_Number` AS `Seminar_Number`,
`d1`.`Venue_State` AS `Venue_State`,
group_concat(distinct `d1`.`Event_Time` order by str_to_date(`d1`.`Event_Time`,'%h:%i %p') ASC separator ' & ') AS `Event_Time`,
group_concat(distinct if((`d1`.`Region` = ''),NULL,`d1`.`Region`) separator ',') AS `Region`,
group_concat(distinct if((`d`.`Market` = ''),NULL,`d`.`Market`) separator ',') AS `Market`,
(`d1`.`Event_Date` - interval 10 day) AS `day1`,
dayname((`d1`.`Event_Date` - interval 10 day)) AS `day1_weekday`,
(`d1`.`Event_Date` - interval 5 day) AS `day2`,
dayname((`d1`.`Event_Date` - interval 5 day)) AS `day2_weekday`,
`d1`.`Event_Date` AS `day3`,
dayname(`d1`.`Event_Date`) AS `day3_weekday`,
if((dayofweek(`d1`.`Event_Date`) = 1),`d1`.`Event_Date`,NULL) AS `day4`,
concat_ws('\n',`d1`.`Venue_City`,`d1`.`Venue_Name`,`d1`.`Venue_Address1`) AS `detail`,
group_concat(distinct `d`.`Event_Date` separator ',') AS `Group_Date`,
`d`.`Presentation_Language` AS `Presentation_Language` 
from ((`multipleEvent_2018` `m` left join `event_latest_2018` `d` on((`m`.`geid` = `d`.`id`))) 
left join `event_latest_2018` `d1` on((`m`.`eid` = `d1`.`id`))) 
where (`d`.`id` is not null) 
group by `m`.`id`;



TRUNCATE `event_day1_2018`;
INSERT INTO `event_day1_2018`
SELECT
  '' AS `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`pid`              AS `pid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  ''    AS `newpaper_date`,
  `d`.`Newspaper_Name`   AS `Newspaper_Name`,
  `d`.`day1_weekday`     AS `ad_date_weekday`,
  '' AS `newpaper_weekday`
FROM `qa1_2018_FSI` `d`
GROUP BY `d`.`eid`,`d`.`pid`,`d`.`ad_date`;

TRUNCATE `event_day2_2018`;
INSERT INTO `event_day2_2018`
SELECT
  '' AS `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`pid`              AS `pid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  ''    AS `newpaper_date`,
  `d`.`Newspaper_Name`   AS `Newspaper_Name`,
  `d`.`day2_weekday`     AS `ad_date_weekday`,
  '' AS `newpaper_weekday`
FROM `qa2_2018_FSI` `d`
GROUP BY `d`.`pid`,`d`.`eid`,`d`.`ad_date`;

TRUNCATE `event_day3_2018`;
INSERT INTO `event_day3_2018`
SELECT
'' `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`pid`              AS `pid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  ''    AS `newpaper_date`,
  `d`.`Newspaper_Name`   AS `Newspaper_Name`,
  `d`.`day3_weekday`     AS `ad_date_weekday`,
  '' AS `newpaper_weekday`
FROM `qa3_2018_FSI` `d`
GROUP BY `d`.`eid`,`d`.`pid`,`d`.`ad_date`;

TRUNCATE `event_day4_2018`;
INSERT INTO `event_day4_2018`
SELECT
  '' AS `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`pid`              AS `pid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  ''    AS `newpaper_date`,
  `d`.`Newspaper_Name`   AS `Newspaper_Name`,
  `d`.`day4_weekday`     AS `ad_date_weekday`,
  '' AS `newpaper_weekday`
FROM `qa4_2018_FSI` d;


-- REFRESH REPORT TABLE

TRUNCATE `report_by_id_2018`;

-- day 1
INSERT INTO `report_by_id_2018`
SELECT 
`pid`,
`eid`,
`insertion_date`,
1
from event_day1_2018;

-- day 2
INSERT INTO `report_by_id_2018`
SELECT 
`pid`,
`eid`,
`insertion_date`,
2
from event_day2_2018;

-- day 3
INSERT INTO `report_by_id_2018`
SELECT 
`pid`,
`eid`,
`insertion_date`,
3
from event_day3_2018;

-- day 4
INSERT INTO `report_by_id_2018`
SELECT 
`pid`,
`eid`,
`insertion_date`,
4
from event_day4_2018;


    
-- using unqiue publication for same city, state, county
-- call `SNAPUniqueReport_2018`;
TRUNCATE  `report_by_id_unique_2018`;
INSERT INTO `report_by_id_unique_2018`
SELECT * FROM `report_by_id_2018`;


-- using one promotion logic
truncate `report_by_id_onepromotion_2018`;
INSERT INTO `report_by_id_onepromotion_2018`
SELECT 
r.`pid`,
r.`eid`,
CASE
	WHEN DAYOFWEEK(r.`Promotion 2`) = 1
	THEN r.`Promotion 2`
	WHEN DAYOFWEEK(r.`Promotion 1`) = 1
	THEN r.`Promotion 1`
	WHEN DAYOFWEEK(r.`Promotion 3`) = 1
	THEN r.`Promotion 3` 
	WHEN DAYOFWEEK(r.`Promotion 2`) = 4
	THEN r.`Promotion 2`
	WHEN DAYOFWEEK(r.`Promotion 1`) = 4
	THEN r.`Promotion 1`
	WHEN DAYOFWEEK(r.`Promotion 3`) = 4
	THEN r.`Promotion 3`
	WHEN r.`Promotion 2` IS NOT NULL
	THEN r.`Promotion 2`
	WHEN r.`Promotion 1` IS NOT NULL
	THEN r.`Promotion 1`
	WHEN r.`Promotion 3` IS NOT NULL
	THEN r.`Promotion 3`
 END   AS `date`  ,
 NULL
FROM `Report_in_event_2018` r;

-- fetch 1 block report 
CALL `SNAPClean1DayBlock_2018`;


/*
-----------UPDATE REPORT QUERY------------
*/

set mcol :=  (SELECT COUNT(*)  
	FROM `AetnaPrint_2018`.`report_by_id_onepromotion_2018` `r` 
	GROUP BY `r`.`date`,`r`.`pid`
	ORDER BY COUNT(*) DESC LIMIT 1) ;
set col := 1;
-- START LOOP 
WHILE col  < mcol DO
	SET  @str = CONCAT(@str,"  IF(LENGTH(SUBSTRING_INDEX(GROUP_CONCAT(`e`.`detail`  SEPARATOR ';'), ';', "
	,col,")) -  LENGTH(GROUP_CONCAT(`e`.`detail`  SEPARATOR ';')) != 0 ,
	SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(concat(`e`.`detail`, '\n', e.`Group_Date`, ', ', e.`Event_Time`)  SEPARATOR ';'), ';', ",col+1,"), ';' , -1),'') AS `Meeting Priority "
	,col+1,"`,
	");
	SET  col = col + 1; 
END WHILE;

set @str = concat(@str," date_format(`d`.`Space_Deadline`, '%m/%e, %l:%i %p') AS `Space Deadline`,
'' as `Newspaper Specs`,
'' as `Insertion Format`,
'' as `Insertion Cost`,
'' as `Benefit Bullets`,
'' as `Product Creative/NVN Co-brand`,
'' as `TFNs`,
'' as `Meeting/Non-Meeting`
FROM (((`AetnaPrint_2018`.`report_by_id_onepromotion_2018` `r`
LEFT JOIN `AetnaPrint_2018`.`aetna_print_publication_2018` `p`
ON ((`r`.`pid` = `p`.`id`)))
LEFT JOIN `AetnaPrint_2018`.`event_by_day_2018` `e`
ON ((`r`.`sfid` = `e`.`id`)))
LEFT JOIN `AetnaPrint_2018`.`publication_by_day_2018` `d`
ON (((`d`.`pid` = `r`.`pid`)
AND (`d`.`date` = `r`.`date`))))
GROUP BY `r`.`date`,`r`.`pid`
ORDER BY e.`Region`, e.`Market`, p.`DominantCounty`, `p`.`Rank`, `r`.`date` ");
/*
set @str = concat(@str,"  '' AS `Newspaper Specs` ,
'' AS `Insertion_Format`,
'' AS `Insertion_Cost`,
'' AS `Benefit_Bullets 1`,
'' AS `Benefit_Bullets 2`,
'' AS `Benefit_Bullets 3`,
'' AS `Benefit_Bullets 4`,
'' AS `Benefit_Bullets 5`, 
'' AS `Product_Creative_NVN_Co-brand`,
'' AS `TFNs`,
'' AS `Meeting_Non-Meeting`
FROM (((`Aetna`.`report_by_id_2017` `r`
LEFT JOIN `Aetna`.`aetna_print_publication` `p`
ON ((`r`.`pid` = `p`.`id`)))
LEFT JOIN `Aetna`.`event_by_day_2017` `e`
ON ((`r`.`sfid` = `e`.`id`)))
LEFT JOIN `Aetna`.`publication_by_day` `d`
ON (((`d`.`pid` = `r`.`pid`)
AND (`d`.`date` = `r`.`date`))))
GROUP BY `r`.`date`,`r`.`pid`
ORDER BY `r`.`pid`");
*/
-- SELECT str;
-- select @sql;
PREPARE dstmt FROM @dv;
EXECUTE dstmt; 
PREPARE cvstmt FROM @str;
EXECUTE cvstmt;


END