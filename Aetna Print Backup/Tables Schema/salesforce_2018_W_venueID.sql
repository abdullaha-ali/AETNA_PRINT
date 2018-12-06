CREATE TABLE `salesforce_2018_W_venueID` (
  `id` int(11) NOT NULL,
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
  `VENUE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `state_county` (`Venue_State`,`Venue_County`,`Presentation_Language`),
  KEY `SSM_Seminar_Nbr` (`SSM_Seminar_Nbr`,`Lead_Brand`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;