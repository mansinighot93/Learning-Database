-- Create Functions Days Difference
CREATE FUNCTION tflecommerce.days_between(start_date date,end_date date)
RETURNS DETERMINISTIC
BEGIN
	RETURN datediff(start_date,end_date);
END

SELECT days_between('2024-01-10','2024-01-01') as days_diff;


--Create Function Tax Value
CREATE FUNCTION tflecommerce.tax_val(amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
	RETURN amount * 0.2;
END

select tax_val(123456) as total_tax;