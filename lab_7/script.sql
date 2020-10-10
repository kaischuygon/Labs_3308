-- SETUP from homework

CREATE TABLE IF NOT EXISTS football_games (
  visitor_name VARCHAR(30),       /* Name of the visiting team                     */
  home_score SMALLINT NOT NULL,   /* Final score of the game for the Buffs         */
  visitor_score SMALLINT NOT NULL,/* Final score of the game for the visiting team */
  game_date DATE NOT NULL,        /* Date of the game                              */
  players INT[] NOT NULL,         /* This array consists of the football player ids (basically a foreign key to the football_player.id) */
  PRIMARY KEY(visitor_name, game_date) /* A game's unique primary key consists of the visitor_name & the game date (this assumes you can't have multiple games against the same team in a single day) */
);

CREATE TABLE IF NOT EXISTS football_players(
  id SERIAL PRIMARY KEY,       /* Unique identifier for each player (it's possible multiple players have the same name/similiar information) */
  name VARCHAR(50) NOT NULL,   /* The player's first & last name */
  year VARCHAR(3),             /* FSH - Freshman, SPH - Sophomore, JNR - Junior, SNR - Senior */
  major VARCHAR(4),            /* The unique 4 character code used by CU Boulder to identify student majors (ex. CSCI, ATLS) */
  passing_yards SMALLINT,      /* The number of passing yards in the players entire football career  */
  rushing_yards SMALLINT,      /* The number of rushing yards in the players entire football career  */
  receiving_yards SMALLINT,    /* The number of receiving yards in the players entire football career*/
  img_src VARCHAR(200)         /* This is a file path (absolute or relative), that locates the player's profile image */
);

INSERT INTO football_games(visitor_name, home_score, visitor_score, game_date, players)
VALUES('Colorado State', 45, 13, '20200831', ARRAY [1,2,3,4,5]),
('Nebraska', 33, 28, '20200908', ARRAY [2,3,4,5,6]),
('New Hampshire', 45, 14, '20200915', ARRAY [3,4,5,6,7]),
('UCLA', 38, 16, '20200928', ARRAY [4,5,6,7,8]),
('Arizona State', 28, 21, '20201006', ARRAY [5,6,7,8,9]),
('Southern California', 20, 31, '20201013', ARRAY [6,7,8,9,10]),
('Washington', 13, 27, '20201020', ARRAY [7,8,9,10,1]),
('Oregon State', 34, 41, '20201027', ARRAY [8,9,10,1,2]),
('Arizona', 34, 42, '20201102', ARRAY [9,10,1,2,3]),
('Washington State', 7, 31, '20201110', ARRAY [10,1,2,3,4]),
('Utah', 7, 30, '20201117', ARRAY [1,2,3,4,5]),
('California', 21, 33, '20201124', ARRAY [2,3,4,5,6])
;

INSERT INTO football_players(name, year, major, passing_yards, rushing_yards, receiving_yards)
VALUES('Cedric Vega', 'FSH', 'ARTS', 15, 25, 33),
('Myron Walters', 'SPH', 'CSCI', 32, 43, 52),
('Javier Washington', 'JNR', 'MATH', 1, 61, 45),
('Wade Farmer', 'SNR', 'ARTS', 14, 55, 12),
('Doyle Huff', 'FSH', 'CSCI', 23, 44, 92),
('Melba Pope', 'SPH', 'MATH', 13, 22, 45),
('Erick Graves', 'JNR', 'ARTS', 45, 78, 98 ),
('Charles Porter', 'SNR', 'CSCI', 92, 102, 125),
('Rafael Boreous', 'JNR', 'MATH', 102, 111, 105),
('Jared Castillo', 'SNR', 'ARTS', 112, 113, 114);

-- END SETUP

-- Name: Kai Schuyler Gonzalez

-- ### Answer Scripts

-- ## Section 3

-- # 3.1:Write an SQL Script to create a new table to hold information on the competing universities. The table should hold the following information:

    -- University Name (Text) (Note: University Name should be unique and set as PRIMARY KEY)
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

-- ##SECTION 4

-- #4.1 Write a script to list the Football Players (name & major), organized by major in college.

-- >>
select name,major from football_players
order by major;

-- #4.2 Write a script to list all of the Football Players (name & rushing yards) who have 70 or more rushing yards.

-- >>
select name,rushing_yards from football_players
WHERE rushing_yards > 70;

-- #4.3 Write a script to list all of the games played against Nebraska (show all game information).

-- >>
select * from football_games
where visitor_name = 'Nebraska';

-- #4.4 Write a script to list all of the games CU Boulder has won.

-- >>
select * from football_games
where home_score > visitor_score;

-- #4.5 Write a script to list all of the games played in the Fall 2020 Season (show team name & game date).

-- >>
select visitor_name, game_date from football_games
where game_date between '2020-09-01' and '2020-12-31';

-- #4.6 Write a script to list the average number of points CU has scored in past games.

-- >>
select AVG(home_score) from football_games;

-- #4.7 Write a script to list the majors of the Football players and calculate how many of them are in each of the majors listed. Rename the column where you calculate the majors to number_of_players.

-- >>
select  major,
        count(*) as number_of_players
from football_players
GROUP BY major;

-- #4.8 Write a script to modify the above query in 5.6 to include only the Football players who are majoring in Computer Science.

-- >>
select  major,
        count(*) as number_of_players
from football_players
WHERE major = 'CSCI'
GROUP BY major;

-- ##SECTION 5

-- #5.1 Write a script to create a view that counts the total number of winning games.

-- >>
create view v1 as
    select count(*) as winning_games from football_games
    where home_score > visitor_score;

-- #5.2 Write a script to create a view that counts the total number of games played.

-- >>
create view v2 as
    select count(*) as games from football_games;

-- drop view v2;

-- #5.3 Write a script that uses the two views you created (from 6.1 and 6.2) to calculate the percent of wins.

-- >>
select (cast(winning_games as decimal) / cast(games as decimal)) * 100 from v1, v2;

drop view v1; -- comment out if you want to keep the view
drop view v2; -- comment out if you want to keep the view

-- ##SECTION 6

-- #6.1 Write a script that will count how many games "Cedric Vega" has played in during his entire football career.

-- >>

-- #6.2 Write a script that will calculate the average number of rushing yards for "Cedric Vega", based on the number of games he has played.

-- >>