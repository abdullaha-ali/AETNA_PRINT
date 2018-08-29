CREATE DEFINER=`asharma`@`%` PROCEDURE `updatePublicationLookup_2018`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
INSERT INTO `publication_day_lookup_2018` 
SELECT
DISTINCT(d.PublicationDays), '','','',''
FROM `aetna_print_publication_2018` d
WHERE d.PublicationDays NOT IN 
(SELECT 
e.`publication_day`
FROM `publication_day_lookup_2018` e
);
INSERT INTO `publication_deadline_lookup_2018` 
SELECT
NULL,
 `deadline` 
FROM
(SELECT
p1.`SpaceDeadline` AS `deadline`
FROM `aetna_print_publication_2018` p1
UNION
SELECT
p2.`MaterialDeadline`AS `deadline`
FROM `aetna_print_publication_2018` p2
) d
WHERE d.`deadline` NOT IN 
(
SELECT `deadline` FROM `publication_deadline_lookup_2018`)
GROUP BY `deadline`;

END