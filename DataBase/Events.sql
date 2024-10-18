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
