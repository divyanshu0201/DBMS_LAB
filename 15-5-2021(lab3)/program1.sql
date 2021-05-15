create database supplier;
use supplier;
CREATE TABLE suppliers(
    sid INT,
    sname VARCHAR(20),
    address VARCHAR(50),
    PRIMARY KEY (sid)
);
CREATE TABLE parts(
    pid INT,
    pname VARCHAR(20),
    color VARCHAR(10),
    PRIMARY KEY (pid)
);
CREATE TABLE catalog(
    sid INT,
    pid INT,
    cost REAL,
    PRIMARY KEY(sid,pid),
    FOREIGN KEY(sid) REFERENCES suppliers(sid)
    ON delete CASCADE ON update CASCADE,
    FOREIGN KEY(pid) REFERENCES parts(pid)
    ON delete CASCADE ON update CASCADE
);

insert into suppliers values (10001,'Acme Widget','Bangalore'), (10002,'Johns','Kolkata'), (10003,'Vimal','Mumbai'),(10004,'Reliance','Delhi');
insert into parts values (20001,'Book','Red'),(20002,'Pen','Red'),(20003,'Pencil','Green'),(20004,'Mobile','Green'),(20005,'Charger','Black');
insert into catalog values(10001,20001,10),(10001,20002,10),(10001,20003,30),(10001,20004,10),(10001,20005,10),(10002,20001,10),(10002,20002,20),(10003,20003,30),(10004,20003,40);

SELECT * FROM suppliers;
SELECT * FROM parts;
SELECT * FROM catalog;

SELECT DISTINCT p.pname FROM parts p, catalog c WHERE p.pid = c.pid; 
select suppliers.sname from suppliers where suppliers.sid in(select catalog.sid from catalog inner join
parts on catalog.pid=parts.pid group by catalog.sid having count(*)=(select count(parts.pid) from
parts));
select suppliers.sname from suppliers where suppliers.sid in (select catalog.sid from catalog inner join
parts on catalog.pid=parts.pid where catalog.pid in (select parts.pid from parts where
parts.color='Red') group by catalog.sid having count(*)=(select count(parts.color) from parts where
parts.color='Red'));
SELECT p.pname FROM parts p, catalog c, suppliers s WHERE p.pid = c.pid AND c.sid = s.sid AND s.sname = 'Acme Widget' AND NOT EXISTS ( SELECT * FROM catalog c1, suppliers s1 WHERE p.pid = c1.pid AND c1.sid = s1.sid AND s1.sname <> 'Acme Widget');
SELECT DISTINCT c.sid FROM catalog c WHERE c.cost > (SELECT AVG(C1.cost) FROM catalog c1 WHERE c1.pid = c.pid) ;
SELECT p.pid, s.sname FROM parts p, suppliers s, catalog c WHERE c.pid = p.pid AND c.sid = s.sid AND c.cost = (SELECT MAX(c1.cost) FROM catalog c1 WHERE c1.pid = p.pid);  
