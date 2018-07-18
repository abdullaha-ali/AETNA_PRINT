CREATE DEFINER=`root`@`%` PROCEDURE `SNAPUniqueReport_2017`()
BEGIN
-- using unqiue publication for same city, state, county
TRUNCATE  `report_by_id_unique_2017`;
INSERT INTO `report_by_id_unique_2017`
SELECT * FROM
`report_by_id_2017` r
WHERE r.`pid` IN (
SELECT p.`id` FROM
`aetna_print_publication_2017` p, 
(SELECT 
-- MAX(d.`Daily_ROP_Circulation`) AS Daily_ROP_Circulation,
d.ZipCode,
d.`State`
FROM `aetna_print_publication_2017` d
GROUP BY  d.`ZipCode`, d.`State`
)  p1
WHERE p.`State` = p1.`State` 
AND p.`ZipCode` = p1.`ZipCode`
 #AND p.`Daily_ROP_Circulation` = p1.`Daily_ROP_Circulation`
);
END