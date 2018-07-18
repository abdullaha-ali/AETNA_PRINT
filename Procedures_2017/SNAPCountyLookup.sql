CREATE DEFINER=`asharma`@`%` PROCEDURE `SNAPCountyLookup`()
BEGIN

INSERT INTO `aetna_event_county_lookup`

SELECT e.`Venue_County`,

NULL,

e.`Venue_State`

FROM `aetna_print_events2` e

WHERE e.`id` NOT IN

(SELECT ae.id FROM `aetna_print_events2` ae

JOIN `aetna_print_publication` ap

ON LOWER(ap.`State`) = LOWER(ae.`Venue_State`) AND LOWER(ap.`Dominant_County`) = LOWER(ae.`Venue_County`))

AND (e.`Venue_County`,e.`Venue_State`) NOT IN (SELECT `old_county` ,`state` FROM `aetna_event_county_lookup`)

GROUP BY e.`Venue_State`, e.`Venue_County`

ORDER BY e.`Venue_State`, e.`Venue_County`;

UPDATE`aetna_print_events2` e, (SELECT * FROM `aetna_event_county_lookup` l

WHERE l.`new_county` IS NOT NULL OR l.`new_county` != '') ll

SET e.`Venue_County` = ll.`new_county`

WHERE e.`Venue_County` = ll.`old_county` AND e.`Venue_State` = ll.`state`;

END