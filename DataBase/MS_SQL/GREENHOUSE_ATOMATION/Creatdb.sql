USE tflgreenhouse;

CREATE TABLE Users (
    			UserID INT PRIMARY KEY IDENTITY(1,1),
				Username NVARCHAR(50) NOT NULL,
				PasswordHash NVARCHAR(255) NOT NULL,
    			Role NVARCHAR(20) NOT NULL, -- e.g., Admin, User
				CreatedAt DATETIME DEFAULT GETDATE());

CREATE TABLE Sensors (
   				SensorID INT PRIMARY KEY IDENTITY(1,1),
   				SensorType NVARCHAR(50) NOT NULL, -- e.g., Temperature, Humidity
   				Location NVARCHAR(100) NOT NULL,
   				Description NVARCHAR(255),
   				CreatedAt DATETIME DEFAULT GETDATE());
 
CREATE TABLE SensorReadings (
				ReadingID INT PRIMARY KEY IDENTITY(1,1),
   				SensorID INT FOREIGN KEY REFERENCES Sensors(SensorID),
   				ReadingValue FLOAT NOT NULL,
   				ReadingTime DATETIME DEFAULT GETDATE());
 
CREATE TABLE ControlDevices (
   				DeviceID INT PRIMARY KEY IDENTITY(1,1),
   				DeviceType NVARCHAR(50) NOT NULL, -- e.g., Water Pump, Heater
   				Status NVARCHAR(20), -- e.g., On, Off
   				Location NVARCHAR(100) NOT NULL,
   				CreatedAt DATETIME DEFAULT GETDATE());
 
CREATE TABLE ControlLogs (
   				LogID INT PRIMARY KEY IDENTITY(1,1),
				DeviceID INT FOREIGN KEY REFERENCES ControlDevices(DeviceID),
   				Action NVARCHAR(100), -- e.g., Started, Stopped
   				ActionTime DATETIME DEFAULT GETDATE());
 
CREATE TABLE Settings (
   				SettingID INT PRIMARY KEY IDENTITY(1,1),
   				SensorType NVARCHAR(50) NOT NULL,
   				ThresholdMin FLOAT,
   				ThresholdMax FLOAT,
   				NotificationEnabled BIT DEFAULT 0);
