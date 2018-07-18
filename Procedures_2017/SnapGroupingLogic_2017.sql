CREATE DEFINER=`root`@`%` PROCEDURE `SnapGroupingLogic_2017`()
BEGIN
SET @cout=0;
SET @count2=0;
update `report_by_id_group_2017` rgp,
(
SELECT 
p.`pid`,
p.`eid`,
p.`date`,
p.`geid`,
p.`gdate`,
p.`gtime`,
@group_rank := IF(@curr_pid = p.`pid`  AND @count2<7 , concat('Group',@cout) , concat('Group',@cout+1)) AS `grouprank`,
@count2:=@count2+1,
@cout:=@cout+1,
@curr_pid:=p.`pid`
FROM 
`report_by_id_group_2017` p,(SELECT @count2:=0,@curr_pid) t 
ORDER BY p.`pid` DESC
)pr 
SET 
rgp.`grouprank`=pr.`grouprank`
where 
rgp.`pid`=pr.`pid` ;-- and rgp.`date`=pr.`date`;
END