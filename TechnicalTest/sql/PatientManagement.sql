

IF OBJECT_ID('dbo.MedicationAdministration') IS NOT NULL
BEGIN
	DROP TABLE dbo.MedicationAdministration
END
GO

IF OBJECT_ID('dbo.PatientAllergy') IS NOT NULL
BEGIN
	DROP TABLE [dbo].[PatientAllergy]
END
GO

IF OBJECT_ID('dbo.Patient') IS NOT NULL
BEGIN
	DROP TABLE dbo.Patient
END
GO

IF OBJECT_ID('dbo.Medication') IS NOT NULL
BEGIN
	DROP TABLE dbo.Medication
END
GO


IF OBJECT_ID('dbo.ErrorLog') IS NOT NULL
BEGIN
	DROP TABLE dbo.ErrorLog
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[PatientID] [int] NOT NULL,
	[FirstName] [nvarchar](40) NOT NULL,
	[LastName] [nvarchar](40) NOT NULL,
	[Gender] [nvarchar](10) NOT NULL,
	[DOB] [datetime] NOT NULL,
	[HeightCms] [decimal](4, 1) NOT NULL,
	[WeightKgs] [decimal](4, 1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Medication](
	[MedicationID] [int] NOT NULL,
	[MedicationName] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MedicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MedicationAdministration](
	[MedicationAdministrationID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NOT NULL,
	[MedicationID] [int] NOT NULL,
	[Created] [datetime] NOT NULL,
	[BMI] [decimal](3, 1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MedicationAdministrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MedicationAdministration]  WITH CHECK ADD  CONSTRAINT [FK_MedicationAdministration_Medication] FOREIGN KEY([MedicationID])
REFERENCES [dbo].[Medication] ([MedicationID])
GO

ALTER TABLE [dbo].[MedicationAdministration] CHECK CONSTRAINT [FK_MedicationAdministration_Medication]
GO

ALTER TABLE [dbo].[MedicationAdministration]  WITH CHECK ADD  CONSTRAINT [FK_MedicationAdministration_Patient] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO

ALTER TABLE [dbo].[MedicationAdministration] CHECK CONSTRAINT [FK_MedicationAdministration_Patient]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ErrorLog](
	[ErrorLogID] [int] IDENTITY(1,1) NOT NULL,
	[ErrorMessage] [nvarchar](4000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ErrorLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PatientAllergy](
	[PatientAllergyID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NOT NULL,
	[MedicationID] [int] NOT NULL,
 CONSTRAINT [PK_PatientAllergy] PRIMARY KEY CLUSTERED 
(
	[PatientAllergyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PatientAllergy]  WITH CHECK ADD  CONSTRAINT [FK_PatientAllergy_Medication] FOREIGN KEY([MedicationID])
REFERENCES [dbo].[Medication] ([MedicationID])
GO

ALTER TABLE [dbo].[PatientAllergy] CHECK CONSTRAINT [FK_PatientAllergy_Medication]
GO

ALTER TABLE [dbo].[PatientAllergy]  WITH CHECK ADD  CONSTRAINT [FK_PatientAllergy_Patient] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO

ALTER TABLE [dbo].[PatientAllergy] CHECK CONSTRAINT [FK_PatientAllergy_Patient]
GO


INSERT INTO [dbo].[Patient]
VALUES
           (1
           ,'Barbara'
           ,'Smith'
           ,'Female'
           ,'1944-08-28'
           ,165
           ,75.6)

INSERT INTO [dbo].[Patient]
VALUES
           (2
           ,'Helen'
           ,'Castillo'
           ,'Female'
           ,'1963-10-19'
           ,161
           ,65)

INSERT INTO [dbo].[Patient]
VALUES
           (3
           ,'Ivan'
           ,'Winter'
           ,'Male'
           ,'1942-10-12'
           ,175.3
           ,85)


INSERT INTO [dbo].[Medication]
VALUES
           (1
           ,'Laxsol sodium 50 mg + sennoside B 8 mg tablet'
		   )
INSERT INTO [dbo].[Medication]
VALUES
           (2
           ,'Ativan 1 mg tablet'
		   )  
INSERT INTO [dbo].[Medication]
VALUES
           (3
           ,'Abacavir 300 mg tablet'
		   )  

INSERT INTO [dbo].[Medication]
VALUES
           (4
           ,'Cardizem CD - diltiazem hydrochloride 240 mg capsule: extended release'
		   )  
INSERT INTO [dbo].[Medication]
VALUES
           (5
           ,'Docusate sodium 50 mg + sennoside B 8 mg tablet'
		   )  

INSERT PatientAllergy (PatientID, MedicationID) VALUES (3, 2)

GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[uspPatientManage]
	@PatientId INT = NULL,
	@FirstName NVARCHAR(40),
	@LastName NVARCHAR(40),
	@Gender NVARCHAR(10),
	@DOB DATETIME,
	@HeightCms DECIMAL(4,1),
	@WeightKgs DECIMAL(4,1)
AS 
BEGIN

	/*
		This procedure receives data from the API tier that will insert a new patient record or update an existing patient record.
	*/

	BEGIN TRAN
		IF EXISTS (SELECT * FROM [dbo].[Patient] WITH (UPDLOCK,SERIALIZABLE) WHERE [PatientID] = @PatientId)
		BEGIN
			UPDATE 
				[dbo].[Patient]	
			SET
				[FirstName] = @FirstName,
				[LastName] = @LastName,
				[Gender] = @Gender,
				[DOB] = @DOB,
				[HeightCms] = @HeightCms,
				[WeightKgs] = @WeightKgs
			WHERE 
				[PatientID] = @PatientId
		END
		ELSE
		BEGIN
			INSERT 
				[dbo].[Patient] (
					[PatientID],
					[FirstName],
					[LastName],
					[Gender],
					[DOB],
					[HeightCms],
					[WeightKgs]
			) VALUES (
				@PatientId,
				@FirstName,
				@LastName,
				@Gender,
				@DOB,
				@HeightCms,
				@WeightKgs
			)
		END
	COMMIT TRAN


END
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[uspMedicationAdministration]
	@PatientId INT,
	@MedicationId INT,
	@BMI DECIMAL(3,1)
AS 
BEGIN


	/*
		This procedure receives data from the API tier that will insert a new Medication being administered to an existing patient.
	*/
	IF EXISTS (SELECT * FROM [dbo].[PatientAllergy] WITH (NOLOCK) WHERE [PatientID] = @PatientId AND [MedicationID] = @MedicationId)
	BEGIN

		;THROW 50000, 'Patient is allergic to this medication', 1

	END
	ELSE
	BEGIN

		INSERT
			[dbo].[MedicationAdministration] (
				[PatientID],
				[MedicationID],
				[Created],
				[BMI]
			) VALUES (
				@PatientId,
				@MedicationId,
				GETDATE(),
				@BMI
			)

			END

END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[uspLogError]
	@ErrorMessage NVARCHAR(400)
AS 
BEGIN

	/*
		This procedure will insert an error message log.
	*/

	INSERT
		[dbo].[ErrorLog] (ErrorMessage)
	VALUES
		(@ErrorMessage)

END

GO
