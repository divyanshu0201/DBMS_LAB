create database orderdb2;
use orderdb2;
create table salesman(
salesman_id varchar(20),
salesman_name varchar(20),
salesman_city varchar(20),
commission varchar(20),
primary key(salesman_id)
);
create table customer(
customer_id varchar(20),
customer_name varchar(20),
customer_city varchar(20),
grade varchar(20),
salesman_id varchar(20),
primary key(customer_id),
foreign key(salesman_id) references salesman(salesman_id) on delete set null);
create table orders(
ord_no int,
purchase_amt double,
ord_date date,
customer_id varchar(20),
salesman_id varchar(20),
foreign key(salesman_id) references salesman(salesman_id) on delete cascade,
foreign key(customer_id) references customer(customer_id) on delete cascade
);
insert into salesman values("1000","JHON","BANGLORE","25%"),
("2000","RAVI","BANGLORE","20%"),
("3000","KUMAR","MYSORE","15%"),
("4000","SMITH","DELHI","30%"),
("5000","HARSHA","HYDRABAD","15%");
select * from salesman;
insert into customer values("10","PREETHI","BANGLORE","100","1000"),
("11","VIVEK","MANGLORE","300","1000"),
("12","BHASKAR","CHENNAI","400","2000"),
("13","CHETHAN","BANGLORE","200","2000"),
("14","MAMTHA","BANGLORE","400","3000");
select * from customer;
insert into orders values("50","5000","17-05-04","10","1000"),
("51","450","17-01-20","10","2000"),
("52","1000","17-02-24","13","2000"),
("53","3500","17-04-13","14","3000"),
("54","550","17-03-09","12","2000");
select * from orders;
select grade,count(distinct customer_id) from customer group by grade having grade > (select
avg(grade) from customer where customer_city ="BANGLORE");
select salesman_id ,salesman_name from salesman S where 1 <(select count(*) from customer
where salesman_id = S.salesman_id);
select salesman.salesman_id ,salesman_name,customer_name,commission from
salesman,customer where salesman_city = customer_city union select
salesman_id,salesman_name ,'NO MATCH FOUND',commission from salesman where not
salesman_city = any(select customer_city from customer)order by 2 desc;
create view best_salesman as select b.ord_date ,a.salesman_id,a.salesman_name from
salesman a,orders b where a.salesman_id=b.salesman_id and b.purchase_amt=(select
max(purchase_amt) from orders c where c.ord_date=b.ord_date);
select * from best_salesman;
delete from salesman where salesman_id = 1000;
