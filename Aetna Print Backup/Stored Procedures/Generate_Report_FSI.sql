CREATE DEFINER=`aali`@`%` PROCEDURE `Generate_Report_FSI`()
BEGIN
DECLARE col INT;

SET @dv = 'DROP VIEW IF EXISTS snap_fsi_tech.`RDV_dev_test`';
SET @str =  "CREATE VIEW snap_fsi_tech.`RDV_dev_test` as SELECT
	`r`.date as pubDate,
	`r`.grouprank,
   Group_concat(distinct `e`.`id`) as eid,
   Group_concat(distinct `r`.`geid`) as geid,
	group_concat(distinct(e.`Region`) order by e.`Region`) AS `Region`,
	e.`Lead_Brand`,
	group_concat(distinct(if(e.`Market`='',NULL,e.`Market`)) order by e.`Market`) as `Market`,
	group_concat(distinct(`e`.`Venue_County`) order by `e`.`Venue_County` ) as `County`,
    group_concat(distinct(substring(CONCAT(`e`.`Venue_State`,' ',`e`.`Venue_County`), 1,2)) order by `e`.`Venue_State` ) as `State`,
	'' as `insertion_date`,

	SUM(CHAR_LENGTH(`r`.`geid`)-CHAR_LENGTH(REPLACE(`r`.`geid`,',',''))+1) AS `Total Event OLD`,
   (CHAR_LENGTH(`r`.`geid`)-CHAR_LENGTH(REPLACE(`r`.`geid`,',','')) + 1) * (CHAR_LENGTH(`r`.gtime)-CHAR_LENGTH(REPLACE(`r`.gtime,',','')) + 1) AS `Total Event`,

	
	SUBSTRING_INDEX(GROUP_CONCAT(CONCAT_WS('\n', `e`.`detail`, CONCAT(case when LENGTH(`r`.`gdate`) - LENGTH(REPLACE(`r`.`gdate`, '/', ''))-1 = 0 then `r`.`gdate`
else concat((substring_index(`r`.`gdate`, ',', LENGTH(`r`.`gdate`) - LENGTH(REPLACE(`r`.`gdate`, '/', ''))-1)), ' &', substring_index(`r`.`gdate`, ',', -1)) end,', ',case when LENGTH(`r`.`gtime`) - LENGTH(REPLACE(`r`.`gtime`, ':', ''))-1 = 0 then `r`.`gtime`
else concat((substring_index(`r`.`gtime`, ',', LENGTH(`r`.`gtime`) - LENGTH(REPLACE(`r`.`gtime`, ':', ''))-1)), ' &', substring_index(`r`.`gtime`, ',', -1)) end), `r`.`geid`) ORDER BY STR_TO_DATE(r.gdate, '%m/%d') ASC SEPARATOR ';'), ';', 1) AS `Meeting_Block_1`,
	"; 

set col := 1;

-- START LOOP 
WHILE col  < 9 DO
	SET  @str = CONCAT(@str,"  IF(LENGTH(SUBSTRING_INDEX(GROUP_CONCAT(`e`.`detail`  SEPARATOR ';'), ';', "
	,col,")) -  LENGTH(GROUP_CONCAT(`e`.`detail`  SEPARATOR ';')) != 0 ,
	SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(CONCAT_WS('\n', `e`.`detail`, CONCAT(case when LENGTH(`r`.`gdate`) - LENGTH(REPLACE(`r`.`gdate`, '/', ''))-1 = 0 then `r`.`gdate`
else concat((substring_index(`r`.`gdate`, ',', LENGTH(`r`.`gdate`) - LENGTH(REPLACE(`r`.`gdate`, '/', ''))-1)), ' &', substring_index(`r`.`gdate`, ',', -1)) end,', ',case when LENGTH(`r`.`gtime`) - LENGTH(REPLACE(`r`.`gtime`, ':', ''))-1 = 0 then `r`.`gtime`
else concat((substring_index(`r`.`gtime`, ',', LENGTH(`r`.`gtime`) - LENGTH(REPLACE(`r`.`gtime`, ':', ''))-1)), ' &', substring_index(`r`.`gtime`, ',', -1)) end), `r`.`geid`) ORDER BY STR_TO_DATE(r.gdate, '%m/%d') ASC  SEPARATOR ';'), ';', ",col+1,"), ';' , -1),'') AS `Meeting_Block_"
	,col+1,"`,
	");
	SET  col = col + 1; 
END WHILE;

set @str = concat(@str," 
'' as `Newspaper Specs`,
'' as `Insertion Format`,
'' as `Insertion Cost`,
'' as `Benefit Bullets 1`,
'' as `Benefit Bullets 2`,
'' as `Benefit Bullets 3`,
'' as `Benefit Bullets 4`,
'' as `Benefit Bullets 5`,
'' as `Product Creative/NVN Co-brand`,
'' as `TFNs`,
'' as `YBR`,
'' as `Meeting/Non-Meeting`,
`e`.`Presentation_Language` as Presentation_language
FROM (`snap_fsi_tech`.`report_by_id_group_2018` `r`
LEFT JOIN `snap_fsi_tech`.`event_by_day_g_18_venue_ID` `e`
ON ((`r`.`eid` = `e`.`id`)))
GROUP BY `r`.`grouprank`
ORDER BY  e.`Region`, e.`Market`, r.`State` asc");

set @str = replace(@str, ', `r`.`geid`','');

PREPARE dstmt FROM @dv;
EXECUTE dstmt; 
PREPARE cvstmt FROM @str;
EXECUTE cvstmt;

-- Now populate FSI report view
SET @drp = 'DROP VIEW IF EXISTS snap_fsi_tech.`Report_FSI_2018`';
SET @stmt = "CREATE 
				ALGORITHM = UNDEFINED 
				DEFINER = `aali`@`%` 
				SQL SECURITY DEFINER
			VIEW `Report_FSI_2018` AS
            SELECT Region, Lead_Brand, Market, County, State, 
            Meeting_Block_1, Meeting_Block_2, Meeting_Block_3,
            Meeting_Block_4, Meeting_Block_5, Meeting_Block_6,   
			Meeting_Block_7, Meeting_Block_8, Meeting_Block_9,
            TFNs, YBR, Presentation_language
            FROM snap_fsi_tech.RDV_dev_test";

PREPARE dropst FROM @drp;
EXECUTE dropst;
PREPARE createstmt FROM @stmt;
EXECUTE createstmt;


END