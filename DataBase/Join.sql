create database demodb;
use demodb;

create table customer(id int auto_increment primary key,
name varchar(20) not null unique ,
contactname varchar(20) not null unique);

create table orders( id int auto_increment primary key,
order_date date,cust_id int,
FOREIGN KEY (cust_id) REFERENCES customer(id)
ON UPDATE CASCADE
ON DELETE SET NULL);

insert into customer(name,contactname)values('manasi nighot','nighot');
insert into customer(name,contactname)values('rutuja tambe','tambe');
insert into customer(name,contactname)values('sanika bhor','bhor');
insert into customer(name,contactname)values('piu','piu');
select * from demodb.customer;

insert into orders(order_date,cust_id)values('2024-08-08',1);
insert into orders(order_date,cust_id)values('2024-09-09',2);
insert into orders(order_date,cust_id)values('2024-09-09',1);
insert into orders(order_date,cust_id)values('2024-09-09',8);
insert into orders(order_date,cust_id)values('2024-09-09',11);

-- -- LEFT JOIN
SELECT  customer.id, customer.name, orders.id, orders.order_date
FROM  customer
LEFT JOIN  orders ON  customer.id = orders.id;

-- RIGHT JOIN
SELECT  customer.id, customer.name, orders.id, orders.order_date
FROM  customer
RIGHT JOIN  orders ON  customer.id = orders.id;

create table employee(id int auto_increment primary key,
name varchar(50),managerID int);

insert into employee(name,managerID)values('sachin raje',null);
insert into employee(name,managerID)values('ramakant pande',1);
insert into employee(name,managerID)values('seeta varma',1);
insert into employee(name,managerID)values('ganesh patil',2);
insert into employee(name,managerID)values('sitaram jadhav',3);

select * from demodb.employee;

-- LEFT JOIN
SELECT  e.id  AS  EmployeeID,
        e.name AS EmployeeName,
        m.name AS ManagerName
FROM  employee e
LEFT JOIN employee m ON e.managerID =m.id;

-- INNER JOIN
SELECT  customer.id, customer.name, orders.id, orders.order_date
FROM  customer
RIGHT JOIN  orders ON  customer.id = orders.id;

-- Other Example OF INNER JOIN
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEmployees`()
BEGIN
    SELECT 
        firstName, 
        lastName, 
        city, 
        state, 
        country
    FROM employees
    INNER JOIN offices using (officeCode);
    
END
