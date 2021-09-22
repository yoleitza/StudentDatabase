USE CanadianFood

-- determining maximum length of strings to decide on datatypes --

SELECT DISTINCT Instructor1
FROM ClassroomData;

SELECT DISTINCT City, Province, Country
FROM ClassroomData
ORDER BY City;

SELECT LastName, LEN(LastName) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT FirstName, LEN(FirstName) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT Middle_Initial, LEN(Middle_Initial) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;  --Some are not initials --

SELECT Certification, LEN(Certification) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT Address, LEN(Address) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT City, LEN(City) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT Province, LEN(Province) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT Postal, LEN(Postal) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT Country, LEN(Country) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT EMail, LEN(EMail) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT Company, LEN(Company) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT CourseName, LEN(CourseName) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT TrimmedPhone, LEN(TrimmedPhone) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT Extension, LEN(Extension) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT ExamNumber, LEN(ExamNumber) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT CourseCity, LEN(CourseCity) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT CourseProvince, LEN(CourseProvince) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT Instructor1, LEN(Instructor1) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT Instructor_2, LEN(Instructor_2) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT ValidEmail, LEN(ValidEmail) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT Surname, LEN(Surname) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Given_Name, LEN(Given_Name) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Employee_ID, LEN(Employee_ID) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Email_Address, LEN(Email_Address) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Alternate_Email, LEN(Alternate_Email) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Company, LEN(Company) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Address_Line_1, LEN(Address_Line_1) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Address_Line_2, LEN(Address_Line_2) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT City, LEN(City) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Region, LEN(Region) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Country, LEN(Country) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Country, TrimmedPhone, LEN(TrimmedPhone) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Ext, LEN(Ext) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Course_Group, LEN(Course_Group) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Course, LEN(Course) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT Grade, LEN(Grade) Namelength
FROM OnlineData
ORDER BY Namelength desc;

SELECT DISTINCT Province 
FROM ClassroomData
ORDER BY Province;

SELECT DISTINCT Region, Country
FROM OnlineData
WHERE Country <> 'Canada'
ORDER BY Region;

SELECT DISTINCT City, Province 
FROM ClassroomData
ORDER BY City;


/**********************************************************************************************************

DATA BASE TABLES 

**********************************************************************************************************/
--Student Info Tables --

BEGIN TRAN
CREATE TABLE Student(
	StudentID INT IDENTITY(1,1),
 	LastName VARCHAR(100),
	FirstName VARCHAR(100),
	MiddleInitial VARCHAR(12),
	Email VARCHAR(254)
);


CREATE TABLE ContactInfo(
	StudentID INT NOT NULL,
	CountryCode VARCHAR(3),
	Phone1 VARCHAR(15),
	Phone2 VARCHAR(15),
	Extension VARCHAR(10),
	Email VARCHAR(254),
	AlternateEmail VARCHAR(254)
);


CREATE TABLE StudentAddress(
	StudentID INT NOT NULL,
	AddressLine1 NVARCHAR(65),
	AddressLine2 NVARCHAR(65),
	PostalCode VARCHAR(18),
	LocationID SMALLINT
);

CREATE TABLE Company(
	CompanyID SMALLINT IDENTITY(1,1) NOT NULL,
	CompanyName VARCHAR(100)
);

CREATE TABLE StudentCompany(
	StudentID INT NOT NULL,
	CompanyID SMALLINT NOT NULL
);

CREATE TABLE EmployeeID(
	StudentID INT NOT NULL,
	EmployeeID VARCHAR(60)
);


--  Location Tables --

CREATE TABLE Location(
	LocationID SMALLINT IDENTITY(1,1) NOT NULL,
	CityID SMALLINT NOT NULL,
	ProvinceOrRegionID SMALLINT NOT NULL,
	CountryID TINYINT NOT NULL,
	City VARCHAR(100),
	ProvinceOrRegion VARCHAR(50),
	Country VARCHAR(90)
);


CREATE TABLE Country(
	CountryID TINYINT IDENTITY(1,1) NOT NULL,
	Country VARCHAR(90)
	);

CREATE TABLE City(
	CityID SMALLINT IDENTITY(1,1) NOT NULL,
	City VARCHAR(100),
	Province VARCHAR(50),
	);
	   
CREATE TABLE ProvinceOrRegion(
	ProvinceOrRegionID SMALLINT IDENTITY(1,1) NOT NULL,
	ProvinceOrRegionName VARCHAR(50),
	CountryID TINYINT NOT NULL
);


-- Courses Tables --

CREATE TABLE ClassroomCertification(
	CertificationNumber CHAR(9) NOT NULL,
	StudentID INT,
	CourseName VARCHAR(80),
	CourseID SMALLINT,
	ExamDate DATE,
	ExamNumber VARCHAR(25),
	Grade SMALLINT,
	CertificateExpiryDate DATE,
	CertificateEmailed DATE,
	CertificatePrinted DATE,
	CertificateMailed DATE
);



CREATE TABLE OnlineCertification(
	StudentID INT NOT NULL,
	CourseName VARCHAR(80),
	CourseGroup VARCHAR(80),
	CompletionDate DATE,
	Grade TINYINT,
	CertificateExpiryDate DATE
);


CREATE TABLE ClassroomCourse(
	CourseID SMALLINT IDENTITY(1,1) NOT NULL,
	CourseName VARCHAR(80),
	ExamDate DATE,
	LocationID SMALLINT NOT NULL,
	Instructor1ID  TINYINT,
	Instructor2ID TINYINT
);


CREATE TABLE Instructor(
	InstructorID TINYINT IDENTITY(1,1) NOT NULL,
	FirstName VARCHAR(100),
	LastName VARCHAR(100)
);


COMMIT TRAN

-- Populate Tables with Data --

-- Instructor Table --

BEGIN TRAN
INSERT INTO Instructor (LastName, FirstName)
	VALUES	('Steward',			'Aaron'),
			('M''harzi',		'Ahmed'),
			('Levine',			'Arliss T E'),
			('Montgomery',		'Ashton '),
			('Wiber',			'Blaine'),
			('Easton',			'Brittany'),
			('Hatt',			'Carmen'),
			('Bramer',			'Chelsea'),
			('Rossler',			'Christine'),
			('Salcedo',			'Christine'),
			('Budgell',			'Daphne'),
			('McNeil',			'Darcy'),
			('Kensington',		'Debbie'),
			('Lambert',			'Delores'),
			('Pedulla',			'Domenic'),
			('Cahilig',			'Domino'),
			('Walsh',			'Frank'),
			('Adams',			'Freedom'),
			('Hettiarachchi',	'Gayan'),
			('VanZeggelaar',	'Gwen'),
			('Nair',			'Harish'),
			('Klassen',			'Helda'),
			('Cervera',			'Herly'),
			('Ainslie',			'Jacquie'),
			('Moore',			'Jamie'),
			('Bougie',			'Jean'),
			('Cooper',			'Jeffrey'),
			('Swampy',			'Joeanne'),
			('McLaughlin',		'Judith'),
			('Wolford',			'Kameron'),
			('Whalen',			'Karen'),
			('DiCarlo',			'Karin'),
			('Barrett',			'Kelly'),
			('McNeil',			'Kimberly'),
			('Shoring',			'Lance'),
			('Wolfgang',		'Leske'),
			('Graham',			'Matthew'),
			('Fyhn',			'Michael'),
			('Valani',			'Nafisha'),
			('Siddiqui',		'Nasreen'),
			('Schalk',			'Nicholas'),
			('Williams',		'Nicky'),
			('Brown-Alvord',	'Penny'),
			('Ancheta',			'Princess'),
			('Abbott',			'Robert'),
			('Jussila',			'Robert'),
			('Torok',			'Sandra'),
			('Warraich',		'Shandy'),
			('McKay',			'Shannon'),
			('Collis',			'Sue'),
			('Lorenz',			'Teri'),
			('Mulrooney',		'Terry'),
			('Houde',			'Tracy'),
			('Mitchell',		'Tricia'),
			('Akella',			'Valli'),
			('Leske',			'Wolfgang');

SELECT * FROM Instructor
COMMIT TRAN

UPDATE Instructor
SET FirstName = 'Wolfang'
WHERE InstructorID = '36';

UPDATE Instructor
SET LastName = 'Leske'
WHERE InstructorID = '36';

UPDATE Instructor
SET FirstName = 'Jack'
WHERE InstructorID = '56';

UPDATE Instructor
SET LastName = 'Zhang'
WHERE InstructorID = '56';

INSERT INTO Instructor (FirstName, LastName)
VALUES ('Angela', 'Hrsak');


SELECT * FROM Instructor

-- Country Table --

BEGIN TRAN
INSERT INTO Country (Country)
	VALUES	('Canada'),
			('United States'),
			('India'),
			('Brazil'),
			('Morocco'),
			('United Kingdom'),
			('United Arab Emirates'),
			('Samoa'),
			('Ukraine'),
			('Algeria'),
			('Nigeria'),
			('Philippines'),
			('Saudi Arabia'),
			('Mexico');

INSERT INTO Country (Country)
	VALUES	('Bangladesh');

SELECT * FROM Country

COMMIT TRAN

-- ProvinceOrRegion Table --

BEGIN TRAN
INSERT INTO ProvinceOrRegion(ProvinceOrRegionName, CountryID)
	VALUES	('Alberta',						1),
			('British Columbia',			1),
			('Manitoba',					1),
			('New Brunswick',				1),
			('New Foundland and Labrador',	1),
			('Northwest Territories',		1),
			('Nova Scotia',					1),
			('Nunavut',						1),
			('Ontario',						1),
			('Prince Edward Island',		1),
			('Quebec',						1),
			('Saskatchewan',				1),
			('Yukon',						1),
			('Abu Dhabi',					7),
			('California',					2),
			('Cherkasy Oblast',				9),
			('Chhattisgarh',				3),
			('Constantine',					10),
			('Dhaka',						15),
			('Edo',							11),
			('Hampshire',					6),
			('Illinois',					2),
			('Punjab',						3),
			('Kerala',						3),
			('Laguna',						12),
			('Michigan',					2),
			('Mississippi',					2),
			('Nevada',						2),
			('New Hampshire',				2),
			('New York',					2),
			('Pennsylvania',				2),
			('Quezon',						12),
			('Rio de Janeiro',				4),
			('Sao Paulo',					4),
			('Riyadh',						13),
			('San Luis Potosi',				14),
			('Tamil Nadu',					3),
			('Tanger-Tetouan-Al Hoceima',	5),
			('Texas',						2);

SELECT * FROM ProvinceOrRegion

COMMIT TRAN

-- City Table --

CREATE TABLE City1(
	City VARCHAR(100),
	Province VARCHAR(50),
	);

BEGIN TRAN
INSERT INTO City1(City, Province)
SELECT City, Province  FROM ClassroomData
WHERE City IS NOT NULL AND Province IS NOT NULL
UNION ALL
SELECT CourseCity, CourseProvince FROM ClassroomData
WHERE CourseCity IS NOT NULL AND CourseProvince IS NOT NULL
UNION ALL
SELECT City, Region FROM OnlineData
WHERE City IS NOT NULL AND Region IS NOT NULL;

SELECT DISTINCT City, Province 
FROM City1
ORDER BY City

SELECT * FROM City1
ORDER BY City;

SELECT City, Province, COUNT(*) AS total  --Check for duplicates --
FROM City1
GROUP BY City, Province
HAVING COUNT(*) > 1 ORDER BY total desc;

 -- Eliminate duplicates in City1
WITH cte 
AS (SELECT 	
		City,
		Province,
		rownumber = ROW_NUMBER() OVER(
		PARTITION BY
			City,
			Province
		ORDER BY 
			City,
			Province
		) 
	FROM 
		City1
)
DELETE FROM cte WHERE rownumber >1;


COMMIT TRAN

UPDATE City1
SET City = 'Bradford'
WHERE City = 'Braford';

UPDATE City1
SET City = 'Cold Lake'
WHERE City = 'Coldlake';

UPDATE City1
SET City = 'Kehewin'
WHERE City = 'Kehwin ';

UPDATE City1
SET Province = 'Saskatchewan'
WHERE Province = 'saskatchewan';

UPDATE City1
SET City = 'Paul First Nation  '
WHERE City = 'Paul Band First Nation  ';

UPDATE City1
SET Province = 'British Columbia'
WHERE City = 'Penticton';

UPDATE City1
SET City = 'Quebec'
WHERE City = 'Québec';

UPDATE City1
SET Province = 'Newfoundland and Labrador'
WHERE Province = 'Newfounland and Labrador';

UPDATE City1
SET Province = 'Nova Scotia'
WHERE City = 'Upper Tantallon';

UPDATE City1
SET Province = 'British Columbia'
WHERE City = 'Vancouver';

UPDATE City1
SET City = 'Wetaskiwin'
WHERE City = 'Wetaskawin';

UPDATE City1
SET Province = 'Manitoba'
WHERE City = 'Winnipeg';

SELECT * FROM City1
WHERE City LIKE 'Z%'
ORDER BY City;

INSERT INTO City (City, Province)
SELECT City, Province
FROM City1

SELECT * FROM City

COMMIT TRAN

BEGIN TRAN
UPDATE City
SET City = LTRIM(RTRIM(City));

UPDATE City
SET Province = LTRIM(RTRIM(Province));

COMMIT TRAN

UPDATE City
SET Province = 'Dhaka'
WHERE City = 'Dhaka';

UPDATE City
SET Province = 'Punjab'
WHERE Province = 'Jalandhar';

--Location Table --


BEGIN TRAN
INSERT INTO Location(CityID, ProvinceOrRegionID, CountryID, City, ProvinceOrRegion, Country)
SELECT City.CityID, ProvinceOrRegion.ProvinceOrRegionID, Country.CountryID, City.City, ProvinceOrRegion.ProvinceOrRegionName, Country.Country 
FROM City 
INNER JOIN ProvinceOrRegion ON 
		City.Province = ProvinceOrRegion.ProvinceOrRegionName
INNER JOIN Country ON 
		ProvinceOrRegion.CountryID = Country.CountryID;

COMMIT TRAN

BEGIN TRAN 

ALTER TABLE Location
ADD City VARCHAR(100);

ALTER TABLE Location
ADD ProvinceOrRegion VARCHAR(50);

ALTER TABLE Location
ADD Country VARCHAR(90);

COMMIT TRAN



SELECT * FROM Location 
SELECT * FROM City
SELECT * FROM ProvinceOrRegion
SELECT * FROM Country
SELECT DISTINCT CourseCity, Province  FROM ClassroomData ORDER BY CourseCity


-- Student Tables--


CREATE TABLE ClassStudent(
	LastName VARCHAR(100),
	FirstName VARCHAR(100),
	MiddleInitial VARCHAR(12),
	Email VARCHAR(254),
	AlternateEmail VARCHAR(254)
);

CREATE TABLE OnlineStudent(
	LastName VARCHAR(100),
	FirstName VARCHAR(100),
	MiddleInitial VARCHAR(12),
	Email VARCHAR(254),
	AlternateEmail VARCHAR(254)
);

BEGIN TRAN
INSERT INTO ClassStudent (LastName, FirstName, MiddleInitial, Email)
SELECT LastName, FirstName, Middle_Initial, EMail
FROM ClassroomData;

SELECT * FROM ClassStudent

SELECT * FROM ClassStudent
WHERE LastName = 'De La Cruz';

SELECT * FROM OnlineStudent
WHERE LastName = 'De La Cruz';

COMMIT TRAN


BEGIN TRAN
INSERT INTO OnlineStudent (LastName, FirstName, Email, AlternateEmail)
SELECT Surname, Given_Name, Email_Address, Alternate_Email
FROM OnlineData;

SELECT * FROM OnlineStudent;

COMMIT TRAN

CREATE TABLE StudentAll(
	LastName VARCHAR(100),
	FirstName VARCHAR(100),
	MiddleInitial VARCHAR(12),
	Email VARCHAR(254),
	AlternateEmail VARCHAR(254)
);


INSERT INTO StudentAll
SELECT * FROM ClassStudent
UNION ALL
SELECT * FROM OnlineStudent;

SELECT * FROM StudentAll ORDER BY LastName

SELECT * FROM StudentAll
WHERE LastName = 'De La Cruz';

--Check for duplicates --

SELECT LastName, FirstName, MiddleInitial, Email, COUNT(*) AS total
FROM StudentDuplicate
GROUP BY LastName, FirstName, MiddleInitial, Email
HAVING COUNT(*) > 1 ORDER BY total desc;

CREATE TABLE StudentDuplicate(
	LastName VARCHAR(100),
	FirstName VARCHAR(100),
	MiddleInitial VARCHAR(12),
	Email VARCHAR(254),
	AlternateEmail VARCHAR(254)
);

-- StudentDuplicate is a copy of StudentAll and include duplicate records--

INSERT INTO StudentDuplicate
SELECT * FROM StudentAll

SELECT DISTINCT * FROM StudentDuplicate


SELECT * FROM StudentAll
SELECT * FROM StudentDuplicate


/*******************************************************************************************************************
SELECT * FROM StudentAll a
LEFT JOIN StudentDuplicate b
ON a.LastName = b.LastName AND a.FirstName = b.FirstName AND a.MiddleInitial = b.MiddleInitial AND a.Email = b.Email
ORDER BY B.Email desc


SELECT LastName, FirstName, MiddleInitial, Email, 
ROW_NUMBER() OVER (PARTITION BY LastName, FirstName, Email
ORDER BY LastName, FirstName, Email) rownum
FROM StudentAll ORDER BY rownum DESC;

**********************************************************************************************************************/

-- Eliminate Duplicates in the StudentAll Table, 13068 rows were deleted --

WITH cte 
AS (SELECT 	
		LastName,
		FirstName,
		MiddleInitial,
		Email,
		rownumber = ROW_NUMBER() OVER(
		PARTITION BY
			LastName,
			FirstName,
			MiddleInitial,
			Email
		ORDER BY 
			LastName,
			FirstName,
			MiddleInitial,
			Email
		) 
	FROM 
		StudentAll
)
DELETE FROM cte WHERE rownumber >1;



SELECT * FROM StudentAll 
ORDER BY LastName 


SELECT LastName, FirstName, Email, MiddleInitial, COUNT(*) AS total
FROM StudentAll
GROUP BY LastName, FirstName, MiddleInitial, Email
HAVING COUNT(*) > 1 ORDER BY total desc;

SELECT * FROM Student

BEGIN TRAN
INSERT INTO Student (LastName, FirstName, MiddleInitial, Email)
SELECT LastName, FirstName, MiddleInitial, Email FROM StudentAll;

COMMIT TRAN

ALTER TABLE OnlineData
ADD StudentID INT;

ALTER TABLE ClassroomData
ADD StudentID INT;

SELECT * FROM OnlineData
SELECT * FROM Student
SELECT * FROM ClassroomData

-- Inserting the STUDENTID into the OnlineData and ClassroomData Tables --

BEGIN TRAN

UPDATE OnlineData
SET OnlineData.StudentID = Student.StudentID
FROM	OnlineData INNER JOIN Student ON  
		OnlineData.Surname = Student.LastName 
	AND OnlineData.Given_Name = Student.FirstName   
	AND OnlineData.Email_Address = Student.Email;


SELECT * FROM OnlineData
ORDER BY StudentID

COMMIT TRAN

BEGIN TRAN

UPDATE ClassroomData
SET ClassroomData.StudentID = Student.StudentID
FROM	ClassroomData INNER JOIN Student ON  
		ClassroomData.LastName = Student.LastName 
	AND ClassroomData.FirstName = Student.FirstName 
	AND ClassroomData.Middle_Initial = Student.MiddleInitial
	AND ClassroomData.EMail = Student.Email;

BEGIN TRAN
UPDATE ClassroomData
SET ClassroomData.StudentID = Student.StudentID
FROM	ClassroomData INNER JOIN Student ON  
		ClassroomData.LastName = Student.LastName 
	AND ClassroomData.FirstName = Student.FirstName 
	AND ClassroomData.EMail = Student.Email;

UPDATE ClassroomData
SET ClassroomData.StudentID = Student.StudentID
FROM	ClassroomData INNER JOIN Student ON  
		ClassroomData.FirstName = Student.FirstName 
	AND ClassroomData.Middle_Initial = Student.MiddleInitial
	AND ClassroomData.EMail = Student.Email;

SELECT * FROM  ClassroomData
ORDER BY StudentID

SELECT * FROM  ClassroomData
WHERE StudentID = 70155

SELECT * FROM Student
WHERE StudentID =  4604

UPDATE ClassroomData
SET StudentID = 70155 
WHERE FirstName = 'Rahul' AND Email = 'rahuljoon21@yahoo.ca'

COMMIT TRAN

--  Student ContactInfo Table --

SELECT * FROM Student
ORDER BY StudentID

SELECT * FROM ClassroomData
ORDER BY StudentID

SELECT * FROM OnlineData
ORDER BY StudentID

BEGIN TRAN
INSERT INTO ContactInfo (StudentID)
	SELECT StudentID
	FROM  Student;

SELECT * FROM ContactInfo 
WHERE CountryCode IS NULL AND Phone1 IS NOT NULL
Order by CountryCode;

COMMIT TRAN

-- Students that appear in the CassroomData Table and the OnlineData table --

SELECT DISTINCT a.StudentID, FirstName, LastName, EMail, a.TrimmedPhone, b.TrimmedPhone
FROM ClassroomData a
INNER JOIN OnlineData b
ON a.StudentID = b.StudentID
ORDER BY a.StudentID;

ALTER TABLE ContactInfo
ADD CountryCode2 VARCHAR(3);

BEGIN TRAN
UPDATE ContactInfo
SET ContactInfo.CountryCode = ClassroomData.CountryCode
FROM	ContactInfo INNER JOIN ClassroomData ON  
		ContactInfo.StudentID = ClassroomData.StudentID;

UPDATE ContactInfo
SET ContactInfo.CountryCode2 = OnlineData.CountryCode
FROM	ContactInfo INNER JOIN OnlineData ON  
		ContactInfo.StudentID = OnlineData.StudentID;

UPDATE ContactInfo
SET ContactInfo.Phone1 = ClassroomData.TrimmedPhone
FROM	ContactInfo INNER JOIN ClassroomData ON  
		ContactInfo.StudentID = ClassroomData.StudentID;

UPDATE ContactInfo
SET ContactInfo.Phone2 = OnlineData.TrimmedPhone
FROM	ContactInfo INNER JOIN OnlineData ON  
		ContactInfo.StudentID = OnlineData.StudentID;

UPDATE ContactInfo
SET CountryCode = CountryCode2
WHERE CountryCode IS NULL AND CountryCode2 IS NOT NULL;

UPDATE ContactInfo
SET Phone1 = Phone2
WHERE Phone1 IS NULL AND Phone2 IS NOT NULL;

UPDATE ContactInfo
SET Phone2 = NULL
WHERE Phone1 = Phone2;

COMMIT TRAN

SELECT * FROM ContactInfo 
ORDER BY StudentID

ALTER TABLE ContactInfo
DROP COLUMN CountryCode2;

ALTER TABLE ContactInfo
ADD Email1 VARCHAR(254);

ALTER TABLE ContactInfo
ADD Email2 VARCHAR(254);

BEGIN TRAN
UPDATE ContactInfo
SET ContactInfo.Email1 = ClassroomData.EMail
FROM	ContactInfo INNER JOIN ClassroomData ON  
		ContactInfo.StudentID = ClassroomData.StudentID;

UPDATE ContactInfo
SET ContactInfo.Email2 = OnlineData.Email_Address
FROM	ContactInfo INNER JOIN OnlineData ON  
		ContactInfo.StudentID = OnlineData.StudentID;

UPDATE ContactInfo
SET ContactInfo.AlternateEmail = OnlineData.Alternate_Email
FROM	ContactInfo INNER JOIN OnlineData ON  
		ContactInfo.StudentID = OnlineData.StudentID;

UPDATE ContactInfo
SET Email = Email1;

UPDATE ContactInfo
SET AlternateEmail = Email2
WHERE Email1 <> Email2 AND AlternateEmail IS NULL;

UPDATE ContactInfo
SET Email = Email2
WHERE Email1 IS NULL AND Email2 IS NOT NULL;

SELECT * FROM ContactInfo 
WHERE AlternateEmail IS NOT NULL;

SELECT * FROM ContactInfo 
WHERE Email1 <> Email2;

SELECT * FROM ContactInfo;

COMMIT TRAN

ALTER TABLE ContactInfo
DROP COLUMN Email1;

ALTER TABLE ContactInfo
DROP COLUMN Email2;

ALTER TABLE ContactInfo
ADD Extension1 VARCHAR(10);

ALTER TABLE ContactInfo
ADD Extension2 VARCHAR(10);

BEGIN TRAN
UPDATE ContactInfo
SET ContactInfo.Extension1 = ClassroomData.Extension
FROM	ContactInfo INNER JOIN ClassroomData ON  
		ContactInfo.StudentID = ClassroomData.StudentID;

UPDATE ContactInfo
SET ContactInfo.Extension2 = OnlineData.Ext
FROM	ContactInfo INNER JOIN OnlineData ON  
		ContactInfo.StudentID = OnlineData.StudentID;

SELECT * FROM ContactInfo
WHERE Extension1 IS NOT NULL;

SELECT * FROM ContactInfo
WHERE Extension2 IS NOT NULL -- AND Extension2 IS NOT NULL;

UPDATE ContactInfo
SET Extension1 = Extension2 
WHERE Phone2 IS NULL AND Extension2 IS NOT NULL;

UPDATE ContactInfo
SET Extension2 = NULL
WHERE STUDENTID = '23114';

UPDATE ContactInfo
SET Extension2 = NULL
WHERE STUDENTID = '30575';

ALTER TABLE ContactInfo
DROP COLUMN Extension;

COMMIT TRAN

--  Student StudentAddress Table --

ALTER TABLE StudentAddress
ADD City VARCHAR(100);

ALTER TABLE StudentAddress
ADD Province VARCHAR(50);

ALTER TABLE StudentAddress
ADD Country VARCHAR(90);

BEGIN TRAN
DELETE FROM StudentAddress

ALTER TABLE ClassroomData
ADD AddressLine2 NVARCHAR(65); 

ALTER TABLE ClassroomData
ALTER COLUMN Address NVARCHAR(100);


INSERT INTO StudentAddress (StudentID, AddressLine1, AddressLine2, PostalCode, City, Province, Country)
SELECT StudentID, Address, AddressLine2, Postal, City, Province, Country 
FROM ClassroomData;

INSERT INTO StudentAddress (StudentID, AddressLine1, AddressLine2, PostalCode, City, Province, Country)
SELECT StudentID, Address_Line_1, Address_Line_2, Postal_Code, City, Region, Country 
FROM OnlineData;

COMMIT TRAN

SELECT * FROM StudentAddress 
WHERE AddressLine1 IS NULL AND AddressLine2 IS NULL AND PostalCode IS NULL
ORDER BY StudentID;

SELECT * FROM StudentAddress
WHERE AddressLine1 IS NULL AND AddressLine2 IS NULL AND PostalCode IS NULL AND City IS NULL AND Province IS NULL AND Country IS NULL;

SELECT * FROM StudentAddress
WHERE AddressLine1 IS NOT NULL -- AND  PostalCode IS NOT NULL;

BEGIN TRAN
DELETE FROM StudentAddress
WHERE AddressLine1 IS NULL AND AddressLine2 IS NULL AND PostalCode IS NULL AND City IS NULL AND Province IS NULL AND Country IS NULL;

SELECT * FROM StudentAddress
WHERE  Country IS NULL;  -- 4 records had cities and provinces in Canada but Country was NULL --

UPDATE StudentAddress
SET Country = 'Canada'
WHERE Country IS NULL;

SELECT * FROM StudentAddress
WHERE City IS NULL AND Province IS NULL;

DELETE FROM StudentAddress
WHERE AddressLine1 IS NULL AND AddressLine2 IS NULL AND PostalCode IS NULL AND City IS NULL AND Province IS NULL;

SELECT * FROM StudentAddress
ORDER BY StudentID;

COMMIT TRAN

ALTER TABLE StudentAddress
ADD CityID INT;

ALTER TABLE StudentAddress
ADD ProvinceID INT;

ALTER TABLE StudentAddress
ADD CountryID INT;


UPDATE StudentAddress
SET StudentAddress.CityID = City.CityID
FROM	StudentAddress INNER JOIN City ON  
		StudentAddress.City = City.City AND 
		StudentAddress.Province = City.Province;

UPDATE StudentAddress
SET StudentAddress.ProvinceID = ProvinceOrRegion.ProvinceOrRegionID
FROM	StudentAddress INNER JOIN ProvinceOrRegion ON  
		StudentAddress.Province = ProvinceOrRegion.ProvinceOrRegionName;

UPDATE StudentAddress
SET StudentAddress.CountryID = Country.CountryID
FROM	StudentAddress INNER JOIN Country ON  
		StudentAddress.Country = Country.Country;


SELECT * FROM StudentAddress
ORDER BY StudentID;

UPDATE StudentAddress
SET StudentAddress.LocationID = Location.LocationID
FROM	StudentAddress INNER JOIN Location ON  
		StudentAddress.CityID = Location.CityID AND
		StudentAddress.ProvinceID = Location.ProvinceOrRegionID AND 
		StudentAddress.CountryID = Location.CountryID;


SELECT * FROM StudentAddress
ORDER BY City;

UPDATE StudentAddress
SET Country = 'Canada'
WHERE StudentID = '61009' AND Country = 'Samoa';


SELECT * FROM StudentAddress
WHERE LocationID IS NULL
ORDER BY PostalCode;

UPDATE StudentAddress
SET City = 'Edmonton' 
WHERE StudentID = '16601' AND AddressLine1 = '21719 86Ave  Northwest';

UPDATE StudentAddress
SET City = 'Lloydminster' 
WHERE StudentID = '16610' AND AddressLine1 = '4728 18 Street';

UPDATE StudentAddress
SET City = 'Calgary' 
WHERE StudentID = '51044' AND AddressLine1 = '122 Village Heights  Sw';

UPDATE StudentAddress
SET City = 'Burnaby' 
WHERE StudentID = '26155' AND AddressLine1 = '7008 Nelson Street';

UPDATE StudentAddress
SET AddressLine2 = NULL
WHERE StudentID = '16610' AND AddressLine2 = 'Lloydminster';

UPDATE StudentAddress
SET AddressLine2 = NULL
WHERE StudentID = '51044' AND AddressLine2 = 'Calgary';

UPDATE StudentAddress
SET AddressLine2 = NULL
WHERE StudentID = '16601' AND AddressLine2 = 'Edmonton';

UPDATE StudentAddress
SET AddressLine2 = NULL
WHERE StudentID = '26155' AND AddressLine2 = 'Burnaby';

UPDATE StudentAddress
SET PostalCode = 'T2X 2W1'
WHERE PostalCode = 'T2X "W1';

SELECT * FROM StudentAddress
ORDER BY Province;

SELECT * FROM ProvinceOrRegion

-- EmployeeID Table --

SELECT * FROM EmployeeID


INSERT INTO EmployeeID
SELECT StudentID, Employee_ID
FROM OnlineData
WHERE Employee_ID IS NOT NULL;


--Check for duplicates --

SELECT StudentID, EmployeeID, COUNT(*) AS total
FROM EmployeeID
GROUP BY StudentID, EmployeeID
HAVING COUNT(*) > 1 ORDER BY total desc;

--Eliminate duplicates --

WITH cte 
AS (SELECT 	
		StudentID,
		EmployeeID,
		rownumber = ROW_NUMBER() OVER(
		PARTITION BY
			StudentID,
			EmployeeID
		ORDER BY 
			StudentID,
			EmployeeID
		) 
	FROM 
		EmployeeID
)
DELETE FROM cte WHERE rownumber >1;

SELECT Surname, Given_Name, StudentID, Employee_ID
FROM OnlineData
WHERE Employee_ID = '22036';

-- Online Certification Table --


--  Correcting CompletionDate that came from excel with the day as the year and the year as the day --


SELECT * FROM OnlineCertification

CREATE TABLE OnlineCertification1(
	StudentID INT,
	CourseName VARCHAR(80),
	CourseGroup VARCHAR(80),
	CompletionDate DATE,
	Grade TINYINT,
	CertificateExpiryDate DATE,
	CompletionDay TINYINT,
	CompletionMonth TINYINT,
	CompletionYear TINYINT
);

ALTER TABLE OnlineCertification1
ALTER COLUMN CompletionYear SMALLINT;


ALTER TABLE OnlineCertification1
ALTER COLUMN CompletionDay SMALLINT;

INSERT INTO OnlineCertification1  (StudentID, CourseName, CourseGroup, CompletionDate, Grade, CertificateExpiryDate)
SELECT * FROM OnlineCertification;

UPDATE OnlineCertification1
SET CompletionYear = DAY(CompletionDate)+2000;

UPDATE OnlineCertification1
SET CompletionMonth = MONTH(CompletionDate);

UPDATE OnlineCertification1
SET CompletionDay = YEAR(CompletionDate) - 2000;

ALTER TABLE OnlineCertification1
ADD CorrectedDate DATE;

UPDATE OnlineCertification1
SET CorrectedDate = DATEFROMPARTS(CompletionYear, CompletionMonth, CompletionDay);

SELECT * FROM OnlineCertification1

SELECT * FROM Student WHERE StudentID = '8427'

SELECT * FROM OnlineCertification ORDER BY CompletionDate DESC;

INSERT INTO OnlineCertification (StudentID, CourseName, CourseGroup, CompletionDate, Grade)
SELECT StudentID, CourseName, CourseGroup, CorrectedDate, Grade
FROM OnlineCertification1; 


-- Expiry Date for the OnlineCertification Table is a calculated value, no need to enter it manually --
BEGIN TRAN
UPDATE OnlineCertification
SET CertificateExpiryDate = DATEADD(YEAR,5,CompletionDate);
COMMIT TRAN

--  ClassroomCourse Table --

-- Temporary table Courses1 to bring data from ClassroomData --

CREATE TABLE Courses1(
	CourseName VARCHAR(60),
	ExamDate DATE,
	CourseCity VARCHAR(100),
	CourseProvince VARCHAR(50),
	LocationID INT,
	Instructor1 VARCHAR(160),
	Instructor2 VARCHAR(160),
	InstructorID1 TINYINT,
	InstructorID2 TINYINT
);

	
INSERT INTO Courses1 (CourseName, ExamDate, CourseCity, CourseProvince, Instructor1, Instructor2)
SELECT CourseName, ExamDate, CourseCity, CourseProvince, Instructor1, Instructor_2
FROM ClassroomData;

SELECT * FROM Courses1;

--Check for duplicates --

SELECT CourseName, ExamDate, CourseCity, CourseProvince, Instructor1, Instructor2, COUNT(*) AS total
FROM Courses1
GROUP BY CourseName, ExamDate, CourseCity, CourseProvince, Instructor1, Instructor2
HAVING COUNT(*) > 1 ORDER BY total desc;

--Eliminate duplicates --

WITH cte 
AS (SELECT 	
		CourseName,
		ExamDate,
		CourseCity,
		CourseProvince,
		Instructor1,
		Instructor2,
		rownumber = ROW_NUMBER() OVER(
		PARTITION BY
			CourseName,
			ExamDate,
			CourseCity,
			CourseProvince,
			Instructor1,
			Instructor2
		ORDER BY 
			CourseName,
			ExamDate,
			CourseCity,
			CourseProvince,
			Instructor1,
			Instructor2
		) 
	FROM 
		Courses1
)
DELETE FROM cte WHERE rownumber >1;

SELECT * FROM Courses1;

ALTER TABLE Courses1
ADD CityID SMALLINT;


ALTER TABLE Courses1
ADD ProvinceID SMALLINT;

ALTER TABLE Courses1
ADD CountryID SMALLINT;

UPDATE Courses1
SET CountryID = 1;

UPDATE Courses1
SET Courses1.CityID = City.CityID
FROM	Courses1 INNER JOIN City ON  
		Courses1.CourseCity = City.City AND
		Courses1.CourseProvince = City.Province;

UPDATE Courses1
SET Courses1.ProvinceID = ProvinceOrRegion.ProvinceOrRegionID
FROM	Courses1 INNER JOIN ProvinceOrRegion ON  
		Courses1.CourseProvince = ProvinceOrRegion.ProvinceOrRegionName;

UPDATE Courses1
SET Courses1.LocationID = Location.LocationID
FROM	Courses1 INNER JOIN Location ON  
		Courses1.CityID = Location.CityID AND
		Courses1.ProvinceID = Location.ProvinceOrRegionID AND
		Courses1.CountryID = Location.CountryID;

SELECT * FROM Courses1 WHERE LocationID IS NULL
SELECT * FROM Location
SELECT * FROM City WHERE City = 'Wetaskiwin'

UPDATE Courses1
SET CourseCity = 'Wetaskiwin'
WHERE CourseCity = 'Wetaskawin  ';

UPDATE Courses1
SET CourseCity = 'Kehewin'
WHERE CourseCity = 'Kehwin ';

UPDATE Courses1
SET CourseCity = 'Paul First Nation'
WHERE CourseCity = 'Paul Band First Nation  ';

DELETE FROM Courses1 WHERE LocationID IS NULL AND Instructor1 IS NULL AND Instructor2 IS NULL;

UPDATE Courses1
SET InstructorID1 = CASE Instructor1
	WHEN 'Aaron Steward'		THEN '1'
	WHEN 'Ahmed M''harzi'		THEN '2'
	WHEN 'Arliss T E Levine'	THEN '3'
	WHEN 'Ashton Montgomery'	THEN '4'
	WHEN 'Blaine Wiber'			THEN '5'
	WHEN 'Brittany Easton'		THEN '6'
	WHEN 'Carmen Hatt'			THEN '7'
	WHEN 'Chelsea Bramer'		THEN '8'
	WHEN 'Christine Rossler'	THEN '9'
	WHEN 'Christine Salcedo'	THEN '10'
	WHEN 'Daphne Budgell'		THEN '11'
	WHEN 'Darcy McNeil'			THEN '12'
	WHEN 'Debbie Kensington'	THEN '13'
	WHEN 'Delores Lambert'		THEN '14'
	WHEN 'Domenic Pedulla'		THEN '15'
	WHEN 'Domino Cahilig'		THEN '16'
	WHEN 'Frank Walsh'			THEN '17'
	WHEN 'Freedom Adams'		THEN '18'
	WHEN 'Gayan Hettiarachchi'	THEN '19'
	WHEN 'Gwen VanZeggelaar'	THEN '20'
	WHEN 'Harish Nair'			THEN '21'
	WHEN 'Helda Klassen'		THEN '22'
	WHEN 'Herly Cervera'		THEN '23'
	WHEN 'Jacquie Ainslie'		THEN '24'
	WHEN 'Jamie Moore'			THEN '25'
	WHEN 'Jean Bougie'			THEN '26'
	WHEN 'Jeffrey Cooper'		THEN '27'
	WHEN 'Joeanne Swampy'		THEN '28'
	WHEN 'Judith McLaughlin'	THEN '29'
	WHEN 'Kameron Wolford'		THEN '30'
	WHEN 'Karen Whalen'			THEN '31'
	WHEN 'Karin DiCarlo'		THEN '32'
	WHEN 'Kelly Barrett'		THEN '33'
	WHEN 'Kimberly McNeil'		THEN '34'
	WHEN 'Lance Shoring'		THEN '35'
	WHEN 'Leske Wolfgang'		THEN '36'
	WHEN 'Wolfgang Leske'		THEN '36'
	WHEN 'Matthew Graham'		THEN '37'
	WHEN 'Michael Fyhn'			THEN '38'
	WHEN 'Nafisha Valani'		THEN '39'
	WHEN 'Nasreen Siddiqui'		THEN '40'
	WHEN 'Nicholas Schalk'		THEN '41'
	WHEN 'Nicky Williams'		THEN '42'
	WHEN 'Penny Brown-Alvord'	THEN '43'
	WHEN 'Princess Ancheta'		THEN '44'
	WHEN 'Robert Abbott'		THEN '45'
	WHEN 'Robert Jussila'		THEN '46'
	WHEN 'Sandra Torok'			THEN '47'
	WHEN 'Shandy Warraich'		THEN '48'
	WHEN 'Shannon McKay'		THEN '49'
	WHEN 'Sue Collis'			THEN '50'
	WHEN 'Teri Lorenz'			THEN '51'
	WHEN 'Terry Mulrooney'		THEN '52'
	WHEN 'Tracy Houde'			THEN '53'
	WHEN 'Tricia Mitchell'		THEN '54'
	WHEN 'Valli Akella'			THEN '55'
	WHEN 'Jack Zhang'			THEN '56'
	WHEN 'Angela Hrsak'			THEN '57'
END;

UPDATE Courses1
SET InstructorID2 = CASE Instructor2
	WHEN 'Aaron Steward'		THEN '1'
	WHEN 'Ahmed M''harzi'		THEN '2'
	WHEN 'Arliss T E Levine'	THEN '3'
	WHEN 'Ashton Montgomery'	THEN '4'
	WHEN 'Blaine Wiber'			THEN '5'
	WHEN 'Brittany Easton'		THEN '6'
	WHEN 'Carmen Hatt'			THEN '7'
	WHEN 'Chelsea Bramer'		THEN '8'
	WHEN 'Christine Rossler'	THEN '9'
	WHEN 'Christine Salcedo'	THEN '10'
	WHEN 'Daphne Budgell'		THEN '11'
	WHEN 'Darcy McNeil'			THEN '12'
	WHEN 'Debbie Kensington'	THEN '13'
	WHEN 'Delores Lambert'		THEN '14'
	WHEN 'Domenic Pedulla'		THEN '15'
	WHEN 'Domino Cahilig'		THEN '16'
	WHEN 'Frank Walsh'			THEN '17'
	WHEN 'Freedom Adams'		THEN '18'
	WHEN 'Gayan Hettiarachchi'	THEN '19'
	WHEN 'Gwen VanZeggelaar'	THEN '20'
	WHEN 'Harish Nair'			THEN '21'
	WHEN 'Helda Klassen'		THEN '22'
	WHEN 'Herly Cervera'		THEN '23'
	WHEN 'Jacquie Ainslie'		THEN '24'
	WHEN 'Jamie Moore'			THEN '25'
	WHEN 'Jean Bougie'			THEN '26'
	WHEN 'Jeffrey Cooper'		THEN '27'
	WHEN 'Joeanne Swampy'		THEN '28'
	WHEN 'Judith McLaughlin'	THEN '29'
	WHEN 'Kameron Wolford'		THEN '30'
	WHEN 'Karen Whalen'			THEN '31'
	WHEN 'Karin DiCarlo'		THEN '32'
	WHEN 'Kelly Barrett'		THEN '33'
	WHEN 'Kimberly McNeil'		THEN '34'
	WHEN 'Lance Shoring'		THEN '35'
	WHEN 'Leske Wolfgang'		THEN '36'
	WHEN 'Wolfgang Leske'		THEN '36'
	WHEN 'Matthew Graham'		THEN '37'
	WHEN 'Michael Fyhn'			THEN '38'
	WHEN 'Nafisha Valani'		THEN '39'
	WHEN 'Nasreen Siddiqui'		THEN '40'
	WHEN 'Nicholas Schalk'		THEN '41'
	WHEN 'Nicky Williams'		THEN '42'
	WHEN 'Penny Brown-Alvord'	THEN '43'
	WHEN 'Princess Ancheta'		THEN '44'
	WHEN 'Robert Abbott'		THEN '45'
	WHEN 'Robert Jussila'		THEN '46'
	WHEN 'Sandra Torok'			THEN '47'
	WHEN 'Shandy Warraich'		THEN '48'
	WHEN 'Shannon McKay'		THEN '49'
	WHEN 'Sue Collis'			THEN '50'
	WHEN 'Teri Lorenz'			THEN '51'
	WHEN 'Terry Mulrooney'		THEN '52'
	WHEN 'Tracy Houde'			THEN '53'
	WHEN 'Tricia Mitchell'		THEN '54'
	WHEN 'Valli Akella'			THEN '55'
	WHEN 'Jack Zhang'			THEN '56'
	WHEN 'Angela Hrsak'			THEN '57'
END;

SELECT * FROM Courses1;
SELECT * FROM ClassroomData

--Inserting data into ClassroomCourse Table --

SELECT * FROM ClassroomCourse

INSERT INTO ClassroomCourse (CourseName, ExamDate, LocationID, Instructor1ID, Instructor2ID)
SELECT CourseName, ExamDate, LocationID, InstructorID1, InstructorID2
FROM Courses1;

BEGIN TRAN
ALTER TABLE ClassroomCourse
ADD CertificateExpiryDate DATE; 

ALTER TABLE ClassroomCourse
ADD CertificateIssueDate DATE; 

UPDATE ClassroomCourse 
SET CertificateIssueDate = DATEADD (DAY, 7, ExamDate);

UPDATE ClassroomCourse 
SET CertificateExpiryDate = CASE
	WHEN CertificateIssueDate <= '2014-12-31' THEN DATEADD(YEAR, 3, CertificateIssueDate)
	WHEN CertificateIssueDate >= '2014-01-01' THEN DATEADD(YEAR, 5, CertificateIssueDate)
END;
COMMIT TRAN

-- ClassroomCertification Table --

ALTER  TABLE ClassroomCertification
ADD Instructor1 VARCHAR(160);

ALTER  TABLE ClassroomCertification
ADD Instructor2 VARCHAR(160);

ALTER TABLE ClassroomCertification
ADD CourseCity VARCHAR(100);

ALTER TABLE ClassroomCertification
ADD CourseProvince VARCHAR(100);

/*****************************************************************
INSERT INTO ClassroomCertification (CourseCity, CourseProvince)
SELECT CourseCity
FROM ClassroomData;
*****************************************************************/

INSERT INTO ClassroomCertification (StudentID, CourseName, CertificationNumber, ExamDate, ExamNumber, Grade, CertificateExpiryDate, 
			CertificateEmailed, CertificatePrinted, CertificateMailed, Instructor1, Instructor2, CourseCity, CourseProvince)
SELECT StudentID, CourseName, Certification, ExamDate, ExamNumber, Grade, CertificateExpiryDate, CertificatesEmailed, CertificatePrinted, 
		CertificatesMailed, Instructor1, Instructor_2, CourseCity, CourseProvince
FROM ClassroomData;



SELECT * FROM ClassroomData WHERE Grade > 100


SELECT * FROM ClassroomCourse
SELECT * FROM ClassroomCertification

ALTER  TABLE ClassroomCertification
ADD Instructor1ID TINYINT;

ALTER  TABLE ClassroomCertification
ADD Instructor2ID TINYINT;

UPDATE ClassroomCertification
SET Instructor1ID = CASE Instructor1
	WHEN 'Aaron Steward'		THEN '1'
	WHEN 'Ahmed M''harzi'		THEN '2'
	WHEN 'Arliss T E Levine'	THEN '3'
	WHEN 'Ashton Montgomery'	THEN '4'
	WHEN 'Blaine Wiber'			THEN '5'
	WHEN 'Brittany Easton'		THEN '6'
	WHEN 'Carmen Hatt'			THEN '7'
	WHEN 'Chelsea Bramer'		THEN '8'
	WHEN 'Christine Rossler'	THEN '9'
	WHEN 'Christine Salcedo'	THEN '10'
	WHEN 'Daphne Budgell'		THEN '11'
	WHEN 'Darcy McNeil'			THEN '12'
	WHEN 'Debbie Kensington'	THEN '13'
	WHEN 'Delores Lambert'		THEN '14'
	WHEN 'Domenic Pedulla'		THEN '15'
	WHEN 'Domino Cahilig'		THEN '16'
	WHEN 'Frank Walsh'			THEN '17'
	WHEN 'Freedom Adams'		THEN '18'
	WHEN 'Gayan Hettiarachchi'	THEN '19'
	WHEN 'Gwen VanZeggelaar'	THEN '20'
	WHEN 'Harish Nair'			THEN '21'
	WHEN 'Helda Klassen'		THEN '22'
	WHEN 'Herly Cervera'		THEN '23'
	WHEN 'Jacquie Ainslie'		THEN '24'
	WHEN 'Jamie Moore'			THEN '25'
	WHEN 'Jean Bougie'			THEN '26'
	WHEN 'Jeffrey Cooper'		THEN '27'
	WHEN 'Joeanne Swampy'		THEN '28'
	WHEN 'Judith McLaughlin'	THEN '29'
	WHEN 'Kameron Wolford'		THEN '30'
	WHEN 'Karen Whalen'			THEN '31'
	WHEN 'Karin DiCarlo'		THEN '32'
	WHEN 'Kelly Barrett'		THEN '33'
	WHEN 'Kimberly McNeil'		THEN '34'
	WHEN 'Lance Shoring'		THEN '35'
	WHEN 'Leske Wolfgang'		THEN '36'
	WHEN 'Wolfgang Leske'		THEN '36'
	WHEN 'Matthew Graham'		THEN '37'
	WHEN 'Michael Fyhn'			THEN '38'
	WHEN 'Nafisha Valani'		THEN '39'
	WHEN 'Nasreen Siddiqui'		THEN '40'
	WHEN 'Nicholas Schalk'		THEN '41'
	WHEN 'Nicky Williams'		THEN '42'
	WHEN 'Penny Brown-Alvord'	THEN '43'
	WHEN 'Princess Ancheta'		THEN '44'
	WHEN 'Robert Abbott'		THEN '45'
	WHEN 'Robert Jussila'		THEN '46'
	WHEN 'Sandra Torok'			THEN '47'
	WHEN 'Shandy Warraich'		THEN '48'
	WHEN 'Shannon McKay'		THEN '49'
	WHEN 'Sue Collis'			THEN '50'
	WHEN 'Teri Lorenz'			THEN '51'
	WHEN 'Terry Mulrooney'		THEN '52'
	WHEN 'Tracy Houde'			THEN '53'
	WHEN 'Tricia Mitchell'		THEN '54'
	WHEN 'Valli Akella'			THEN '55'
	WHEN 'Jack Zhang'			THEN '56'
	WHEN 'Angela Hrsak'			THEN '57'
END;


UPDATE ClassroomCertification
SET Instructor2ID = CASE Instructor2
	WHEN 'Aaron Steward'		THEN '1'
	WHEN 'Ahmed M''harzi'		THEN '2'
	WHEN 'Arliss T E Levine'	THEN '3'
	WHEN 'Ashton Montgomery'	THEN '4'
	WHEN 'Blaine Wiber'			THEN '5'
	WHEN 'Brittany Easton'		THEN '6'
	WHEN 'Carmen Hatt'			THEN '7'
	WHEN 'Chelsea Bramer'		THEN '8'
	WHEN 'Christine Rossler'	THEN '9'
	WHEN 'Christine Salcedo'	THEN '10'
	WHEN 'Daphne Budgell'		THEN '11'
	WHEN 'Darcy McNeil'			THEN '12'
	WHEN 'Debbie Kensington'	THEN '13'
	WHEN 'Delores Lambert'		THEN '14'
	WHEN 'Domenic Pedulla'		THEN '15'
	WHEN 'Domino Cahilig'		THEN '16'
	WHEN 'Frank Walsh'			THEN '17'
	WHEN 'Freedom Adams'		THEN '18'
	WHEN 'Gayan Hettiarachchi'	THEN '19'
	WHEN 'Gwen VanZeggelaar'	THEN '20'
	WHEN 'Harish Nair'			THEN '21'
	WHEN 'Helda Klassen'		THEN '22'
	WHEN 'Herly Cervera'		THEN '23'
	WHEN 'Jacquie Ainslie'		THEN '24'
	WHEN 'Jamie Moore'			THEN '25'
	WHEN 'Jean Bougie'			THEN '26'
	WHEN 'Jeffrey Cooper'		THEN '27'
	WHEN 'Joeanne Swampy'		THEN '28'
	WHEN 'Judith McLaughlin'	THEN '29'
	WHEN 'Kameron Wolford'		THEN '30'
	WHEN 'Karen Whalen'			THEN '31'
	WHEN 'Karin DiCarlo'		THEN '32'
	WHEN 'Kelly Barrett'		THEN '33'
	WHEN 'Kimberly McNeil'		THEN '34'
	WHEN 'Lance Shoring'		THEN '35'
	WHEN 'Leske Wolfgang'		THEN '36'
	WHEN 'Wolfgang Leske'		THEN '36'
	WHEN 'Matthew Graham'		THEN '37'
	WHEN 'Michael Fyhn'			THEN '38'
	WHEN 'Nafisha Valani'		THEN '39'
	WHEN 'Nasreen Siddiqui'		THEN '40'
	WHEN 'Nicholas Schalk'		THEN '41'
	WHEN 'Nicky Williams'		THEN '42'
	WHEN 'Penny Brown-Alvord'	THEN '43'
	WHEN 'Princess Ancheta'		THEN '44'
	WHEN 'Robert Abbott'		THEN '45'
	WHEN 'Robert Jussila'		THEN '46'
	WHEN 'Sandra Torok'			THEN '47'
	WHEN 'Shandy Warraich'		THEN '48'
	WHEN 'Shannon McKay'		THEN '49'
	WHEN 'Sue Collis'			THEN '50'
	WHEN 'Teri Lorenz'			THEN '51'
	WHEN 'Terry Mulrooney'		THEN '52'
	WHEN 'Tracy Houde'			THEN '53'
	WHEN 'Tricia Mitchell'		THEN '54'
	WHEN 'Valli Akella'			THEN '55'
	WHEN 'Jack Zhang'			THEN '56'
	WHEN 'Angela Hrsak'			THEN '57'
END;


SELECT * FROM ClassroomCourse
SELECT * FROM ClassroomCertification


ALTER TABLE ClassroomCertification
ADD LocationID SMALLINT;

BEGIN TRAN

ALTER TABLE ClassroomCertification
ADD CityID  SMALLINT;


ALTER TABLE ClassroomCertification
ADD ProvinceID  SMALLINT;

ALTER TABLE ClassroomCertification
ADD CountryID  SMALLINT;

UPDATE ClassroomCertification
SET CountryID = '1';

UPDATE ClassroomCertification 
SET ClassroomCertification.CityID = City.CityID
FROM	ClassroomCertification  INNER JOIN City  
		ON  ClassroomCertification.CourseCity = City.City

UPDATE ClassroomCertification 
SET ClassroomCertification.ProvinceID = ProvinceOrRegion.ProvinceOrRegionID
FROM	ClassroomCertification  INNER JOIN ProvinceOrRegion  
		ON  ClassroomCertification.CourseProvince = ProvinceOrRegion.ProvinceOrRegionName
	
UPDATE ClassroomCertification 
SET ClassroomCertification.LocationID = Location.LocationID
FROM	ClassroomCertification  INNER JOIN Location  
		ON  ClassroomCertification.CityID = Location.CityID AND
			ClassroomCertification.ProvinceID = Location.ProvinceOrRegionID AND
			ClassroomCertification.CountryID = Location.CountryID

BEGIN TRAN 

UPDATE ClassroomCertification 
SET ClassroomCertification.CourseID = ClassroomCourse.CourseID
FROM	ClassroomCertification  INNER JOIN ClassroomCourse  
		ON  ClassroomCertification.LocationID = ClassroomCourse.LocationID AND
			ClassroomCertification.ExamDate = ClassroomCourse.ExamDate AND
			ClassroomCertification.Instructor1ID = ClassroomCourse.Instructor1ID AND
			ClassroomCertification.Instructor2ID = ClassroomCourse.Instructor2ID AND
			ClassroomCertification.CourseName = ClassroomCourse.CourseName;

UPDATE ClassroomCertification 
SET ClassroomCertification.CourseID = ClassroomCourse.CourseID
FROM	ClassroomCertification  INNER JOIN ClassroomCourse  
		ON  ClassroomCertification.LocationID = ClassroomCourse.LocationID AND
			ClassroomCertification.ExamDate = ClassroomCourse.ExamDate AND
			ClassroomCertification.Instructor1ID = ClassroomCourse.Instructor1ID AND
			ClassroomCertification.CourseName = ClassroomCourse.CourseName
WHERE ClassroomCertification.CourseID IS NULL;

COMMIT TRAN

SELECT * FROM ClassroomCertification
SELECT * FROM ClassroomCourse

--Eliminate not needed columns in ClassroomCertification Table--

BEGIN TRAN

ALTER TABLE ClassroomCertification
DROP COLUMN CourseName;

ALTER TABLE ClassroomCertification
DROP COLUMN ExamDate;

ALTER TABLE ClassroomCertification
DROP COLUMN Instructor1;

ALTER TABLE ClassroomCertification
DROP COLUMN Instructor2;

ALTER TABLE ClassroomCertification
DROP COLUMN CourseCity;

ALTER TABLE ClassroomCertification
DROP COLUMN CourseProvince;

ALTER TABLE ClassroomCertification
DROP COLUMN Instructor1ID;

ALTER TABLE ClassroomCertification
DROP COLUMN Instructor2ID;

ALTER TABLE ClassroomCertification
DROP COLUMN CityID;

ALTER TABLE ClassroomCertification
DROP COLUMN ProvinceID;

ALTER TABLE ClassroomCertification
DROP COLUMN CountryID;

ALTER TABLE ClassroomCertification
DROP COLUMN LocationID;

COMMIT TRAN

BEGIN TRAN
ALTER TABLE ClassroomCertification
DROP COLUMN CertificateExpiryDate;

SELECT * FROM ClassroomCertification

COMMIT TRAN

SELECT * FROM ClassroomCourse
SELECT * FROM ClassroomCertification



-- Company Table --

CREATE TABLE Company1(
	CompanyName VARCHAR(100)
);


INSERT INTO Company1 
SELECT Company
FROM ClassroomData;

INSERT INTO Company1 
SELECT Company
FROM OnlineData;

SELECT * FROM Company1
WHERE CompanyName IS NULL;

DELETE FROM Company1
WHERE CompanyName IS NULL;

SELECT DISTINCT CompanyName
FROM Company1;

--Check for duplicates --

SELECT CompanyName, COUNT(*) AS total
FROM Company1
GROUP BY CompanyName
HAVING COUNT(*) > 1 ORDER BY total desc;

--Eliminate duplicates --

WITH cte 
AS (SELECT 	
		CompanyName,
		rownumber = ROW_NUMBER() OVER(
		PARTITION BY
			CompanyName
		ORDER BY 
			CompanyName
		) 
	FROM 
		Company1
)
DELETE FROM cte WHERE rownumber >1;

SELECT * FROM Company1

-- Company Table --

INSERT INTO Company
SELECT * FROM Company1;

SELECT * FROM Company

-- StudentCompany Table --


SELECT * FROM StudentCompany

CREATE TABLE StudentCompany1(
	StudentID INT,
	Company VARCHAR(100)
);

INSERT INTO StudentCompany1 (StudentID, Company)
SELECT StudentID, Company
FROM ClassroomData
UNION ALL
SELECT StudentID, Company
FROM OnlineData;

SELECT * FROM StudentCompany1;

--Check for duplicates --

SELECT StudentID, Company, COUNT(*) AS total
FROM StudentCompany1
GROUP BY StudentID, Company
HAVING COUNT(*) > 1 ORDER BY total desc;

--Eliminate duplicates --

WITH cte 
AS (SELECT 	
		StudentId,
		Company,
		rownumber = ROW_NUMBER() OVER(
		PARTITION BY
			StudentID,
			Company
		ORDER BY 
			StudentID,
			Company
		) 
	FROM 
		StudentCompany1
)
DELETE FROM cte WHERE rownumber >1;

SELECT * FROM StudentCompany1;

DELETE FROM StudentCompany1
WHERE Company IS NULL;





SELECT StudentCompany1.StudentID, StudentCompany1.Company, Company.CompanyID, Company.CompanyName
FROM StudentCompany1
INNER JOIN Company ON
StudentCompany1.Company = Company.CompanyName
ORDER BY StudentCompany1.StudentID;

INSERT INTO StudentCompany (StudentID, CompanyID)
SELECT StudentCompany1.StudentID, Company.CompanyID
FROM StudentCompany1
INNER JOIN Company ON
StudentCompany1.Company = Company.CompanyName
ORDER BY StudentCompany1.StudentID;

SELECT * FROM StudentCompany WHERE StudentID = '6415';

SELECT * FROM Student WHERE StudentID = '6415';
SELECT * FROM Company  WHERE CompanyID = '1985';
SELECT * FROM Student WHERE StudentID = '6415';
SELECT * FROM ClassroomData WHERE StudentID = '6415';
SELECT * FROM OnlineData WHERE StudentID = '6415';

SELECT * FROM StudentCompany1 WHERE StudentID = '6415'

-- Verifying unique records -- 

SELECT * FROM ClassroomCertification WHERE CertificationNumber = '520110307';

SELECT * FROM OnlineCertification WHERE StudentID = '1714';

-- same person several times with the same course, same completion date, different Grades, will keep the highest --

SELECT * FROM OnlineCertification WHERE StudentID = '12255';  

SELECT * FROM OnlineData WHERE StudentID = '12255';

DELETE FROM OnlineCertification
WHERE StudentID = '12255' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-03-31' AND Grade = 76;

DELETE FROM OnlineCertification
WHERE StudentID = '12255' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-03-31' AND Grade = 78;


SELECT * FROM OnlineCertification WHERE StudentID = '16707';

DELETE FROM OnlineCertification
WHERE StudentID = '16707' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-04-05' AND Grade = 70;

SELECT * FROM OnlineCertification WHERE StudentID = '22112';

DELETE FROM OnlineCertification
WHERE StudentID = '22112' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-03-25' AND Grade = 80;

DELETE FROM OnlineCertification
WHERE StudentID = '22112' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-03-25' AND Grade = 82;

DELETE FROM OnlineCertification
WHERE StudentID = '22112' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-03-25' AND Grade = 78;

SELECT * FROM OnlineCertification WHERE StudentID = '22800';

DELETE FROM OnlineCertification
WHERE StudentID = '22800' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-05-07' AND Grade = 82;

SELECT * FROM OnlineCertification WHERE StudentID = '24014';

DELETE FROM OnlineCertification
WHERE StudentID = '24014' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-04-05' AND Grade = 78;

SELECT * FROM OnlineCertification WHERE StudentID = '25908';

DELETE FROM OnlineCertification
WHERE StudentID = '25908' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-04-01' AND Grade = 90;

SELECT StudentID, CourseName, CompletionDate, Grade, COUNT(*) AS total
FROM OnlineCertification
GROUP BY StudentID, CourseName, CompletionDate, Grade
HAVING COUNT(*) > 1 ORDER BY total desc;

--Eliminate duplicates --


WITH cte 
AS (SELECT 	
		StudentId,
		CourseName,
		CompletionDate,
		Grade,
		rownumber = ROW_NUMBER() OVER(
		PARTITION BY
			StudentId,
			CourseName,
			CompletionDate,
			Grade
		ORDER BY 
			StudentId,
			CourseName,
			CompletionDate,
			Grade
		) 
	FROM 
		OnlineCertification
)
DELETE FROM cte WHERE rownumber >1;

SELECT * FROM OnlineCertification WHERE StudentID = '31504';

DELETE FROM OnlineCertification
WHERE StudentID = '31504' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-03-21' AND Grade = 76;

SELECT * FROM OnlineCertification WHERE StudentID = '33372';

DELETE FROM OnlineCertification
WHERE StudentID = '33372' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-04-07' AND Grade = 82;

SELECT * FROM OnlineCertification WHERE StudentID = '33733';

DELETE FROM OnlineCertification
WHERE StudentID = '33733' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-04-11' AND Grade = 84;

SELECT * FROM OnlineCertification WHERE StudentID = '35700';

DELETE FROM OnlineCertification
WHERE StudentID = '35700' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-04-06' AND Grade = 74;

SELECT * FROM OnlineCertification WHERE StudentID = '71297';

DELETE FROM OnlineCertification
WHERE StudentID = '71297' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-04-15' AND Grade = 74;

DELETE FROM OnlineCertification
WHERE StudentID = '71297' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-04-15' AND Grade = 84;

DELETE FROM OnlineCertification
WHERE StudentID = '71297' AND CourseName = 'Exam SHP - SafeCheck® Canadian Food Safety Certification' AND CompletionDate ='2019-04-15' AND Grade = 88;

/*************************************************************************************************/

SELECT * FROM StudentAddress WHERE AddressLine1 IS NULL

--Checking for duplicates --

SELECT StudentID, AddressLine1, AddressLine2, PostalCode, LocationID, COUNT(*) AS total
FROM StudentAddress
GROUP BY StudentID, AddressLine1, AddressLine2, PostalCode, LocationID
HAVING COUNT(*) > 1 ORDER BY total desc;


-- Eliminating duplicates --


WITH cte 
AS (SELECT 	
		StudentId,
		AddressLine1,
		AddressLine2,
		PostalCode,
		LocationID,
		rownumber = ROW_NUMBER() OVER(
		PARTITION BY
			StudentId,
			AddressLine1,
			AddressLine2,
			PostalCode,
			LocationID
		ORDER BY 
			StudentId,
			AddressLine1,
			AddressLine2,
			PostalCode,
			LocationID
		) 
	FROM 
		StudentAddress
)
DELETE FROM cte WHERE rownumber >1;

SELECT * FROM StudentAddress WHERE AddressLine1 IS NULL AND PostalCode IS NULL AND LocationID IS NULL;


SELECT StudentID, AddressLine1, PostalCode, LocationID, COUNT(*) AS total
FROM StudentAddress
GROUP BY StudentID, AddressLine1, PostalCode, LocationID
HAVING COUNT(*) > 1 ORDER BY total desc;


BEGIN TRAN
DELETE FROM  StudentAddress 
WHERE AddressLine1 IS NULL AND PostalCode IS NULL AND LocationID IS NULL;

COMMIT TRAN

SELECT * FROM StudentAddress WHERE AddressLine1 IS NULL;

SELECT * FROM StudentAddress WHERE PostalCode IS NULL;

SELECT * FROM StudentAddress WHERE LocationID IS NULL;

UPDATE City
SET City = 'Sao Bernardo do Campo'
WHERE City = 'Sao Bernardo do Comno';

UPDATE StudentAddress
SET AddressLine1 = 'Rua Maria Azevedo Florence, 1658'
WHERE AddressLine1 = 'Maris De Ogevdo flourance 1658';

UPDATE StudentAddress
SET PostalCode = '09811-050'
WHERE StudentID = '716' AND Country = 'Brazil';

UPDATE StudentAddress
SET PostalCode = 'T3E 1P1'
WHERE StudentID = '4475' AND AddressLine1 = '5253 - 19 Street NW';

SELECT * FROM StudentAddress WHERE AddressLine1 IS NULL;

--Postal Codes are missing in incomplete or invalid addresses --

DELETE FROM StudentAddress WHERE PostalCode IS NULL;

SELECT StudentID, PostalCode, LocationID, COUNT(*) AS total
FROM StudentAddress
GROUP BY StudentID, PostalCode, LocationID
HAVING COUNT(*) > 1 ORDER BY total desc;

SELECT * FROM StudentAddress WHERE StudentID = '561'

UPDATE StudentAddress
SET AddressLine1 = '5254 - 41 Street Crescent'
WHERE AddressLine1 = '5254 - 41st Cres.';

UPDATE StudentAddress
SET AddressLine1 = '5254 - 41 Street Crescent'
WHERE StudentID = '561' AND AddressLine1 = '5254 - 41 Crescent';

SELECT * FROM StudentAddress WHERE StudentID = '518'

UPDATE StudentAddress
SET AddressLine1 = '318 538 8 Ave SE'
WHERE StudentID = '518';


UPDATE StudentAddress
SET AddressLine1 = '9610 - 149 Street. Villa Rica Apt.15'
WHERE StudentID = '3005';

DELETE FROM StudentAddress
WHERE StudentID = '2337' AND AddressLine1 = '20 Hawkdale Close';

DELETE FROM StudentAddress
WHERE StudentID = '6935' AND AddressLine1 = '81 Eton Rd W';

DELETE FROM StudentAddress
WHERE StudentID = '64111' AND AddressLine1 = '146, 6715 - 8 Street NE';

DELETE FROM StudentAddress
WHERE StudentID = '3358' AND AddressLine1 = '37 Hawside Rd NE';

DELETE FROM StudentAddress
WHERE StudentID = '778' AND AddressLine1 = '221 Citadel Grdns N.W.';

DELETE FROM StudentAddress
WHERE StudentID = '2798' AND AddressLine1 = '66 Allardway Southpointe';

UPDATE StudentAddress
SET AddressLine1 = '45 Sage Meadows Way NW'
WHERE StudentID = '68942';

DELETE FROM StudentAddress
WHERE StudentID = '1404' AND AddressLine1 = 'T3A 1A4';

UPDATE StudentAddress
SET AddressLine1 = '10712 - 128 Ave NW'
WHERE StudentID = '3277';

DELETE FROM StudentAddress
WHERE StudentID = '68215' AND AddressLine1 = '2033 Cottonwood Cres. S.E.';

UPDATE StudentAddress
SET AddressLine1 = '325 Callaghan Close SW'
WHERE StudentID = '66809';

UPDATE StudentAddress
SET AddressLine1 = '301, 525 - 75 Ave SW'
WHERE StudentID = '1403';

DELETE FROM StudentAddress
WHERE StudentID = '1378' AND AddressLine1 = '25 11440 60 Ave ';

DELETE FROM StudentAddress
WHERE StudentID = '4055' AND AddressLine1 = '11-53222 Range Rd 272';

UPDATE StudentAddress
SET AddressLine1 = '844 Archwood Road SE'
WHERE StudentID = '62921';

UPDATE StudentAddress
SET AddressLine1 = 'Unit C, 9908 Sherridon Drive'
WHERE StudentID = '2800';

UPDATE StudentAddress
SET AddressLine1 = '609 Somerset Drive SW'
WHERE StudentID = '68126';

UPDATE StudentAddress
SET AddressLine1 = '101 - 25 Auburn Meadows Ave SE'
WHERE StudentID = '7320';

UPDATE StudentAddress
SET AddressLine1 = '8 Tuscany Hills Close NW'
WHERE StudentID = '5085';

UPDATE StudentAddress
SET AddressLine1 = '74 Chaparral Valley Grove SE'
WHERE StudentID = '3501';

UPDATE StudentAddress
SET AddressLine1 = '52 Sunhaven Way SE'
WHERE StudentID = '65311';

UPDATE StudentAddress
SET AddressLine1 = '507 Bracewood Cres. Sw'
WHERE StudentID = '10769';

UPDATE StudentAddress
SET AddressLine1 = '5029 Elgin Ave SE'
WHERE StudentID = '67135';

UPDATE StudentAddress
SET AddressLine1 = '6323 Rundlehorn Drive NE'
WHERE StudentID = '65071';

UPDATE StudentAddress
SET AddressLine1 = '4728 - 21 Ave NW'
WHERE StudentID = '1209';

UPDATE StudentAddress
SET AddressLine1 = '11 Cougar Ridge Bay SW'
WHERE StudentID = '6533';

DELETE FROM StudentAddress
WHERE StudentID = '64115' AND AddressLine1 = '146, 6715 - 8 Street NE';

DELETE FROM StudentAddress
WHERE StudentID = '4502' AND AddressLine1 = '136 Pinewood Cls NE';

UPDATE StudentAddress
SET AddressLine1 = '72 Castledale Crescent NE'
WHERE StudentID = '551';

UPDATE StudentAddress
SET AddressLine1 = '15 Aspen Hill Close SW'
WHERE StudentID = '69944';


SELECT * FROM StudentAddress WHERE StudentID = '69944'

SELECT StudentID, PostalCode, LocationID, COUNT(*) AS total
FROM StudentAddress
GROUP BY StudentID, PostalCode, LocationID
HAVING COUNT(*) > 1 ORDER BY total desc;

SELECT * FROM StudentAddress WHERE AddressLine1 IS NULL;

/********************************************************************
The primary key for the Student Address Table requires 
a composite primary key, and the columns that are part of the key cannot have null values.
The primary key include StudentID, AddressLine1, PostalCode and LocationID columns.
For that reason the 33 rows with missing AddressLine1 are being deleted from this table.

AddressLine1 is included in the key because the same student can have several addresses 
in the same city.  It will be a matter of deciding if all are needed or if the latest 
is the one to be kept.

The deleted addresses are stored in a table named StudentAddressDeleted
*********************************************************************/
CREATE TABLE StudentAddressDeleted(
	StudentID INT,
	AddressLine1 NVARCHAR(65),
	AddressLine2 NVARCHAR(65),
	PostalCode VARCHAR(18),
	LocationID SMALLINT
);

INSERT INTO StudentAddressDeleted (StudentID, AddressLine1, AddressLine2, PostalCode, LocationID)
SELECT StudentID, AddressLine1, AddressLine2, PostalCode, LocationID
FROM StudentAddress WHERE AddressLine1 IS NULL;

SELECT * FROM StudentAddressDeleted;

DELETE FROM StudentAddress
WHERE AddressLine1 IS NULL;


--Check for duplicates --

SELECT StudentID, AddressLine1, PostalCode, LocationID, COUNT(*) AS total
FROM StudentAddress
GROUP BY StudentID, AddressLine1, PostalCode, LocationID
HAVING COUNT(*) > 1 ORDER BY total desc;


--  Delete duplicates --

WITH cte 
AS (SELECT 	
		StudentId,
		AddressLine1,
		PostalCode,
		LocationID,
		rownumber = ROW_NUMBER() OVER(
		PARTITION BY
			StudentId,
			AddressLine1,
			PostalCode,
			LocationID
		ORDER BY 
			StudentId,
			AddressLine1,
			PostalCode,
			LocationID
		) 
	FROM 
		StudentAddress
)
DELETE FROM cte WHERE rownumber >1;

SELECT * FROM StudentAddress

ALTER TABLE StudentAddress
DROP COLUMN City;

ALTER TABLE StudentAddress
DROP COLUMN Province;

ALTER TABLE StudentAddress
DROP COLUMN Country;

ALTER TABLE StudentAddress
DROP COLUMN CityID;

ALTER TABLE StudentAddress
DROP COLUMN ProvinceID;

ALTER TABLE StudentAddress
DROP COLUMN CountryID;

-- Duplicates in Certification # in the ClassroomCertification Table --

SELECT CertificationNumber, StudentID, CourseID, CertificateExpiryDate, COUNT(*) AS total
FROM ClassroomCertification
GROUP BY CertificationNumber, StudentID, CourseID, ExamNumber, CertificateExpiryDate
HAVING COUNT(*) > 1 ORDER BY total desc;

-- Deleted the 5 duplicates where it was the same student repeated --

WITH cte 
AS (SELECT 	
		CertificationNumber,
		StudentID,
		CourseID,
		CertificateExpiryDate,
		rownumber = ROW_NUMBER() OVER(
		PARTITION BY
		CertificationNumber,
		StudentID,
		CourseID,
		CertificateExpiryDate
		ORDER BY 
		CertificationNumber,
		StudentID,
		CourseID,
		CertificateExpiryDate
		) 
	FROM 
		ClassroomCertification
)
DELETE FROM cte WHERE rownumber >1;

-- Checking for other CertificationNumber duplicates for different students--

SELECT CertificationNumber, CourseID, CertificateExpiryDate, COUNT(*) AS total
FROM ClassroomCertification
GROUP BY CertificationNumber, CourseID, ExamNumber, CertificateExpiryDate
HAVING COUNT(*) > 1 ORDER BY total desc;


SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520125992%';

BEGIN TRAN

UPDATE ClassroomCertification
SET CertificationNumber = '520125992-1'
WHERE CertificationNumber = '520125992' AND StudentID = '7428'AND CourseID = '1277';

UPDATE ClassroomCertification
SET CertificationNumber = '520125992-2'
WHERE CertificationNumber = '520125992' AND StudentID = '7429' AND CourseID = '1277';

UPDATE ClassroomCertification
SET CertificationNumber = '520125992-3'
WHERE CertificationNumber = '520125992' AND StudentID = '7430' AND CourseID = '1277';

UPDATE ClassroomCertification
SET CertificationNumber = '520125992-4'
WHERE CertificationNumber = '520125992' AND StudentID = '7431' AND CourseID = '1277';

COMMIT TRAN

SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520118044%';

BEGIN TRAN
UPDATE ClassroomCertification
SET CertificationNumber = '520118044-1'
WHERE CertificationNumber = '520118044' AND StudentID = '70150'AND CourseID = '577';

UPDATE ClassroomCertification
SET CertificationNumber = '520118044-2'
WHERE CertificationNumber = '520118044' AND StudentID = '70151'AND CourseID = '577';

UPDATE ClassroomCertification
SET CertificationNumber = '520118044-3'
WHERE CertificationNumber = '520118044' AND StudentID = '70152'AND CourseID = '577';

COMMIT TRAN


SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520115515%';

BEGIN TRAN
UPDATE ClassroomCertification
SET CertificationNumber = '520115515-1'
WHERE CertificationNumber = '520115515' AND StudentID = '70579'AND CourseID = '386';

UPDATE ClassroomCertification
SET CertificationNumber = '520115515-2'
WHERE CertificationNumber = '520115515' AND StudentID = '70581'AND CourseID = '386';

COMMIT TRAN

SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520118045%';

BEGIN TRAN
UPDATE ClassroomCertification
SET CertificationNumber = '520118045-1'
WHERE CertificationNumber = '520118045' AND StudentID = '69120'AND CourseID = '577';

UPDATE ClassroomCertification
SET CertificationNumber = '520118045-2'
WHERE CertificationNumber = '520118045' AND StudentID = '70153'AND CourseID = '577';

COMMIT TRAN


SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520110307%';

BEGIN TRAN
UPDATE ClassroomCertification
SET CertificationNumber = '520110307-1'
WHERE CertificationNumber = '520110307' AND StudentID = '137'AND CourseID = '18';

UPDATE ClassroomCertification
SET CertificationNumber = '520110307-2'
WHERE CertificationNumber = '520110307' AND StudentID = '138'AND CourseID = '18';

COMMIT TRAN

SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520115514%';

BEGIN TRAN
UPDATE ClassroomCertification
SET CertificationNumber = '520115514-1'
WHERE CertificationNumber = '520115514' AND StudentID = '70578'AND CourseID = '386';

UPDATE ClassroomCertification
SET CertificationNumber = '520115514-2'
WHERE CertificationNumber = '520115514' AND StudentID = '70580'AND CourseID = '386';

COMMIT TRAN

SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520119236%';

BEGIN TRAN
UPDATE ClassroomCertification
SET CertificationNumber = '520119236-1'
WHERE CertificationNumber = '520119236' AND StudentID = '65937'AND CourseID = '680';

UPDATE ClassroomCertification
SET CertificationNumber = '520119236-2'
WHERE CertificationNumber = '520119236' AND StudentID = '65938'AND CourseID = '680';

COMMIT TRAN

SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520112659%';

BEGIN TRAN
UPDATE ClassroomCertification
SET CertificationNumber = '520112659-1'
WHERE CertificationNumber = '520112659' AND StudentID = '1406'AND CourseID = '179';

UPDATE ClassroomCertification
SET CertificationNumber = '520112659-2'
WHERE CertificationNumber = '520112659' AND StudentID = '1407'AND CourseID = '179';

COMMIT TRAN


SELECT CertificationNumber, COUNT(*) AS total
FROM ClassroomCertification
GROUP BY CertificationNumber
HAVING COUNT(*) > 1 ORDER BY total desc;

SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520111596%'

BEGIN TRAN
UPDATE ClassroomCertification
SET CertificationNumber = '520111596-1'
WHERE CertificationNumber = '520111596' AND StudentID = '69127'AND CourseID = '104';

UPDATE ClassroomCertification
SET CertificationNumber = '520111596-2'
WHERE CertificationNumber = '520111596' AND StudentID = '69128'AND CourseID = '110';

COMMIT TRAN

SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520112453%'

BEGIN TRAN
UPDATE ClassroomCertification
SET CertificationNumber = '520112453-1'
WHERE CertificationNumber = '520112453' AND StudentID = '69944'AND CourseID = '162';

UPDATE ClassroomCertification
SET CertificationNumber = '520112453-2'
WHERE CertificationNumber = '520112453' AND StudentID = '69944'AND CourseID = '174';

COMMIT TRAN

SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520120119%'

BEGIN TRAN
UPDATE ClassroomCertification
SET CertificationNumber = '520120119-1'
WHERE CertificationNumber = '520120119' AND StudentID = '4824'AND CourseID = '761';

UPDATE ClassroomCertification
SET CertificationNumber = '520120119-2'
WHERE CertificationNumber = '520120119' AND StudentID = '4836'AND CourseID = '762';

COMMIT TRAN

SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '520111248%'

BEGIN TRAN
UPDATE ClassroomCertification
SET CertificationNumber = '520111248-1'
WHERE CertificationNumber = '520111248' AND StudentID = '68788'AND CourseID = '83';

UPDATE ClassroomCertification
SET CertificationNumber = '520111248-2'
WHERE CertificationNumber = '520111248' AND StudentID = '68789'AND CourseID = '282';

COMMIT TRAN

SELECT * FROM ClassroomCertification
WHERE CertificationNumber LIKE '%-%'

select * from OnlineData
select * from ClassroomData