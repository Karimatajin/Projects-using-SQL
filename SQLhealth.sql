
/*** Create two new tables for patient visits ***/
/*** Add to database diagram ***/
/*** Create stored procedure for inserts ***/
/*** Insert test data ***/
/*** Add Indexes ***/
/*** Add a column to patient,and a trigger to insert the modified date to the column ***/
/*** Create views for common reports required by users ***/

CREATE DATABASE patient; 

USE patient; 

CREATE TABLE PatientVisits	(PatientKey nchar(15) PRIMARY KEY NOT NULL, VisitDate date NOT NULL, BloodPressure nchar(8) NOT NULL , 
Weight decimal(18,0) NOT NULL, Pulse int NOT NULL, DepressionLevel int NOT NULL, DoctorNotes varchar(MAX) NULL)

DROP TABLE PatientVisits
CREATE TABLE PatientVisitSymptoms (PatientKey nchar(15) Primary key, VisitDate date, Symptom varchar(100))
DROP TABLE PatientVisitSymptoms

CREATE TABLE Patient (PatientKey nchar(15) Primary Key, DoctorKey nchar(15), FirstName varchar(20), MiddleName varchar(20), LastName varchar(20), PhoneNumber nchar(10))
CREATE TABLE DroppedPatient(PatientKey nchar(15) Primary Key, DateDropped date, ReasonDropped varchar(20))
Create table PatientGroupAssignment(PatientKey nchar(15) Primary Key, GroupKey nchar(10))
CREATE TABLE Doctor(DoctorKey nchar(15) Primary Key, DoctorName varchar(20))
Create table Groups(GroupKey nchar(10) Primary Key, GroupDescription nvarchar(20))


/** Create Stored Procedure for each table  ***/

CREATE PROCEDURE [dbo].[usp_RecordPatient] 
	@PatientKey nchar(15),
	@DoctorKey nchar(15),
	@FirstName varchar(20),
	@MiddleName varchar(20),
	@LastName varchar(20),
	@PhoneNumber nchar(10)
AS
INSERT INTO [dbo].[Patient]
			([PatientKey],
			[DoctorKey],
			[FirstName],
			[MiddleName],
			[LastName],
			[PhoneNumber])
	  VALUES
			(@PatientKey,
			 @DoctorKey, 
	         @FirstName, 
	         @MiddleName, 
	         @LastName, 
	         @PhoneNumber)
GO

/****************************/
CREATE PROCEDURE [dbo].[usp_GetDoctorPatients] 
	@DoctorKey nchar(15),
	@DoctorName varchar(20)
AS
INSERT INTO [dbo].[Doctor]
			([DoctorKey],
			 [DoctorName])
	  VALUES
			(@DoctorKey, 
	         @DoctorName)
GO

/*********************/
CREATE PROCEDURE [dbo].[usp_GetRecordPatientVisitSymptoms]
	@PatientKey nchar(15),
	@VisitDate date,
    @Symptom varchar(20)
AS
INSERT INTO [dbo].[PatientVisitSymptoms]
			([PatientKey],
			 [VisitDate],
			 [Symptom])
	  VALUES
			(@PatientKey,
			 @VisitDate,
             @Symptom)
GO
/**********************/
CREATE PROCEDURE [dbo].[usp_GetRecordPatientVisits] 
	@PatientKey nchar(15),
	@VisitDate date,
	@BloodPressure nchar(8),
	@Weight decimal(18,0) ,
	@Pulse int,
	@DepressionLevel int, 
	@DoctorNotes varchar(max)
AS
INSERT INTO [dbo].[PatientVisits]
			([PatientKey],
			 [VisitDate],
			 [BloodPressure],
			 [Weight],
			 [Pulse],
			 [DepressionLevel],
			 [DoctorNotes])
	  VALUES
			(@PatientKey,
			 @VisitDate,
	         @BloodPressure, 
	         @Weight  ,
	         @Pulse ,
	         @DepressionLevel , 
	         @DoctorNotes)
GO

/********************************/
CREATE PROCEDURE [dbo].[usp_GetPatientGroupAssignment]
		@PatientKey nchar(15),
		@GroupKey nchar(10)
AS
INSERT INTO [dbo].[PatientGroupAssignment]
			([PatientKey],
			[GroupKey])
VALUES
			(@PatientKey,
			@GroupKey)


/*******************************************/
CREATE PROCEDURE [dbo].[usp_GETDroppedPatient]
		@PatientKey nchar(15),
		@DateDropped date,
		@ReasonDropped varchar(20)
AS
INSERT INTO [dbo].[DroppedPatient]
			([PatientKey],
			[DateDropped],
			[ReasonDropped])
VALUES
			(@PatientKey,
			 @DateDropped ,
			 @ReasonDropped )



/*** Execute the stored procedure of the patient table ***/
EXEC	[dbo].[usp_RecordPatient]
		@PatientKey =  '7',
		@DoctorKey =  '678',
		@FirstName =  'Mustafa',
		@MiddleName = 're',
		@LastName = 'fariss',
		@PhoneNumber = '905567778'


/*** Execute the stored procedure of the doctor table ***/
EXEC  [dbo].[usp_GetDoctorPatients]
	  @DoctorKey = '123',
	  @DoctorName = 'emiley'


/*** Execute the stored procedure of the DroppedPatient ***/
EXEC   [dbo].[usp_GETDroppedPatient]
		@PatientKey = '7',
		@DateDropped = '12/20/2020',
		@ReasonDropped = 'Bad Service'

/*** Execute the stored procedure of the PatientGroupAssignment ***/
EXEC	[dbo].[usp_GetPatientGroupAssignment]
		@PatientKey = '7',
		@GroupKey = '20'

/*** Execute the stored procedure of the patient visits ***/
EXEC	[dbo].[usp_GetRecordPatientVisits]
		@PatientKey = '10',
		@VisitDate = '12/25/2009',
		@BloodPressure = '100',
		@Weight = 10,
		@Pulse = 303,
		@DepressionLevel = 9,
		@DoctorNotes = 'better'


/*** Execute the stored procedure of the patient visits symptoms ***/

EXEC	[dbo].[usp_GetRecordPatientVisitSymptoms]
		@PatientKey = '7',
		@VisitDate = '12/25/2009',
		@Symptom = 'covid-19'


SELECT  'karima tajin' AS student,* FROM [dbo].[Patient]

/***** Create Triggers after updating the patient table ***/

CREATE TRIGGER [dbo].[trg_PatientModified1]
   ON  [dbo].[Patient]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	UPDATE Patient SET [DateModified] = GETDATE()
	WHERE PatientKey  IN (SELECT PatientKey FROM inserted)   

END
GO

SELECT 'karima tajin' AS student,* FROM [dbo].[Patient]

UPDATE Patient SET PhoneNumber = '383844'
WHERE PatientKey = '7'

/*************VIEWS**************************************************/
CREATE VIEW query1 AS 
SELECT 'Karima Tajin' AS Student, [PatientKey], [VisitDate]
FROM [dbo].[PatientVisits]
WHERE [DepressionLevel] > 10


SELECT * FROM query1

