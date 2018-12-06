CREATE DEFINER=`aali`@`%` PROCEDURE `loadEventsByDayGroup_FSI`()
BEGIN

SET @dv = 'DROP VIEW IF EXISTS snap_fsi_tech.`event_by_day_g_18_venue_ID`';
SET @stmt = "CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `aali`@`%` 
    SQL SECURITY DEFINER
VIEW `event_by_day_g_18_venue_ID` AS
    SELECT 
        `m`.`id` AS `id`,
        `d1`.`Event_Date` AS `Event_Date`,
        STR_TO_DATE(CONCAT(`d1`.`Event_Date`,
                        ' ',
                        `d1`.`Event_Time`),
                '%Y-%m-%d %h:%i %p') AS `Event_DateTime`,
        `d1`.`Venue_County` AS `Venue_County`,
        `d`.`Lead_Brand` AS `Lead_Brand`,
        `d1`.`Venue_Zip_Code` AS `Venue_Zip_Code`,
        `d1`.`Seminar_Number` AS `Seminar_Number`,
        `d1`.`Venue_State` AS `Venue_State`,
        GROUP_CONCAT(DISTINCT `d1`.`Event_Time`
            ORDER BY STR_TO_DATE(`d1`.`Event_Time`, '%h:%i %p') ASC
            SEPARATOR ' & ') AS `Event_Time`,
        GROUP_CONCAT(DISTINCT IF((`d1`.`Region` = ''),
                NULL,
                `d1`.`Region`)
            SEPARATOR ',') AS `Region`,
        GROUP_CONCAT(DISTINCT IF((`d`.`Market` = ''),
                NULL,
                `d`.`Market`)
            SEPARATOR ',') AS `Market`,
        (`d1`.`Event_Date` - INTERVAL 10 DAY) AS `day1`,
        DAYNAME((`d1`.`Event_Date` - INTERVAL 10 DAY)) AS `day1_weekday`,
        (`d1`.`Event_Date` - INTERVAL 5 DAY) AS `day2`,
        DAYNAME((`d1`.`Event_Date` - INTERVAL 5 DAY)) AS `day2_weekday`,
        `d1`.`Event_Date` AS `day3`,
        DAYNAME(`d1`.`Event_Date`) AS `day3_weekday`,
        IF((DAYOFWEEK(`d1`.`Event_Date`) = 1),
            `d1`.`Event_Date`,
            NULL) AS `day4`,
        CONCAT_WS('\n',
                `d1`.`Venue_ID`,
                `d1`.`Venue_City`,
                `d1`.`Venue_Name`,
                `d1`.`Venue_Address1`) AS `detail`,
        GROUP_CONCAT(DISTINCT `d`.`Event_Date`
            SEPARATOR ',') AS `Group_Date`,
        `d`.`Presentation_Language` AS `Presentation_Language`,
        `d`.`Venue_ID` AS `Venue_ID`
    FROM
        ((`multipleEvent_2018` `m`
        LEFT JOIN `event_latest_W_venueID_2018` `d` ON ((`m`.`geid` = `d`.`id`)))
        LEFT JOIN `event_latest_W_venueID_2018` `d1` ON ((`m`.`eid` = `d1`.`id`)))
    WHERE
        (`d`.`id` IS NOT NULL)
    GROUP BY `m`.`id`";
    
PREPARE dropstmt FROM @dv;
EXECUTE dropstmt;
PREPARE createstmt FROM @stmt;
EXECUTE createstmt;

END