create database sample11;
use sample11;

CREATE TABLE branch
( branch_name VARCHAR(20),
branch_city VARCHAR(20),
assets REAL,
PRIMARY KEY(branch_name)
);

CREATE TABLE accounts
( acc_no INT,
branch_name VARCHAR(50),
balance REAL,
PRIMARY KEY(acc_no),
FOREIGN KEY(branch_name) REFERENCES branch(branch_name)
ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE customer
( customer_name VARCHAR(20),
customer_street VARCHAR(50),
customer_city VARCHAR(20),
PRIMARY KEY(customer_name)
);

CREATE TABLE depositor
( customer_name VARCHAR(20),
acc_no INT,
PRIMARY KEY(customer_name, acc_no),
FOREIGN KEY(customer_name) REFERENCES customer(customer_name)
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(acc_no) REFERENCES accounts(acc_no)
ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE loan
( loan_number INT,
branch_name VARCHAR(50),
amount REAL,
PRIMARY KEY(loan_number),
FOREIGN KEY(branch_name) REFERENCES branch(branch_name)
ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO branch(branch_name,branch_city,assets) VALUES ('SBI_Chamrajpet','Bangalore',50000),('SBI_ResidencyRoad','Bangalore',10000),('SBI_ShivajiRoad','Bombay',20000),('SBI_ParlimentRoad','Delhi',10000),('SBI_Jantarmantar','Delhi',20000);

INSERT INTO accounts(acc_no,branch_name,balance) VALUES (1,'SBI_Chamrajpet',2000),(2,'SBI_ResidencyRoad',5000),(3,'SBI_ShivajiRoad',6000),(4,'SBI_ParlimentRoad',9000),(5,'SBI_Jantarmantar',8000),(6,'SBI_ShivajiRoad',4000),(8,'SBI_ResidencyRoad',4000),(9,'SBI_ParlimentRoad',3000),(10,'SBI_ResidencyRoad',5000),(11,'SBI_Jantarmantar',2000);

INSERT INTO customer(customer_name,customer_street,customer_city) VALUES ('Avinash','Bull_Temple_Road','Bangalore'),('Dinesh','Bannergatta_Road','Bangalore'),('Mohan','NationalCollege_Road','Bangalore'),('Nikil','Akbar_Road','Delhi'),('Ravi','Prithviraj_Road','Delhi');

INSERT INTO depositor(customer_name,acc_no) VALUES ('Avinash',1),('Dinesh',2),('Nikil',4),('Ravi',5),('Avinash',8),('Nikil',9),('Dinesh',10),('Nikil',11);

INSERT INTO loan(loan_number,branch_name,amount) VALUES (1,'SBI_Chamrajpet',1000),(2,'SBI_ResidencyRoad',2000),(3,'SBI_ShivajiRoad',3000),(4,'SBI_ParlimentRoad',4000),(5,'SBI_Jantarmantar',5000);

SELECT * FROM branch;
SELECT * FROM accounts; 
SELECT * FROM customer; 
SELECT * FROM depositor;
SELECT * FROM loan; 

SELECT * FROM customer WHERE customer_name IN(SELECT customer_name FROM depositor group by customer_name having COUNT(customer_name)>=2);
SELECT d.customer_name FROM accounts a, depositor d,branch b WHERE d.acc_no=a.acc_no AND b.branch_name=a.branch_name AND b.branch_city="Delhi" GROUP BY d.customer_name having count(distinct b.branch_name)=(SELECT COUNT(branch_name) FROM branch  WHERE branch_city="Delhi"); 
DELETE FROM ACCOUNTS WHERE branch_name IN(SELECT branch_name FROM BRANCH WHERE branch_city='Bombay'); 
