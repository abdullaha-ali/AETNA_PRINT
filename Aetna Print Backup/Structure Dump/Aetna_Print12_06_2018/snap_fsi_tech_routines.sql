-- MySQL dump 10.13  Distrib 5.6.23, for Win32 (x86)
--
-- Host: gfprdsmysqlp001.cvbz72fzclwf.us-west-2.rds.amazonaws.com    Database: snap_fsi_tech
-- ------------------------------------------------------
-- Server version	5.7.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `Report_FSI_2018`
--

DROP TABLE IF EXISTS `Report_FSI_2018`;
/*!50001 DROP VIEW IF EXISTS `Report_FSI_2018`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `Report_FSI_2018` AS SELECT 
 1 AS `Region`,
 1 AS `Lead_Brand`,
 1 AS `Market`,
 1 AS `County`,
 1 AS `State`,
 1 AS `Meeting_Block_1`,
 1 AS `Meeting_Block_2`,
 1 AS `Meeting_Block_3`,
 1 AS `Meeting_Block_4`,
 1 AS `Meeting_Block_5`,
 1 AS `Meeting_Block_6`,
 1 AS `Meeting_Block_7`,
 1 AS `Meeting_Block_8`,
 1 AS `Meeting_Block_9`,
 1 AS `TFNs`,
 1 AS `YBR`,
 1 AS `Presentation_language`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `event_latest_W_venueID_2018`
--

DROP TABLE IF EXISTS `event_latest_W_venueID_2018`;
/*!50001 DROP VIEW IF EXISTS `event_latest_W_venueID_2018`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `event_latest_W_venueID_2018` AS SELECT 
 1 AS `id`,
 1 AS `Event_DateTime`,
 1 AS `Seminar_Number`,
 1 AS `Event_Date`,
 1 AS `Event_Time`,
 1 AS `Event_Type`,
 1 AS `Lead_Brand`,
 1 AS `Market`,
 1 AS `Presentation_Language`,
 1 AS `Region`,
 1 AS `Venue_Address1`,
 1 AS `Venue_Address2`,
 1 AS `Venue_City`,
 1 AS `Venue_County`,
 1 AS `Venue_Name`,
 1 AS `Venue_State`,
 1 AS `Venue_Zip_Code`,
 1 AS `Venue_ID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `qa3_2018_FSI`
--

DROP TABLE IF EXISTS `qa3_2018_FSI`;
/*!50001 DROP VIEW IF EXISTS `qa3_2018_FSI`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `qa3_2018_FSI` AS SELECT 
 1 AS `eid`,
 1 AS `event_date`,
 1 AS `venue_county`,
 1 AS `ad_date`,
 1 AS `day3_weekday`,
 1 AS `seminar_number`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `RDV_dev_test`
--

DROP TABLE IF EXISTS `RDV_dev_test`;
/*!50001 DROP VIEW IF EXISTS `RDV_dev_test`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `RDV_dev_test` AS SELECT 
 1 AS `pubDate`,
 1 AS `grouprank`,
 1 AS `eid`,
 1 AS `geid`,
 1 AS `Region`,
 1 AS `Lead_Brand`,
 1 AS `Market`,
 1 AS `County`,
 1 AS `State`,
 1 AS `insertion_date`,
 1 AS `Total Event OLD`,
 1 AS `Total Event`,
 1 AS `Meeting_Block_1`,
 1 AS `Meeting_Block_2`,
 1 AS `Meeting_Block_3`,
 1 AS `Meeting_Block_4`,
 1 AS `Meeting_Block_5`,
 1 AS `Meeting_Block_6`,
 1 AS `Meeting_Block_7`,
 1 AS `Meeting_Block_8`,
 1 AS `Meeting_Block_9`,
 1 AS `Newspaper Specs`,
 1 AS `Insertion Format`,
 1 AS `Insertion Cost`,
 1 AS `Benefit Bullets 1`,
 1 AS `Benefit Bullets 2`,
 1 AS `Benefit Bullets 3`,
 1 AS `Benefit Bullets 4`,
 1 AS `Benefit Bullets 5`,
 1 AS `Product Creative/NVN Co-brand`,
 1 AS `TFNs`,
 1 AS `YBR`,
 1 AS `Meeting/Non-Meeting`,
 1 AS `Presentation_language`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `qa2_2018_FSI`
--

DROP TABLE IF EXISTS `qa2_2018_FSI`;
/*!50001 DROP VIEW IF EXISTS `qa2_2018_FSI`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `qa2_2018_FSI` AS SELECT 
 1 AS `eid`,
 1 AS `event_date`,
 1 AS `venue_county`,
 1 AS `ad_date`,
 1 AS `day2_weekday`,
 1 AS `seminar_number`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `qa4_2018_FSI`
--

DROP TABLE IF EXISTS `qa4_2018_FSI`;
/*!50001 DROP VIEW IF EXISTS `qa4_2018_FSI`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `qa4_2018_FSI` AS SELECT 
 1 AS `eid`,
 1 AS `event_date`,
 1 AS `venue_county`,
 1 AS `ad_date`,
 1 AS `day4_weekday`,
 1 AS `seminar_number`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Report_in_event_2018`
--

DROP TABLE IF EXISTS `Report_in_event_2018`;
/*!50001 DROP VIEW IF EXISTS `Report_in_event_2018`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `Report_in_event_2018` AS SELECT 
 1 AS `eid`,
 1 AS `Event Date`,
 1 AS `Venue County`,
 1 AS `Promotion 1`,
 1 AS `Promotion 1 weekday`,
 1 AS `Promotion 2`,
 1 AS `Promotion 2 weekday`,
 1 AS `Promotion 3`,
 1 AS `Promotion 3 weekday`,
 1 AS `Promotion 4`,
 1 AS `Promotion 4 weekday`,
 1 AS `Detail`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `qa1_2018_FSI`
--

DROP TABLE IF EXISTS `qa1_2018_FSI`;
/*!50001 DROP VIEW IF EXISTS `qa1_2018_FSI`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `qa1_2018_FSI` AS SELECT 
 1 AS `eid`,
 1 AS `event_date`,
 1 AS `venue_county`,
 1 AS `ad_date`,
 1 AS `day1_weekday`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `event_by_day_g_18_venue_ID`
--

DROP TABLE IF EXISTS `event_by_day_g_18_venue_ID`;
/*!50001 DROP VIEW IF EXISTS `event_by_day_g_18_venue_ID`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `event_by_day_g_18_venue_ID` AS SELECT 
 1 AS `id`,
 1 AS `Event_Date`,
 1 AS `Event_DateTime`,
 1 AS `Venue_County`,
 1 AS `Lead_Brand`,
 1 AS `Venue_Zip_Code`,
 1 AS `Seminar_Number`,
 1 AS `Venue_State`,
 1 AS `Event_Time`,
 1 AS `Region`,
 1 AS `Market`,
 1 AS `day1`,
 1 AS `day1_weekday`,
 1 AS `day2`,
 1 AS `day2_weekday`,
 1 AS `day3`,
 1 AS `day3_weekday`,
 1 AS `day4`,
 1 AS `detail`,
 1 AS `Group_Date`,
 1 AS `Presentation_Language`,
 1 AS `Venue_ID`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `Report_FSI_2018`
--

/*!50001 DROP VIEW IF EXISTS `Report_FSI_2018`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aali`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `Report_FSI_2018` AS select `RDV_dev_test`.`Region` AS `Region`,`RDV_dev_test`.`Lead_Brand` AS `Lead_Brand`,`RDV_dev_test`.`Market` AS `Market`,`RDV_dev_test`.`County` AS `County`,`RDV_dev_test`.`State` AS `State`,`RDV_dev_test`.`Meeting_Block_1` AS `Meeting_Block_1`,`RDV_dev_test`.`Meeting_Block_2` AS `Meeting_Block_2`,`RDV_dev_test`.`Meeting_Block_3` AS `Meeting_Block_3`,`RDV_dev_test`.`Meeting_Block_4` AS `Meeting_Block_4`,`RDV_dev_test`.`Meeting_Block_5` AS `Meeting_Block_5`,`RDV_dev_test`.`Meeting_Block_6` AS `Meeting_Block_6`,`RDV_dev_test`.`Meeting_Block_7` AS `Meeting_Block_7`,`RDV_dev_test`.`Meeting_Block_8` AS `Meeting_Block_8`,`RDV_dev_test`.`Meeting_Block_9` AS `Meeting_Block_9`,`RDV_dev_test`.`TFNs` AS `TFNs`,`RDV_dev_test`.`YBR` AS `YBR`,`RDV_dev_test`.`Presentation_language` AS `Presentation_language` from `RDV_dev_test` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `event_latest_W_venueID_2018`
--

/*!50001 DROP VIEW IF EXISTS `event_latest_W_venueID_2018`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aali`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `event_latest_W_venueID_2018` AS select `sf`.`id` AS `id`,str_to_date(concat(`sf`.`Event_Date`,' ',`sf`.`Event_Time`),'%Y-%m-%d %h:%i %p') AS `Event_DateTime`,`sf`.`SSM_Seminar_Nbr` AS `Seminar_Number`,`sf`.`Event_Date` AS `Event_Date`,`sf`.`Event_Time` AS `Event_Time`,`sf`.`Event_Type` AS `Event_Type`,`sf`.`Lead_Brand` AS `Lead_Brand`,`sf`.`Market` AS `Market`,`sf`.`Presentation_Language` AS `Presentation_Language`,`sf`.`Region` AS `Region`,`sf`.`Venue_Address1` AS `Venue_Address1`,`sf`.`Venue_Address2` AS `Venue_Address2`,`sf`.`Venue_City` AS `Venue_City`,`sf`.`Venue_County` AS `Venue_County`,`sf`.`Venue_Name` AS `Venue_Name`,`sf`.`Venue_State` AS `Venue_State`,`sf`.`Venue_Zip_Code` AS `Venue_Zip_Code`,`sf`.`VENUE_ID` AS `Venue_ID` from `salesforce_2018_W_venueID` `sf` where ((`sf`.`Event_Type` = 'Formal') and (`sf`.`Event_Date` >= '2018-11-27') and (`sf`.`Event_Date` <= '2018-12-07') and (`sf`.`Lead_Brand` = 'AET') and (lower(`sf`.`Presentation_Language`) = 'english')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `qa3_2018_FSI`
--

/*!50001 DROP VIEW IF EXISTS `qa3_2018_FSI`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aali`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `qa3_2018_FSI` AS select `e`.`id` AS `eid`,`e`.`Event_Date` AS `event_date`,`e`.`Venue_County` AS `venue_county`,`e`.`day3` AS `ad_date`,dayname(`e`.`day3`) AS `day3_weekday`,`e`.`Seminar_Number` AS `seminar_number` from `event_by_day_group_2018` `e` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `RDV_dev_test`
--

/*!50001 DROP VIEW IF EXISTS `RDV_dev_test`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aali`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `RDV_dev_test` AS select `r`.`date` AS `pubDate`,`r`.`grouprank` AS `grouprank`,group_concat(distinct `e`.`id` separator ',') AS `eid`,group_concat(distinct `r`.`geid` separator ',') AS `geid`,group_concat(distinct `e`.`Region` order by `e`.`Region` ASC separator ',') AS `Region`,`e`.`Lead_Brand` AS `Lead_Brand`,group_concat(distinct if((`e`.`Market` = ''),NULL,`e`.`Market`) order by `e`.`Market` ASC separator ',') AS `Market`,group_concat(distinct `e`.`Venue_County` order by `e`.`Venue_County` ASC separator ',') AS `County`,group_concat(distinct substr(concat(`e`.`Venue_State`,' ',`e`.`Venue_County`),1,2) order by `e`.`Venue_State` ASC separator ',') AS `State`,'' AS `insertion_date`,sum(((char_length(`r`.`geid`) - char_length(replace(`r`.`geid`,',',''))) + 1)) AS `Total Event OLD`,(((char_length(`r`.`geid`) - char_length(replace(`r`.`geid`,',',''))) + 1) * ((char_length(`r`.`gtime`) - char_length(replace(`r`.`gtime`,',',''))) + 1)) AS `Total Event`,substring_index(group_concat(concat_ws('\n',`e`.`detail`,convert(concat((case when (((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1) = 0) then `r`.`gdate` else concat(substring_index(`r`.`gdate`,',',((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1)),' &',substring_index(`r`.`gdate`,',',-(1))) end),', ',(case when (((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1) = 0) then `r`.`gtime` else concat(substring_index(`r`.`gtime`,',',((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1)),' &',substring_index(`r`.`gtime`,',',-(1))) end)) using utf8mb4)) order by str_to_date(`r`.`gdate`,'%m/%d') ASC separator ';'),';',1) AS `Meeting_Block_1`,if(((length(substring_index(group_concat(`e`.`detail` separator ';'),';',1)) - length(group_concat(`e`.`detail` separator ';'))) <> 0),substring_index(substring_index(group_concat(concat_ws('\n',`e`.`detail`,convert(concat((case when (((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1) = 0) then `r`.`gdate` else concat(substring_index(`r`.`gdate`,',',((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1)),' &',substring_index(`r`.`gdate`,',',-(1))) end),', ',(case when (((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1) = 0) then `r`.`gtime` else concat(substring_index(`r`.`gtime`,',',((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1)),' &',substring_index(`r`.`gtime`,',',-(1))) end)) using utf8mb4)) order by str_to_date(`r`.`gdate`,'%m/%d') ASC separator ';'),';',2),';',-(1)),'') AS `Meeting_Block_2`,if(((length(substring_index(group_concat(`e`.`detail` separator ';'),';',2)) - length(group_concat(`e`.`detail` separator ';'))) <> 0),substring_index(substring_index(group_concat(concat_ws('\n',`e`.`detail`,convert(concat((case when (((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1) = 0) then `r`.`gdate` else concat(substring_index(`r`.`gdate`,',',((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1)),' &',substring_index(`r`.`gdate`,',',-(1))) end),', ',(case when (((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1) = 0) then `r`.`gtime` else concat(substring_index(`r`.`gtime`,',',((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1)),' &',substring_index(`r`.`gtime`,',',-(1))) end)) using utf8mb4)) order by str_to_date(`r`.`gdate`,'%m/%d') ASC separator ';'),';',3),';',-(1)),'') AS `Meeting_Block_3`,if(((length(substring_index(group_concat(`e`.`detail` separator ';'),';',3)) - length(group_concat(`e`.`detail` separator ';'))) <> 0),substring_index(substring_index(group_concat(concat_ws('\n',`e`.`detail`,convert(concat((case when (((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1) = 0) then `r`.`gdate` else concat(substring_index(`r`.`gdate`,',',((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1)),' &',substring_index(`r`.`gdate`,',',-(1))) end),', ',(case when (((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1) = 0) then `r`.`gtime` else concat(substring_index(`r`.`gtime`,',',((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1)),' &',substring_index(`r`.`gtime`,',',-(1))) end)) using utf8mb4)) order by str_to_date(`r`.`gdate`,'%m/%d') ASC separator ';'),';',4),';',-(1)),'') AS `Meeting_Block_4`,if(((length(substring_index(group_concat(`e`.`detail` separator ';'),';',4)) - length(group_concat(`e`.`detail` separator ';'))) <> 0),substring_index(substring_index(group_concat(concat_ws('\n',`e`.`detail`,convert(concat((case when (((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1) = 0) then `r`.`gdate` else concat(substring_index(`r`.`gdate`,',',((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1)),' &',substring_index(`r`.`gdate`,',',-(1))) end),', ',(case when (((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1) = 0) then `r`.`gtime` else concat(substring_index(`r`.`gtime`,',',((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1)),' &',substring_index(`r`.`gtime`,',',-(1))) end)) using utf8mb4)) order by str_to_date(`r`.`gdate`,'%m/%d') ASC separator ';'),';',5),';',-(1)),'') AS `Meeting_Block_5`,if(((length(substring_index(group_concat(`e`.`detail` separator ';'),';',5)) - length(group_concat(`e`.`detail` separator ';'))) <> 0),substring_index(substring_index(group_concat(concat_ws('\n',`e`.`detail`,convert(concat((case when (((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1) = 0) then `r`.`gdate` else concat(substring_index(`r`.`gdate`,',',((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1)),' &',substring_index(`r`.`gdate`,',',-(1))) end),', ',(case when (((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1) = 0) then `r`.`gtime` else concat(substring_index(`r`.`gtime`,',',((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1)),' &',substring_index(`r`.`gtime`,',',-(1))) end)) using utf8mb4)) order by str_to_date(`r`.`gdate`,'%m/%d') ASC separator ';'),';',6),';',-(1)),'') AS `Meeting_Block_6`,if(((length(substring_index(group_concat(`e`.`detail` separator ';'),';',6)) - length(group_concat(`e`.`detail` separator ';'))) <> 0),substring_index(substring_index(group_concat(concat_ws('\n',`e`.`detail`,convert(concat((case when (((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1) = 0) then `r`.`gdate` else concat(substring_index(`r`.`gdate`,',',((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1)),' &',substring_index(`r`.`gdate`,',',-(1))) end),', ',(case when (((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1) = 0) then `r`.`gtime` else concat(substring_index(`r`.`gtime`,',',((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1)),' &',substring_index(`r`.`gtime`,',',-(1))) end)) using utf8mb4)) order by str_to_date(`r`.`gdate`,'%m/%d') ASC separator ';'),';',7),';',-(1)),'') AS `Meeting_Block_7`,if(((length(substring_index(group_concat(`e`.`detail` separator ';'),';',7)) - length(group_concat(`e`.`detail` separator ';'))) <> 0),substring_index(substring_index(group_concat(concat_ws('\n',`e`.`detail`,convert(concat((case when (((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1) = 0) then `r`.`gdate` else concat(substring_index(`r`.`gdate`,',',((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1)),' &',substring_index(`r`.`gdate`,',',-(1))) end),', ',(case when (((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1) = 0) then `r`.`gtime` else concat(substring_index(`r`.`gtime`,',',((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1)),' &',substring_index(`r`.`gtime`,',',-(1))) end)) using utf8mb4)) order by str_to_date(`r`.`gdate`,'%m/%d') ASC separator ';'),';',8),';',-(1)),'') AS `Meeting_Block_8`,if(((length(substring_index(group_concat(`e`.`detail` separator ';'),';',8)) - length(group_concat(`e`.`detail` separator ';'))) <> 0),substring_index(substring_index(group_concat(concat_ws('\n',`e`.`detail`,convert(concat((case when (((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1) = 0) then `r`.`gdate` else concat(substring_index(`r`.`gdate`,',',((length(`r`.`gdate`) - length(replace(`r`.`gdate`,'/',''))) - 1)),' &',substring_index(`r`.`gdate`,',',-(1))) end),', ',(case when (((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1) = 0) then `r`.`gtime` else concat(substring_index(`r`.`gtime`,',',((length(`r`.`gtime`) - length(replace(`r`.`gtime`,':',''))) - 1)),' &',substring_index(`r`.`gtime`,',',-(1))) end)) using utf8mb4)) order by str_to_date(`r`.`gdate`,'%m/%d') ASC separator ';'),';',9),';',-(1)),'') AS `Meeting_Block_9`,'' AS `Newspaper Specs`,'' AS `Insertion Format`,'' AS `Insertion Cost`,'' AS `Benefit Bullets 1`,'' AS `Benefit Bullets 2`,'' AS `Benefit Bullets 3`,'' AS `Benefit Bullets 4`,'' AS `Benefit Bullets 5`,'' AS `Product Creative/NVN Co-brand`,'' AS `TFNs`,'' AS `YBR`,'' AS `Meeting/Non-Meeting`,`e`.`Presentation_Language` AS `Presentation_language` from (`report_by_id_group_2018` `r` left join `event_by_day_g_18_venue_ID` `e` on((`r`.`eid` = `e`.`id`))) group by `r`.`grouprank` order by `e`.`Region`,`e`.`Market`,`r`.`State` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `qa2_2018_FSI`
--

/*!50001 DROP VIEW IF EXISTS `qa2_2018_FSI`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aali`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `qa2_2018_FSI` AS select `e`.`id` AS `eid`,`e`.`Event_Date` AS `event_date`,`e`.`Venue_County` AS `venue_county`,`e`.`day1` AS `ad_date`,dayname(`e`.`day2`) AS `day2_weekday`,`e`.`Seminar_Number` AS `seminar_number` from `event_by_day_group_2018` `e` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `qa4_2018_FSI`
--

/*!50001 DROP VIEW IF EXISTS `qa4_2018_FSI`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aali`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `qa4_2018_FSI` AS select `e`.`id` AS `eid`,`e`.`Event_Date` AS `event_date`,`e`.`Venue_County` AS `venue_county`,`e`.`day1` AS `ad_date`,dayname(`e`.`day4`) AS `day4_weekday`,`e`.`Seminar_Number` AS `seminar_number` from `event_by_day_group_2018` `e` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Report_in_event_2018`
--

/*!50001 DROP VIEW IF EXISTS `Report_in_event_2018`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aali`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `Report_in_event_2018` AS select `d`.`sfid` AS `eid`,`e`.`Event_Date` AS `Event Date`,`e`.`Venue_County` AS `Venue County`,`d1`.`insertion_date` AS `Promotion 1`,dayname(`d1`.`insertion_date`) AS `Promotion 1 weekday`,`d2`.`insertion_date` AS `Promotion 2`,dayname(`d2`.`insertion_date`) AS `Promotion 2 weekday`,`d3`.`insertion_date` AS `Promotion 3`,dayname(`d3`.`insertion_date`) AS `Promotion 3 weekday`,`d4`.`insertion_date` AS `Promotion 4`,dayname(`d4`.`insertion_date`) AS `Promotion 4 weekday`,concat_ws('\n                                                                ',convert(`e`.`detail` using utf8mb4),concat(convert(`e`.`Group_Date` using utf8mb4),', ',convert(`e`.`Event_Time` using utf8mb4))) AS `Detail` from (((((`report_by_id_2018` `d` left join `event_by_day_group_2018` `e` on((`d`.`sfid` = `e`.`id`))) left join `event_day1_2018` `d1` on((`d`.`sfid` = `d1`.`eid`))) left join `event_day2_2018` `d2` on((`d`.`sfid` = `d2`.`eid`))) left join `event_day3_2018` `d3` on((`d`.`sfid` = `d3`.`eid`))) left join `event_day4_2018` `d4` on((`d`.`sfid` = `d4`.`eid`))) group by `d`.`sfid` order by `d`.`sfid` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `qa1_2018_FSI`
--

/*!50001 DROP VIEW IF EXISTS `qa1_2018_FSI`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aali`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `qa1_2018_FSI` AS select `e`.`id` AS `eid`,`e`.`Event_Date` AS `event_date`,`e`.`Venue_County` AS `venue_county`,`e`.`day1` AS `ad_date`,dayname(`e`.`day1`) AS `day1_weekday` from `event_by_day_group_2018` `e` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `event_by_day_g_18_venue_ID`
--

/*!50001 DROP VIEW IF EXISTS `event_by_day_g_18_venue_ID`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aali`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `event_by_day_g_18_venue_ID` AS select `m`.`id` AS `id`,`d1`.`Event_Date` AS `Event_Date`,str_to_date(concat(`d1`.`Event_Date`,' ',`d1`.`Event_Time`),'%Y-%m-%d %h:%i %p') AS `Event_DateTime`,`d1`.`Venue_County` AS `Venue_County`,`d`.`Lead_Brand` AS `Lead_Brand`,`d1`.`Venue_Zip_Code` AS `Venue_Zip_Code`,`d1`.`Seminar_Number` AS `Seminar_Number`,`d1`.`Venue_State` AS `Venue_State`,group_concat(distinct `d1`.`Event_Time` order by str_to_date(`d1`.`Event_Time`,'%h:%i %p') ASC separator ' & ') AS `Event_Time`,group_concat(distinct if((`d1`.`Region` = ''),NULL,`d1`.`Region`) separator ',') AS `Region`,group_concat(distinct if((`d`.`Market` = ''),NULL,`d`.`Market`) separator ',') AS `Market`,(`d1`.`Event_Date` - interval 10 day) AS `day1`,dayname((`d1`.`Event_Date` - interval 10 day)) AS `day1_weekday`,(`d1`.`Event_Date` - interval 5 day) AS `day2`,dayname((`d1`.`Event_Date` - interval 5 day)) AS `day2_weekday`,`d1`.`Event_Date` AS `day3`,dayname(`d1`.`Event_Date`) AS `day3_weekday`,if((dayofweek(`d1`.`Event_Date`) = 1),`d1`.`Event_Date`,NULL) AS `day4`,concat_ws('\n',`d1`.`Venue_ID`,`d1`.`Venue_City`,`d1`.`Venue_Name`,`d1`.`Venue_Address1`) AS `detail`,group_concat(distinct `d`.`Event_Date` separator ',') AS `Group_Date`,`d`.`Presentation_Language` AS `Presentation_Language`,`d`.`Venue_ID` AS `Venue_ID` from ((`multipleEvent_2018` `m` left join `event_latest_W_venueID_2018` `d` on((`m`.`geid` = `d`.`id`))) left join `event_latest_W_venueID_2018` `d1` on((`m`.`eid` = `d1`.`id`))) where (`d`.`id` is not null) group by `m`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-06 12:35:35
