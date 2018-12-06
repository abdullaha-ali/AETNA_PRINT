CREATE DEFINER=`aali`@`%` PROCEDURE `snap_groupings_fsi`(
	IN `date_range` INT,
	IN `SNAP_client` VARCHAR(50)

)
BEGIN

DECLARE col INT;
DECLARE mcol INT;

SET @dvEvent = "TRUNCATE snap_fsi_tech.event_latest_2018";

select date_range,SNAP_client;

SET @cvEvemt = "Insert into `snap_fsi_tech`.event_latest_2018  SELECT
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
`snap_fsi_tech`.`aetna_print_events_2018` `d`

where

((`d`.`Event_Type` = 'Formal')
and (`d`.`Event_Date` >= '2018-11-27')
and (`d`.`Event_Date` <= '2018-12-07')
and (`d`.`Lead_Brand` = '";
SET @cvEvemt = concat(@cvEvemt, SNAP_client);
SET @cvEvemt = concat(@cvEvemt, "')
and (lcase(`d`.`Presentation_Language`) = 'english'))");

PREPARE dstmt FROM @dvEvent;
EXECUTE dstmt;
PREPARE cvstmt FROM @cvEvemt;
EXECUTE cvstmt;




/*
--------REFRESH DAY1,2,3,4 TABLE--------------
--------Reload data from multiple event-------
*/
-- update multupleevent table
call `snap_fsi_tech`.`SNAPUpdateMultipleEvent`(date_range);


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
from ((`snap_fsi_tech`.`multipleEvent_2018` `m` left join `snap_fsi_tech`.`event_latest_2018` `d` on((`m`.`geid` = `d`.`id`))) 
left join `snap_fsi_tech`.`event_latest_2018` `d1` on((`m`.`eid` = `d1`.`id`))) 
where (`d`.`id` is not null) 
group by `m`.`id`;







TRUNCATE `event_day1_2018`;
INSERT INTO `event_day1_2018`
SELECT
  '' AS `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  ''   AS `newpaper_date`,
  `d`.`day1_weekday`     AS `ad_date_weekday`,
  '' AS `newpaper_weekday`
FROM `qa1_2018_FSI` `d`
GROUP BY `d`.`eid`,`d`.`ad_date`;

TRUNCATE `event_day2_2018`;
INSERT INTO `event_day2_2018`
SELECT
  '' `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  ''    AS `newpaper_date`,
  `d`.`day2_weekday`     AS `ad_date_weekday`,
  '' AS `newpaper_weekday`
FROM `qa2_2018_FSI` `d`
GROUP BY `d`.`eid`,`d`.`ad_date`;

TRUNCATE `event_day3_2018`;
INSERT INTO `event_day3_2018`
SELECT
  '' `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  ''    AS `newpaper_date`,
  `d`.`day3_weekday`     AS `ad_date_weekday`,
  '' AS `newpaper_weekday`
FROM `qa3_2018_FSI` `d`
GROUP BY `d`.`eid`,`d`.`ad_date`;

TRUNCATE `event_day4_2018`;
INSERT INTO `event_day4_2018`
SELECT
  ''  AS `insertion_date`,
  `d`.`eid`              AS `eid`,
  `d`.`Event_Date`       AS `Event_Date`,
  `d`.`Venue_County`     AS `Venue_County`,
  `d`.`ad_date`          AS `ad_date`,
  ''    AS `newpaper_date`,
  `d`.`day4_weekday`     AS `ad_date_weekday`,
  '' AS `newpaper_weekday`
FROM `qa4_2018_FSI` d;


-- REFRESH REPORT TABLE

TRUNCATE `report_by_id_2018`;

-- day 1
INSERT INTO `report_by_id_2018`
SELECT 
`eid`,
`insertion_date`,
1
from event_day1_2018;

-- day 2
INSERT INTO `report_by_id_2018`
SELECT 
`eid`,
`insertion_date`,
2
from event_day2_2018;

-- day 3
INSERT INTO `report_by_id_2018`
SELECT 
`eid`,
`insertion_date`,
3
from event_day3_2018;

-- day 4
INSERT INTO `report_by_id_2018`
SELECT 
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


END