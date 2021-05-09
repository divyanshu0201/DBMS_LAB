create database sample7;
use sample7;
create table PERSON(
driver_id char(20) NOT NULL,
Name_ char(30),
address char(50),
PRIMARY KEY (driver_id)
);

create table car(
reg_num char(20),
model char(30),
year int,
PRIMARY KEY(reg_num)
);

create table ACCIDENT(
report_num int,
accident_date date,
location char(50),
PRIMARY KEY(report_num)
);

create table OWNS(
driver_id char(20),
reg_num char(20),
FOREIGN KEY(driver_id) references PERSON(driver_id),
FOREIGN KEY(reg_num) references car(reg_num)
);

create table PARTICIPATED(
driver_id char(20),
reg_num char(20),
report_num int,
damage_amount int,
FOREIGN KEY(driver_id) references PERSON(driver_id),
FOREIGN KEY(reg_num) references car(reg_num),
FOREIGN KEY(report_num) references ACCIDENT(report_num)
);

insert into PERSON
values ("A01","RICHARD","SRINIVAS NAGAR"),("A02","PRADEEP","RAJAJI NAGAR"),("A03","SMITH","ASHOK NAGAR")
,("A04","VENU","N R COLONY"),("A05","JHON","HANUMANYH NAGAR");
select* from PERSON;

insert into car
values ("KA052250","INDICA",1990),("KA031181","LANCER",1957),("KA095477","TOYOTA",1998)
,("KA053408","HONDA",2008),("KA041702","AUDI",2005);
select* from car;

insert into ACCIDENT
values (11,"2003-01-01","MYSORE ROAD"),(12,"2004-02-02","SOUTH END CIRCLE"),(13,"2003-01-21","BULL TEMPLE ROAD");
select* from ACCIDENT;

insert into ACCIDENT
values (14,"2008-02-17","MYSORE ROAD"),(15,"2005-03-04","KANAKPURA ROAD");
select* from ACCIDENT;

insert into OWNS
values ("A01","KA052250"),("A02","KA053408"),("A03","KA031181"),("A04","KA095477"),("A05","KA041702");
select* from OWNS;

insert into PARTICIPATED
values ("A01","KA052250",11,10000),("A02","KA053408",12,50000),("A03","KA095477",13,25000)
,("A04","KA031181",14,3000),("A05","KA041702",15,5000);
select* from PARTICIPATED;

update PARTICIPATED
SET damage_amount=25000
WHERE reg_num="KA053408";

select* from PARTICIPATED;

insert into ACCIDENT
values (16,"2018-03-29","KORMANGLA");
select* from ACCIDENT;

SELECT COUNT(accident_date) AS accidentsin2008 FROM ACCIDENT
WHERE YEAR(accident_date)=2008;

SELECT COUNT(model) AS carwithhondaomodel FROM car
WHERE model="HONDA";

select* from ACCIDENT
where accident_date="2008-02-17";

insert into PERSON
values ("A06","JOHN","BANSHANKARI SATGE 2");
select * from PERSON;

insert into car
values ("KA05MC001","AUDI",2018);
select * from car;

insert into ACCIDENT
values (17,"2019-03-01","BULL TEMPLE RD");
select * from ACCIDENT;

insert into OWNS
values ("A06","KA05MC001");
select * from OWNS;

insert into PARTICIPATED
values ("A06","KA05MC001",17,75000);

select * from PARTICIPATED;

SELECT driver_id, reg_num FROM OWNS WHERE reg_num IN(SELECT reg_num FROM car WHERE model="indica"); 

SELECT reg_num FROM PARTICIPATED WHERE report_num IN(SELECT report_num FROM ACCIDENT WHERE YEAR(accident_date)>=2003 AND YEAR(accident_date)<=2005);

SELECT COUNT(*) FROM ACCIDENT WHERE location LIKE "%MYSORE%";

SELECT driver_id FROM PARTICIPATED WHERE damage_amount>=(SELECT AVG(damage_amount) FROM PARTICIPATED);

SELECT COUNT(*) FROM ACCIDENT WHERE YEAR(accident_date)=2008;

DELETE FROM PERSON WHERE Name_="JOHN";
