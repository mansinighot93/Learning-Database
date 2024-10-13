-- LOOP Statement
CREATE TABLE calendars (
    date DATE PRIMARY KEY,
    month INT NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL
);

DELIMITER //

CREATE PROCEDURE LoopCondtion(
	IN startDate DATE,
    IN endDate DATE
)
BEGIN
	DECLARE currentDate DATE DEFAULT startDate;
    
	insert_date: LOOP
		-- increase date by one day
		SET currentDate = DATE_ADD(currentDate, INTERVAL 1 DAY);
        
        -- leave the loop if the current date is after the end date
        IF currentDate > endDate THEN
			LEAVE insert_date;
        END IF;
        
        -- insert date into the table
        INSERT INTO calendars(date, month, quarter, year)
        VALUES(currentDate, MONTH(currentDate), QUARTER(currentDate), YEAR(currentDate));
		
    END LOOP;
END //

DELIMITER ;

-- Invoke Stored Procedures
CALL LoopCondtion('2024-01-01','2024-12-31');
SELECT COUNT(*) FROM calendars;


-- WHILE LOOP Statement 
-- Create Table Calendars
CREATE TABLE calendars (
    date DATE PRIMARY KEY,
    month INT NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL
);

-- Create Stored Procedures 
DELIMITER $$
CREATE PROCEDURE InsertCalendar(IN calendarDate DATE)
BEGIN
    DECLARE monthValue INT;
    DECLARE quarterValue INT;
    DECLARE yearValue INT;

    SET monthValue = MONTH(calendarDate);
    SET quarterValue = QUARTER(calendarDate);
    SET yearValue = YEAR(calendarDate);

    INSERT INTO calendars (date, month, quarter, year) 
    VALUES (calendarDate, monthValue, quarterValue, yearValue);
END$$

DELIMITER ;

-- Create Stored Procedures 
DELIMITER $$
CREATE PROCEDURE WhileLoop(
    startDate DATE, 
    day INT
)
BEGIN
    DECLARE counter INT DEFAULT 0;
    DECLARE currentDate DATE DEFAULT startDate;

    WHILE counter < day DO
        CALL InsertCalendar(currentDate);
        SET counter = counter + 1;
        SET currentDate = DATE_ADD(currentDate, INTERVAL 1 DAY);
    END WHILE;

END$$

DELIMITER ;

-- Invoke Stored Procedures
CALL WhileLoop('2023-01-01', 365);
SELECT * FROM calendars ORDER BY date DESC ;
SELECT COUNT(*) FROM calendars;


-- REPEAT LOOP Statement
DELIMITER $$

CREATE PROCEDURE RepeatLoop()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE result VARCHAR(100) DEFAULT '';
    
    REPEAT
        SET result = CONCAT(result,counter,',');
        SET counter = counter + 1;
    UNTIL counter >= 10
    END REPEAT;
    
    -- display result
    SELECT result;
END$$

DELIMITER ;

-- Invoke Stored Procedures
CALL RepeatLoop();

