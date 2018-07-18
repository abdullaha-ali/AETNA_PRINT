CREATE DEFINER=`root`@`%` PROCEDURE `loadSNAPbygroup_2017_FSI`(
	IN `date_range` INT,
	IN `SNAP_client` VARCHAR(50)


























)
BEGIN
DECLARE col INT;

DECLARE mcol INT;

SET @dvEvent = 'DROP VIEW IF EXISTS Aetna_2017_new.`event_latest_2017`';

select date_range,SNAP_client;

SET @cvEvemt = "CREATE VIEW Aetna_2017_new.`event_latest_2017` as SELECT

`d`.`id` AS `id`,

str_to_date(concat(`d`.`Event_Date`, ' ', `d`.`Event_Time`),

'%Y-%m-%d %h:%i %p') AS `Event_DateTime`,

`d`.`Seminar_Submission_Management_ID` AS `Seminar_Submission_Management_ID`,

`d`.`Seminar_Number` AS `Seminar_Number`,

`d`.`Advertised_Event` AS `Advertised_Event`,

`d`.`Agent_National_Producers_Number` AS `Agent_National_Producers_Number`,

`d`.`Agent_Type` AS `Agent_Type`,

`d`.`Brokerage_Firm_Agency` AS `Brokerage_Firm_Agency`,

`d`.`Cancel_Event` AS `Cancel_Event`,

`d`.`Cancel_Reason` AS `Cancel_Reason`,

`d`.`Contact_Phone` AS `Contact_Phone`,

`d`.`Contract_Number` AS `Contract_Number`,

`d`.`Date_Cancelled` AS `Date_Cancelled`,

`d`.`Date_Reviewed` AS `Date_Reviewed`,

`d`.`DupeKey` AS `DupeKey`,

`d`.`Event_Contact` AS `Event_Contact`,

`d`.`Event_Date` AS `Event_Date`,

`d`.`Event_Name` AS `Event_Name`,

`d`.`Event_Time` AS `Event_Time`,

`d`.`Event_Type` AS `Event_Type`,

`d`.`Facility_Type` AS `Facility_Type`,

`d`.`Facility_Type_if_Other` AS `Facility_Type_if_Other`,

`d`.`Handicap_Accessible` AS `Handicap_Accessible`,

`d`.`IsFuture` AS `IsFuture`,

`d`.`Lead_Brand` AS `Lead_Brand`,

`d`.`Market` AS `Market`,

`d`.`MCE_ID` AS `MCE_ID`,

`d`.`Presentation_Language` AS `Presentation_Language`,

`d`.`Presentation_Language_if_Other` AS `Presentation_Language_if_Other`,

`d`.`Region` AS `Region`,

`d`.`Room_Capacity` AS `Room_Capacity`,

`d`.`Seat_RSVP` AS `Seat_RSVP`,

`d`.`Seats_Available` AS `Seats_Available`,

`d`.`Seminar_Agent_Name` AS `Seminar_Agent_Name`,

`d`.`Target_Audience` AS `Target_Audience`,

`d`.`Territory` AS `Territory`,

`d`.`Venue_Address1` AS `Venue_Address1`,

`d`.`Venue_Address2` AS `Venue_Address2`,

`d`.`Venue_Capacity` AS `Venue_Capacity`,

`d`.`Venue_City` AS `Venue_City`,

`d`.`Venue_County` AS `Venue_County`,

`d`.`Venue_Name` AS `Venue_Name`,

`d`.`Venue_Phone` AS `Venue_Phone`,

`d`.`Venue_State` AS `Venue_State`,

`d`.`Venue_Zip_Code` AS `Venue_Zip_Code`

from

`aetna_print_events2_2017` `d`

where

((`d`.`Event_Type` = 'Formal')

and (`d`.`Cancel_Event` = 0)

and (`d`.`Target_Audience` = 'Prospect')

and (`d`.`Event_Date` >= '2017-01-01')

and (`d`.`Lead_Brand` = '";

SET @cvEvemt = concat(@cvEvemt, SNAP_client);

SET @cvEvemt = concat(@cvEvemt, "')

and (lcase(`d`.`Presentation_Language`) = 'English')

and (`d`.`Advertised_Event` = 1))");

PREPARE dstmt FROM @dvEvent;

EXECUTE dstmt;

PREPARE cvstmt FROM @cvEvemt;

EXECUTE cvstmt;

SET @dv = 'DROP VIEW IF EXISTS Aetna_2017_new.`Report_in_publication`';
SET @str =  "CREATE VIEW Aetna_2017_new.`Report_in_publication` as SELECT
	`r`.`pid`               AS `pid`,
	e.`Region` AS `Region`,
	e.`Lead_Brand` as `Lead_Brand`,
	group_concat(distinct(e.`Market`)) as `Market`,
	`p`.`Newspaper_Name`    AS `Publication`,
	date_format(`r`.`date`,'%m/%e/%Y')    AS `Insertion date`,
	`p`.`Material_Deadline` AS `Material Deadline Range`,
	date_format(`d`.`Material_Deadline`, '%m/%e, %l:%i %p') AS `Material Deadline`, 
	GROUP_CONCAT(`e`.`id` SEPARATOR ';') AS `eid`,
	COUNT(*) AS `Total Event`,
	SUBSTRING_INDEX(GROUP_CONCAT(concat(`e`.`detail`, '\n', e.`Group_Date`, ', ', e.`Event_Time`) SEPARATOR ';'), ';', 1) AS `Meeting Priority 1`,
	"; 

-- update at 8/28/2015



-- update the top 3 ranking for publication in same State and same county
CALL `updatePublicationRanking_2017`;

/*
--------REFRESH DAY1,2,3,4 TABLE--------------
--------Reload data from multiple event-------
*/
-- update multupleevent table
call SNAPUpdateMultipleEvent_2017(date_range);

-- truncate `event_by_day_2017`;
-- insert into `event_by_day_2017`
-- select * from `event_by_day_group_FSI`;

TRUNCATE `event_day1_2017_FSI`;
INSERT INTO `event_day1_2017_FSI`
SELECT
  MIN(`d`.`newpaper_date`) AS `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`pid`              AS `pid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  `d`.`newpaper_date`    AS `newpaper_date`,
  `d`.`Newspaper_Name`   AS `Newspaper_Name`,
  `d`.`day1_weekday`     AS `ad_date_weekday`,
  `d`.`newpaper_weekday` AS `newpaper_weekday`
FROM `qa1_FSI` `d`
GROUP BY `d`.`eid`,`d`.`pid`,`d`.`ad_date`;
TRUNCATE `event_day2_2017_FSI`;
INSERT INTO `event_day2_2017_FSI`
SELECT
  IF((GROUP_CONCAT(`d`.`newpaper_date` SEPARATOR ',') LIKE CONCAT('%',(CAST(`d`.`Event_Date` AS DATE) - INTERVAL (DAYOFWEEK(`d`.`Event_Date`) - 1) DAY),'%')),(CAST(`d`.`Event_Date` AS DATE) - INTERVAL (DAYOFWEEK(`d`.`Event_Date`) - 1) DAY),IF((GROUP_CONCAT(`d`.`newpaper_date` SEPARATOR ',') LIKE CONCAT('%',`d`.`ad_date`,'%')),`d`.`ad_date`,IF((GROUP_CONCAT(`d`.`newpaper_date` SEPARATOR ',') LIKE CONCAT('%',(`d`.`ad_date` + INTERVAL 1 DAY),'%')),(`d`.`ad_date` + INTERVAL 1 DAY),`d`.`newpaper_date`))) AS `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`pid`              AS `pid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  `d`.`newpaper_date`    AS `newpaper_date`,
  `d`.`Newspaper_Name`   AS `Newspaper_Name`,
  `d`.`day2_weekday`     AS `ad_date_weekday`,
  `d`.`newpaper_weekday` AS `newpaper_weekday`
FROM `qa2_FSI` `d`
GROUP BY `d`.`pid`,`d`.`eid`,`d`.`ad_date`;
TRUNCATE `event_day3_2017_FSI`;
INSERT INTO `event_day3_2017_FSI`
SELECT
CASE 
	WHEN COUNT(*) = 1 THEN `newpaper_date`
	WHEN GROUP_CONCAT(`d`.`newpaper_date` SEPARATOR ',') LIKE CONCAT('%',(CAST(`d`.`Event_Date` AS DATE) - INTERVAL (DAYOFWEEK(`d`.`Event_Date`) - 1) DAY),'%')
	THEN (CAST(`d`.`Event_Date` AS DATE) - INTERVAL (DAYOFWEEK(`d`.`Event_Date`) - 1) DAY)
	WHEN GROUP_CONCAT(`d`.`newpaper_date` SEPARATOR ',') LIKE CONCAT('%',(CAST(`d`.`Event_Date` AS DATE) - INTERVAL 1 DAY),'%')
	THEN (CAST(`d`.`Event_Date` AS DATE) - INTERVAL 1 DAY)
	WHEN GROUP_CONCAT(`d`.`newpaper_date` SEPARATOR ',') LIKE CONCAT('%',(CAST(`d`.`Event_Date` AS DATE) - INTERVAL 2 DAY),'%')
	THEN (CAST(`d`.`Event_Date` AS DATE) - INTERVAL 2 DAY)
	WHEN GROUP_CONCAT(`d`.`newpaper_date` SEPARATOR ',') LIKE CONCAT('%',(CAST(`d`.`Event_Date` AS DATE) - INTERVAL 3 DAY),'%')
	THEN (CAST(`d`.`Event_Date` AS DATE) - INTERVAL 3 DAY)
	ELSE MAX(`d`.`newpaper_date`) 
END AS `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`pid`              AS `pid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  `d`.`newpaper_date`    AS `newpaper_date`,
  `d`.`Newspaper_Name`   AS `Newspaper_Name`,
  `d`.`day3_weekday`     AS `ad_date_weekday`,
  `d`.`newpaper_weekday` AS `newpaper_weekday`
FROM `qa3_FSI` `d`
GROUP BY `d`.`eid`,`d`.`pid`,`d`.`ad_date`;
TRUNCATE `event_day4_2017_FSI`;
INSERT INTO `event_day4_2017_FSI`
SELECT
  `d`.`insertion_date`  AS `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`pid`              AS `pid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  `d`.`insertion_date`    AS `newpaper_date`,
  `d`.`Newspaper_Name`   AS `Newspaper_Name`,
  `d`.`day4_weekday`     AS `ad_date_weekday`,
  `d`.`newpaper_weekday` AS `newpaper_weekday`
FROM `qa4_FSI` d;


-- REFRESH REPORT TABLE
TRUNCATE `report_by_id_2017`;
-- day 1
INSERT INTO `report_by_id_2017`
SELECT 
`pid`,
`eid`,
`insertion_date`,
1
from event_day1_2017_FSI;
-- day 2
INSERT INTO `report_by_id_2017`
SELECT 
`pid`,
`eid`,
`insertion_date`,
2
from event_day2_2017_FSI;
-- day 3
INSERT INTO `report_by_id_2017`
SELECT 
`pid`,
`eid`,
`insertion_date`,
3
from event_day3_2017_FSI;
-- day 4
INSERT INTO `report_by_id_2017`
SELECT 
`pid`,
`eid`,
`insertion_date`,
4
from event_day4_2017_FSI;
    

-- using unqiue publication for same city, state, county
call SNAPUniqueReport_2017;

-- using one promotion logic
truncate `report_by_id_onepromotion_2017`;
INSERT INTO `report_by_id_onepromotion_2017`
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
FROM `Report_in_event_FSI` r;



-- fetch 1 block report 
CALL `SNAPClean1DayBlock_2017`;


/*
-----------UPDATE REPORT QUERY------------
*/
set mcol :=  (SELECT COUNT(*)  
	FROM `Aetna_2017_new`.`report_by_id_onepromotion_2017` `r` 
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
FROM (((`Aetna_2017_new`.`report_by_id_onepromotion_2017` `r`
LEFT JOIN `Aetna_2017_new`.`aetna_print_publication_2017` `p`
ON ((`r`.`pid` = `p`.`id`)))
LEFT JOIN `Aetna_2017_new`.`event_by_day_2017` `e`
ON ((`r`.`sfid` = `e`.`id`)))
LEFT JOIN `Aetna_2017_new`.`publication_by_day` `d`
ON (((`d`.`pid` = `r`.`pid`)
AND (`d`.`date` = `r`.`date`))))
GROUP BY `r`.`date`,`r`.`pid`
ORDER BY e.`Region`, e.`Market`, p.`Dominant_County`, `p`.`Rank`, `r`.`date` ");
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
-- PREPARE cvstmt FROM @str;
-- EXECUTE cvstmt;


-- Grouping all same address, same insertion date events to unique date and 5 event in 1 block
-- CALL `SNAPGroupReportBy5Dates_FSI`();

END