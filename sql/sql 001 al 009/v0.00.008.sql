/*    
	  Jueves, 16 de Mayo de 2.024  -   v0.00.008.sql 
	  
	  Agregamos la columna Nosotros a la tabla Companias 
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
CREATE TABLE dbo.Tmp_Companias
	(
	Id nvarchar(10) NOT NULL,
	Nombre nvarchar(50) NOT NULL,
	Abreviatura nvarchar(15) NOT NULL,
	Nosotros bit NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Companias SET (LOCK_ESCALATION = TABLE)
GO
IF EXISTS(SELECT * FROM dbo.Companias)
	 EXEC('INSERT INTO dbo.Tmp_Companias (Id, Nombre, Abreviatura, Nosotros)
		SELECT Id, Nombre, Abreviatura, 0 FROM dbo.Companias WITH (HOLDLOCK TABLOCKX)')
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Companias
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Companias1
GO
DROP TABLE dbo.Companias
GO
EXECUTE sp_rename N'dbo.Tmp_Companias', N'Companias', 'OBJECT' 
GO
ALTER TABLE dbo.Companias ADD CONSTRAINT
	PK_Companias PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Companias FOREIGN KEY
	(
	Cedente
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Companias1 FOREIGN KEY
	(
	Corredor
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
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
ALTER TABLE dbo.Monedas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Companias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.RiesgosCompanias
	(
	Id int NOT NULL IDENTITY (1, 1),
	RiesgoId int NOT NULL,
	CompaniaId nvarchar(10) NOT NULL,
	Nosotros bit NOT NULL,
	MonedaId nvarchar(10) NOT NULL,
	OrdenPorc decimal(5, 2) NOT NULL,
	SumaAsegurada money NOT NULL,
	SumaReasegurada money NOT NULL,
	Dias smallint NOT NULL,
	Prima money NOT NULL,
	DiasOrden smallint NOT NULL,
	PrimaProrrata money NOT NULL,
	PrimaBruta money NOT NULL,
	ComPorc decimal(9, 6) NOT NULL,
	Comision money NOT NULL,
	ResPorc decimal(9, 6) NOT NULL,
	Reserva money NOT NULL,
	CorrPorc decimal(9, 6) NOT NULL,
	Corretaje money NOT NULL,
	ImpPorc decimal(9, 6) NOT NULL,
	Impuesto money NOT NULL,
	PrimaNeta money NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.RiesgosCompanias ADD CONSTRAINT
	PK_RiesgosCompanias PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.RiesgosCompanias ADD CONSTRAINT
	FK_RiesgosCompanias_Riesgos FOREIGN KEY
	(
	RiesgoId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.RiesgosCompanias ADD CONSTRAINT
	FK_RiesgosCompanias_Companias FOREIGN KEY
	(
	CompaniaId
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RiesgosCompanias ADD CONSTRAINT
	FK_RiesgosCompanias_Monedas FOREIGN KEY
	(
	MonedaId
	) REFERENCES dbo.Monedas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RiesgosCompanias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.008', GetDate()) 
