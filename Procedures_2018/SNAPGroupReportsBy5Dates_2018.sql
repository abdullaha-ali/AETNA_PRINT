CREATE DEFINER=`asharma`@`%` PROCEDURE `SNAPGroupReportsBy5Dates_2018`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
/*
-----------UPDATE REPORT QUERY------------
*/
DECLARE pid  INT;
DECLARE sfid INT;
DECLARE report_date  date;
DECLARE geid  text(2048);
DECLARE count  INT; 
declare counter INT; 
DECLARE Publication text(2048);
DECLARE NewspaperType text(2048);
DECLARE County text(2048);
DECLARE State text(2048);
DECLARE Market text(2048);

declare bDone int default 0;

DECLARE col  INT;
DECLARE mcol INT; 


  DECLARE curs CURSOR FOR  
	SELECT
	distinct	r.`pid`,
		-- r.`sfid`,
		GROUP_CONCAT(r.`sfid`),
		r.`date`,
		GROUP_CONCAT(DISTINCT(m.`geid`)),  
		COUNT(DISTINCT(m.`geid`)) ,
		p.PublicationName,
		p.NewspaperType,
		e.Venue_County,
		e.Venue_State,
		e.Market
		FROM `report_by_id_onepromotion_2018` r
		LEFT JOIN `aetna_print_publication_2018` p
		ON r.`pid` = p.`id`
		LEFT JOIN `multipleEvent_2018` m
		ON r.`sfid` = m.`id`
		LEFT JOIN `event_by_day_group_2018` e
		ON r.`sfid` = e.`id`
		LEFT JOIN `event_latest_2018` el
		ON m.`geid` = el.`id`
	-- 	GROUP BY r.`pid`, r.`date`, e.`detail`;
		GROUP BY p.PublicationName, p.State, e.`detail`;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET bDone := 1;

truncate `report_by_id_group_2018`;

	open curs;
	curs_loop: loop
	fetch curs into pid, sfid,report_date,geid,count,Publication,NewspaperType, County, State, Market;
	if bDone = 1 then 
	close curs;
	leave curs_loop;
	end if;

	
	-- second loop
		block2:begin

			-- table 2
			DECLARE gid  text(2048);
			DECLARE gdate  text(2048);
			DECLARE gtime  text(2048);
			DECLARE count2  INT; 
			DECLARE tempNum  INT; 

			-- table 3 
			DECLARE gid2  text(2048);
			DECLARE gdate2  text(2048);
			DECLARE gtime2  text(2048);
			declare attribute_done boolean default false; 
			DECLARE olddate  text(2048) default '';


			DECLARE cur2 cursor for
				SELECT 
				GROUP_CONCAT(t1.`id` )AS `id`,
				GROUP_CONCAT(date_format(t1.`date`,'%m/%e')) AS `date`,
				 t1.`time`  ,
				COUNT(*) AS total
				FROM
				(
				SELECT 
				GROUP_CONCAT(e.`id`) AS `id`,
				 e.`Event_Date`  AS `date`,
				GROUP_CONCAT(e.`Event_Time` order by substring_index(substring_index(e.Event_Time,' ',2), ' ',-1), substring_index(e.Event_Time,' ',1) SEPARATOR ', ') AS `time`
				#GROUP_CONCAT(e.`Event_Time` ORDER BY e.`Event_Time`) AS `time`
				FROM `event_latest_2018` e
				WHERE FIND_IN_SET(e.`id`, geid) 
				GROUP BY e.`Event_Date`
				) t1
				GROUP BY t1.`time` ;
				DECLARE CONTINUE HANDLER FOR NOT FOUND SET attribute_done := TRUE;
				open cur2;

				cur2_loop: LOOP
				FETCH FROM cur2 INTO gid, gdate, gtime, count2;   

				
					IF attribute_done THEN  
					close cur2;
					LEAVE cur2_loop;
					END IF; 

				
	 

				-- cur2 content
					if count2 < 6 then
					-- insert into report table
					insert into `report_by_id_group_2018`
					value (pid, sfid, report_date, gid, replace(gdate, ',', ', '), lower(gtime),Publication,NewspaperType ,County, State, Market,null);
					
		
					else 

						
						set tempNum = 0;
						while(count2 > 0) do
							set gid2 := '';
							set gdate2 := '';
							SELECT 
								GROUP_CONCAT(t1.`id`) AS `id`,
								GROUP_CONCAT(date_format(t1.`date`,'%m/%e')) AS `date` 
								into gid2, gdate2 
								FROM
								(
								SELECT 
								GROUP_CONCAT(e.`id`) AS `id`,
								 e.`Event_Date`  AS `date`,
								#GROUP_CONCAT(e.`Event_Time` ORDER BY e.`Event_Time`) AS `time`
								GROUP_CONCAT(e.`Event_Time` order by substring_index(substring_index(e.Event_Time,' ',2), ' ',-1), substring_index(e.Event_Time,' ',1)  SEPARATOR ', ') AS `time`
								FROM `event_latest_2018` e
								WHERE FIND_IN_SET(e.`id`, gid)
								AND FIND_IN_SET(e.Event_Time, gtime)

								-- AND  NOT FIND_IN_SET(e.Event_Date, olddate)
								GROUP BY e.`Event_Date`
                        LIMIT tempNum, 5
								) t1
								GROUP BY t1.`time` ;

							-- insert into report table
							insert into `report_by_id_group_2018`
							value (pid, sfid, report_date, gid2, replace(gdate2, ',', ', '), lower(gtime),Publication,NewspaperType ,County, State, Market,null);

							set tempNum := tempNum + 5;
							set count2 := count2 - 5;
						end while;

					end if;
				
				-- add current date set for next loop, for some event has multi times on same date
				-- set olddate = concat(olddate , ',',gdate);
				end loop cur2_loop;
		end block2;
	end loop curs_loop; 



    END