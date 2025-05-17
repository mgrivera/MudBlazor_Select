/*    
	  Miércoles, 18 de Diciembre de 2.024  -   v0.00.034.sql 
	  
	  Consulta de cobranzas: modificamos la tabla tmp de esta consulta, 
	  para agregar el nuevo campo Numero. También el endoso. 
*/


Delete From Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report


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
ALTER TABLE dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report
	DROP CONSTRAINT FK_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report_ProcesosUsuarios
GO
ALTER TABLE dbo.ProcesosUsuarios SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report
	(
	Id int NOT NULL IDENTITY (1, 1),
	ProcesoId int NOT NULL,
	MonedaId nvarchar(10) NOT NULL,
	CompaniaId nvarchar(10) NOT NULL,
	Numero int NOT NULL,
	Endoso smallint NOT NULL,
	Referencia nvarchar(16) NOT NULL,
	Origen nvarchar(10) NOT NULL,
	NumeroCuota smallint NOT NULL,
	CantidadCuotas smallint NOT NULL,
	Fecha date NOT NULL,
	FechaVencimiento date NOT NULL,
	Monto money NOT NULL,
	Pago_Remesa int NOT NULL,
	Pago_MonedaId nvarchar(10) NOT NULL,
	Pago_Fecha date NOT NULL,
	Pago_Monto money NOT NULL,
	Pago_Completo bit NOT NULL,
	Cia nvarchar(10) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report ON
GO
IF EXISTS(SELECT * FROM dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report)
	 EXEC('INSERT INTO dbo.Tmp_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report (Id, ProcesoId, MonedaId, CompaniaId, Referencia, Origen, NumeroCuota, CantidadCuotas, Fecha, FechaVencimiento, Monto, Pago_Remesa, Pago_MonedaId, Pago_Fecha, Pago_Monto, Pago_Completo, Cia)
		SELECT Id, ProcesoId, MonedaId, CompaniaId, CONVERT(nvarchar(16), Entidad), Origen, NumeroCuota, CantidadCuotas, Fecha, FechaVencimiento, Monto, Pago_Remesa, Pago_MonedaId, Pago_Fecha, Pago_Monto, Pago_Completo, Cia FROM dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report OFF
GO
DROP TABLE dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report
GO
EXECUTE sp_rename N'dbo.Tmp_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report', N'Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report', 'OBJECT' 
GO
ALTER TABLE dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report ADD CONSTRAINT
	PK_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report ADD CONSTRAINT
	FK_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report_ProcesosUsuarios FOREIGN KEY
	(
	ProcesoId
	) REFERENCES dbo.ProcesosUsuarios
	(
	Id
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
COMMIT






















/****** Object:  View [dbo].[V_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report]    Script Date: 12/18/2024 11:38:12 AM ******/
DROP VIEW [dbo].[V_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report]
GO

/****** Object:  View [dbo].[V_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report]    Script Date: 12/18/2024 11:38:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   View [dbo].[V_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report]
AS 
SELECT dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Id, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.ProcesoId, 
				  dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.MonedaId, dbo.Monedas.Descripcion AS MonedaDescripcion, 
				  dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.CompaniaId, dbo.Companias.Nombre AS CompaniaNombre, 
				  dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Numero, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Endoso, 
                  dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Referencia, 
				  dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Origen, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.NumeroCuota, 
                  dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.CantidadCuotas, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Fecha, 
                  dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.FechaVencimiento, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Monto, 
                  dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Pago_Remesa, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Pago_MonedaId, 
				  monRem.Simbolo as RemesaMonedaSimbolo, rem.MiSu as Pago_Remesa_MiSu, 
                  dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Pago_Fecha, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Pago_Monto, 
                  dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Pago_Completo, dbo.Empresa.Nombre AS EmpresaNombre
	FROM dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report INNER JOIN dbo.Monedas ON dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.MonedaId = dbo.Monedas.Id
	Inner Join dbo.Companias ON dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.CompaniaId = dbo.Companias.Id

	Inner Join Monedas monRem On Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Pago_MonedaId = monRem.Id 
	Inner Join Remesas rem On Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Pago_Remesa = rem.Id 
	Inner Join dbo.Empresa On dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Cia = dbo.Empresa.Id
	
GO













Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.034', GetDate()) 

