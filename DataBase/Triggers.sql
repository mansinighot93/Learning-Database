use demodb; 

-- Create Table For Trigger
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- BEFORE INSERT Trigger
DELIMITER //
CREATE TRIGGER update_last_updated
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
SET NEW.last_updated = current_timestamp();
END;
//
 
-- BEFORE UPDATE TRIGGER
CREATE TRIGGER update_last_updated_on_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.last_updated = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

 
-- Insert a new employee
INSERT INTO employees (name, department) VALUES ('Ravi Tambade', 'training');
INSERT INTO employees (name, department) VALUES ('Rutuja Tambade', 'BOD');
INSERT INTO employees (name, department) VALUES ('Manasi Nighot', 'BOD');

-- Update existing record 
UPDATE employees SET department='training' WHERE id=3;
 
SELECT * FROM employees;


