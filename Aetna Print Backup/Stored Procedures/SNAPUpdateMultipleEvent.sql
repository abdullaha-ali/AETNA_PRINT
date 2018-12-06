CREATE DEFINER=`aali`@`%` PROCEDURE `SNAPUpdateMultipleEvent`(
	IN `date_range` INT





)
BEGIN
-- add same date different time
TRUNCATE multipleEvent_2018;

INSERT INTO multipleEvent_2018
SELECT 
dup.`rowNumber`,
d.`id`,
d.`id`
FROM
snap_fsi_tech.event_latest_2018 d
JOIN
(
SELECT 
(@cnt := @cnt + 1) AS rowNumber,
temp.* FROM 
(SELECT
e.`Venue_Address1`, e.`Event_Date`
FROM snap_fsi_tech.event_latest_2018 e 
GROUP BY e.`Venue_Address1`, e.`Event_Date` HAVING COUNT(*) > 1 ) temp
CROSS JOIN (SELECT @cnt := 0) AS dummy
) dup 
ON d.`Venue_Address1` = dup.`Venue_Address1` AND d.`Event_Date` = dup.`Event_Date`;
 


-- add 7 days grouping
INSERT INTO multipleEvent_2018
SELECT
t2.`rowNumber`,
t1.`id`,
t1.`eid`
FROM
(
SELECT
e.Venue_Address1 ,e.Event_Time,  e.`id` AS `eid`  , d.`id`, e.Event_Date
FROM
snap_fsi_tech.event_latest_2018 d, snap_fsi_tech.event_latest_2018 e 
WHERE `e`.`Event_Date` BETWEEN (d.Event_Date ) AND (d.Event_Date + INTERVAL date_range DAY)  
AND e.`Venue_Address1` = d.`Venue_Address1`  AND e.`Venue_Address2` = d.`Venue_Address2`  AND e.`Event_Time` = d.`Event_Time`
AND d.`id` IN (
SELECT
 d1.`id` 
FROM
snap_fsi_tech.event_latest_2018 d1, snap_fsi_tech.event_latest_2018 e1 
WHERE   `e1`.`Event_Date` BETWEEN (d1.Event_Date ) AND (d1.Event_Date + INTERVAL date_range DAY)  
AND e1.`Venue_Address1` = d1.`Venue_Address1`  AND e1.`Venue_Address2` = d1.`Venue_Address2`  AND e1.`Event_Time` = d1.`Event_Time`
GROUP BY d1.`id` HAVING COUNT(*)>1 
)
) t1 LEFT JOIN
(
SELECT 
(@cnt := @cnt + 1) AS rowNumber,
temp.* FROM 
(SELECT
e.Venue_Address1 ,e.Event_Time,d.`id`,GROUP_CONCAT(e.`id`), GROUP_CONCAT(e.Event_Date)
FROM
snap_fsi_tech.event_latest_2018 d, snap_fsi_tech.event_latest_2018 e 
WHERE `e`.`Event_Date` BETWEEN (d.Event_Date ) AND (d.Event_Date + INTERVAL date_range DAY)  
AND e.`Venue_Address1` = d.`Venue_Address1`  AND e.`Venue_Address2` = d.`Venue_Address2`  AND e.`Event_Time` = d.`Event_Time`
GROUP BY d.`id` HAVING COUNT(*)>1  ) temp
CROSS JOIN (SELECT @cnt) AS dummy
) t2
ON t1.`id` = t2.`id` ;


-- add the exlcusion 
INSERT INTO multipleEvent_2018 
SELECT 
(@cnt := @cnt + 1) AS rowNumber,
temp.* FROM 
(SELECT
e.`id` ,e.`id` as `geid`
FROM snap_fsi_tech.event_latest_2018 e 
WHERE e.`id` NOT IN (SELECT DISTINCT(`geid`) FROM multipleEvent_2018) ) temp
CROSS JOIN (SELECT @cnt) AS dummy ;

SELECT 
dup.`rowNumber`,
d.`id`
FROM
snap_fsi_tech.event_latest_2018 d
JOIN
(
SELECT 
(@cnt := @cnt + 1) AS rowNumber,
temp.* FROM 
(SELECT
e.`Venue_Address1`, e.`Event_Date`
FROM snap_fsi_tech.event_latest_2018 e 
WHERE e.`id` NOT IN (SELECT DISTINCT(`eid`) FROM multipleEvent_2018) ) temp
CROSS JOIN (SELECT @cnt) AS dummy
) dup 
ON d.`Venue_Address1` = dup.`Venue_Address1` AND d.`Event_Date` = dup.`Event_Date`;
 
END