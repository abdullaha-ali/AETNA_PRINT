CREATE DEFINER=`asharma`@`%` PROCEDURE `CheckModifiedSaleforce`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN

truncate table `AetnaPrint_2018`.Salesforce_Difference;
insert into `AetnaPrint_2018`.Salesforce_Difference(`SSM_SEMINAR_NBR`,`EVENT_CONTACT`,`VENUE_PHONE`,`REGION`,`MARKET`,`LEAD_BRAND`,`MAILABILITY_SCORE`,`MARKETING_APPROVED`,`EVENT_DATE`, 
`EVENT_TIME`,`EVENT_END_TIME`,`VENUE_NAME`,`VENUE_ADDRESS1`,`VENUE_ADDRESS2`,`VENUE_CITY`,`VENUE_COUNTY`,`VENUE_STATE`,`VENUE_ZIP_CODE`,`STD_VENUE_NAME`,`STD_VENUE_ADDRESS1`,`STD_VENUE_ADDRESS2`, 
`STD_VENUE_CITY`,`STD_VENUE_COUNTY_NAME`,`STD_VENUE_STATE`,`STD_VENUE_ZIP_CODE`,`COMMENT_IF_ANY`,`SEMINAR_AGENT_NAME`,`AGENT_NATIONAL_PRODUCERS_NBR`,`AGENT_TYPE`,`BROKERAGE_FIRM_AGENCY`,
`CANCEL_EVENT`,`TARGET_AUDIENCE`,`PRESENTATION_LANGUAGE`,`ADVERTISED_EVENT`,`EVENT_TYPE`,`LOCATION_ID`,`DP_CENSUS_STATE_CD`,`DP_CENSUS_COUNTY_CD`,`DP_LATITUDE`,`DP_LONGITUDE`,`MEETING_TIER`,
`HIT_01`,`HIT_02`,`HIT_04`)

select m.`SSM_SEMINAR_NBR`,m.`EVENT_CONTACT`,m.`VENUE_PHONE`,m.`REGION`,m.`MARKET`,m.`LEAD_BRAND`,m.`MAILABILITY_SCORE`,m.`MARKETING_APPROVED`,m.`EVENT_DATE`, 
m.`EVENT_TIME`,m.`EVENT_END_TIME`,m.`VENUE_NAME`,m.`VENUE_ADDRESS1`,m.`VENUE_ADDRESS2`,m.`VENUE_CITY`,m.`VENUE_COUNTY`,m.`VENUE_STATE`,m.`VENUE_ZIP_CODE`,m.`STD_VENUE_NAME`,
m.`STD_VENUE_ADDRESS1`,m.`STD_VENUE_ADDRESS2`,m.`STD_VENUE_CITY`,m.`STD_VENUE_COUNTY_NAME`,m.`STD_VENUE_STATE`,m.`STD_VENUE_ZIP_CODE`,m.`COMMENT_IF_ANY`,m.`SEMINAR_AGENT_NAME`,
m.`AGENT_NATIONAL_PRODUCERS_NBR`,m.`AGENT_TYPE`,m.`BROKERAGE_FIRM_AGENCY`,m.`CANCEL_EVENT`,m.`TARGET_AUDIENCE`,m.`PRESENTATION_LANGUAGE`,m.`ADVERTISED_EVENT`,m.`EVENT_TYPE`,m.`LOCATION_ID`,
m.`DP_CENSUS_STATE_CD`,m.`DP_CENSUS_COUNTY_CD`,m.`DP_LATITUDE`,m.`DP_LONGITUDE`,m.`MEETING_TIER`,m.`HIT_01`,m.`HIT_02`,m.`HIT_04`

from `AetnaPrint_2018`.Salesforce_Modified m join `AetnaPrint_2018`.Salesforce_Raw o on (m.SSM_SEMINAR_NBR = o.SSM_SEMINAR_NBR)
where((m.EVENT_DATE <> o.EVENT_DATE) or (m.EVENT_TIME <> o.EVENT_TIME) or (m.VENUE_ADDRESS1 <> o.VENUE_ADDRESS1));

END