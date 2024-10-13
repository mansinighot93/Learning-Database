use classicmodels;

-- IF-THEN Condition
DELIMITER $$
CREATE PROCEDURE IfCondition(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL(10,2) DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    END IF;
END$$
DELIMITER ;

-- Invoke Storage Procedures
call IfCondition(141,@level);
select @level as Level


-- IF-THEN-ELSE Condition
DELIMITER $$
CREATE PROCEDURE IfElseCondition(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSE
        SET pCustomerLevel = 'NOT PLATINUM';
    END IF;
END$$
DELIMITER ;

-- Invoke Stored Procedures
CALL IfElseCondition(447, @level);
SELECT @level;


-- IF-THEN-ELSEIF-ELSE Condition
DELIMITER $$
CREATE PROCEDURE IfElseIfCondtion(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSEIF credit <= 50000 AND credit > 10000 THEN
        SET pCustomerLevel = 'GOLD';
    ELSE
        SET pCustomerLevel = 'SILVER';
    END IF;
END $$
DELIMITER ;

-- Invoke Stored Procedures
CALL IfElseIfCondtion(447, @level);
SELECT @level;


-- Simple CASE Condition
DELIMITER $$ 
CREATE PROCEDURE CaseCondition(
  IN pCustomerNumber INT, 
  OUT pShipping VARCHAR(50)
) 
BEGIN 
	DECLARE customerCountry VARCHAR(100);
	SELECT 
	  country INTO customerCountry 
	FROM 
	  customers 
	WHERE 
	  customerNumber = pCustomerNumber;

	CASE customerCountry 
		WHEN 'USA' THEN 
			SET pShipping = '2-day Shipping';
		WHEN 'Canada' THEN 
			SET pShipping = '3-day Shipping';
		ELSE 
			SET pShipping = '5-day Shipping';
	END CASE;
END$$ 
DELIMITER ;

-- Invoke Stored Procedures
CALL CaseCondition(202,@shipping);
SELECT @shipping;


-- Search CASE Condition
DELIMITER $$ 
CREATE PROCEDURE SearchCaseCondition(
  IN pOrderNumber INT, 
  OUT pDeliveryStatus VARCHAR(100)
) 

BEGIN 
	DECLARE waitingDay INT DEFAULT 0;
	SELECT 
	  DATEDIFF(shippedDate, requiredDate) INTO waitingDay 
	FROM 
	  orders 
	WHERE 
	  orderNumber = pOrderNumber;
      
	-- determine delivery status	  
	CASE 
		WHEN waitingDay < 0 THEN 
			SET pDeliveryStatus = 'Early Delivery';
        WHEN waitingDay = 0 THEN 
			SET pDeliveryStatus = 'On Time';
		WHEN waitingDay >= 1 AND waitingDay < 5 THEN 
			SET pDeliveryStatus = 'Late';
		WHEN waitingDay >= 5 THEN 
			SET pDeliveryStatus = 'Very Late';
		ELSE 
			SET pDeliveryStatus = 'No Information';
	END CASE;

END$$ 
DELIMITER ;

-- Invoke Stored Procedures
CALL SearchCaseCondition(10100,@delivery);
SELECT @delivery;