/*    
	  Jueves, 23 de Mayo de 2.024  -   v0.00.009.sql 
	  
	  Agregamos la columna Cia a la tabla Riesgos 
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
ALTER TABLE dbo.Riesgos ADD
	Cia nvarchar(10) NULL
GO
ALTER TABLE dbo.Riesgos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/*    
	  NOTA IMPORTANTE: 
	  Aquí debemos tomoar el valor del id de la empresa y agregarlo a la nueva columna 
*/

Update Riesgos Set Cia = 'smr'


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
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Paises
GO
ALTER TABLE dbo.Paises SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Asegurados
GO
ALTER TABLE dbo.Asegurados SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Ramos
GO
ALTER TABLE dbo.Ramos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Monedas
GO
ALTER TABLE dbo.Monedas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Companias
GO
ALTER TABLE dbo.Riesgos
	DROP CONSTRAINT FK_Riesgos_Companias1
GO
ALTER TABLE dbo.Companias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Empresa SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Riesgos
	(
	Id int NOT NULL IDENTITY (1, 1),
	Numero nvarchar(16) NOT NULL,
	Endoso smallint NOT NULL,
	Desde_original datetime NOT NULL,
	Hasta_original datetime NOT NULL,
	Dias_original smallint NOT NULL,
	Desde_aceptacion datetime NULL,
	Hasta_aceptacion datetime NULL,
	Dias_aceptacion smallint NULL,
	Estado nvarchar(4) NOT NULL,
	Moneda nvarchar(10) NOT NULL,
	Cedente nvarchar(10) NOT NULL,
	Corredor nvarchar(10) NULL,
	Ramo nvarchar(10) NOT NULL,
	Asegurado nvarchar(10) NOT NULL,
	Pais nvarchar(6) NOT NULL,
	Cia nvarchar(10) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Riesgos SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_Riesgos ON
GO
IF EXISTS(SELECT * FROM dbo.Riesgos)
	 EXEC('INSERT INTO dbo.Tmp_Riesgos (Id, Numero, Endoso, Desde_original, Hasta_original, Dias_original, Desde_aceptacion, Hasta_aceptacion, Dias_aceptacion, Estado, Moneda, Cedente, Corredor, Ramo, Asegurado, Pais, Cia)
		SELECT Id, Numero, Endoso, Desde_original, Hasta_original, Dias_original, Desde_aceptacion, Hasta_aceptacion, Dias_aceptacion, Estado, Moneda, Cedente, Corredor, Ramo, Asegurado, Pais, Cia FROM dbo.Riesgos WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Riesgos OFF
GO
ALTER TABLE dbo.RiesgosCoberturas
	DROP CONSTRAINT FK_RiesgosCoberturas_Riesgos
GO
ALTER TABLE dbo.RiesgosCompanias
	DROP CONSTRAINT FK_RiesgosCompanias_Riesgos
GO
DROP TABLE dbo.Riesgos
GO
EXECUTE sp_rename N'dbo.Tmp_Riesgos', N'Riesgos', 'OBJECT' 
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	PK_Riesgos PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE UNIQUE NONCLUSTERED INDEX IX_Riesgos ON dbo.Riesgos
	(
	Numero,
	Endoso
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Monedas FOREIGN KEY
	(
	Moneda
	) REFERENCES dbo.Monedas
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Ramos FOREIGN KEY
	(
	Ramo
	) REFERENCES dbo.Ramos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Asegurados FOREIGN KEY
	(
	Asegurado
	) REFERENCES dbo.Asegurados
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Paises FOREIGN KEY
	(
	Pais
	) REFERENCES dbo.Paises
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Riesgos ADD CONSTRAINT
	FK_Riesgos_Empresa FOREIGN KEY
	(
	Cia
	) REFERENCES dbo.Empresa
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
BEGIN TRANSACTION
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
ALTER TABLE dbo.RiesgosCompanias SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.RiesgosCoberturas ADD CONSTRAINT
	FK_RiesgosCoberturas_Riesgos FOREIGN KEY
	(
	RiesgoId
	) REFERENCES dbo.Riesgos
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.RiesgosCoberturas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT























/* agregamos la tabla tCiaSeleccionada */ 
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CiaSeleccionada](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CiaSeleccionada] nvarchar(10) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Abreviatura] [nvarchar](15) NOT NULL,
	[Usuario] [nvarchar](50) NOT NULL
 CONSTRAINT [PK_CiaSeleccionada] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CiaSeleccionada]  WITH CHECK ADD  CONSTRAINT [FK_CiaSeleccionada_Empresa] FOREIGN KEY([CiaSeleccionada])
REFERENCES [dbo].[Empresa] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[CiaSeleccionada] CHECK CONSTRAINT [FK_CiaSeleccionada_Empresa]
GO























Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.009', GetDate()) 
