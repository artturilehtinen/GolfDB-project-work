-- Query 1, all the golf pros and their wins
SELECT * FROM Golf_pros g
INNER JOIN Tour_wins tw ON tw.golf_pro_id = g.golf_pro_id;

-- Query 2 the view's name tells it all
CREATE VIEW Caddies_with_known_ages AS
SELECT first_name AS "First name", last_name AS "Last name", birth_year AS "Birth year" FROM Caddies
WHERE Caddies.birth_year IS NOT NULL
ORDER BY last_name;

SELECT * FROM Caddies_with_known_ages;

-- Query 3, players with at least 4 sponsors, their coaches and sponsors' names
DROP VIEW IF EXISTS Players_with_many_sponsors;
CREATE VIEW Players_with_many_sponsors ("Pro last name", "Pro first name", "Coaches", "Sponsors") AS
SELECT g.last_name, g.first_name, GROUP_CONCAT(DISTINCT c.first_name || ' ' || c.last_name), GROUP_CONCAT(DISTINCT s.name)
FROM Golf_pros g
JOIN Coached_by cb ON g.golf_pro_id = cb.golf_pro_id
JOIN Coaches c ON cb.coach_id = c.coach_id
JOIN Sponsored_by sb ON g.golf_pro_id = sb.golf_pro_id
JOIN Sponsors s ON sb.sponsor_id = s.sponsor_id
GROUP BY g.golf_pro_id
HAVING COUNT(DISTINCT s.sponsor_id) >= 4
ORDER BY COUNT(DISTINCT s.sponsor_id) DESC;

SELECT * FROM Players_with_many_sponsors;

-- Query 4, players with more than 15 total wins and their world rank in order
SELECT 
	g.first_name || ' ' || g.last_name AS "Pro",
	tw.PGA_tour_wins + tw.European_tour_wins + tw.other_wins AS "Total wins",
	wr.rank AS "World rank"
FROM Golf_pros g
JOIN World_ranking wr ON g.golf_pro_id = wr.golf_pro_id
JOIN Tour_wins tw ON g.golf_pro_id = tw.golf_pro_id
WHERE ("Total wins") > 15
ORDER BY wr.rank ASC;

-- Query 5, averages of world ranking table stats
SELECT
	AVG(wr.total_points) AS "Average total points",
	AVG(wr.avg_points) AS "Average of average ppe",
	AVG(wr.events_played_div) AS "Average events played"
FROM Golf_pros g
JOIN World_ranking wr ON g.golf_pro_id = wr.golf_pro_id;