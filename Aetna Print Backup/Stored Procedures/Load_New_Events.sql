CREATE DEFINER=`aali`@`%` PROCEDURE `Load_New_Events`(
	IN `lead_brand` VARCHAR(50),
	IN `lang` VARCHAR(1)
)
BEGIN
DECLARE presentation VARCHAR(15);
if(lang = 'E') then
	set presentation = 'english';
elseif(lang = 'S') then
	set presentation = 'spanish';
end if;
    
SET @dv = 'DROP VIEW IF EXISTS snap_fsi_tech.`event_latest_W_venueID_2018`';
SET @stmt = "CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `aali`@`%` 
    SQL SECURITY DEFINER
VIEW `event_latest_W_venueID_2018` AS
    SELECT 
        `sf`.`id` AS `id`,
        STR_TO_DATE(CONCAT(`sf`.`Event_Date`,
                        ' ',
                        `sf`.`Event_Time`),
                '%Y-%m-%d %h:%i %p') AS `Event_DateTime`,
        `sf`.`SSM_Seminar_Nbr` AS `Seminar_Number`,
        `sf`.`Event_Date` AS `Event_Date`,
        `sf`.`Event_Time` AS `Event_Time`,
        `sf`.`Event_Type` AS `Event_Type`,
        `sf`.`Lead_Brand` AS `Lead_Brand`,
        `sf`.`Market` AS `Market`,
        `sf`.`Presentation_Language` AS `Presentation_Language`,
        `sf`.`Region` AS `Region`,
        `sf`.`Venue_Address1` AS `Venue_Address1`,
        `sf`.`Venue_Address2` AS `Venue_Address2`,
        `sf`.`Venue_City` AS `Venue_City`,
        `sf`.`Venue_County` AS `Venue_County`,
        `sf`.`Venue_Name` AS `Venue_Name`,
        `sf`.`Venue_State` AS `Venue_State`,
        `sf`.`Venue_Zip_Code` AS `Venue_Zip_Code`,
        `sf`.`VENUE_ID` AS `Venue_ID`
    FROM
        `salesforce_2018_W_venueID` `sf`
    WHERE
        ((`sf`.`Event_Type` = 'Formal')
            AND (`sf`.`Event_Date` >= '2018-11-27')
            AND (`sf`.`Event_Date` <= '2018-12-07')
            AND (`sf`.`Lead_Brand` = '";
	SET @stmt = concat(@stmt, lead_brand);
    SET @stmt = concat(@stmt, "') AND (LCASE(`sf`.`Presentation_Language`) = '");
	SET @stmt = concat(@stmt, presentation);
    SET @stmt = concat(@stmt, "')) ");
	
PREPARE dropstmt FROM @dv;
EXECUTE dropstmt;
PREPARE createstmt FROM @stmt;
EXECUTE createstmt;

END