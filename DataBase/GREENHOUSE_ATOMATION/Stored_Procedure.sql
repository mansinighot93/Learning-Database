
-- Create a procedure to insert random values for different sensor types
CREATE PROCEDURE RandomValues
AS
DECLARE @i INT = 0;
DECLARE @CurrentTime DATETIME = GETDATE();
DECLARE @Temperature FLOAT;
DECLARE @Humidity FLOAT;
DECLARE @Soil_Moisture FLOAT;
DECLARE @CO2_Levels FLOAT;
DECLARE @Light_Intensity FLOAT;
WHILE @i < 144 -- 24 hours * 6 readings per hour
BEGIN

    -- Generate a random temperature between 15 and 30 degrees Celsius
    SET @Temperature = 15 + (RAND() * (30 - 15));
	SET @Humidity = 40 +(RAND() * (70-40));
	SET @Soil_Moisture = 20 + (RAND() * (50-20));
	SET @CO2_Levels = 150 + (RAND() * (1000-150));
	SET @Light_Intensity = 200 + (RAND() * (800-200));
    -- Insert the reading into the table
    INSERT INTO SimulatedReadings (Temperature,Humidity, Soil_Moisture, CO2_Levels, Light_Intensity, Reading_Time)
    VALUES (@Temperature,@Humidity,@Soil_Moisture,@CO2_Levels,@Light_Intensity, DATEADD(MINUTE, -@i * 10, @CurrentTime));
    SET @i = @i + 1;

END;

-- Execute Stored Procedures
EXEC RandomValues;
SELECT * FROM SimulatedReadings;


-- Automatically Insert Next Temperature Reading
CREATE PROCEDURE GetNextSensorReading
AS
BEGIN
	DECLARE  @lastId INT=0;
	DECLARE @Temperature FLOAT;
	DECLARE @Humidity FLOAT;
	DECLARE @Soil_Moisture FLOAT;
	DECLARE @CO2_Levels FLOAT;
	DECLARE @Light_Intensity FLOAT;

	SELECT  @lastID = Count from  TemporaryCount; 
	SELECT  TOP 1 @temperature=Temperature, 
				@Humidity=Humidity,
				@Soil_Moisture=Soil_Moisture,
				@CO2_Levels=CO2_Levels,
				@Light_Intensity=Light_Intensity
	FROM SimulatedReadings
	WHERE Id > @lastId
	ORDER BY Id;

	INSERT INTO SensorReadings (SensorID, ReadingValue)
	VALUES (1, @temperature),
			(2, @Humidity),
			(3, @Soil_Moisture),
			(4, @Light_Intensity),
			(5, @CO2_Levels);  

	SET @lastId=@lastId+1;
 
	update TemporaryCount
	SET Count = @lastId;

END;

-- Execute Stored Procedures
EXEC GetNextSensorReading;
SELECT * FROM SensorReadings;
