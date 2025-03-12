/*
Script de implementación para BDPruebaOLTP

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BDPruebaOLTP"
:setvar DefaultFilePrefix "BDPruebaOLTP"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creando Tabla [dbo].[HistoriaClinica]...';


GO
CREATE TABLE [dbo].[HistoriaClinica] (
    [codHist]     INT       IDENTITY (1, 1) NOT NULL,
    [codPaciente] INT       NULL,
    [rowversion]  TIMESTAMP NOT NULL,
    CONSTRAINT [PK_HistoriaClinica] PRIMARY KEY CLUSTERED ([codHist] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Hospital]...';


GO
CREATE TABLE [dbo].[Hospital] (
    [codHospital]       INT           IDENTITY (1, 1) NOT NULL,
    [nombre]            VARCHAR (100) NOT NULL,
    [ciudad]            VARCHAR (50)  NOT NULL,
    [telefono]          VARCHAR (15)  NULL,
    [codMedicoDirector] INT           NULL,
    [rowversion]        TIMESTAMP     NOT NULL,
    CONSTRAINT [PK_Hospital] PRIMARY KEY CLUSTERED ([codHospital] ASC),
    UNIQUE NONCLUSTERED ([codMedicoDirector] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[HospitalServicio]...';


GO
CREATE TABLE [dbo].[HospitalServicio] (
    [codHospital] INT       NOT NULL,
    [codServicio] INT       NOT NULL,
    [numCamas]    INT       NULL,
    [rowversion]  TIMESTAMP NOT NULL,
    PRIMARY KEY CLUSTERED ([codHospital] ASC, [codServicio] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Internacion]...';


GO
CREATE TABLE [dbo].[Internacion] (
    [codinternacion]   INT       NOT NULL,
    [codVisita]        INT       NULL,
    [numHabitacion]    INT       NULL,
    [fechaInternacion] DATE      NULL,
    [fechaSalida]      DATE      NULL,
    [numCama]          INT       NULL,
    [rowversion]       TIMESTAMP NOT NULL,
    PRIMARY KEY CLUSTERED ([codinternacion] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Medico]...';


GO
CREATE TABLE [dbo].[Medico] (
    [codMedico]       INT           IDENTITY (1, 1) NOT NULL,
    [DNI]             VARCHAR (10)  NOT NULL,
    [apellidosnombre] VARCHAR (100) NOT NULL,
    [fechaNacimiento] DATE          NULL,
    [codHospital]     INT           NULL,
    [esDirector]      BIT           NULL,
    [rowversion]      TIMESTAMP     NOT NULL,
    CONSTRAINT [PK_Medico] PRIMARY KEY CLUSTERED ([codMedico] ASC),
    UNIQUE NONCLUSTERED ([DNI] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[MedicoServicio]...';


GO
CREATE TABLE [dbo].[MedicoServicio] (
    [codMedico]   INT       NOT NULL,
    [codServicio] INT       NOT NULL,
    [codHospital] INT       NOT NULL,
    [rowversion]  TIMESTAMP NOT NULL,
    CONSTRAINT [PK_MedicoServicio] PRIMARY KEY CLUSTERED ([codMedico] ASC, [codServicio] ASC, [codHospital] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Paciente]...';


GO
CREATE TABLE [dbo].[Paciente] (
    [codPaciente]     INT           IDENTITY (1, 1) NOT NULL,
    [DNI]             VARCHAR (10)  NOT NULL,
    [apellidosnombre] VARCHAR (100) NOT NULL,
    [fechaNacimiento] DATE          NULL,
    [numSS]           VARCHAR (20)  NOT NULL,
    [datosOpcionales] VARCHAR (150) NULL,
    [rowversion]      TIMESTAMP     NOT NULL,
    CONSTRAINT [PK_Paciente] PRIMARY KEY CLUSTERED ([codPaciente] ASC),
    UNIQUE NONCLUSTERED ([DNI] ASC),
    UNIQUE NONCLUSTERED ([numSS] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Servicio]...';


GO
CREATE TABLE [dbo].[Servicio] (
    [codServicio] INT           IDENTITY (1, 1) NOT NULL,
    [nombre]      VARCHAR (100) NOT NULL,
    [comentario]  VARCHAR (150) NULL,
    [rowversion]  TIMESTAMP     NOT NULL,
    CONSTRAINT [PK_Servicio] PRIMARY KEY CLUSTERED ([codServicio] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[VisitaMedica]...';


GO
CREATE TABLE [dbo].[VisitaMedica] (
    [codVisita]   INT           IDENTITY (1, 1) NOT NULL,
    [fechahora]   DATETIME      NOT NULL,
    [codHospital] INT           NULL,
    [codServicio] INT           NULL,
    [codMedico]   INT           NULL,
    [codHist]     INT           NULL,
    [diagnostico] VARCHAR (150) NULL,
    [tratamiento] VARCHAR (150) NULL,
    [rowversion]  TIMESTAMP     NOT NULL,
    CONSTRAINT [PK_VisitaMedica] PRIMARY KEY CLUSTERED ([codVisita] ASC)
);


GO
PRINT N'Creando Clave externa [dbo].[FK_HistoriaClinica_Paciente]...';


GO
ALTER TABLE [dbo].[HistoriaClinica] WITH NOCHECK
    ADD CONSTRAINT [FK_HistoriaClinica_Paciente] FOREIGN KEY ([codPaciente]) REFERENCES [dbo].[Paciente] ([codPaciente]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creando Clave externa [dbo].[FK_HospServicio_Hosp]...';


GO
ALTER TABLE [dbo].[HospitalServicio] WITH NOCHECK
    ADD CONSTRAINT [FK_HospServicio_Hosp] FOREIGN KEY ([codHospital]) REFERENCES [dbo].[Hospital] ([codHospital]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creando Clave externa [dbo].[FK_HospServcio_Serv]...';


GO
ALTER TABLE [dbo].[HospitalServicio] WITH NOCHECK
    ADD CONSTRAINT [FK_HospServcio_Serv] FOREIGN KEY ([codServicio]) REFERENCES [dbo].[Servicio] ([codServicio]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creando Clave externa [dbo].[FK_Internacion_VisitaMedica]...';


GO
ALTER TABLE [dbo].[Internacion] WITH NOCHECK
    ADD CONSTRAINT [FK_Internacion_VisitaMedica] FOREIGN KEY ([codVisita]) REFERENCES [dbo].[VisitaMedica] ([codVisita]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Medico]...';


GO
ALTER TABLE [dbo].[Medico] WITH NOCHECK
    ADD CONSTRAINT [FK_Medico] FOREIGN KEY ([codHospital]) REFERENCES [dbo].[Hospital] ([codHospital]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creando Clave externa [dbo].[FK_MedicoServicio_Medico]...';


GO
ALTER TABLE [dbo].[MedicoServicio] WITH NOCHECK
    ADD CONSTRAINT [FK_MedicoServicio_Medico] FOREIGN KEY ([codMedico]) REFERENCES [dbo].[Medico] ([codMedico]);


GO
PRINT N'Creando Clave externa [dbo].[FK_MedicoServicio_Servicio]...';


GO
ALTER TABLE [dbo].[MedicoServicio] WITH NOCHECK
    ADD CONSTRAINT [FK_MedicoServicio_Servicio] FOREIGN KEY ([codServicio]) REFERENCES [dbo].[Servicio] ([codServicio]);


GO
PRINT N'Creando Clave externa [dbo].[FK_MedicoServicio_Hospital]...';


GO
ALTER TABLE [dbo].[MedicoServicio] WITH NOCHECK
    ADD CONSTRAINT [FK_MedicoServicio_Hospital] FOREIGN KEY ([codHospital]) REFERENCES [dbo].[Hospital] ([codHospital]);


GO
PRINT N'Creando Clave externa [dbo].[FK_VisitaMedica_Hospital]...';


GO
ALTER TABLE [dbo].[VisitaMedica] WITH NOCHECK
    ADD CONSTRAINT [FK_VisitaMedica_Hospital] FOREIGN KEY ([codHospital]) REFERENCES [dbo].[Hospital] ([codHospital]);


GO
PRINT N'Creando Clave externa [dbo].[FK_VisitaMedica_Servicio]...';


GO
ALTER TABLE [dbo].[VisitaMedica] WITH NOCHECK
    ADD CONSTRAINT [FK_VisitaMedica_Servicio] FOREIGN KEY ([codServicio]) REFERENCES [dbo].[Servicio] ([codServicio]);


GO
PRINT N'Creando Clave externa [dbo].[FK_VisitaMedica_Medico]...';


GO
ALTER TABLE [dbo].[VisitaMedica] WITH NOCHECK
    ADD CONSTRAINT [FK_VisitaMedica_Medico] FOREIGN KEY ([codMedico]) REFERENCES [dbo].[Medico] ([codMedico]);


GO
PRINT N'Creando Clave externa [dbo].[FK_VisitaMedica_HistoriaClinica]...';


GO
ALTER TABLE [dbo].[VisitaMedica] WITH NOCHECK
    ADD CONSTRAINT [FK_VisitaMedica_HistoriaClinica] FOREIGN KEY ([codHist]) REFERENCES [dbo].[HistoriaClinica] ([codHist]);


GO
PRINT N'Creando Procedimiento [dbo].[GetDatabaseRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetDatabaseRowVersion]
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON

	SELECT DBTS = (CONVERT(BIGINT,MIN_ACTIVE_ROWVERSION())-1);
END
GO
PRINT N'Creando Procedimiento [dbo].[GetHospitalChangesByRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetHospitalChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
	SELECT codHospital
    ,nombre
    ,ciudad
    ,telefono
    ,codMedicoDirector
 FROM Hospital
	  WHERE [rowversion] > CONVERT(ROWVERSION,@startRow) 
	  AND [rowversion] <= CONVERT(ROWVERSION,@endRow)
END
GO
PRINT N'Creando Procedimiento [dbo].[GetMedicoChangesByRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetMedicoChangesByRowVersion]
	(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
SELECT codMedico
       ,DNI
       ,apellidosnombre
       ,fechaNacimiento
       ,hos.nombre

 FROM Medico med INNER JOIN Hospital hos ON (med.codHospital=hos.codHospital)
	  WHERE (med.[rowversion]) > CONVERT(ROWVERSION,@startRow) 
	  AND (med.[rowversion]) <= CONVERT(ROWVERSION,@endRow)
	  OR (hos.[rowversion]) > CONVERT(ROWVERSION,@startRow) 
	  AND (hos.[rowversion]) <= CONVERT(ROWVERSION,@endRow)
END
GO
PRINT N'Creando Procedimiento [dbo].[GetPacienteChangesByRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetPacienteChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
SELECT 
    codPaciente
   ,DNI
   ,apellidosnombre
   ,fechaNacimiento
   ,numSS
   ,datosOpcionales
 FROM Paciente
	  WHERE [rowversion] > CONVERT(ROWVERSION,@startRow) 
	  AND [rowversion] <= CONVERT(ROWVERSION,@endRow)
END
GO
PRINT N'Creando Procedimiento [dbo].[GetServicioChangesByRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetServicioChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
SELECT codServicio
       ,nombre
       ,comentario
 FROM Servicio
	  WHERE [rowversion] > CONVERT(ROWVERSION,@startRow) 
	  AND [rowversion] <= CONVERT(ROWVERSION,@endRow)
END
GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[HistoriaClinica] WITH CHECK CHECK CONSTRAINT [FK_HistoriaClinica_Paciente];

ALTER TABLE [dbo].[HospitalServicio] WITH CHECK CHECK CONSTRAINT [FK_HospServicio_Hosp];

ALTER TABLE [dbo].[HospitalServicio] WITH CHECK CHECK CONSTRAINT [FK_HospServcio_Serv];

ALTER TABLE [dbo].[Internacion] WITH CHECK CHECK CONSTRAINT [FK_Internacion_VisitaMedica];

ALTER TABLE [dbo].[Medico] WITH CHECK CHECK CONSTRAINT [FK_Medico];

ALTER TABLE [dbo].[MedicoServicio] WITH CHECK CHECK CONSTRAINT [FK_MedicoServicio_Medico];

ALTER TABLE [dbo].[MedicoServicio] WITH CHECK CHECK CONSTRAINT [FK_MedicoServicio_Servicio];

ALTER TABLE [dbo].[MedicoServicio] WITH CHECK CHECK CONSTRAINT [FK_MedicoServicio_Hospital];

ALTER TABLE [dbo].[VisitaMedica] WITH CHECK CHECK CONSTRAINT [FK_VisitaMedica_Hospital];

ALTER TABLE [dbo].[VisitaMedica] WITH CHECK CHECK CONSTRAINT [FK_VisitaMedica_Servicio];

ALTER TABLE [dbo].[VisitaMedica] WITH CHECK CHECK CONSTRAINT [FK_VisitaMedica_Medico];

ALTER TABLE [dbo].[VisitaMedica] WITH CHECK CHECK CONSTRAINT [FK_VisitaMedica_HistoriaClinica];


GO
PRINT N'Actualización completada.';


GO
