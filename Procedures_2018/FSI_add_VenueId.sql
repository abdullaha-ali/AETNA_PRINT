CREATE DEFINER=`asharma`@`%` PROCEDURE `FSI_add_VenueId`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
Truncate AetnaPrint_2018.salesforce_2018_W_venueID;
Insert into AetnaPrint_2018.salesforce_2018_W_venueID
Select id,
SSM_Seminar_Nbr,
Region,
Market,
Lead_Brand,
Event_Date,
Event_Time,
Venue_Name,
Venue_Address1,
Venue_Address2,
Venue_City,
Venue_County,
Venue_State,
Venue_Zip_Code,
Presentation_Language,
Event_Type,
DP_LATITUDE,
DP_LONGITUDE,
CONCAT('$',DP_LATITUDE,DP_LONGITUDE,'$') 
from AetnaPrint_2018.aetna_print_events_2018;
END