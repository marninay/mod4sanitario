/*
Script de implementación para BDPruebaDW

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BDPruebaDW"
:setvar DefaultFilePrefix "BDPruebaDW"
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
PRINT N'Creando Tabla [dbo].[DIMDate]...';


GO
CREATE TABLE [dbo].[DIMDate] (
    [DateKey]           INT           NOT NULL,
    [FullDate]          DATE          NOT NULL,
    [DayNumberOfWeek]   TINYINT       NOT NULL,
    [DayNameOfWeek]     NVARCHAR (10) NOT NULL,
    [DayNumberOfMonth]  TINYINT       NOT NULL,
    [DayNumberOfYear]   SMALLINT      NOT NULL,
    [WeekNumberOfYear]  TINYINT       NOT NULL,
    [MonthName]         NVARCHAR (10) NOT NULL,
    [MonthNumberOfYear] TINYINT       NOT NULL,
    [CalendarQuarter]   TINYINT       NOT NULL,
    [CalendarYear]      SMALLINT      NOT NULL,
    [CalendarSemester]  TINYINT       NOT NULL,
    CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED ([DateKey] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DIMHospital]...';


GO
CREATE TABLE [dbo].[DIMHospital] (
    [HospitalSK]  INT           IDENTITY (1, 1) NOT NULL,
    [codHospital] INT           NOT NULL,
    [nombre]      VARCHAR (100) NOT NULL,
    [ciudad]      VARCHAR (50)  NOT NULL,
    [telefono]    VARCHAR (15)  NULL,
    [codDirector] INT           NULL,
    PRIMARY KEY CLUSTERED ([HospitalSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DIMMedico]...';


GO
CREATE TABLE [dbo].[DIMMedico] (
    [MedicoSK]        INT           IDENTITY (1, 1) NOT NULL,
    [codMedico]       INT           NOT NULL,
    [DNI]             VARCHAR (10)  NOT NULL,
    [apellidosnombre] VARCHAR (100) NOT NULL,
    [fechaNacimiento] DATE          NULL,
    [HospitalSK]      INT           NULL,
    PRIMARY KEY CLUSTERED ([MedicoSK] ASC),
    UNIQUE NONCLUSTERED ([DNI] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DIMPaciente]...';


GO
CREATE TABLE [dbo].[DIMPaciente] (
    [PacienteSK]      INT           IDENTITY (1, 1) NOT NULL,
    [codPaciente]     INT           NOT NULL,
    [DNI]             VARCHAR (10)  NOT NULL,
    [apellidosnombre] VARCHAR (100) NOT NULL,
    [fechaNacimiento] DATE          NULL,
    [numSS]           VARCHAR (20)  NOT NULL,
    [datosOpcionales] VARCHAR (150) NULL,
    PRIMARY KEY CLUSTERED ([PacienteSK] ASC),
    UNIQUE NONCLUSTERED ([DNI] ASC),
    UNIQUE NONCLUSTERED ([numSS] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DIMServicio]...';


GO
CREATE TABLE [dbo].[DIMServicio] (
    [ServicioSK]  INT           IDENTITY (1, 1) NOT NULL,
    [codServicio] INT           NOT NULL,
    [nombre]      VARCHAR (100) NOT NULL,
    [comentario]  VARCHAR (150) NULL,
    PRIMARY KEY CLUSTERED ([ServicioSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[FactInternaciones]...';


GO
CREATE TABLE [dbo].[FactInternaciones] (
    [InternacionKey]   INT IDENTITY (1, 1) NOT NULL,
    [VisitaKey]        INT NULL,
    [HospitalSK]       INT NULL,
    [PacienteSK]       INT NULL,
    [TiempoIngresoKey] INT NULL,
    [TiempoSalidaKey]  INT NULL,
    [codInternacion]   INT NOT NULL,
    [numHabitacion]    INT NULL,
    [numCama]          INT NULL,
    PRIMARY KEY CLUSTERED ([InternacionKey] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[FactVisitasMedicas]...';


GO
CREATE TABLE [dbo].[FactVisitasMedicas] (
    [VisitaKey]   INT           IDENTITY (1, 1) NOT NULL,
    [HospitalSK]  INT           NULL,
    [ServicioSK]  INT           NULL,
    [MedicoSK]    INT           NULL,
    [PacienteSK]  INT           NULL,
    [DateKey]     INT           NULL,
    [codVisita]   INT           NOT NULL,
    [diagnostico] VARCHAR (150) NULL,
    [tratamiento] VARCHAR (150) NULL,
    PRIMARY KEY CLUSTERED ([VisitaKey] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[PackageConfig]...';


GO
CREATE TABLE [dbo].[PackageConfig] (
    [PackageID]      INT          IDENTITY (1, 1) NOT NULL,
    [TableName]      VARCHAR (50) NOT NULL,
    [LastRowVersion] BIGINT       NULL,
    CONSTRAINT [PK_PackageConfig] PRIMARY KEY CLUSTERED ([PackageID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[stagingHospital]...';


GO
CREATE TABLE [dbo].[stagingHospital] (
    [HospitalSK]  INT           NULL,
    [nombre]      VARCHAR (100) NOT NULL,
    [ciudad]      VARCHAR (50)  NOT NULL,
    [telefono]    VARCHAR (15)  NULL,
    [codDirector] INT           NULL
);


GO
PRINT N'Creando Tabla [dbo].[stagingMedico]...';


GO
CREATE TABLE [dbo].[stagingMedico] (
    [MedicoSK]        INT           NULL,
    [DNI]             VARCHAR (10)  NOT NULL,
    [apellidosnombre] VARCHAR (100) NOT NULL,
    [fechaNacimiento] DATE          NULL,
    [nombre]          VARCHAR (100) NULL,
    UNIQUE NONCLUSTERED ([DNI] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[stagingPaciente]...';


GO
CREATE TABLE [dbo].[stagingPaciente] (
    [PacienteSK]      INT           NULL,
    [DNI]             VARCHAR (10)  NOT NULL,
    [apellidosnombre] VARCHAR (100) NOT NULL,
    [fechaNacimiento] DATE          NULL,
    [numSS]           VARCHAR (20)  NOT NULL,
    [datosOpcionales] VARCHAR (150) NULL,
    UNIQUE NONCLUSTERED ([DNI] ASC),
    UNIQUE NONCLUSTERED ([numSS] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[stagingServicio]...';


GO
CREATE TABLE [dbo].[stagingServicio] (
    [ServicioSK] INT           NULL,
    [nombre]     VARCHAR (100) NOT NULL,
    [comentario] VARCHAR (150) NULL
);


GO
PRINT N'Creando Clave externa [dbo].[FK_DIMMedico_DIMHospital]...';


GO
ALTER TABLE [dbo].[DIMMedico] WITH NOCHECK
    ADD CONSTRAINT [FK_DIMMedico_DIMHospital] FOREIGN KEY ([HospitalSK]) REFERENCES [dbo].[DIMHospital] ([HospitalSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactInternaciones_FactVisitasMedicas]...';


GO
ALTER TABLE [dbo].[FactInternaciones] WITH NOCHECK
    ADD CONSTRAINT [FK_FactInternaciones_FactVisitasMedicas] FOREIGN KEY ([VisitaKey]) REFERENCES [dbo].[FactVisitasMedicas] ([VisitaKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactInternaciones_DimHospital]...';


GO
ALTER TABLE [dbo].[FactInternaciones] WITH NOCHECK
    ADD CONSTRAINT [FK_FactInternaciones_DimHospital] FOREIGN KEY ([HospitalSK]) REFERENCES [dbo].[DIMHospital] ([HospitalSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactInternaciones_DimPaciente]...';


GO
ALTER TABLE [dbo].[FactInternaciones] WITH NOCHECK
    ADD CONSTRAINT [FK_FactInternaciones_DimPaciente] FOREIGN KEY ([PacienteSK]) REFERENCES [dbo].[DIMPaciente] ([PacienteSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactInternaciones_DimTiempo_TiempoIngreso]...';


GO
ALTER TABLE [dbo].[FactInternaciones] WITH NOCHECK
    ADD CONSTRAINT [FK_FactInternaciones_DimTiempo_TiempoIngreso] FOREIGN KEY ([TiempoIngresoKey]) REFERENCES [dbo].[DIMDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactInternaciones_DimTiempo_TiempoSalida]...';


GO
ALTER TABLE [dbo].[FactInternaciones] WITH NOCHECK
    ADD CONSTRAINT [FK_FactInternaciones_DimTiempo_TiempoSalida] FOREIGN KEY ([TiempoSalidaKey]) REFERENCES [dbo].[DIMDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactVisitasMedicas_DIMHospital]...';


GO
ALTER TABLE [dbo].[FactVisitasMedicas] WITH NOCHECK
    ADD CONSTRAINT [FK_FactVisitasMedicas_DIMHospital] FOREIGN KEY ([HospitalSK]) REFERENCES [dbo].[DIMHospital] ([HospitalSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactVisitasMedicas_DimServicio]...';


GO
ALTER TABLE [dbo].[FactVisitasMedicas] WITH NOCHECK
    ADD CONSTRAINT [FK_FactVisitasMedicas_DimServicio] FOREIGN KEY ([ServicioSK]) REFERENCES [dbo].[DIMServicio] ([ServicioSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactVisitasMedicas_DimMedico]...';


GO
ALTER TABLE [dbo].[FactVisitasMedicas] WITH NOCHECK
    ADD CONSTRAINT [FK_FactVisitasMedicas_DimMedico] FOREIGN KEY ([MedicoSK]) REFERENCES [dbo].[DIMMedico] ([MedicoSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactVisitasMedicas_DimPaciente]...';


GO
ALTER TABLE [dbo].[FactVisitasMedicas] WITH NOCHECK
    ADD CONSTRAINT [FK_FactVisitasMedicas_DimPaciente] FOREIGN KEY ([PacienteSK]) REFERENCES [dbo].[DIMPaciente] ([PacienteSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactVisitasMedicas_DimDate]...';


GO
ALTER TABLE [dbo].[FactVisitasMedicas] WITH NOCHECK
    ADD CONSTRAINT [FK_FactVisitasMedicas_DimDate] FOREIGN KEY ([DateKey]) REFERENCES [dbo].[DIMDate] ([DateKey]);


GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[DIMMedico] WITH CHECK CHECK CONSTRAINT [FK_DIMMedico_DIMHospital];

ALTER TABLE [dbo].[FactInternaciones] WITH CHECK CHECK CONSTRAINT [FK_FactInternaciones_FactVisitasMedicas];

ALTER TABLE [dbo].[FactInternaciones] WITH CHECK CHECK CONSTRAINT [FK_FactInternaciones_DimHospital];

ALTER TABLE [dbo].[FactInternaciones] WITH CHECK CHECK CONSTRAINT [FK_FactInternaciones_DimPaciente];

ALTER TABLE [dbo].[FactInternaciones] WITH CHECK CHECK CONSTRAINT [FK_FactInternaciones_DimTiempo_TiempoIngreso];

ALTER TABLE [dbo].[FactInternaciones] WITH CHECK CHECK CONSTRAINT [FK_FactInternaciones_DimTiempo_TiempoSalida];

ALTER TABLE [dbo].[FactVisitasMedicas] WITH CHECK CHECK CONSTRAINT [FK_FactVisitasMedicas_DIMHospital];

ALTER TABLE [dbo].[FactVisitasMedicas] WITH CHECK CHECK CONSTRAINT [FK_FactVisitasMedicas_DimServicio];

ALTER TABLE [dbo].[FactVisitasMedicas] WITH CHECK CHECK CONSTRAINT [FK_FactVisitasMedicas_DimMedico];

ALTER TABLE [dbo].[FactVisitasMedicas] WITH CHECK CHECK CONSTRAINT [FK_FactVisitasMedicas_DimPaciente];

ALTER TABLE [dbo].[FactVisitasMedicas] WITH CHECK CHECK CONSTRAINT [FK_FactVisitasMedicas_DimDate];


GO
PRINT N'Actualización completada.';


GO
