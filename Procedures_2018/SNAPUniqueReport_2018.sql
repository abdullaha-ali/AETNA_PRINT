CREATE DEFINER=`asharma`@`%` PROCEDURE `SNAPUniqueReport_2018`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
-- using unqiue publication for same city, state, county
TRUNCATE  `report_by_id_unique_2018`;
INSERT INTO `report_by_id_unique_2018`
SELECT * FROM
`report_by_id_2018` r
WHERE r.`pid` IN (
SELECT p.`id` FROM
`aetna_print_publication_2018` p, 
(SELECT 
MAX(d.DailyCirc) AS DailyCirculation,
d.SecondaryCounties,
d.`State`
FROM `aetna_print_publication_2018` d
GROUP BY  d.SecondaryCounties, d.`State`
)  p1
WHERE p.`State` = p1.`State` 
AND p.SecondaryCounties = p1.SecondaryCounties
 #AND p.`Daily_ROP_Circulation` = p1.`Daily_ROP_Circulation`
);
END