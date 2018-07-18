CREATE DEFINER=`root`@`%` PROCEDURE `updatePublicationLookup_2017`()
BEGIN
INSERT INTO `publication_day_lookup_2017` 
SELECT
DISTINCT(d.`PUBLICATION_DAYS`), '','','',''
FROM `aetna_print_publication_2017` d
WHERE d.`PUBLICATION_DAYS` NOT IN 
(SELECT 
e.`publication_day`
FROM `publication_day_lookup_2017` e
);
INSERT INTO `publication_deadline_lookup_2017` 
SELECT
NULL,
 `deadline` 
FROM
(SELECT
p1.`Space_Deadline` AS `deadline`
FROM `aetna_print_publication_2017` p1
UNION
SELECT
p2.`Material_Deadline`AS `deadline`
FROM `aetna_print_publication_2017` p2
) d
WHERE d.`deadline` NOT IN 
(
SELECT `deadline` FROM `publication_deadline_lookup_2017`)
GROUP BY `deadline`;

END