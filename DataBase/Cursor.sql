use demodb;

DELIMITER $$
CREATE PROCEDURE create_name_list (
	INOUT name_list TEXT
)
BEGIN
	DECLARE done BOOL DEFAULT false;
	DECLARE name_add VARCHAR(100) DEFAULT "";
    
	-- declare cursor for employee email
	DECLARE cur CURSOR FOR SELECT name FROM employees;

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET done = true;
	
    -- open the cursor
	OPEN cur;
    SET name_list = '';
    right_loop: LOOP
        FETCH cur INTO name_add;
		IF done = true THEN 
			LEAVE right_loop;
		END IF;
		
        -- concatenate the email into the emailList
		SET name_list = CONCAT(name_add,";",name_list);
	END LOOP;
    -- close the cursor
	CLOSE cur;
END$$
DELIMITER ;

CALL create_name_list(@name_list); 
SELECT @name_list;