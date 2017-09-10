USE starwarsfinal;
/* 
Question 1
  Differences: 
    1) In my old starwars schema, I have an affiliation table to store the affiliation and 
	   let affliation from movies and characters tables refrence it and update cascade with it.
	   I think this improves the mechanics of data integrity that we can change one place to change everything in the database, which reduce
	   the mistakes. (same idea for planet name in planets table and homeworld in characters table)
	2) Compared with my old schema, the new one gives more space for title of movies. I think it imporved the mechanics of data integrity, 
       because the data of movies.title may be out of 45 bits. 
	3) Compared with my old schema, the new one gives less space for planet type and affiliatin in planet table. 
	   I think it imporved the mechanics of data integrity, because the data of movies won't be more than 30 bits. 
       (I think we can also reduce the space of affiliation in characters table).
	4) Compared with my old schema, the new one doesn't limit none null for the characters' names, 
	   planets' names and movie ints in character tale and the title in movies table, 
	   I think this decreases the mechanics of the data integrity.
	   It makes more sense to limit them not null to represent movies and characters in movies.
	5) All foreign keys are setted as update cascade or delete set null(/cascade) in starwasfinal. 
       I think this improves the mechanics of data integrity as well 
       that we can change one thing but not cause error or problem of other tables.
*/
-- Question 2
SELECT
	t.character_name,
    t.planet_name,
    m.title AS movie_name,
    SUM(t.departure - t.arrival) AS screen_time
FROM 
	timetable t  
    INNER JOIN movies m ON t.movie_id = m.movie_id
GROUP BY
	t.character_name,
    t.planet_name,
    m.title;

-- Question 3
-- use distinct to get rid of duplicate count of same planet
SELECT
	character_name,
    COUNT(DISTINCT planet_name) AS number_planets_appear
FROM 
	timetable
GROUP BY
	character_name;
    
-- Question 4
-- use distinct to get rid of duplicate count of same character
SELECT
	COUNT(DISTINCT t.character_name) AS number_character_appear
FROM
	timetable t
    INNER JOIN planets p ON t.planet_name = p.planet_name
WHERE
	p.planet_type = 'desert';
    
-- Question 5
-- use distinct to get rid of duplicate count of same character
SELECT
	planet_name,
    COUNT(DISTINCT character_name) number_visit
FROM 
	timetable
GROUP BY 
	planet_name
ORDER BY
	COUNT(DISTINCT character_name) DESC
LIMIT 1;

-- Question 6
-- use distinct to get rid of duplicate count of same character
SELECT
	t.planet_name
FROM 
	timetable t 
GROUP BY
	t.planet_name
HAVING
	COUNT(DISTINCT t.character_name) = (SELECT COUNT(*) FROM characters);

-- Question 7
CREATE TABLE IF NOT EXISTS Movie1Timings AS 
(
	SELECT 
		*
	FROM
		timetable
	WHERE
		movie_id = 1
);

-- Question 8
SELECT
	t.character_name,
    m.title AS movie_name,
    SUM(t.departure - t.arrival) AS screen_time
FROM 
	timetable t  
    INNER JOIN movies m ON t.movie_id = m.movie_id
WHERE t.character_name = "Lando Calrissian"
GROUP BY
	t.character_name,
    m.title
ORDER BY
	SUM(t.departure - t.arrival) DESC
LIMIT 1;

-- Question 9
-- use distinct to get rid of duplicate count of same character
SELECT 
	planet_type,
    GROUP_CONCAT(DISTINCT t.character_name SEPARATOR ', ') AS characters_appeard
FROM 
	timetable t
    INNER JOIN planets p ON t.planet_name = p.planet_name
GROUP BY
	p.planet_type;
    
-- Question 10
SELECT 
	planet_type,
    COUNT(DISTINCT t.character_name) AS number_characters_appearing
FROM 
	timetable t
    INNER JOIN planets p ON t.planet_name = p.planet_name
WHERE 
	t.movie_id = 2
GROUP BY
	p.planet_type
ORDER BY
	COUNT(t.character_name)
LIMIT 1;

-- Question 11
SELECT 
	COUNT(character_name) AS number_characters
FROM 
	characters
WHERE 
	affiliation = "rebels";
    
-- Quesion 12
CREATE TABLE IF NOT EXISTS RebelsinMovie1Timings AS (SELECT * FROM
    timetable
WHERE
    character_name IN (SELECT 
            character_name
        FROM
            characters
        WHERE
            affiliation = 'rebels'));

-- Question 13
SELECT
	c.character_name
FROM 
	characters c
    INNER JOIN planets p ON c.homeworld = p.planet_name
WHERE
	c.affiliation = p.affiliation;