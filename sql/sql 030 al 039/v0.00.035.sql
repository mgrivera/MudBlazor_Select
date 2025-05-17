/*    
	  Domingo, 22 de Diciembre de 2.024  -   v0.00.035.sql 
	  
	  Siniestros: agregamos la tabla de movimientos. 
*/



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
ALTER TABLE dbo.Siniestros SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.SiniestrosMovimientos
	(
	Id int NOT NULL IDENTITY (1, 1),
	SiniestroId int NOT NULL,
	Fecha date NOT NULL,
	MonedaId nvarchar(10) NOT NULL,
	Tipo nvarchar(10) NOT NULL,
	Monto money NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.SiniestrosMovimientos ADD CONSTRAINT
	PK_SiniestrosMovimientos PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.SiniestrosMovimientos ADD CONSTRAINT
	FK_SiniestrosMovimientos_Siniestros FOREIGN KEY
	(
	SiniestroId
	) REFERENCES dbo.Siniestros
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.SiniestrosMovimientos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
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
ALTER TABLE dbo.Monedas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.SiniestrosMovimientos ADD CONSTRAINT
	FK_SiniestrosMovimientos_Monedas FOREIGN KEY
	(
	MonedaId
	) REFERENCES dbo.Monedas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.SiniestrosMovimientos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT































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
ALTER TABLE dbo.Siniestros
	DROP CONSTRAINT FK_Siniestros_Ciudades
GO
ALTER TABLE dbo.Siniestros
	DROP CONSTRAINT FK_Siniestros_Ciudades1
GO
ALTER TABLE dbo.Siniestros
	DROP CONSTRAINT FK_Siniestros_Ciudades2
GO
ALTER TABLE dbo.Ciudades SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Siniestros
	DROP CONSTRAINT FK_Siniestros_CausasSiniestro
GO
ALTER TABLE dbo.CausasSiniestro SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Siniestros
	DROP CONSTRAINT FK_Siniestros_Riesgos
GO
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Companias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Siniestros
	(
	Id int NOT NULL IDENTITY (1, 1),
	RiesgoId int NOT NULL,
	FEmision date NOT NULL,
	FNotificacion date NOT NULL,
	FOcurrencia date NOT NULL,
	Status nvarchar(20) NOT NULL,
	AjustadorId nvarchar(10) NULL,
	Causa nvarchar(10) NOT NULL,
	CiudadPoliza nvarchar(6) NOT NULL,
	CiudadAsegurado nvarchar(6) NOT NULL,
	CiudadSiniestro nvarchar(6) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Siniestros SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_Siniestros ON
GO
IF EXISTS(SELECT * FROM dbo.Siniestros)
	 EXEC('INSERT INTO dbo.Tmp_Siniestros (Id, RiesgoId, FEmision, FNotificacion, FOcurrencia, Status, Causa, CiudadPoliza, CiudadAsegurado, CiudadSiniestro)
		SELECT Id, RiesgoId, FEmision, FNotificacion, FOcurrencia, Status, Causa, CiudadPoliza, CiudadAsegurado, CiudadSiniestro FROM dbo.Siniestros WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Siniestros OFF
GO
ALTER TABLE dbo.SiniestrosMovimientos
	DROP CONSTRAINT FK_SiniestrosMovimientos_Siniestros
GO
DROP TABLE dbo.Siniestros
GO
EXECUTE sp_rename N'dbo.Tmp_Siniestros', N'Siniestros', 'OBJECT' 
GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	PK_Siniestros PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	FK_Siniestros_Riesgos FOREIGN KEY
	(
	RiesgoId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	FK_Siniestros_CausasSiniestro FOREIGN KEY
	(
	Causa
	) REFERENCES dbo.CausasSiniestro
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	FK_Siniestros_Ciudades FOREIGN KEY
	(
	CiudadPoliza
	) REFERENCES dbo.Ciudades
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	FK_Siniestros_Ciudades1 FOREIGN KEY
	(
	CiudadAsegurado
	) REFERENCES dbo.Ciudades
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	FK_Siniestros_Ciudades2 FOREIGN KEY
	(
	CiudadSiniestro
	) REFERENCES dbo.Ciudades
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Siniestros ADD CONSTRAINT
	FK_Siniestros_Companias FOREIGN KEY
	(
	AjustadorId
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.SiniestrosMovimientos ADD CONSTRAINT
	FK_SiniestrosMovimientos_Siniestros FOREIGN KEY
	(
	SiniestroId
	) REFERENCES dbo.Siniestros
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.SiniestrosMovimientos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


















Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.035', GetDate()) 

