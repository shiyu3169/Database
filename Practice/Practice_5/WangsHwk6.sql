
-- ------------------------ Question 1 -----------------------------
-- A procedure accepts a character name and returns a result set 
-- that contains a list of the movie scenes the character is in.
DROP PROCEDURE IF EXISTS track_character;
DELIMITER $$
CREATE PROCEDURE track_character
(IN cha NVARCHAR(50))
BEGIN
	SELECT
		t.character_name,
		t.planet_name,
		m.title AS movie_name,
		SUM(t.departure - t.arrival) AS screen_time
	FROM 
		timetable t  
		INNER JOIN movies m ON t.movie_id = m.movie_id
	WHERE
		character_name = cha
	GROUP BY
		t.character_name,
		t.planet_name,
		m.title;
END $$
DELIMITER ;

-- call the procedure to test
-- call track_character('C-3 PO');


-- ------------------------ Question 2 -----------------------------
-- A procedure accepts a planet name and returns a result set 
-- that contain the planet name, the movie name, and the number of characters 
-- that appear on that planet during that movie
DROP PROCEDURE IF EXISTS track_planet;
DELIMITER $$
CREATE PROCEDURE track_planet
(IN pla NVARCHAR(50))
BEGIN
	SELECT
		p.planet_name,
        m.title,
		COUNT(DISTINCT t.character_name) AS number_character_appear
	FROM
		timetable t
		INNER JOIN planets p ON t.planet_name = p.planet_name
        INNER JOIN movies m ON m.movie_id =t.movie_id
	WHERE
		p.planet_name = pla
	GROUP BY
		p.planet_name,
        m.title;
END $$
DELIMITER ;

-- call the procedure to test
-- call track_planet('Dagobah');

-- ------------------------ Question 3 -----------------------------
-- A function accepts a character name 
-- and returns the number of planets the character has appeared on
DROP FUNCTION IF EXISTS  planet_hopping;
DELIMITER $$
CREATE FUNCTION planet_hopping(cha NVARCHAR(50))
	RETURNS INT
 BEGIN
	DECLARE number_character INT;

    SELECT 
		COUNT(DISTINCT planet_name)
	INTO 
        number_character 
	FROM
		timetable
	WHERE
		character_name = cha
	GROUP BY 
		character_name;
        
	RETURN (number_character);
END $$ 
DELIMITER ;
-- call the function on any table to test 
-- SELECT planet_hopping('C-3 PO');

-- ------------------------ Question 4 -----------------------------
-- A function accepts a character name
-- and returns the name of the planet
-- where the character appeared the most
DROP FUNCTION IF EXISTS planet_most_visited;
DELIMITER $$
CREATE FUNCTION planet_most_visited(cha NVARCHAR(50))
	RETURNS NVARCHAR(50)
BEGIN
	DECLARE planet NVARCHAR(50);

	SELECT 
		planet_name
	INTO 
		planet 
    FROM
		timetable
	WHERE
		character_name = cha
	GROUP BY 
		planet_name
	ORDER BY 
		COUNT(DISTINCT character_name) DESC
	LIMIT 1;
        
	RETURN (planet);
END $$ 
DELIMITER ;
-- call the function on any table to test 
-- SELECT planet_most_visited('C-3 PO');


-- ------------------------ Question 5 -----------------------------
-- A function accepts a character name and returns TRUE 
-- if the character has the same affiliation as his home planet, 
-- FALSE if the character has a different affiliation than his home planet 
-- or NULL if the home planet or the affiliation is not known.
DROP FUNCTION IF EXISTS home_affiliation_same;
DELIMITER $$
CREATE FUNCTION home_affiliation_same(cha NVARCHAR(50))
	RETURNS BOOLEAN
BEGIN
	DECLARE aff nvarchar(5);

	SELECT 
		c.affiliation = p.affiliation
	INTO
		aff 
    FROM
		characters c
        INNER JOIN
		planets p ON c.homeworld = p.planet_name
	WHERE
		c.character_name = cha;
	
	RETURN (aff);
END $$ 
DELIMITER ;
-- call the function on any table to test 
-- SELECT home_affiliation_same('Chewbacca');
-- SELECT home_affiliation_same('C-3 PO');

-- ------------------------ Question 6 -----------------------------
-- a function that accepts a planet’s name as an argument
-- and returns the number of movies that the planet appeared in.
DROP FUNCTION IF EXISTS planet_in_num_movies;
DELIMITER $$
CREATE FUNCTION planet_in_num_movies(pla NVARCHAR(50))
	RETURNS int
BEGIN
	DECLARE num_movies int;

	SELECT 
		COUNT(DISTINCT t.movie_id)
	INTO 
		num_movies 
    FROM
		timetable t
	WHERE
		t.planet_name = pla;
	
	RETURN (num_movies);
END $$ 
DELIMITER ;

-- call the function on any table to test 
SELECT  planet_in_num_movies('Dagobah');

-- ------------------------ Question 7 -----------------------------
-- A procedure accepts an affiliation and returns the character records 
-- (all fields associated with the character) with that affiliation.
DROP PROCEDURE IF EXISTS character_with_affiliation;
DELIMITER $$
CREATE PROCEDURE character_with_affiliation
(IN aff NVARCHAR(50))
BEGIN
	SELECT 
		*
	FROM
		characters c
	WHERE
		c.affiliation = aff;
END $$
DELIMITER ;
-- call the procedure to test
 call character_with_affiliation('rebels');
 
-- ------------------------ Question 8 -----------------------------
-- A trigger that updates the field scenesinDB for the movie records in the Movies table.
-- The field should contain the maximum scene number found in the timetable table for that movie.
DROP TRIGGER IF EXISTS timetable_after_insert;
DELIMITER $$
CREATE TRIGGER timetable_after_insert
	AFTER INSERT ON timetable 
	FOR EACH ROW 
		BEGIN
            SET @scene = (SELECT scenes_in_db FROM movies WHERE movies.movie_id = new.movie_id);
			IF 
				@scene < new.departure
            THEN
				UPDATE movies
                SET scenes_in_db = new.departure
                where movies.movie_id = new.movie_id;
			END IF;
		END $$
DELIMITER ;
-- test the trigger after insert
INSERT INTO timetable (character_name, planet_name, movie_id, arrival, departure) VALUES ('Chewbacca', 'Endor', 3, 11, 12);
INSERT INTO timetable (character_name, planet_name, movie_id, arrival, departure) VALUES ('Princess Leia', 'Endor', 3, 11, 12); 
SELECT * FROM movies;
-- delete the test records (remove it if necessary)
DELETE FROM timetable WHERE time_id > 65;

-- ------------------------ Question 9 -----------------------------
-- Create and execute a prepared statement from the SQL workbench 
-- that calls track_character with the argument ‘Princess Leia’.
SET @cha_name = 'Princess Leia'; 
SET @query1 =  'CALL track_character(?)';
PREPARE stmt1 FROM @query1;
EXECUTE stmt1 using @cha_name;


-- ------------------------ Question 10 ----------------------------
-- Create and execute a prepared statement that calls planet_in_num_movies() with the argument ‘Bespin’
SET @pla_name = 'Bespin';
SET @query2 =  'SELECT planet_in_num_movies(?)';
PREPARE stmt2 FROM @query2;
EXECUTE stmt2 using @pla_name;

