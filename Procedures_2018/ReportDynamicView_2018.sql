CREATE DEFINER=`asharma`@`%` PROCEDURE `ReportDynamicView_2018`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN

DECLARE col  INT;

SET @dv = 'DROP VIEW IF EXISTS AetnaPrint_2018.`Report_in_publication_GroupAfter_dev`';
SET @str =  "CREATE VIEW AetnaPrint_2018.`Report_in_publication_GroupAfter_dev` as SELECT
	`r`.`pid` AS `pid`,
	`r`.date as pubDate,
	`r`.grouprank,
   Group_concat(distinct `e`.`id`) as eid,
   Group_concat(distinct `r`.`geid`) as geid,
	group_concat(distinct(e.`Region`) order by e.`Region`) AS `Region`,
	e.`Lead_Brand`,
	group_concat(distinct(if(e.`Market`='',NULL,e.`Market`)) order by e.`Market`) as `Market`,
	p.`SubMarket` as `SubMarket`,
	group_concat(distinct(`p`.`DominantCounty`) order by `p`.`DominantCounty` ) as `DominantCounty`,
	group_concat(distinct(substring(p.DominantCounty_State, 1,2)) order by `p`.`State` ) as `State`,
	`p`.PublicationName    AS `Publication`,
	/*case when min(`p`.`Rank`) = 1 then 'Dominant'
	 when min(`p`.`Rank`) = 2 then 'Secondary'
	 when min(`p`.`Rank`) = 3 then 'Tertiary'
	else p.`Rank`
	END as `Ranking`,*/
	'' as `insertion_date`,
	p.`PUBLICATIONDAYS`as `Publication Days`,
	-- date_format(`r`.`date`,'%m/%e/%Y')    AS `Insertion date`,
	`p`.`MaterialDeadline` AS `Material Deadline Range`,
	-- lower(date_format(`d`.`Material_Deadline`, '%m/%e, %l:%i %p')) AS `Material Deadline`, 
	-- GROUP_CONCAT(replace(`r`.`geid`, ',',';') SEPARATOR ';') AS `eid`,
	-- Case WHEN COUNT(*)>6 THEN 6
--	ELSE COUNT(*) 
--	END AS `Total Event`,
-- CASE WHEN `r`.`geid` LIKE '%,%' THEN 
	'' as `material_due_date`,
	SUM(CHAR_LENGTH(`r`.`geid`)-CHAR_LENGTH(REPLACE(`r`.`geid`,',',''))+1) AS `Total Event`,
-- 	ELSE count(*) 
--	END 
	
	SUBSTRING_INDEX(GROUP_CONCAT(CONCAT_WS('\n', `e`.`detail`, CONCAT(case when LENGTH(`r`.`gdate`) - LENGTH(REPLACE(`r`.`gdate`, '/', ''))-1 = 0 then `r`.`gdate`
else concat((substring_index(`r`.`gdate`, ',', LENGTH(`r`.`gdate`) - LENGTH(REPLACE(`r`.`gdate`, '/', ''))-1)), ' &', substring_index(`r`.`gdate`, ',', -1)) end,', ',case when LENGTH(`r`.`gtime`) - LENGTH(REPLACE(`r`.`gtime`, ':', ''))-1 = 0 then `r`.`gtime`
else concat((substring_index(`r`.`gtime`, ',', LENGTH(`r`.`gtime`) - LENGTH(REPLACE(`r`.`gtime`, ':', ''))-1)), ' &', substring_index(`r`.`gtime`, ',', -1)) end), `r`.`geid`) ORDER BY STR_TO_DATE(r.gdate, '%m/%d') ASC SEPARATOR ';'), ';', 1) AS `Meeting Block 1`,
	"; 


/*set mcol :=  (SELECT COUNT(*)  
	FROM  `Aetna_2017_new`. `report_by_id_group_2017` `r` 
	LEFT JOIN `aetna_print_publication_2017` p
	ON r.`pid` = p.`id`
-- 	GROUP BY `r`.`date`,`r`.`pid`
	GROUP BY `r`.`date`,`p`.`Newspaper_Name`, `p`.`State`
	ORDER BY COUNT(*) DESC LIMIT 1 ) ;
*/
set col := 1;

-- START LOOP 
WHILE col  < 9 DO
	SET  @str = CONCAT(@str,"  IF(LENGTH(SUBSTRING_INDEX(GROUP_CONCAT(`e`.`detail`  SEPARATOR ';'), ';', "
	,col,")) -  LENGTH(GROUP_CONCAT(`e`.`detail`  SEPARATOR ';')) != 0 ,
	SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(CONCAT_WS('\n', `e`.`detail`, CONCAT(case when LENGTH(`r`.`gdate`) - LENGTH(REPLACE(`r`.`gdate`, '/', ''))-1 = 0 then `r`.`gdate`
else concat((substring_index(`r`.`gdate`, ',', LENGTH(`r`.`gdate`) - LENGTH(REPLACE(`r`.`gdate`, '/', ''))-1)), ' &', substring_index(`r`.`gdate`, ',', -1)) end,', ',case when LENGTH(`r`.`gtime`) - LENGTH(REPLACE(`r`.`gtime`, ':', ''))-1 = 0 then `r`.`gtime`
else concat((substring_index(`r`.`gtime`, ',', LENGTH(`r`.`gtime`) - LENGTH(REPLACE(`r`.`gtime`, ':', ''))-1)), ' &', substring_index(`r`.`gtime`, ',', -1)) end), `r`.`geid`) ORDER BY STR_TO_DATE(r.gdate, '%m/%d') ASC  SEPARATOR ';'), ';', ",col+1,"), ';' , -1),'') AS `Meeting Block "
	,col+1,"`,
	");
	SET  col = col + 1; 
END WHILE;

set @str = concat(@str," 
p.FullPage as FullPageSpecs,
p.JrPage as JrPageSpecs,
'' as `Insertion Format`,
p.DailyCirc as Circulation,
p.NewspaperType as NewspaperType,
'' as `Insertion Cost`,
'' as `Benefit Bullets 1`,
'' as `Benefit Bullets 2`,
'' as `Benefit Bullets 3`,
'' as `Benefit Bullets 4`,
'' as `Benefit Bullets 5`,
'' as `Product Creative/NVN Co-brand`,
'' as `TFNs`,
'' as `Meeting/Non-Meeting`,
(case when (`p`.`Multicultural` = 'N') then 'English' when (`p`.`Multicultural` = 'Y') then 'Spanish' end) as Presentation_language
FROM (((`AetnaPrint_2018`.`report_by_id_group_2018` `r`
LEFT JOIN `AetnaPrint_2018`.`aetna_print_publication_2018` `p`
ON ((`r`.`pid` = `p`.`id`)))
LEFT JOIN `AetnaPrint_2018`.`event_by_day_group_2018` `e`
ON ((`r`.`eid` = `e`.`id`)))
LEFT JOIN `AetnaPrint_2018`.`publication_by_day_2018` `d`
ON (((`d`.`pid` = `r`.`pid`)
AND (`d`.`date` = `r`.`date`))))
-- where p.`Rank` <= 3
-- GROUP BY `r`.`grouprank`,`p`.`Newspaper_Name`, `p`.`State`
GROUP BY `r`.`grouprank`
ORDER BY  e.`Region`, e.`Market`, p.`State`, `p`.`PublicationName` asc");

PREPARE dstmt FROM @dv;
EXECUTE dstmt; 
PREPARE cvstmt FROM @str;
EXECUTE cvstmt;
-- add new view without eid in meeting block
set @dv = replace(@dv, 'Report_in_publication_GroupAfter_dev','Report_in_publication_GroupAfter');
set @str = replace(@str, 'Report_in_publication_GroupAfter_dev','Report_in_publication_GroupAfter');
set @str = replace(@str, ', `r`.`geid`','');


PREPARE dstmt FROM @dv;
EXECUTE dstmt; 
PREPARE cvstmt FROM @str;
EXECUTE cvstmt;

insert into Publication_Report_2018(select * from ReportWithBullets);
END