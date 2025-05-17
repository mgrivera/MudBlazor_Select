/*    
	  Lunes, 11 de Noviembre de 2.024  -   v0.00.028.sql 
	  
	  Agregamos la nueva tabla Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report
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
CREATE TABLE dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report
	(
	Id int NOT NULL IDENTITY (1, 1),
	ProcesoId int NOT NULL,
	MonedaId nvarchar(10) NOT NULL,
	CompaniaId nvarchar(10) NOT NULL,
	Entidad nvarchar(25) NOT NULL,
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
ALTER TABLE dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



CREATE OR ALTER View [dbo].[V_Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report]
AS 
SELECT dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Id, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.ProcesoId, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.MonedaId, 
                  dbo.Monedas.Descripcion AS MonedaDescripcion, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.CompaniaId, dbo.Companias.Nombre AS CompaniaNombre, 
                  dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Entidad, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.Origen, dbo.Tmp_CuotasCobradasYPagadas_ConsultaCobranzas_Report.NumeroCuota, 
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
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.028', GetDate()) 

