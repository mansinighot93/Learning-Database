
-- Automatically Insert Next Temperature Reading
CREATE PROCEDURE GetNextTemperatureReading
AS
BEGIN
DECLARE  @lastId INT=0;
DECLARE  @temperature FLOAT;

SELECT  @lastID=count from  TempCount; 
SELECT  TOP 1 @temperature=Temperature 
FROM SimulatedTemperatureReadings
WHERE Id > @lastId
ORDER BY Id;
 
INSERT INTO SensorReadings (SensorID, ReadingValue)
VALUES (1, @temperature);  

SET @lastId=@lastId+1;
 
update TempCount
SET count=@lastId;
END;


EXEC GetNextTemperatureReading;