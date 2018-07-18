CREATE DEFINER=`root`@`%` PROCEDURE `updatePublicationRanking_2017`()
BEGIN
UPDATE `aetna_print_publication_2017` ap, 
(
SELECT
p.`id`,
p.`State`,
p.`Circulation`,
p.`65_Coverage`,
@current_rank := IF(@curr_zipcode = p.`ZipCode` , @current_rank + 1, 1) AS `Rank`,

@curr_zipcode := p.`ZipCode`
FROM 
`aetna_print_publication_2017` p, (SELECT @current_rank := 1, @curr_zipcode ) t
ORDER BY p.`ZipCode`,p.`Circulation`, p.`65_Coverage` DESC
)  pr
SET ap.`Rank` = pr.`rank`
WHERE ap.`id` = pr.`id`;
END