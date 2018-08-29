CREATE DEFINER=`asharma`@`%` PROCEDURE `UpdatePublicationRanking`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN

UPDATE aetna_print_publication_2018 ap, 
(
SELECT
p.PublicationName AS PublicationName,
p.Multicultural AS Multicultural,
p.State AS State,
replace(replace(p.SecondaryCounties,'.',''),' ','') AS SecondaryCounties,
p.DailyCirc,
@current_rank := IF( @curr_state = p.State AND @curr_county = replace(replace(p.SecondaryCounties,'.',''),' ','') AND @planguage = p.Multicultural, @current_rank + 1, 1) AS `Rank`,
@pname := p.PublicationName,
@planguage := p.Multicultural,
@curr_state := p.State,
@curr_county := replace(replace(p.SecondaryCounties,'.',''),' ','')

FROM 
(SELECT * FROM
aetna_print_publication_2018 GROUP BY PublicationName,SecondaryCounties, Multicultural) p, (SELECT  @current_rank := 1, @curr_state := '', @curr_county := '', @pname := '' , @planguage := '') t 
ORDER BY p.State, replace(replace(p.SecondaryCounties,'.',''),' ',''),p.Multicultural,p.DailyCirc DESC
)  pr
SET ap.Rank = pr.rank
WHERE ap.PublicationName = pr.PublicationName AND ap.Multicultural = pr.Multicultural AND ap.State = pr.State AND replace(replace(ap.SecondaryCounties,'.',''),' ','') = replace(replace(pr.SecondaryCounties,'.',''),' ','');

END