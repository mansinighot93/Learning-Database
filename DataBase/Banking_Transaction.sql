-- Stored Procedures

CREATE DEFINER=`root`@`localhost` PROCEDURE `spfundtransfer`(
	IN sp_fromaccountid INT,
    IN sp_toaccountid INT,
    IN sp_amount DECIMAL(10,3)
    )
BEGIN
	START TRANSACTION;
    -- SELECT amount INTO accountid FROM accounts WHERE accountid = sp_accountid;
    UPDATE accounts SET balance = balance + sp_amount
    WHERE accountid = sp_toaccountid;
    
    INSERT into operations(accountid, date_time, amount, oper_type)values
    (sp_toaccountid, NOW(), sp_amount, 'D');

    UPDATE accounts SET balance = balance - sp_amount
    WHERE accountid = sp_fromaccountid;

    INSERT into operations(accountid, date_time, amount, oper_type)values
    (sp_fromaccountid, NOW(), sp_amount, 'W'); 
    COMMIT;
END

-- Create Account Table

create table accounts(
	accountid int auto_increment primary key,
    holder varchar(50) not null,
    balance Decimal(10,3) not null
    );

insert into accounts( accountid, holder, balance) values
(12,'Sameer', 300),
(13,'Raj', 1500),
(14,'Seeta', 1200);
 
select * from accounts;

-- Create Operation Table

create table operations(
	operationid int auto_increment primary key,
    accountid int,
    date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,3) not null,
    oper_type varchar(50) not null,
    constraint fk_account_id foreign key (accountid) references accounts(accountid) on update cascade
    on delete cascade );
 
insert into operations(accountid, date_time, amount, oper_type) values
(12, NOW(), 300, "Deposit"),
(12, NOW(), 6000, "Withdrawl"),
(13, NOW(), 6000, "Deposit");
 
select * from operations;

-- Invoking  A STORED PROCEDURE
 
CALL spfundtransfer(12,13,4000);
select * from accounts;
