/*    
	  Lunes, 23 de Septiembre de 2.024  -   v0.00.025.sql 
	  
	  Agregamos las tablas: Tmp_Generales_ConsultaEmision_Report 
	  Además, el view para leer la tabla desde la apliacción Access: V_Tmp_Generales_ConsultaEmision_Report
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
ALTER TABLE dbo.ProcesosUsuarios SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Generales_ConsultaEmision_Report
	(
	Id int NOT NULL IDENTITY (1, 1),
	ProcesoId int NOT NULL,
	RiesgoId int NOT NULL,
	MonedaId nvarchar(10) NOT NULL,
	RamoId nvarchar(10) NOT NULL,
	Numero nvarchar(16) NOT NULL,
	Endoso smallint NOT NULL,
	Desde datetime NOT NULL,
	Hasta datetime NOT NULL,
	Estado nvarchar(10) NOT NULL,
	CedenteId nvarchar(10) NOT NULL,
	Parte nvarchar(10) NOT NULL,
	CompaniaId nvarchar(10) NOT NULL,
	AseguradoId nvarchar(10) NOT NULL,
	SumaAsegurada money NOT NULL,
	Prima money NOT NULL,
	OrdenPorc decimal(10, 6) NOT NULL,
	SumaReasegurada money NOT NULL,
	PrimaBruta money NOT NULL,
	Com_Corr_Imp_Res money NOT NULL,
	PrimaNeta money NOT NULL,
	CiaId nvarchar(10) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Generales_ConsultaEmision_Report ADD CONSTRAINT
	PK_Tmp_Generales_ConsultaEmision_Report PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Tmp_Generales_ConsultaEmision_Report ADD CONSTRAINT
	FK_Tmp_Generales_ConsultaEmision_Report_ProcesosUsuarios FOREIGN KEY
	(
	ProcesoId
	) REFERENCES dbo.ProcesosUsuarios
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.Tmp_Generales_ConsultaEmision_Report SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO

/****** Object:  View [dbo].[V_Tmp_Generales_ConsultaEmision_Report]     ******/
CREATE OR ALTER View [dbo].[V_Tmp_Generales_ConsultaEmision_Report] as 

Select t.Id, t.ProcesoId, t.RiesgoId,  
m.Descripcion as MonedaNombre, m.Simbolo as MonedaSimbolo, 
r.Descripcion as RamoNombre, r.Abreviatura as RamoAbreviatura, 
t.Numero, t.Endoso, t.Desde, t.Hasta, t.Estado, 
ced.Nombre as CedenteNombre, ced.Abreviatura as CedenteAbreviatura, 
t.Parte, 
c.Nombre as ReaseguradorNombre, c.Abreviatura as ReaseguradorAbreviatura, 
a.Nombre as AseguradoNombre, a.Abreviatura as AseguradoAbreviatura, 
t.SumaAsegurada, t.Prima, t.OrdenPorc, t.SumaReasegurada, t.PrimaBruta, t.Com_Corr_Imp_Res, t.PrimaNeta, 
e.Nombre as EmpresaNombre, e.Abreviatura as EmpresaAbreviatura 

From Tmp_Generales_ConsultaEmision_Report t 
Inner Join Monedas m On t.MonedaId = m.Id 
Inner Join Ramos r On t.RamoId = r.Id 
Inner Join Companias ced On t.CedenteId = ced.Id 
Inner Join Companias c On t.CompaniaId = c.Id 
Inner Join Asegurados a On t.AseguradoId = a.Id 
Inner Join Empresa e On t.CiaId = e.Id 
				 
GO

COMMIT


Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.025', GetDate()) 

