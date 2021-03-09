--1.  show the matchid and player name for all goals scored by Germany.

SELECT matchid,  player FROM goal 
  WHERE teamid = 'GER'

--2. From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.

SELECT id,stadium,team1,team2
  FROM game g1
join goal g2 WHERE g1.id = g2.matchid and matchid = 1012 AND player = 'Lars Bender'

--3. Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player, teamid, stadium, mdate
FROM goal JOIN game
ON game.id = goal.matchid
WHERE goal.teamid = 'GER'

--4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
FROM goal JOIN game
ON goal.matchid = game.id
WHERE goal.player LIKE 'Mario%';

--5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
FROM goal JOIN eteam
ON goal.teamid = eteam.id
WHERE gtime <= 10;

--6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
FROM game JOIN eteam
ON game.team1 = eteam.id
WHERE coach = 'Fernando Santos';

--7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player
FROM goal JOIN game
ON goal.matchid = game.id
WHERE game.stadium = 'National Stadium, Warsaw';

--8. show the name of all players who scored a goal against Germany.

SELECT DISTINCT player
FROM goal JOIN game
ON goal.matchid = game.id
WHERE 'GER' IN (team1, team2) AND teamid <> 'GER';

--9. Show teamname and the total number of goals scored.

SELECT teamname, COUNT(player)
FROM eteam JOIN goal
ON eteam.id = goal.teamid
GROUP BY teamname;