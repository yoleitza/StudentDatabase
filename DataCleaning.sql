CREATE DATABASE CanadianFood

USE CanadianFood

/************************************************  

ONLINE DATA  (Stored in table named OnlineData)

**************************************************/

SELECT * FROM OnlineData

-- Show missing names --

SELECT * FROM OnlineData
WHERE Surname  NOT LIKE '%[a-z]%'  

SELECT * FROM OnlineData
WHERE Given_Name NOT LIKE '%[a-z]%'  

SELECT * FROM OnlineData
WHERE Grade LIKE '%[%]%'


-- Formatting columns--

ALTER TABLE OnlineData
ALTER COLUMN Primary_Phone VARCHAR(20);

ALTER TABLE OnlineData
ALTER COLUMN Grade VARCHAR(15);

ALTER TABLE OnlineData
DROP COLUMN column19;

-- CHECKING FOR NULL VALUES -- 

SELECT * FROM OnlineData
WHERE Surname IS NULL;

DELETE FROM OnlineData
WHERE Surname IS NULL;  -- 2 Records were deleted --

SELECT * FROM OnlineData
WHERE Email_Address IS NULL;  

DELETE FROM OnlineData
WHERE Email_Address IS NULL;   -- One record was deleted --



/**********************************************************************
TELEPHONE NUMBER FORMATTING IN ONLINE DATA
strip out all non-digit characters from single string phone
***********************************************************************/

BEGIN TRAN

ALTER TABLE OnlineData
ADD CleanPhoneNumber AS DBO.fn_CleanPhone(Primary_Phone);

SELECT Primary_Phone, CleanPhoneNumber 
FROM OnlineData;

COMMIT TRAN

SELECT * FROM OnlineData
WHERE len(CleanPhoneNumber) > 10 and Country = 'Canada';

SELECT Primary_Phone, CleanPhoneNumber 
FROM OnlineData
WHERE Primary_Phone LIKE '1%' AND Country = 'Canada';

SELECT Primary_Phone, CleanPhoneNumber 
FROM OnlineData
WHERE Primary_Phone NOT LIKE '1%' AND Country = 'Canada' AND len(CleanPhoneNumber) > 10;

-- Removing the country code in Canadian phone numbers --

--ALTER TABLE OnlineData
--DROP COLUMN TrimmedPhone;

BEGIN TRAN

ALTER TABLE OnlineData
ADD TrimmedPhone VARCHAR(15);

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-1)
WHERE Primary_Phone LIKE '1%' AND Country = 'Canada';

SELECT Primary_Phone, CleanPhoneNumber, TrimmedPhone 
FROM OnlineData;

SELECT Primary_Phone, CleanPhoneNumber, TrimmedPhone
FROM OnlineData
WHERE len(CleanPhoneNumber) >= 10 AND Country = 'Canada';


UPDATE OnlineData
SET TrimmedPhone = RIGHT(TrimmedPhone, LEN(TrimmedPhone)-1)
WHERE TrimmedPhone LIKE '0%' AND Country = 'Canada';

SELECT Primary_Phone, CleanPhoneNumber, TrimmedPhone
FROM OnlineData
WHERE TrimmedPhone IS NULL AND Country = 'Canada';


UPDATE OnlineData
SET TrimmedPhone = CleanPhoneNumber
Where TrimmedPhone IS NULL AND Country = 'Canada' AND LEN(CleanPhoneNumber) = 10;

SELECT Primary_Phone, CleanPhoneNumber, TrimmedPhone
FROM OnlineData
WHERE Country = 'Canada';

COMMIT TRAN

BEGIN TRAN

SELECT Primary_Phone, CleanPhoneNumber, TrimmedPhone
FROM OnlineData
WHERE TrimmedPhone IS NULL AND Country = 'Canada';

SELECT Primary_Phone, CleanPhoneNumber, TrimmedPhone
FROM OnlineData
WHERE CleanPhoneNumber LIKE '10%' AND Country = 'Canada';

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber) - 2)
Where CleanPhoneNumber LIKE '10%' AND TrimmedPhone IS NULL AND Country = 'Canada';

SELECT Primary_Phone, CleanPhoneNumber, TrimmedPhone
FROM OnlineData
WHERE CleanPhoneNumber LIKE '1%' AND Country = 'Canada' AND TrimmedPhone IS NULL;

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber) - 1)
WHERE CleanPhoneNumber LIKE '1%' AND TrimmedPhone IS NULL AND Country = 'Canada';

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber) - 1)
WHERE CleanPhoneNumber LIKE '0%' AND TrimmedPhone IS NULL AND Country = 'Canada';

COMMIT TRAN

-- to list remaining phone numbers in Canada that are not valid --

SELECT 
	CleanPhoneNumber,
	LEN(CleanPhoneNumber) CleanPhoneNumber_length
FROM OnlineData
WHERE TrimmedPhone IS NULL AND country = 'Canada';


-- Add a country code column --

SELECT Country, Primary_Phone, CleanPhoneNumber, TrimmedPhone
FROM OnlineData
WHERE Country <> 'Canada';

ALTER TABLE OnlineData
ADD CountryCode VARCHAR(3);

BEGIN TRAN
UPDATE OnlineData
SET CountryCode = 
	( CASE Country
		WHEN 'Canada' THEN '1'
		WHEN 'United States' THEN '1'
		WHEN 'Saudi Arabia' THEN '966'
		WHEN 'Samoa' THEN '685'
		WHEN 'Algeria' THEN '213'
		WHEN 'Philippines' THEN '63'
		WHEN 'Morocco' THEN '212'
		WHEN 'Brazil' THEN '55'
		WHEN 'United Arab Emirates' THEN '971'
		WHEN 'Nigeria' THEN '234'
		WHEN 'Mexico' THEN '52'
		WHEN 'India' THEN '91'
		WHEN 'Ukraine' THEN '380'
		WHEN 'United Kingdom' THEN '44'
	END
	);

COMMIT TRAN

SELECT Country, CountryCode, Primary_Phone, CleanPhoneNumber, TrimmedPhone
FROM OnlineData
WHERE Country <> 'Canada';

-- Remove contry Code from International phone numbers --

BEGIN TRAN

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-3)
WHERE Country = 'Saudi Arabia';

COMMIT TRAN

BEGIN TRAN

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-3)
WHERE Country = 'Samoa';

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-3)
WHERE Country = 'Algeria';

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-2)
WHERE Country = 'Philippines' AND CleanPhoneNumber LIKE '63%';

COMMIT TRAN

BEGIN TRAN
UPDATE OnlineData
SET TrimmedPhone = CleanPhoneNumber
WHERE Country = 'Philippines' AND CleanPhoneNumber NOT LIKE '63%';

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-3)
WHERE Country = 'Morocco';

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-2)
WHERE Country = 'Brazil';

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-3)
WHERE Country = 'United Arab Emirates';

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-3)
WHERE Country = 'Nigeria';

COMMIT TRAN

BEGIN TRAN
UPDATE OnlineData
SET TrimmedPhone = CleanPhoneNumber
WHERE Country = 'United States' AND CleanPhoneNumber NOT LIKE '1%';

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-1)
WHERE Country = 'United States' AND CleanPhoneNumber LIKE '1%';

COMMIT TRAN

BEGIN TRAN
UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-2)
WHERE Country = 'Mexico';

UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-2)
WHERE Country = 'India' AND CleanPhoneNumber LIKE '91%';  -- there are 2 numbers that start with 880 and seem invalid --

UPDATE OnlineData
SET TrimmedPhone = CleanPhoneNumber
WHERE Country = 'India' AND CleanPhoneNumber NOT LIKE '91%' AND  CleanPhoneNumber NOT LIKE '880%';

COMMIT TRAN

BEGIN TRAN
UPDATE OnlineData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-3)
WHERE Country = 'Ukraine';

UPDATE OnlineData
SET TrimmedPhone = CleanPhoneNumber
WHERE Country = 'United Kingdom';

UPDATE OnlineData
SET TrimmedPhone = NULL
WHERE Country = 'India' AND LEN(TrimmedPhone) > 10 ; -- Theres is a number that starts with 978 and does not seem valid --

COMMIT TRAN

SELECT Country, CountryCode, Primary_Phone, CleanPhoneNumber, TrimmedPhone
FROM OnlineData
WHERE Country <> 'Canada';

SELECT Country, TrimmedPhone, LEN(TrimmedPhone) Namelength
FROM OnlineData
ORDER BY Namelength desc;


-- Remove % character when present in the Grade column --

UPDATE OnlineData
SET Grade = TRIM('%' FROM Grade) 

BEGIN TRAN
UPDATE OnlineData
SET Grade = NULL
WHERE Grade = 'Not Graded'

SELECT Grade, LEN(Grade) Namelength
FROM OnlineData
ORDER BY Namelength desc;

UPDATE OnlineData
SET Grade = 96
WHERE Grade = '95.92';

ALTER TABLE OnlineData
ALTER COLUMN Grade int NULL;

COMMIT TRAN

-- Check validity of Emails format in Online Data--

--Valid email

BEGIN TRAN
SELECT Email_Address AS ValidEmail
FROM OnlineData
WHERE Email_Address LIKE '%_@__%.__%'
        AND PATINDEX('%[^a-z,0-9,@,.,_,\-]%', Email_Address) = 0 -- PATINDEX is 0 if the pattern is not found

-- Invalid email

SELECT Email_Address AS NotValidEmail
FROM OnlineData
WHERE NOT Email_Address LIKE '%_@__%.__%'
        AND PATINDEX('%[^a-z,0-9,@,.,_,\-]%', Email_Address) = 0

COMMIT TRAN

-- ROLLBACK TRAN

-- Remove trailing spaces in columns --

BEGIN TRAN

UPDATE OnlineData
SET Surname = RTRIM(Surname)

UPDATE OnlineData
SET Surname = LTRIM(Surname)

UPDATE OnlineData
SET Given_Name = RTRIM(Given_Name)

UPDATE OnlineData
SET Given_Name = LTRIM(Given_Name)

UPDATE OnlineData
SET Employee_ID = RTRIM(Employee_ID)

UPDATE OnlineData
SET Employee_ID = LTRIM(Employee_ID)

UPDATE OnlineData
SET Email_Address = RTRIM(Email_Address)

UPDATE OnlineData
SET Email_Address = LTRIM(Email_Address)

UPDATE OnlineData
SET Alternate_Email = RTRIM(Alternate_Email)

UPDATE OnlineData
SET Alternate_Email = LTRIM(Alternate_Email)

UPDATE OnlineData
SET Company = RTRIM(Company)

UPDATE OnlineData
SET Company = LTRIM(Company)

UPDATE OnlineData
SET Address_Line_1 = RTRIM(Address_Line_1)

UPDATE OnlineData
SET Address_Line_1 = LTRIM(Address_Line_1)

UPDATE OnlineData
SET Address_Line_2 = RTRIM(Address_Line_2)

UPDATE OnlineData
SET Address_Line_2 = LTRIM(Address_Line_2)

UPDATE OnlineData
SET City = RTRIM(City)

UPDATE OnlineData
SET City = LTRIM(City)

UPDATE OnlineData
SET Region = RTRIM(Region)

UPDATE OnlineData
SET Region = LTRIM(Region)

UPDATE OnlineData
SET Postal_Code = LTRIM(RTRIM(Postal_Code))

UPDATE OnlineData
SET Country = LTRIM(RTRIM(Country))

UPDATE OnlineData
SET Primary_Phone = LTRIM(RTRIM(Primary_Phone))

UPDATE OnlineData
SET Ext = LTRIM(RTRIM(Ext))

BEGIN TRAN 

UPDATE OnlineData
SET Course_Group = LTRIM(RTRIM(Course_Group))

UPDATE OnlineData
SET Course = LTRIM(RTRIM(Course))

UPDATE OnlineData
SET Completed = LTRIM(RTRIM(Completed))

UPDATE OnlineData
SET Grade = LTRIM(RTRIM(Grade))

COMMIT TRAN

SELECT * FROM OnlineData

/**************************************************************  
Checking for duplicates in email addresses 
Indicates how many times the same person appears in the table
***************************************************************/

SELECT
	Surname, 
	Given_Name,
	Email_Address,
	COUNT(*) occurrences
FROM OnlineData
GROUP BY 
	Surname,
	Given_Name,
	Email_Address
HAVING COUNT(*) > = 1
ORDER BY occurrences;


/************************************************  

CLASSROOM DATA  (Stored in table named ClassroomData)

**************************************************/
SELECT * FROM ClassroomData
WHERE  CourseCity = 'Online'

BEGIN TRAN
UPDATE ClassroomData
SET CourseCity = NULL
WHERE CourseCity = 'Online'

SELECT * FROM ClassroomData
WHERE  Instructor1 = 'Online'

UPDATE ClassroomData
SET Instructor1 = NULL
WHERE Instructor1 = 'Online'

COMMIT TRAN

/*  Checking for NULL values */

SELECT * FROM ClassroomData
WHERE FirstName IS NULL;   

-- One occurence of NULL FirstName, from email alberto.cantaneda!@yahoo.com.ph assumed first name to be Alberto --
BEGIN TRAN
UPDATE ClassroomData
SET FirstName = 'Alberto'
WHERE EMail = 'alberto.castaneda!@yahoo.com.ph' and LastName = 'Castaneda'   

COMMIT TRAN

SELECT * FROM ClassroomData
WHERE LastName = 'Castaneda'; 

SELECT * FROM ClassroomData
WHERE LastName IS NULL;    -- 2 occurrences of NULL LastName

SELECT * FROM ClassroomData
WHERE LastName IS NULL and FirstName is NULL;   --There are no occurrences where First and Last Names are NULL --

SELECT * FROM ClassroomData
WHERE EMail IS NULL;     -- No NULL emails --

-- CHECK EMAIL VALIDITY IN CLASSROOM DATA--

--Valid email

SELECT EMail AS ValidEmail
FROM ClassroomData
WHERE EMail LIKE '%_@__%.__%'
        AND PATINDEX('%[^a-z,0-9,@,.,_,\-]%', EMail) = 0 -- PATINDEX is 0 if the pattern is not found

-- Invalid email

SELECT EMail AS NotValidEmail
FROM ClassroomData
WHERE NOT EMail LIKE '%_@__%.__%'
        AND PATINDEX('%[^a-z,0-9,@,.,_,\-]%', EMail) = 0  --23 not valid emails found --

-- Add a Valid Email column and edit invalid emails where possible --

ALTER TABLE ClassroomData
ADD ValidEmail VARCHAR(100);

--ALTER TABLE ClassroomData
--DROP COLUMN ValidEmail

UPDATE ClassroomData
SET EMail = LTRIM(RTRIM(EMail))

BEGIN TRAN
UPDATE ClassroomData
SET ValidEmail = EMail
WHERE EMail LIKE '%_@__%.__%'
        AND PATINDEX('%[^a-z,0-9,@,.,_,\-]%', EMail) = 0

SELECT LastName, EMail, ValidEmail 
FROM ClassroomData
WHERE ValidEmail IS NULL;

COMMIT TRAN

BEGIN TRAN

UPDATE ClassroomData
SET ValidEmail = 
	 (CASE EMail
		WHEN 'benandbren@hotmail,com'			THEN 'benandbren@hotmail.com'
		WHEN 'amrikmand@gmail'					THEN 'amrikmand@gmail.com'
		WHEN 'mjkoo28@gmail,com'				THEN 'mjkoo28@gmail.com'
		WHEN 'manjitgarcha8@hotmailcom'			THEN 'manjitgarcha8@hotmail.com'
		WHEN 'norris5shaw.ca'					THEN 'norris5@shaw.ca'
		WHEN 'jotezat@shaw'						THEN 'jotezat@shaw.ca'
		WHEN 'pipesandsnips@shaw,ca'			THEN 'pipesandsnips@shaw.ca'
		WHEN 'ellen. chevalier@shaw.ca'			THEN 'ellen.chevalier@shaw.ca'
		WHEN 'sjj123@ telus.net'				THEN 'sjj123@telus.net'
		WHEN 'abhit&htdm@yahoo.co.in'			THEN 'abhit&htdm@yahoo.co.in'  -- format is valid
		WHEN 'm6570bo@motel6'					THEN 'm6570bo@motel6.com'
		WHEN 'jilllavis@live,com'				THEN 'jilllavis@live.com'
		WHEN 'kamras_kamras@yahoo,com'			THEN 'kamras_kamras@yahoo.com'
		WHEN 'Jeremy_O''Donnell@cpr.ca'			THEN 'Jeremy_O''Donnell@cpr.ca'  --format is valid
		WHEN 'caribou/brandonw@bestofbanff.com'	THEN 'caribou/brandonw@bestofbanff.com'
		WHEN 'HK ryou89735@gmail.com'			THEN 'HKryou89735@gmail.com'
		WHEN 'ddaugela@ hotmail.com'			THEN 'ddaugela@hotmail.com'
		WHEN 'alberto.castaneda!@yahoo.com.ph'	THEN 'alberto.castaneda!@yahoo.com.ph' -- format is valid --
		WHEN 'yls_sido@hotmailcom'				THEN 'yls_sido@hotmail.com'
		WHEN 'bouloudn6@hotmail.com+L5450'		THEN 'bouloudn6@hotmail.com'
		WHEN 'diamse_lloyd22@yahoo'				THEN 'diamse_lloyd22@yahoo.com'
		WHEN 'gtamchuk@sherlockhospitality'		THEN 'gtamchuk@sherlockhospitality.com'
		WHEN 'donnarosemyers@ gmail.com'		THEN 'donnarosemyers@gmail.com'
		WHEN 'chef@ranchmen''sclub.com'			THEN 'chef@ranchmensclub.com'
	END
	);



/**********************************************************************
TELEPHONE NUMBER FORMATTING IN CLASSROOM DATA
strip out all non-digit characters from single string phone
***********************************************************************/
BEGIN TRAN

ALTER TABLE ClassroomData
ADD CleanPhoneNumber AS DBO.fn_CleanPhone(Phone);

SELECT Phone, CleanPhoneNumber 
FROM ClassroomData;

COMMIT TRAN


-- Add Country Code Column to classroom data --

ALTER TABLE ClassroomData
ADD CountryCode VARCHAR(3);

BEGIN TRAN
UPDATE ClassroomData
SET CountryCode = '1'
WHERE Country = 'Canada'

SELECT Country, CountryCode, CleanPhoneNumber
FROM ClassroomData
WHERE Country <> 'Canada'

UPDATE ClassroomData
SET CountryCode = '55'
WHERE Country = 'Brazil'

COMMIT TRAN

-- Create TrimmedPhone column , for Phone numbers without country code --

ALTER TABLE ClassroomData
ADD TrimmedPhone VARCHAR(15);

BEGIN TRAN
UPDATE ClassroomData
SET TrimmedPhone = CleanPhoneNumber;

--Remove Country Code for Number from Brazil --
BEGIN TRAN
UPDATE ClassroomData
SET TrimmedPhone = RIGHT(CleanPhoneNumber, LEN(CleanPhoneNumber)-2)
WHERE Country = 'Brazil';

SELECT TrimmedPhone, LEN(TrimmedPhone) Phonelength
FROM ClassroomData
ORDER BY LEN(Trimmedphone) desc;

COMMIT TRAN

-- Remove trailing spaces in columns --

BEGIN TRAN
UPDATE ClassroomData
SET ExamDate = LTRIM(RTRIM(ExamDate));

UPDATE ClassroomData
SET LastName = LTRIM(RTRIM(LastName));

UPDATE ClassroomData
SET FirstName = LTRIM(RTRIM(FirstName));

UPDATE ClassroomData
SET Middle_Initial = LTRIM(RTRIM(Middle_Initial));

UPDATE ClassroomData
SET Grade = LTRIM(RTRIM(Grade));

UPDATE ClassroomData
SET Certification = LTRIM(RTRIM(Certification));

UPDATE ClassroomData
SET Certification = LTRIM(RTRIM(Certification));

UPDATE ClassroomData
SET Address = LTRIM(RTRIM(Address));

UPDATE ClassroomData
SET City = LTRIM(RTRIM(City));

UPDATE ClassroomData
SET Province = LTRIM(RTRIM(Province));

UPDATE ClassroomData
SET Postal = LTRIM(RTRIM(Postal));

UPDATE ClassroomData
SET Country = LTRIM(RTRIM(Country));

UPDATE ClassroomData
SET Company = LTRIM(RTRIM(Company));

UPDATE ClassroomData
SET CourseName = LTRIM(RTRIM(CourseName));

UPDATE ClassroomData
SET Extension = LTRIM(RTRIM(Extension));

UPDATE ClassroomData
SET ExamNumber = LTRIM(RTRIM(ExamNumber));

UPDATE ClassroomData
SET ExamNumber = LTRIM(RTRIM(ExamNumber));

UPDATE ClassroomData
SET CertificateIssueDate = LTRIM(RTRIM(CertificateIssueDate));

UPDATE ClassroomData
SET CertificateExpiryDate = LTRIM(RTRIM(CertificateExpiryDate));

UPDATE ClassroomData
SET CourseCity = LTRIM(RTRIM(CourseCity));

UPDATE ClassroomData
SET CourseProvince = LTRIM(RTRIM(CourseProvince));

UPDATE ClassroomData
SET Instructor1 = LTRIM(RTRIM(Instructor1));

UPDATE ClassroomData
SET Instructor_2 = LTRIM(RTRIM(Instructor_2));

UPDATE ClassroomData
SET CertificatesEmailed = LTRIM(RTRIM(CertificatesEmailed));

UPDATE ClassroomData
SET CertificatePrinted = LTRIM(RTRIM(CertificatePrinted));

UPDATE ClassroomData
SET CertificatesMailed = LTRIM(RTRIM(CertificatesMailed));

COMMIT TRAN

--Delete columns that contain no information --

BEGIN TRAN
ALTER TABLE ClassroomData
DROP COLUMN ABCert;

ALTER TABLE ClassroomData
DROP COLUMN column28;

ALTER TABLE ClassroomData
DROP COLUMN column29;

ALTER TABLE ClassroomData
DROP COLUMN column30;

SELECT * FROM ClassroomData

COMMIT TRAN

-- Change Data type in Date columns and corrected wrong data --

ALTER TABLE ClassroomData
ALTER COLUMN ExamDate date;

ALTER TABLE ClassroomData
ALTER COLUMN CertificateIssueDate date;

BEGIN TRAN 
UPDATE ClassroomData
SET CertificateExpiryDate = '2021-11-13'
WHERE CertificateExpiryDate = '13/11/2021'; -- 1 DATA POINT WITH THE WRONG DATE FORMAT --
COMMIT TRAN

ALTER TABLE ClassroomData
ALTER COLUMN CertificateExpiryDate date;

BEGIN TRAN 
UPDATE ClassroomData
SET CertificatesEmailed = NULL
WHERE CertificatesEmailed = 'NOT PAID'; -- 1 DATA POINT WITH TEXT --
COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET CertificatesMailed = '2017-05-07'
WHERE CertificatesMailed = '42862'; -- 1 DATA POINT WITH WRONG DATE FORMAT --

UPDATE ClassroomData
SET CertificatesMailed = '2017-01-11'
WHERE CertificatesMailed = '2011-01-07' AND CertificatesEmailed = '2016-12-23' AND CertificatePrinted = '2016-12-23';

COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET CertificatesEmailed = '2017-12-01'
WHERE CertificatesEmailed = '43070'; --  DATA POINTS WITH WRONG DATE FORMAT --

UPDATE ClassroomData
SET CertificatePrinted = '2017-12-01'
WHERE CertificatePrinted = '43070';  --  DATA POINTS WITH WRONG DATE FORMAT --

UPDATE ClassroomData
SET CertificatesEmailed = '2021-02-09'
WHERE CertificatesEmailed = '44236';  --  DATA POINTS WITH WRONG DATE FORMAT --

UPDATE ClassroomData
SET CertificatesEmailed = '2021-03-10'
WHERE CertificatesEmailed = '44265';  --  DATA POINTS WITH WRONG DATE FORMAT --

UPDATE ClassroomData
SET CertificatePrinted = '2021-02-09'
WHERE CertificatePrinted = '44236';  --  DATA POINTS WITH WRONG DATE FORMAT --

UPDATE ClassroomData
SET CertificatePrinted = '2021-03-10'
WHERE CertificatePrinted = '44265';  --  DATA POINTS WITH WRONG DATE FORMAT --

UPDATE ClassroomData
SET CertificatesMailed = '2021-02-09'
WHERE CertificatesMailed = '44236';  --  DATA POINTS WITH WRONG DATE FORMAT --

UPDATE ClassroomData
SET CertificatesMailed = '2021-03-10'
WHERE CertificatesMailed = '44265';  --  DATA POINTS WITH WRONG DATE FORMAT --

ALTER TABLE ClassroomData
ALTER COLUMN CertificatesEmailed date;

ALTER TABLE ClassroomData
ALTER COLUMN CertificatePrinted date;

ALTER TABLE ClassroomData
ALTER COLUMN CertificatesMailed date;

COMMIT TRAN

SELECT FirstName, LastName, CertificatesEmailed, CertificatePrinted, CertificatesMailed
FROM ClassroomData;

-- Remove Values where Company is NA --

BEGIN TRAN
UPDATE ClassroomData
SET Company = NULL
WHERE Company = 'NA';

SELECT Company
FROM ClassroomData
WHERE Company = 'NA'

COMMIT TRAN

-- Cleaning Instructors Names, correcting errors --

SELECT DISTINCT Instructor1, Instructor_2
FROM ClassroomData;

SELECT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Gwen%';

SELECT Instructor1
FROM ClassroomData
WHERE Instructor_2 LIKE 'Gwen%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Gwen VanZeggelaar'
WHERE Instructor1 = 'Gwen Van Zeggelaar';

UPDATE ClassroomData
SET Instructor1 = 'Gwen VanZeggelaar'
WHERE Instructor1 = 'Gwen VanZeggelaaar';

COMMIT TRAN

SELECT DISTINCT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Ashton%';

SELECT Instructor_2
FROM ClassroomData
WHERE Instructor_2 LIKE 'Ashton%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Ashton Montgomery'
WHERE Instructor1 = 'Ashton Montgeomery';
COMMIT TRAN

SELECT DISTINCT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Aaron%';

SELECT Instructor_2
FROM ClassroomData
WHERE Instructor_2 LIKE 'Aaron%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Aaron Steward'
WHERE Instructor1 = 'Aaron Stewart';
COMMIT TRAN

SELECT DISTINCT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Matt%';

SELECT DISTINCT Instructor_2
FROM ClassroomData
WHERE Instructor_2 LIKE 'Matt%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Matthew Graham'
WHERE Instructor1 = 'Matt Graham';
COMMIT TRAN

SELECT DISTINCT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Michael%';

SELECT DISTINCT Instructor_2
FROM ClassroomData
WHERE Instructor_2 LIKE 'Michael%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Michael Fyhn'
WHERE Instructor1 = 'Michael Fhyn';
COMMIT TRAN

SELECT DISTINCT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Ni%';

SELECT DISTINCT Instructor_2
FROM ClassroomData
WHERE Instructor_2 LIKE 'Ni%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Nicholas Schalk'
WHERE Instructor1 = 'Nick Shalk';

UPDATE ClassroomData
SET Instructor1 = 'Nicholas Schalk'
WHERE Instructor1 = 'Nick Schalk';
COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Nicky Williams'
WHERE Instructor1 = 'Nicki Williams';

UPDATE ClassroomData
SET Instructor1 = 'Nicky Williams'
WHERE Instructor1 = 'Nikcy Williams';
COMMIT TRAN

SELECT DISTINCT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Princ%';

SELECT DISTINCT Instructor_2
FROM ClassroomData
WHERE Instructor_2 LIKE 'Princ%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Princess Ancheta'
WHERE Instructor1 = 'Princess Anchets';
COMMIT TRAN

SELECT DISTINCT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Rob%';

SELECT DISTINCT Instructor_2
FROM ClassroomData
WHERE Instructor_2 LIKE 'Rob%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Robert Jussila'
WHERE Instructor1 = 'Rob Jussila';
COMMIT TRAN

SELECT DISTINCT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Ter%';

SELECT DISTINCT Instructor_2
FROM ClassroomData
WHERE Instructor_2 LIKE 'Ter%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Teri Lorenz'
WHERE Instructor1 = 'Terri Lorenz';
COMMIT TRAN

SELECT DISTINCT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Val%';

SELECT DISTINCT Instructor_2
FROM ClassroomData
WHERE Instructor_2 LIKE 'Val%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Valli Akella'
WHERE Instructor1 = 'Vali Akella';
COMMIT TRAN

SELECT DISTINCT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Nas%';

SELECT DISTINCT Instructor_2
FROM ClassroomData
WHERE Instructor_2 LIKE 'Nas%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Nasreen Siddiqui'
WHERE Instructor1 = 'Nasreem Siddiqui';
COMMIT TRAN

SELECT DISTINCT Instructor1
FROM ClassroomData
WHERE Instructor1 LIKE 'Stewart Blaine%';

SELECT DISTINCT Instructor_2
FROM ClassroomData
WHERE Instructor_2 LIKE 'Stewart Blaine%';

BEGIN TRAN
UPDATE ClassroomData
SET Instructor1 = 'Blaine Wiber'
WHERE Instructor1 = 'Stewart Blaine Wiber';
COMMIT TRAN


SELECT Middle_Initial, LEN(Middle_Initial) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

SELECT FirstName, LastName, Middle_Initial, LEN(Middle_Initial) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;  -- Some are not Initials --

SELECT Province, LEN(Province) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

BEGIN TRAN
UPDATE ClassroomData
SET Province = 'Alberta'
WHERE Province = 'AB'

SELECT DISTINCT City, Province
FROM ClassroomData;

UPDATE ClassroomData
SET Province = 'Ontario'
WHERE Province = 'ON'

UPDATE ClassroomData
SET Province = 'Ontario'
WHERE Province = 'Ont'

UPDATE ClassroomData
SET Province = 'Saskatchewan'
WHERE Province = 'SK'

UPDATE ClassroomData
SET Province = 'Saskatchewan'
WHERE Province = 'Sask'

UPDATE ClassroomData
SET Province = 'Manitoba'
WHERE Province = 'MB'

UPDATE ClassroomData
SET Province = 'Manitoba'
WHERE Province = 'MA'

UPDATE ClassroomData
SET Province = 'British Columbia'
WHERE Province = 'BC'

UPDATE ClassroomData
SET Province = 'British Columbia'
WHERE Province = 'B.C.'

UPDATE ClassroomData
SET Province = 'Nova Scotia'
WHERE Province = 'NS'

UPDATE ClassroomData
SET Province = 'Quebec'
WHERE Province = 'QC'

UPDATE ClassroomData
SET Province = 'Northwest Territories'
WHERE Province = 'NWT'

UPDATE ClassroomData
SET Province = 'Newfoundland and Labrador'
WHERE Province = 'NL'

UPDATE ClassroomData
SET Province = 'Newfoundland and Labrador'
WHERE Province = 'NFLD'

UPDATE ClassroomData
SET Province = 'Nunavut'
WHERE Province = 'NU'

UPDATE ClassroomData
SET Province = 'New Brunswick'
WHERE Province = 'NB'

UPDATE ClassroomData
SET Province = 'Yukon'
WHERE Province = 'YT'

UPDATE ClassroomData
SET Province = 'Prince Edward Island'
WHERE Province = 'PE'

UPDATE ClassroomData
SET Province = 'Prince Edward Island'
WHERE Province = 'PEI'

UPDATE ClassroomData
SET Province = 'Sao Paulo'
WHERE Province = 'SP'

UPDATE ClassroomData
SET Province = 'Sao Paulo'
WHERE Province = 'SP'

UPDATE ClassroomData
SET Province = 'California'
WHERE Province = 'CA'

SELECT DISTINCT Province
FROM ClassroomData;

COMMIT TRAN


BEGIN TRAN
UPDATE ClassroomData
SET Postal = 'T3G 3B1'
WHERE Postal = 'T3G 33B1';

UPDATE ClassroomData
SET Postal = 'T0C 0V0'
WHERE Postal = 'T0C 0V0`';

UPDATE ClassroomData
SET Postal = 'T3J 0H7'
WHERE Postal = 'T3J -0H7';

UPDATE ClassroomData
SET Postal = 'T7X 5A4'
WHERE Postal = 'T7X  5A4';

UPDATE ClassroomData
SET Postal = 'T3J 0B1'
WHERE Postal = 'T3J  0B1';

UPDATE ClassroomData
SET Postal = 'T6H 0S3'
WHERE Postal = 'T6H  0S3';

UPDATE ClassroomData
SET Postal = 'T5A 3L5'
WHERE Postal = 'T5A 23L5';

UPDATE ClassroomData
SET Postal = 'T3J 5G3'
WHERE Postal = 'T3J  5G3';

UPDATE ClassroomData
SET Postal = 'T2U 2K8'
WHERE Postal = 'T2U 2 K8';

UPDATE ClassroomData
SET Postal = 'T7Z 3N6'
WHERE Postal = 'T7Z  3N6';

UPDATE ClassroomData
SET Postal = 'T1J 1X9'
WHERE Postal = 'T11J 1X9';

UPDATE ClassroomData
SET Postal = 'T0L 0V0'
WHERE Postal = 'T10L 0V0';

UPDATE ClassroomData
SET Postal = 'T5A 5H2'
WHERE Postal = 'T5A  5H2';

UPDATE ClassroomData
SET Postal = 'T8A 3K6'
WHERE Postal = 'T8A 3K65';

UPDATE ClassroomData
SET Postal = 'T3C 0R6'
WHERE Postal = 'T23C 0R6';

UPDATE OnlineData
SET Postal = 'T3C 0R6'
WHERE Postal = 'T23C 0R6';

COMMIT TRAN

SELECT Postal, LEN(Postal) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

BEGIN TRAN
UPDATE OnlineData
SET Postal_Code = 'A0C 1B0'
WHERE Postal_Code = 'NL A0C 1B0';

UPDATE OnlineData
SET Postal_Code = 'T1L 1G2'
WHERE Postal_Code = 'T1L 1G2 ';

UPDATE OnlineData
SET Postal_Code = 'T3E 7N1'
WHERE Postal_Code = 'T33E 7N1';

UPDATE OnlineData
SET Postal_Code = 'T0E 1V0'
WHERE Postal_Code = 'T0E 1V0 ';

UPDATE OnlineData
SET Postal_Code = 'T8N 2J3'
WHERE Postal_Code = ' T8N 2J3';

UPDATE OnlineData
SET Postal_Code = 'V2B 8K7'
WHERE Postal_Code = ' V2B 8K7';

BEGIN TRAN
UPDATE OnlineData
SET Postal_Code = 'T5P 2B6'
WHERE Postal_Code = 'T5P 2B';

UPDATE OnlineData
SET Postal_Code = 'T8R 1J6'
WHERE Postal_Code = 'T8R 1J';

UPDATE OnlineData
SET Postal_Code = 'T9G 1Y5'
WHERE Postal_Code = 'T9G 1Y';

UPDATE OnlineData
SET Postal_Code = 'T5V 1T7'
WHERE Postal_Code = 'T5V 1T';

UPDATE OnlineData
SET Postal_Code = 'V2W 1E5'
WHERE Postal_Code = 'V2W 1E';

UPDATE OnlineData
SET Postal_Code = 'T6T 0R4'
WHERE Postal_Code = 'T6T0R4';

UPDATE OnlineData
SET Postal_Code = 'L3R 7E6'
WHERE Postal_Code = 'L3R 7E';

UPDATE OnlineData
SET Postal_Code = 'A0P 1E0'
WHERE Postal_Code = 'A0P1E0';

UPDATE OnlineData
SET Postal_Code = 'T1H 4R4'
WHERE Postal_Code = 'T1H 4R';

UPDATE OnlineData
SET Postal_Code = 'K6A 2Z4'
WHERE Postal_Code = 'K6A 2Z';

UPDATE OnlineData
SET Postal_Code = 'T6W 0Z5'
WHERE Postal_Code = 'T6W 0Z';

UPDATE OnlineData
SET Postal_Code = 'S0M 1A0'
WHERE Postal_Code = 'S0M1A0';

UPDATE OnlineData
SET Postal_Code = 'T1B 4N4'
WHERE Postal_Code = 'T1B 4N';

UPDATE OnlineData
SET Postal_Code = 'T6X 0W9'
WHERE Postal_Code = 'T6X 0W';

UPDATE OnlineData
SET Postal_Code = 'T6T 1P6'
WHERE Postal_Code = 'T6T1P6';

UPDATE OnlineData
SET Postal_Code = 'TIL 1H8'
WHERE Postal_Code = 'TIL1H8';

UPDATE OnlineData
SET Postal_Code = 'N2H 4C3'
WHERE Postal_Code = 'N2H 4C';

UPDATE OnlineData
SET Postal_Code = 'T4B 4C8'
WHERE Postal_Code = 'T4B4C8';

COMMIT TRAN

BEGIN TRAN
UPDATE OnlineData
SET Postal_Code = 'L3P 6V6'
WHERE Postal_Code = 'L3P 6V';

UPDATE OnlineData
SET Postal_Code = 'L9E 0B8'
WHERE Postal_Code = 'L9E 0B';

UPDATE OnlineData
SET Postal_Code = 'T6X 2A8'
WHERE Postal_Code = 'T6X 2A';

UPDATE OnlineData
SET Postal_Code = 'V0J 2C0'
WHERE Postal_Code = 'V0J 2C';

UPDATE OnlineData
SET Postal_Code = 'T5H 3S3'
WHERE Postal_Code = 'T5H 3S';

UPDATE OnlineData
SET Postal_Code = 'L5M 7G3'
WHERE Postal_Code = 'L5M 7G';

COMMIT TRAN

BEGIN TRAN
UPDATE OnlineData
SET Postal_Code = 'V0C 1R0'
WHERE Postal_Code = 'V0C1R0';

UPDATE OnlineData
SET Postal_Code = 'T6T 0R4'
WHERE Postal_Code = 'T6T0R4';

UPDATE OnlineData
SET Postal_Code = 'T1H 4R4'
WHERE Postal_Code = 'T1H 4R';
COMMIT TRAN

BEGIN TRAN
UPDATE OnlineData
SET Postal_Code = 'T1L 1A1'
WHERE Postal_Code = 'T1L1A1';

UPDATE OnlineData
SET Postal_Code = 'V9X 1B3'
WHERE Postal_Code = 'V9X 1B';

UPDATE OnlineData
SET Postal_Code = 'K1R 7Y4'
WHERE Postal_Code = 'K1R 7Y';

UPDATE OnlineData
SET Postal_Code = 'E1A 3W7'
WHERE Postal_Code = 'E1A 3W';

UPDATE OnlineData
SET Postal_Code = 'T5P 2B6'
WHERE Postal_Code = 'T5P 2B';

UPDATE OnlineData
SET Postal_Code = 'L3S 3B4'
WHERE Postal_Code = 'L3S3B4';

UPDATE OnlineData
SET Postal_Code = 'L3Y 8C7'
WHERE Postal_Code = 'L3Y 8C';

UPDATE OnlineData
SET Postal_Code = 'T1L 1B1'
WHERE Postal_Code = 'T1L1B1';

UPDATE OnlineData
SET Postal_Code = 'T1L 1A7'
WHERE Postal_Code = 'T1L1A7';

UPDATE OnlineData
SET Postal_Code = 'T1L 1A7'
WHERE Postal_Code = 'K6A 1B';

UPDATE OnlineData
SET Postal_Code = 'N6G 5B3'
WHERE Postal_Code = 'N6G 5B';

UPDATE OnlineData
SET Postal_Code = 'T0H 2M0'
WHERE Postal_Code = 'T0H 2M';

UPDATE OnlineData
SET Postal_Code = 'P0P 1M0'
WHERE Postal_Code = 'P0P1M0';

COMMIT TRAN


SELECT Postal_Code, LEN(Postal_Code) Namelength
FROM OnlineData
WHERE LEN(Postal_Code) > 0
ORDER BY Namelength asc;




BEGIN TRAN
UPDATE ClassroomData
SET Company = 'Aramark - Sagewood'
WHERE Company = 'Aramark/Sagewood';

UPDATE ClassroomData
SET Company = 'ABC Country Restaurant'
WHERE Company = 'ABC Country Rest.';

UPDATE ClassroomData
SET Company = 'AgeCare'
WHERE Company = 'Age Care';

UPDATE ClassroomData
SET Company = 'Alberta Job Corps'
WHERE Company = 'Alberta Job Corp';

UPDATE ClassroomData
SET Company = 'Applebee''s'
WHERE Company = 'Applebees Canada';

UPDATE ClassroomData
SET Company = 'Aramark Remote Services'
WHERE Company = 'Aramark Remote Service';

UPDATE ClassroomData
SET Company = 'Aramark Canada Ltd. Columbian Assisted Living'
WHERE Company = 'Aranmank Canada Ltd. Columbian Assisted Living';

UPDATE ClassroomData
SET Company = 'Austin''s Bar & Grill'
WHERE Company = 'Austin Grill and Bar';

UPDATE ClassroomData
SET Company = 'Austin''s Bar & Grill'
WHERE Company = 'Austins Bar';

UPDATE ClassroomData
SET Company = 'Austin''s Bar & Grill'
WHERE Company = 'Austins Bar';

UPDATE ClassroomData
SET Company = 'BLCO Enterprises Ltd.'
WHERE Company = 'BLCO Enterprises';

UPDATE ClassroomData
SET Company = 'BLCO Enterprises Ltd.'
WHERE Company = 'BLCO Enterprises';

UPDATE ClassroomData
SET Company = 'Brenda Strafford Foundation'
WHERE Company = 'Brenda Stafford Foundation';

UPDATE ClassroomData
SET Company = 'Brenda Strafford Foundation'
WHERE Company = 'Brenda Stratford Foundation';

COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'Blackfoot Diner'
WHERE Company = 'Blackfoot Dinner';

UPDATE ClassroomData
SET Company = 'Brookwood Camps & Catering'
WHERE Company = 'Brookwood Camps and Catering';

UPDATE ClassroomData
SET Company = 'Brookwood Camps & Catering'
WHERE Company = 'Brookwood Camps Catering';

UPDATE ClassroomData
SET Company = 'Brookwood Camps & Catering'
WHERE Company = 'Brookwood Catering';

UPDATE ClassroomData
SET Company = 'Brookwood Camps & Catering'
WHERE Company = 'Brookwoods Camps & Catering';

UPDATE ClassroomData
SET Company = 'Cabela''s Canada'
WHERE Company = 'Cabelas';

UPDATE ClassroomData
SET Company = 'Calgary Catholic School Board'
WHERE Company = 'Calgary Catholic School Bd';

UPDATE ClassroomData
SET Company = 'Calgary Immigrant Women''s Association'
WHERE Company = 'Calgary Imigrant Women''s Association';

UPDATE ClassroomData
SET Company = 'Calgary Women''s Emergency Shelter'
WHERE Company = 'Calgary Women Shelter';

UPDATE ClassroomData
SET Company = 'Calgary Women''s Emergency Shelter'
WHERE Company = 'Calgary Women''s Shelter';

COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'Carewest Nickle House'
WHERE Company = 'Carewest Nicklehouse';

UPDATE ClassroomData
SET Company = 'Carewest Nickle House'
WHERE Company = 'Carewest-Nickle House';

UPDATE ClassroomData
SET Company = 'Camp Chief Hector YMCA'
WHERE Company = 'Camp Chief Hector';

UPDATE ClassroomData
SET Company = 'Camp Chestermere'
WHERE Company = 'Camp Chestemer';

UPDATE ClassroomData
SET Company = 'Carl''s Jr.'
WHERE Company = 'Carl''s Jr';

UPDATE ClassroomData
SET Company = 'Carl''s Jr.'
WHERE Company = 'Carls Jr.';

UPDATE ClassroomData
SET Company = 'A&W Aldersyde'
WHERE Company = 'A7W Aldersyde';

COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'AgeCare Beverley Center '
WHERE Company = 'Age Care Beverley Center ';

UPDATE ClassroomData
SET Company = 'AgeCare Beverley Center Lake '
WHERE Company = 'Age Care Beverley Center Lake ';

UPDATE ClassroomData
SET Company = 'AgeCare Lake Midnapore'
WHERE Company = 'Age Care Lake Midnapore ';

UPDATE ClassroomData
SET Company = 'Agecare The Beverly Center Glenmore'
WHERE Company = 'AgeCare- Beverly Center Glenmore';

UPDATE ClassroomData
SET Company = 'Canada North Camps/ Dj Catering'
WHERE Company = 'Canada North Camps & DJ Catering';

UPDATE ClassroomData
SET Company = 'Austin''s Bar & Grill'
WHERE Company = 'Austin''s Bar & Brill';

UPDATE ClassroomData
SET Company = 'Canadian Brewhouse'
WHERE Company = 'Canadian Brew House';

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'Agecare - Walden Heights'
WHERE Company = 'AgeCare - Walden';

UPDATE ClassroomData
SET Company = 'Agecare - Walden Heights'
WHERE Company = 'Age Care Walden';

UPDATE ClassroomData
SET Company = 'Agecare - Walden Heights'
WHERE Company = 'Agecare Walden';

UPDATE ClassroomData
SET Company = 'Agecare - Walden Heights'
WHERE Company = 'AgeCare Walden Heights';

UPDATE ClassroomData
SET Company = 'AgeCare Beverley Center Lake Midnapore'
WHERE Company = 'AgeCare Beverley Center Lake';

UPDATE ClassroomData
SET Company = 'AgeCare Beverley Center Lake Midnapore'
WHERE Company = 'Agecare Beverly Lake Midnapore';

UPDATE ClassroomData
SET Company = 'AgeCare Beverley Center Lake Midnapore'
WHERE Company = 'AgeCare Lake Midnapore';

UPDATE ClassroomData
SET Company = 'Alpha House Society of Calgary'
WHERE Company = 'Alpha House Calgary';

UPDATE ClassroomData
SET Company = 'Anmol Indian Restaurant'
WHERE Company = 'Anmol Indian Resturant';

UPDATE ClassroomData
SET Company = 'Aramark '
WHERE Company = 'Armark';

UPDATE ClassroomData
SET Company = 'Aramark Age Care'
WHERE Company = 'Arramark Age Care';

UPDATE ClassroomData
SET Company = 'Aramark Canada Ltd'
WHERE Company = 'Aramark Canada limited';

UPDATE ClassroomData
SET Company = 'Aramark Canada Ltd'
WHERE Company = 'Aramark Canada Inc.';

UPDATE ClassroomData
SET Company = 'Aramark Canada Ltd'
WHERE Company = 'Aramark Canada';

UPDATE ClassroomData
SET Company = 'Aramark Canada Ltd'
WHERE Company = 'Aramark';

UPDATE ClassroomData
SET Company = 'Aramark Remote Services'
WHERE Company = 'Aramarak Remote Services';

COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'A&W'
WHERE Company = 'A&W Aldersyde';

UPDATE ClassroomData
SET Company = 'A&W'
WHERE Company = 'A&W Camrose';

UPDATE ClassroomData
SET Company = 'A&W'
WHERE Company = 'A&W Food Services of Canada';

UPDATE ClassroomData
SET Company = 'A&W'
WHERE Company = 'A&W Lacombe';

UPDATE ClassroomData
SET Company = 'A&W'
WHERE Company = 'A&W McKnight';

UPDATE ClassroomData
SET Company = 'A&W'
WHERE Company = 'A&W Petro Canada';

COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'AgeCare'
WHERE Company = 'Agecare';

UPDATE ClassroomData
SET Company = 'AgeCare'
WHERE Company = 'Agecare - Beverly Centre';

UPDATE ClassroomData
SET Company = 'AgeCare'
WHERE Company = 'AgeCare - Glenmore';

UPDATE ClassroomData
SET Company = 'AgeCare'
WHERE Company = 'AgeCare - Midnapore';

UPDATE ClassroomData
SET Company = 'AgeCare'
WHERE Company = 'AgeCare - Seton';

UPDATE ClassroomData
SET Company = 'AgeCare'
WHERE Company = 'Agecare - Valleyview';

UPDATE ClassroomData
SET Company = 'AgeCare'
WHERE Company = 'Agecare - Walden Heights';

UPDATE ClassroomData
SET Company = 'AgeCare'
WHERE Company = 'AgeCare Beverley Center';

UPDATE ClassroomData
SET Company = 'AgeCare'
WHERE Company = 'AgeCare Beverley Center Lake Midnapore';

UPDATE ClassroomData
SET Company = 'AgeCare'
WHERE Company = 'Agecare The Beverly Center Glenmore';

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'Alberta Health Services'
WHERE Company = 'AHS';

UPDATE ClassroomData
SET Company = 'Alberta Health Services Youth Addiction Services'
WHERE Company = 'AHS Youth Addiction Services';

COMMIT TRAN

SELECT DISTINCT Company
FROM ClassroomData
WHERE Company LIKE 'A%'
ORDER BY Company;

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'Bento Nouveau Ltd'
WHERE Company = 'Bento Nouveau';

UPDATE ClassroomData
SET Company = 'Bento Nouveau Ltd'
WHERE Company = 'Bento Nouveau Ltd.';

COMMIT TRAN

ROLLBACK TRAN

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'Best Western Plus Pocaterra Inn'
WHERE Company = 'Best Wester Plus Pocaterra Inn';

UPDATE ClassroomData
SET Company = 'Best Western Plus - Port O''Call Hotel '
WHERE Company = 'Best Western Port O''Call Hotel';

UPDATE ClassroomData
SET Company = 'Blackfoot Truckstop'
WHERE Company = 'Black Foot Truckstop';

UPDATE ClassroomData
SET Company = 'Blackfoot Truckstop'
WHERE Company = 'Blackfoot Truck Stop';

COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston Pizza - Beaumont';

UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston Pizza - Medicine Hat';

UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston Pizza - Shawnessy';

UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston Pizza 17th Ave SW';

UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston Pizza Agryll';

UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston Pizza Capilano';

UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston Pizza Cochrane';

UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston Pizza Innisfail';

UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston Pizza Okotoks';

UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston Pizza Olds';

UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston pizza Southtrail';

UPDATE ClassroomData
SET Company = 'Boston Pizza'
WHERE Company = 'Boston Pizza Sylvan Lake';

COMMIT TRAN

SELECT DISTINCT Company
FROM ClassroomData
WHERE Company LIKE 'B%'
ORDER BY Company;

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'Cabela''s Canada'
WHERE Company = 'Cabela''s Canada Edmonton South';

UPDATE ClassroomData
SET Company = 'Calgary Alpha House'
WHERE Company = 'Calgay Alpha House';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'care west';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewest (Nickle House)';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewesrt- Vernon Fanning';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewest (Signal Point)';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewest - Dr. Vernon Fanning';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewest - Nickle House';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewest Col. Belcher';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewest George Boyak';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewest Glenmore pArk';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewest Nickle House';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewest Royal Park';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewest Sarcee';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carewest-Colonel Belcher';

UPDATE ClassroomData
SET Company = 'Carewest'
WHERE Company = 'Carwest (Sarcee)';

COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'Cedarwood Station'
WHERE Company = 'Cederwood Station';

UPDATE ClassroomData
SET Company = 'Cedarwood Station Retirement Residence'
WHERE Company = 'Cedarwood Station';

UPDATE ClassroomData
SET Company = 'Cedarwood Station Retirement Residence'
WHERE Company = 'Cedarwood Station Retirement';

UPDATE ClassroomData
SET Company = 'Cedarwood Station Retirement Residence'
WHERE Company = 'Cedar Station';

COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET Company = 'Cenovus Energy'
WHERE Company = 'Cenovus';

UPDATE ClassroomData
SET Company = 'Revera Living'
WHERE Company = 'Chateau Renoir (Revera)';

UPDATE ClassroomData
SET Company = 'Revera Living'
WHERE Company = 'Chateau Renoir by Revera Retirement Living';

UPDATE ClassroomData
SET Company = 'Revera Living'
WHERE Company = 'Chateau Renoir Retirement Housing ';

UPDATE ClassroomData
SET Company = 'Revera Living'
WHERE Company = 'Chateau Renoir Retirement Housing ';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chili''s 16 Ave';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chili''s 16th Ave';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chili''s Bar and Grill';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chili''s Barlow';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chili''s Calgary International Airport';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chili''s Noth Hill';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chili''s Texas Grill';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chili''s Texas Grill South Centre';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chilis';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chilis - 16th Ave.';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chilis 16th Ave';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chilis Ct Grill Restaurant';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chilis Resturant';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chilis Southcenter';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chilis Texas Grill';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chilis-Barlow';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chilis-South Center';

UPDATE ClassroomData
SET Company = 'Chili''s'
WHERE Company = 'Chillis Texas Grill';

UPDATE ClassroomData
SET Company = 'Chillabong''s Bar & Grill'
WHERE Company = 'Chillaborjs Bar and Grill';


SELECT DISTINCT Company
FROM ClassroomData
WHERE Company LIKE 'Chil%'
ORDER BY Company;

COMMIT TRAN

BEGIN TRAN
UPDATE ClassroomData
SET CourseName = 'Exam - SafeCheck® Canadian Food Safety Certification'
WHERE CourseName = 'Exam - SafeCheck®? Canadian Food Safety Certification';

COMMIT TRAN

SELECT CourseName, LEN(CourseName) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;

BEGIN TRAN
UPDATE ClassroomData
SET ExamNumber = NULL
WHERE ExamNumber = '- Exam - SafeCheck®? Canadian Food Safety Certification';

COMMIT TRAN

SELECT ExamNumber, LEN(ExamNumber) Namelength
FROM ClassRoomData
ORDER BY Namelength desc;