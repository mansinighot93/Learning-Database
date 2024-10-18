use demodb;
-- 1.Create the Stored Procedure
	DELIMITER //
	CREATE PROCEDURE my_procedure()
	BEGIN
		-- SQL commands here
		INSERT INTO  customer(name,contactname) values ('mau',12345); 
	END //
	DELIMITER ;

CALL my_procedure();
SELECT * FROM customer;
DROP PROCEDURE my_procedure;
-- 2.Enable the Event Scheduler
	SHOW VARIABLES LIKE 'event_scheduler';
	SET GLOBAL event_sheduler = ON;

-- 3.Create an Event to Schedule the stored procedure .
	CREATE EVENT my_event
	ON SCHEDULE EVERY 1 DAY
	STARTS  '2024-10-18 12:27:00'
	DO
	CALL my_procedure();

-- 4.List all scheduled events.
	SHOW EVENTS;

-- 5.Remove the event from event scheduler
	DROP EVENT IF EXISTS my_event;


CREATE DATABASE IF NOT EXISTS mydb;

USE mydb;

SELECT * FROM messages;
SHOW EVENTS FROM mydb;

CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW()
);

CREATE EVENT IF NOT EXISTS one_time_log
ON SCHEDULE AT CURRENT_TIMESTAMP
DO
  INSERT INTO messages(message)
  VALUES('One-time event');
  
CREATE EVENT one_minute_log
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
DO
   INSERT INTO messages(message)
   VALUES('Preserved One-minute event');

CREATE EVENT recurring_log
ON SCHEDULE EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO
   INSERT INTO messages(message)
   VALUES(CONCAT('Running at ', NOW()));

  

  
  