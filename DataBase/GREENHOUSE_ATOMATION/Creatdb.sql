-- creating a database tflgreenhouseautomation
CREATE DATABASE TFLGreenhouse;

-- use the database
USE TFLGreenhouse;

-- creating a table users
CREATE TABLE Users (
		UserID INT PRIMARY KEY IDENTITY(1,1),
		Username NVARCHAR(50) NOT NULL,
		PasswordHash NVARCHAR(255) NOT NULL,
		Role NVARCHAR(20) NOT NULL, -- e.g., Admin, User
		CreatedAt DATETIME DEFAULT GETDATE()
);

-- creating a table Sensors
CREATE TABLE Sensors (
		SensorID INT PRIMARY KEY IDENTITY(1,1),
		SensorType NVARCHAR(50) NOT NULL, -- e.g., Temperature, Humidity
		Location NVARCHAR(100) NOT NULL,
		Description NVARCHAR(255),
		CreatedAt DATETIME DEFAULT GETDATE()
);

-- creating a table SensorReadings
CREATE TABLE SensorReadings (
		ReadingID INT PRIMARY KEY IDENTITY(1,1),
		SensorID INT FOREIGN KEY REFERENCES Sensors(SensorID),
		ReadingValue FLOAT NOT NULL,
		ReadingTime DATETIME DEFAULT GETDATE()
);

-- creating a table ControlDevices
CREATE TABLE ControlDevices (
		DeviceID INT PRIMARY KEY IDENTITY(1,1),
		DeviceType NVARCHAR(50) NOT NULL, -- e.g., Water Pump, Heater
		Status NVARCHAR(20), -- e.g., On, Off
		Location NVARCHAR(100) NOT NULL,
		CreatedAt DATETIME DEFAULT GETDATE()
);
 
-- creating a table ControlLogs
CREATE TABLE ControlLogs (
		LogID INT PRIMARY KEY IDENTITY(1,1),
		DeviceID INT FOREIGN KEY REFERENCES ControlDevices(DeviceID),
  		Action NVARCHAR(100), -- e.g., Started, Stopped
		ActionTime DATETIME DEFAULT GETDATE()
);
 
-- creating a table Settings
CREATE TABLE Settings (
		SettingID INT PRIMARY KEY IDENTITY(1,1),
    	SensorType NVARCHAR(50) NOT NULL,
    	ThresholdMin FLOAT,
    	ThresholdMax FLOAT,
    	NotificationEnabled BIT DEFAULT 0
);

-- Create table SimulatedReadings
CREATE TABLE SimulatedReadings (
		Id INT PRIMARY KEY IDENTITY(1,1), 
		Temperature FLOAT,
		Humidity FLOAT,
		Soil_Moisture FLOAT,
		CO2_Levels FLOAT,
		Light_Intensity FLOAT,
		Reading_Time DATETIME
		);
	
-- Create Table For Temporary Count 
CREATE TABLE TemporaryCount(Count INT);

