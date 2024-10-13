-- IN Parameter
use classicmodes;

CREATE DEFINER=`root`@`localhost` PROCEDURE `InParameter`(
	IN countryName VARCHAR(255)
)
BEGIN
	SELECT * 
 	FROM offices
	WHERE country = countryName;
END

-- Invoked Stored Procedures
CALL InParameter('USA');

--OUT Parameter

CREATE DEFINER=`root`@`localhost` PROCEDURE `OutParameter`(
	IN  orderStatus VARCHAR(25),
	OUT total INT
)
BEGIN
	SELECT COUNT(orderNumber)
	INTO total
	FROM orders
	WHERE status = orderStatus;
END

-- Invoked Stored Procedures
CALL OutParameter('Shipped',@total);
SELECT @total;

CALL OutParameter('In Process',@total);
SELECT @total AS total_in_process;

-- INOUT Parameter

CREATE DEFINER=`root`@`localhost` PROCEDURE `InOutParameter`(
	INOUT counter INT,
    IN inc INT
)
BEGIN
	SET counter = counter + inc;
END

-- Invoked Stored Procedures
SET @counter = 1;
CALL InOutParameter(@counter,1); 
CALL InOutParameter(@counter,1); 
CALL InOutParameter(@counter,5); 
SELECT @counter; 