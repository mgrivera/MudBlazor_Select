/*    
	  Miércoles, 26 de Junio de 2.024  -   v0.00.0017.sql 
	  
	  Agregamos las tablas: Marcas y Modelos 
	  Eliminamos la tabla Aeronaves 
	  Agregamos las columnas a la tabla Riesgos: Make & Model 
	  Agregamos las relaciones entre Marcas, Modelos y Riesgos 
	  Eliminamos la columna Aeronave en la tabla Riesgos 
*/

/* NOTA IMPORTANTE: eliminamos los riesgos ANTES de ejecutar el script  */


Delete From Riesgos 


BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosDatosAeronave
	DROP CONSTRAINT FK_RiesgosDatosAeronave_Aeronaves
GO
DROP TABLE dbo.Aeronaves
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosDatosAeronave
	DROP CONSTRAINT FK_RiesgosDatosAeronave_Riesgos
GO
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosDatosAeronave
	DROP CONSTRAINT FK_RiesgosDatosAeronave_Paises
GO
ALTER TABLE dbo.Paises SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Modelos
	(
	Id nvarchar(10) NOT NULL,
	Descripcion nvarchar(25) NOT NULL,
	Abreviatura nvarchar(15) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Modelos ADD CONSTRAINT
	PK_Modelos PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Modelos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Marcas
	(
	Id nvarchar(10) NOT NULL,
	Descripcion nvarchar(25) NOT NULL,
	Abreviatura nvarchar(15) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Marcas ADD CONSTRAINT
	PK_Marcas PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Marcas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_RiesgosDatosAeronave
	(
	Id int NOT NULL IDENTITY (1, 1),
	RiesgoId int NOT NULL,
	Year smallint NOT NULL,
	Make nvarchar(10) NOT NULL,
	Model nvarchar(10) NOT NULL,
	Wings nvarchar(10) NOT NULL,
	Pax smallint NOT NULL,
	Crew smallint NOT NULL,
	Baby smallint NOT NULL,
	Registration nvarchar(20) NOT NULL,
	UsedFor nvarchar(25) NOT NULL,
	CountryId nvarchar(6) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_RiesgosDatosAeronave SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_RiesgosDatosAeronave ON
GO
IF EXISTS(SELECT * FROM dbo.RiesgosDatosAeronave)
	 EXEC('INSERT INTO dbo.Tmp_RiesgosDatosAeronave (Id, RiesgoId, Year, Wings, Pax, Crew, Baby, Registration, UsedFor, CountryId)
		SELECT Id, RiesgoId, Year, Wings, Pax, Crew, Baby, Registration, UsedFor, CountryId FROM dbo.RiesgosDatosAeronave WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_RiesgosDatosAeronave OFF
GO
DROP TABLE dbo.RiesgosDatosAeronave
GO
EXECUTE sp_rename N'dbo.Tmp_RiesgosDatosAeronave', N'RiesgosDatosAeronave', 'OBJECT' 
GO
ALTER TABLE dbo.RiesgosDatosAeronave ADD CONSTRAINT
	PK_RiesgosDatosAeronave PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.RiesgosDatosAeronave ADD CONSTRAINT
	FK_RiesgosDatosAeronave_Paises FOREIGN KEY
	(
	CountryId
	) REFERENCES dbo.Paises
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RiesgosDatosAeronave ADD CONSTRAINT
	FK_RiesgosDatosAeronave_Riesgos FOREIGN KEY
	(
	RiesgoId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.RiesgosDatosAeronave ADD CONSTRAINT
	FK_RiesgosDatosAeronave_Marcas FOREIGN KEY
	(
	Make
	) REFERENCES dbo.Marcas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RiesgosDatosAeronave ADD CONSTRAINT
	FK_RiesgosDatosAeronave_Modelos FOREIGN KEY
	(
	Model
	) REFERENCES dbo.Modelos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT

Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.017', GetDate()) 

