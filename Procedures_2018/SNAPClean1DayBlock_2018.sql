CREATE DEFINER=`asharma`@`%` PROCEDURE `SNAPClean1DayBlock_2018`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN

DECLARE pid INT;
DECLARE report_date  date;
DECLARE new_date  date;

declare bDone int default 0;


  DECLARE curs CURSOR FOR  
	SELECT 
	r.`pid`,
	r.`date`
	FROM `report_by_id_onepromotion_2018` r  
	GROUP BY `r`.`date`,`r`.`pid`
	HAVING COUNT(*) = 1
	ORDER BY `r`.`pid`, r.`date`;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET bDone := 1;
 

	open curs;
	curs_loop: loop
	fetch curs into pid, report_date;
	if bDone = 1 then 
	close curs;
	leave curs_loop;
	end if;


	-- change the date to latest date within 15 day range
	set new_date := null;

	set  new_date :=
	(select ifnull(
	(select
	MAX(r.`date`) 
	FROM `report_by_id_onepromotion_2018` r
	WHERE r.`date` BETWEEN DATE_ADD(report_date, INTERVAL - 15 DAY) AND  DATE_ADD(report_date, INTERVAL - 1 DAY) 
	AND r.`pid` = pid), NULL));

	if new_date is not null then
	update `report_by_id_onepromotion_2018`
	set `report_by_id_onepromotion_2018`.`date` = new_date
	where `report_by_id_onepromotion_2018`.`pid` = pid and `report_by_id_onepromotion_2018`.`date` = report_date;
	end if;

	end loop curs_loop; 
END