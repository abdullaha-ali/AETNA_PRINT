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
-- Table structure for table `aetna_print_events_2018`
--

DROP TABLE IF EXISTS `aetna_print_events_2018`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aetna_print_events_2018` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `SSM_Seminar_Nbr` varchar(64) NOT NULL,
  `Region` varchar(32) DEFAULT NULL,
  `Market` varchar(64) DEFAULT NULL,
  `Lead_Brand` varchar(16) DEFAULT NULL,
  `Event_Date` date DEFAULT NULL,
  `Event_Time` varchar(32) DEFAULT NULL,
  `Venue_Name` varchar(256) DEFAULT NULL,
  `Venue_Address1` varchar(256) DEFAULT NULL,
  `Venue_Address2` varchar(256) DEFAULT NULL,
  `Venue_City` varchar(32) DEFAULT NULL,
  `Venue_County` varchar(32) DEFAULT NULL,
  `Venue_State` varchar(16) DEFAULT NULL,
  `Venue_Zip_Code` varchar(16) DEFAULT NULL,
  `Presentation_Language` varchar(16) DEFAULT NULL,
  `Event_Type` varchar(16) DEFAULT NULL,
  `DP_LATITUDE` varchar(32) DEFAULT NULL,
  `DP_LONGITUDE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `state_county` (`Venue_State`,`Venue_County`,`Presentation_Language`),
  KEY `SSM_Seminar_Nbr` (`SSM_Seminar_Nbr`,`Lead_Brand`)
) ENGINE=InnoDB AUTO_INCREMENT=8192 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-06 12:35:18
