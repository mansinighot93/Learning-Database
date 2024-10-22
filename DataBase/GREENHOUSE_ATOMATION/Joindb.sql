-- Application queries :
 
-- 1.Retrive all users
	SELECT * from users;
 
-- 2.Retrive Sensor Information with Readings
	SELECT s.SensorID, s.SensorType, sr.ReadingValue, sr.ReadingTime
	FROM Sensors s
	JOIN SensorReadings sr ON s.SensorID =sr.SensorID
	ORDER BY sr.ReadingTime DESC;
 
-- 3.Get Recent Sensor Readings for a Specific Sensor Type
SELECT sr.ReadingID,sr.ReadingValue,s.SensorType
FROM SensorReadings sr
JOIN Sensors S ON sr.SensorID=s.SensorID
WHERE s.SensorType='Humidity'
ORDER BY sr.ReadingValue DESC;
 
-- 4.Get Control Device Status
SELECT cd.DeviceID,cd.DeviceType,cd.Status
FROM ControlDevices cd;

-- 5.Get Control logs for a specific Device
SELECT cl.LogID,cd.DeviceType,cl.Action,cl.ActionTime
FROM ControlLogs cl
JOIN ControlDevices cd ON cl.DeviceID = cd.DeviceID
WHERE cd.DeviceID = 1;

-- 6.Find Alerts for Threshold Viloations
SELECT sr.ReadingID,s.SensorType,st.ThresholdMin,st.ThresholdMax,sr.ReadingValue
FROM SensorReadings sr
JOIN Sensors S ON sr.SensorID=s.SensorID
JOIN Settings st ON s.SensorType = st.SensorType
WHERE sr.ReadingValue < st.ThresholdMin OR sr.ReadingValue > st.ThresholdMax;

-- 7.Count of Sensor Readings per Sensor Types
SELECT s.SensorType,COUNT(sr.ReadingValue) AS Sensor_Reading
FROM SensorReadings sr
JOIN Sensors s ON sr.SensorID = s.SensorID
GROUP BY s.SensorType;

-- 8.Get users with Admin Role.
SELECT * FROM Users WHERE Role='Admin';

-- 9.Get Devices that are currently On
SELECT * FROM ControlDevices WHERE Status='On';

--10.Recent actions taken by Control Devices
SELECT cd.DeviceID,cd.DeviceType,cl.Action,cl.ActionTime
FROM ControlLogs cl 
JOIN ControlDevices cd ON cl.DeviceID = cd.DeviceID
ORDER BY cl.ActionTime DESC;

-- 11.Retrieve Settings for Sensor Types.
SELECT SensorType FROM Settings;

-- 12.Average Sensor Reading for Temperature.
SELECT AVG(ReadingValue) AS Average_Temprature
FROM SensorReadings 
WHERE SensorID IN (SELECT SensorID FROM Sensors WHERE SensorType = 'Temperature');

--13.Find latest Reading for each Sensor.
SELECT DISTINCT(s.SensorType),sr.ReadingValue,sr.ReadingTime
FROM SensorReadings sr
JOIN Sensors s ON sr.SensorID = s.SensorID
ORDER BY sr.ReadingTime DESC;