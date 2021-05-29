CREATE DATABASE AIRLINE_FLIGHT_DATABASE;

USE AIRLINE_FLIGHT_DATABASE;

CREATE TABLE FLIGHTS
(
	flno int,
    ffrom varchar(40),
    tto varchar(40),
    distance int,
    departs datetime,
    arrives datetime,
    price int,
    primary key(flno)
);

CREATE TABLE AIRCRAFT
(
	aid int,
    aname varchar(40),
    cruisingrange int,
	primary key(aid)
);

CREATE TABLE EMPLOYEES
(
	eid int,
    ename varchar(40),
    salary int,
    primary key(eid)
);

CREATE TABLE CERTIFIED
(
	eid int,
    aid int,
    FOREIGN KEY(aid) REFERENCES AIRCRAFT(aid),
    FOREIGN KEY(eid) REFERENCES EMPLOYEES(eid)
);


INSERT INTO FLIGHTS
VALUES (101,"Bangalore","Delhi",2500,'2005-05-13:07:15:31.000000','2005-05-13:07:15:31.000000',5000),
	(102,"Bangalore","Lucknow",3000,'2013-05-05:07:15:31.000000','2013-05-05:11:15:31.000000',6000),
	(103,"Lucknow","Delhi",500,'2013-05-05:12:15:31.000000','2013-05-05:17:15:31.000000',3000),
	(107,"Bangalore","Frankfurt",8000,'2013-05-05:07:15:31.000000','2013-05-05:22:15:31.000000',60000),
	(104,"Bangalore","Frankfurt",8500,'2013-05-05:07:15:31.000000','2013-05-05:23:15:31.000000',75000),
	(105,"Kolkata","Delhi",3400,'2013-05-05:07:15:31.000000','2013-05-05:09:15:31.000000',7000);
SELECT * FROM FLIGHTS;
				
INSERT INTO AIRCRAFT
VALUES (101,747,3000),(102,"Boeing",900),(103,647,800),(104,"Dreamliner",10000),
		(105,"Boeing",3500),(106,707,1500),(107,"Dream",120000);
 SELECT * FROM AIRCRAFT;
       
INSERT INTO  EMPLOYEES
VALUES (701,"A",50000),(702,"B",100000),(703,"C",150000),(704,"D",90000),
		(705,"E",40000),(706,"F",60000),(707,"G",90000);
SELECT * FROM EMPLOYEES;
       
INSERT INTO CERTIFIED
VALUES (701,101),(701,102),(701,106),(701,105),(702,104),(703,104),(704,104),(702,107),
		(703,107),(704,107),(702,101),(703,105),(704,105),(705,103);
SELECT * FROM CERTIFIED;

SELECT distinct a.aname 
FROM  AIRCRAFT a,EMPLOYEES e,CERTIFIED c 
WHERE a.aid=c.aid and e.eid=c.eid and e.salary>80000;

SELECT e.eid,e.ename,max(a. cruisingrange)
FROM EMPLOYEES e,CERTIFIED c,AIRCRAFT a 
WHERE e.eid=c.eid and a.aid=c.aid
group by e.ename 
having count(c.aid)>3;

SELECT e.ename 
FROM EMPLOYEES e
WHERE salary < (select min(price)
			   from FLIGHTS
               where ffrom="Bangalore" and tto="Frankfurt");

SELECT a.aname,a.cruisingrange,avg(e.salary)
FROM AIRCRAFT a,EMPLOYEES e,CERTIFIED c
WHERE c.eid=e.eid and c.aid=a.aid
group by a.aname
having a.cruisingrange > 1000;

SELECT distinct e.ename
FROM EMPLOYEES e,CERTIFIED c,AIRCRAFT a
WHERE e.eid=c.eid and a.aid=c.aid and aname like "Boeing";

SELECT a.aid
FROM AIRCRAFT a
WHERE a. cruisingrange >= (select distance
							from FLIGHTS
                            where ffrom="Bangalore" and tto="Delhi");
                            
SELECT  f.ffrom,f.tto,f.arrives                          
FROM    FLIGHTS f                
WHERE (f.ffrom="Bangalore" and f.tto=(select ffrom 
									  from FLIGHTS
                                      where tto="Kolkata")) or f.tto="Kolkata";
