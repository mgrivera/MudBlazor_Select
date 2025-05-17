/*    
	  Lunes, 24 de Junio de 2.024  -   v0.00.0014.sql 
	  
	  Agregamos columnas para la dirección en Compañías 
	  Agregamos la tabla Tipos 
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
ALTER TABLE dbo.Companias ADD
	Direccion1 nvarchar(75) NULL,
	Direccion2 nvarchar(75) NULL,
	Direccion3 nvarchar(75) NULL
GO
ALTER TABLE dbo.Companias SET (LOCK_ESCALATION = TABLE)
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
CREATE TABLE dbo.Tipos
	(
	Id nvarchar(10) NOT NULL,
	Descripcion nvarchar(50) NOT NULL,
	Abreviatura nvarchar(15) NOT NULL,
	Tipo nvarchar(10) NOT NULL,
	Texto varchar(MAX) NULL,
	TextoEnglish varchar(MAX) NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE dbo.Tipos ADD CONSTRAINT
	PK_Tipos PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Tipos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/* Agregamos el tipo Indefinido para usarlo en los riesgos que *ahora* no lo tienen */
Insert Into Tipos (Id, Descripcion, Abreviatura, Tipo) Values ('Indef', 'Indefinido', 'Indefinido', 'Fac') 


Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.014', GetDate()) 

