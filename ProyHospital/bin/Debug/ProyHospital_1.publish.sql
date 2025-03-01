/*
Script de implementación para BDHospital

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BDHospital"
:setvar DefaultFilePrefix "BDHospital"
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
PRINT N'Creando Tabla [dbo].[Hospital]...';


GO
CREATE TABLE [dbo].[Hospital] (
    [codHospital] INT           NOT NULL,
    [nombre]      VARCHAR (100) NOT NULL,
    [ciudad]      VARCHAR (50)  NOT NULL,
    [telefono]    VARCHAR (15)  NULL,
    [directorDNI] VARCHAR (10)  NULL,
    PRIMARY KEY CLUSTERED ([codHospital] ASC),
    UNIQUE NONCLUSTERED ([directorDNI] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[HospitalServicio]...';


GO
CREATE TABLE [dbo].[HospitalServicio] (
    [codHospital] INT          NOT NULL,
    [idServicio]  VARCHAR (10) NOT NULL,
    [numCamas]    INT          NULL,
    PRIMARY KEY CLUSTERED ([codHospital] ASC, [idServicio] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Medico]...';


GO
CREATE TABLE [dbo].[Medico] (
    [DNI]             VARCHAR (10)  NOT NULL,
    [apellidosnombre] VARCHAR (100) NOT NULL,
    [fechaNacimiento] DATE          NULL,
    [codHospital]     INT           NULL,
    [esDirector]      BIT           NULL,
    PRIMARY KEY CLUSTERED ([DNI] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[MedicoServicio]...';


GO
CREATE TABLE [dbo].[MedicoServicio] (
    [DNI]         VARCHAR (10) NOT NULL,
    [idServicio]  VARCHAR (10) NOT NULL,
    [codHospital] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([DNI] ASC, [idServicio] ASC, [codHospital] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Servicio]...';


GO
CREATE TABLE [dbo].[Servicio] (
    [idServicio] VARCHAR (10)  NOT NULL,
    [nombre]     VARCHAR (100) NOT NULL,
    [comentario] TEXT          NULL,
    PRIMARY KEY CLUSTERED ([idServicio] ASC)
);


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[HospitalServicio]...';


GO
ALTER TABLE [dbo].[HospitalServicio] WITH NOCHECK
    ADD FOREIGN KEY ([codHospital]) REFERENCES [dbo].[Hospital] ([codHospital]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[HospitalServicio]...';


GO
ALTER TABLE [dbo].[HospitalServicio] WITH NOCHECK
    ADD FOREIGN KEY ([idServicio]) REFERENCES [dbo].[Servicio] ([idServicio]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[Medico]...';


GO
ALTER TABLE [dbo].[Medico] WITH NOCHECK
    ADD FOREIGN KEY ([codHospital]) REFERENCES [dbo].[Hospital] ([codHospital]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[MedicoServicio]...';


GO
ALTER TABLE [dbo].[MedicoServicio] WITH NOCHECK
    ADD FOREIGN KEY ([DNI]) REFERENCES [dbo].[Medico] ([DNI]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[MedicoServicio]...';


GO
ALTER TABLE [dbo].[MedicoServicio] WITH NOCHECK
    ADD FOREIGN KEY ([idServicio]) REFERENCES [dbo].[Servicio] ([idServicio]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[MedicoServicio]...';


GO
ALTER TABLE [dbo].[MedicoServicio] WITH NOCHECK
    ADD FOREIGN KEY ([codHospital]) REFERENCES [dbo].[Hospital] ([codHospital]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.HospitalServicio'), OBJECT_ID(N'dbo.Medico'), OBJECT_ID(N'dbo.MedicoServicio'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Comprobando restricción:' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Error de comprobación de restricción:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'Error al comprobar las restricciones', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Actualización completada.';


GO
