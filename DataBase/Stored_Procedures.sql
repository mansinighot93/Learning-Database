USE `tflecommerce`;
DROP procedure IF EXISTS `add_user`;

DELIMITER $$
USE `tflecommerce`$$
CREATE PROCEDURE `add_user`(IN c_name varchar(50),IN c_password varchar(50),IN c_email varchar(100))
BEGIN
	INSERT INTO user(username,password,email) VALUES(c_name,c_password,c_email);
END$$

DELIMITER ;

CALL add_user('surekha','123456','manasi@gmail.com');



use demodb;
CREATE DEFINER=`root`@`localhost` PROCEDURE `calculate_circle_properties`(
IN radius DECIMAL(10,2),
OUT area DECIMAL(10,2),
OUT circumfernce DECIMAL(10,2)
)
BEGIN
    SET area = PI() * POWER(radius, 2);
    SET circumfernce = 2 * PI() * radius;
END
    
   -- Invoking Stored Procedures 
    SET @area=0;
	SET @circumference=0;
    
CALL calculate_circle_properties(5,@area,@circumference);
    
SELECT  @area  AS Area, @circumference AS Circumference ;