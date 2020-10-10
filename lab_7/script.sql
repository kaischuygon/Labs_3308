-- Name: Kai Schuyler Gonzalez
-- ### Answer Scripts

-- ## Section 3

-- # 3.1: Write an SQL Script to create a new table to hold information on the competing universities. The table should hold the following information:
    -- University Name (Text) (Note: University Name should be unique and set AS PRIMARY KEY)
    -- Date Established (Date)
    -- Address (Address)
    -- Student Population (Int)
    -- Acceptance Rate (Decimal)
-- >>
CREATE TABLE IF NOT EXISTS competing_universities (
    university_name VARCHAR(30),
    date_established date,
    address VARCHAR(100),
    student_population int,
    acceptance_rate decimal,
    PRIMARY KEY(university_name)
);

-- # 3.2 Write an insert statement to add the University Information The table should hold the following information:
    -- University Name :- CU Boulder
    -- Date Established :- April 1st, 1876
    -- Address :- 1100 28th St, Boulder, CO 80303
    -- Student Population :- 35,000
    -- Acceptance Rate :- 80%
-- >>
INSERT INTO competing_universities(university_name, date_established, address, student_population, acceptance_rate)
VALUES('CU Boulder', '1876-04-01', '1100 28th St, Boulder, CO 80303', 35000, 80);

-- ## SECTION 4

-- # 4.1 Write a script to list the Football Players (name & major), organized by major in college.
-- >>
SELECT name,major FROM football_players
order by major;

-- # 4.2 Write a script to list all of the Football Players (name & rushing yards) who have 70 or more rushing yards.
-- >>
SELECT name,rushing_yards FROM football_players
WHERE rushing_yards > 70;

-- # 4.3 Write a script to list all of the games played against Nebraska (show all game information).
-- >>
SELECT * FROM football_games
WHERE visitor_name = 'Nebraska';

-- # 4.4 Write a script to list all of the games CU Boulder hAS won.
-- >>
SELECT * FROM football_games
WHERE home_score > visitor_score;

-- # 4.5 Write a script to list all of the games played in the Fall 2020 Season (show team name & game date).
-- >>
SELECT visitor_name, game_date FROM football_games
WHERE game_date between '2020-09-01' and '2020-12-31';

-- # 4.6 Write a script to list the average number of points CU hAS scored in past games.
-- >>
SELECT AVG(home_score) FROM football_games;

-- # 4.7 Write a script to list the majors of the Football players and calculate how many of them are in each of the majors listed. Rename the column WHERE you calculate the majors to number_of_players.
-- >>
SELECT  major, count(*) AS number_of_players
FROM football_players
GROUP BY major;

-- # 4.8 Write a script to modify the above query in 5.6 to include only the Football players who are majoring in Computer Science.
-- >>
SELECT major, count(*) AS number_of_players
FROM football_players
WHERE major = 'CSCI'
GROUP BY major;

-- ## SECTION 5

-- # 5.1 Write a script to create a view that counts the total number of winning games.
-- >>
create view games_won as
SELECT count(*) AS winning_games FROM football_games
WHERE home_score > visitor_score;
select * from games_won;

-- # 5.2 Write a script to create a view that counts the total number of games played.
-- >>
create view games_tot as
SELECT count(*) AS games FROM football_games;
select * from games_tot;

-- # 5.3 Write a script that uses the two views you created (FROM 6.1 and 6.2) to calculate the percent of wins.

-- >>
SELECT (cast(winning_games AS decimal) / cast(games AS decimal)) * 100 FROM games_won, games_tot;

-- ## SECTION 6

-- # 6.1 Write a script that will count how many games "Cedric Vega" hAS played in during his entire football career.

-- >>
create view cedric_vega_games as
SELECT count(*) AS count FROM football_players
INNER JOIN football_games ON name = 'Cedric Vega' and id = any(players);
select * from cedric_vega_games;

-- # 6.2 Write a script that will calculate the average number of rushing yards for "Cedric Vega", based on the number of games he hAS played.

-- >>
create view cedric_vega_avg as
SELECT (cast(rushing_yards AS decimal) / cast(count AS decimal)) FROM cedric_vega_games, football_players
WHERE name = 'Cedric Vega';
select * from cedric_vega_avg;