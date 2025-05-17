/*    
	  Sábado, 22 de Marzo de 2.025  -   v0.00.043.sql 
	  
	  Quitamos la asociación entre Documentos y Siniestros. 
	  En sql server, parece, es complicado que un child tenga 2 parents 
	  (en este caso: Siniestros y Riesgos) 
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
ALTER TABLE dbo.Documentos
	DROP CONSTRAINT FK_Documentos_Siniestros
GO
ALTER TABLE dbo.Siniestros SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX IX_Documentos ON dbo.Documentos
	(
	EntidadId,
	Origen
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE dbo.Documentos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


Delete From tVersion
Insert Into tVersion(VersionActual, Fecha) Values('v0.00.043', GetDate()) 

