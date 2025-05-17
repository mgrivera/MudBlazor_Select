/*    
	  Martes, 25 de Febrero de 2.025  -   v0.00.042.sql 
	  
	  Agregamos la columna CompaniaId a la tabla Compañías 
	  También a la tabla Asegurados (AseguradoId) 

	  Nota: la idea de estas columnas es poder registrar un tipo de ID  para las compañías 
	  y los asegurados; por ejemplo, en Venezuela podría ser el Rif 
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
	CompaniaId nvarchar(15) NULL,
	Nosotros bit NOT NULL,
	Direccion1 nvarchar(75) NULL,
	Direccion2 nvarchar(75) NULL,
	Direccion3 nvarchar(75) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Companias SET (LOCK_ESCALATION = TABLE)
GO
IF EXISTS(SELECT * FROM dbo.Companias)
	 EXEC('INSERT INTO dbo.Tmp_Companias (Id, Nombre, Abreviatura, Nosotros, Direccion1, Direccion2, Direccion3)
		SELECT Id, Nombre, Abreviatura, Nosotros, Direccion1, Direccion2, Direccion3 FROM dbo.Companias WITH (HOLDLOCK TABLOCKX)')
GO
ALTER TABLE dbo.RiesgosProrrata
	DROP CONSTRAINT FK_RiesgosProrrata_Companias
GO
ALTER TABLE dbo.Siniestros
	DROP CONSTRAINT FK_Siniestros_Companias
GO
ALTER TABLE dbo.RiesgosCompanias
	DROP CONSTRAINT FK_RiesgosCompanias_Companias
GO
ALTER TABLE dbo.Remesas
	DROP CONSTRAINT FK_Remesas_Companias
GO
ALTER TABLE dbo.Cuotas
	DROP CONSTRAINT FK_Cuotas_Companias
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Companias
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Companias1
GO
ALTER TABLE dbo.Empresa
	DROP CONSTRAINT FK_Empresa_Companias
GO
ALTER TABLE dbo.Documentos
	DROP CONSTRAINT FK_Documentos_Companias
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
ALTER TABLE dbo.Documentos ADD CONSTRAINT
	FK_Documentos_Companias FOREIGN KEY
	(
	CompaniaId
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Documentos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Empresa ADD CONSTRAINT
	FK_Empresa_Companias FOREIGN KEY
	(
	CompaniaNosotros
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Empresa SET (LOCK_ESCALATION = TABLE)
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
GO
ALTER TABLE dbo.Cuotas ADD CONSTRAINT
	FK_Cuotas_Companias FOREIGN KEY
	(
	Compania
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Cuotas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Remesas ADD CONSTRAINT
	FK_Remesas_Companias FOREIGN KEY
	(
	CompaniaId
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Remesas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
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
ALTER TABLE dbo.RiesgosCompanias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
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
ALTER TABLE dbo.Siniestros SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosProrrata ADD CONSTRAINT
	FK_RiesgosProrrata_Companias FOREIGN KEY
	(
	CompaniaId
	) REFERENCES dbo.Companias
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.RiesgosProrrata SET (LOCK_ESCALATION = TABLE)
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
ALTER TABLE dbo.Asegurados ADD
	AseguradoId nvarchar(15) NULL
GO
ALTER TABLE dbo.Asegurados SET (LOCK_ESCALATION = TABLE)
GO
COMMIT





Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.042', GetDate()) 

