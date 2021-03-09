--1. How many stops are in the database. 

SELECT COUNT(*) FROM stops

--2. Find the id value for the stop 'Craiglockhart' 

SELECT stops.id 
FROM stops WHERE stops.name= 'Craiglockhart'

--3.Give the id and the name for the stops on the '4' 'LRT' service. 

select id, name 
  from stops
  join route on id = stop
  where num = '4' and company = 'lrt';

--4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes. 

select company, num, count(*) as cnt 
  from route where stop=149 or stop=53
  group by company, num
  having cnt=2;

--5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road. 

select a.company, a.num, a.stop, b.stop 
  from route a 
  join route b on (a.company=b.company and a.num=b.num)
  where a.stop=53 and b.stop=149;

--6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross' 

select a.company, a.num, stopa.name, stopb.name 
  from route a 
  join route b on (a.company=b.company and a.num=b.num)
  join stops stopa on (a.stop=stopa.id)
  join stops stopb on (b.stop=stopb.id)
  where stopa.name='craiglockhart' and stopb.name='london road';

  --7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith') 

  select distinct a.company, a.num 
  from route a 
  join route b on (a.company =b.company and a.num=b.num)
  join stops stopa on (a.stop=stopa.id)
  join stops stopb on (b.stop=stopb.id)
  where stopa.name='haymarket' and stopb.name='leith';

  --8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross' 

  select distinct a.company, a.num 
  from route a
  join route b on (a.num=b.num and a.company=b.company)
  join stops stopa on (a.stop=stopa.id)
  join stops stopb on (b.stop=stopb.id)
  where stopa.name = 'craiglockhart' and stopb.name = 'tollcross';

  --9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services. 

  
select distinct stopb.name, a.company, a.num 
  from route a 
  join route b on a.company = b.company and a.num = b.num
  join stops stopa on a.stop = stopa.id
  join stops stopb on b.stop = stopb.id
  where stopa.name = 'craiglockhart';

  --10. Find the routes involving two buses that can go from Craiglockhart to Lochend.
  --Show the bus no. and company for the first bus, the name of the stop for the transfer,
  --and the bus no. and company for the second bus. 

  SELECT trip1.num, trip1.company, trip1.transfer, trip2.num, trip2.company
FROM (
  SELECT DISTINCT a.num, a.company, stopsb.name AS transfer
  FROM route AS a JOIN route AS b
  ON a.company = b.company AND a.num = b.num
  JOIN stops AS stopsa
  ON a.stop = stopsa.id
  JOIN stops AS stopsb
  ON b.stop = stopsb.id
  WHERE stopsa.name = 'Craiglockhart'
) AS trip1
JOIN (
  SELECT DISTINCT c.num, c.company, stopsc.name AS departure
  FROM route AS c JOIN route AS d
  ON c.company = d.company AND c.num = d.num
  JOIN stops AS stopsc
  ON c.stop = stopsc.id
  JOIN stops AS stopsd
  ON d.stop = stopsd.id
  WHERE stopsd.name = 'Lochend'
) AS trip2
ON trip1.transfer = trip2.departure
ORDER BY trip1.num, trip1.transfer, trip2.num