/*
Script de implementación para BDHospitalDW

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BDHospitalDW"
:setvar DefaultFilePrefix "BDHospitalDW"
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
PRINT N'Creando Tabla [dbo].[Dim_Medico]...';


GO
CREATE TABLE [dbo].[Dim_Medico] (
    [idMedico]        INT           NOT NULL,
    [nombre]          VARCHAR (100) NULL,
    [fechaNacimiento] DATE          NULL,
    [especialidad]    VARCHAR (100) NULL,
    [codHospital]     INT           NULL,
    PRIMARY KEY CLUSTERED ([idMedico] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Dim_Servicio]...';


GO
CREATE TABLE [dbo].[Dim_Servicio] (
    [idServicio]     VARCHAR (10)  NOT NULL,
    [nombreServicio] VARCHAR (100) NULL,
    [descripcion]    TEXT          NULL,
    PRIMARY KEY CLUSTERED ([idServicio] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Dim_Tiempo]...';


GO
CREATE TABLE [dbo].[Dim_Tiempo] (
    [idTiempo]  INT          NOT NULL,
    [fecha]     DATE         NULL,
    [diaSemana] VARCHAR (15) NULL,
    [mes]       INT          NULL,
    [anio]      INT          NULL,
    PRIMARY KEY CLUSTERED ([idTiempo] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Hecho_Atencion_Medica]...';


GO
CREATE TABLE [dbo].[Hecho_Atencion_Medica] (
    [idAtencion]    INT          NOT NULL,
    [codHist]       INT          NULL,
    [idMedico]      INT          NULL,
    [codHospital]   INT          NULL,
    [idServicio]    VARCHAR (10) NULL,
    [idTiempo]      INT          NULL,
    [diagnostico]   TEXT         NULL,
    [tratamiento]   TEXT         NULL,
    [numHabitacion] INT          NULL,
    [tipoAtencion]  VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([idAtencion] ASC)
);


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[Dim_Medico]...';


GO
ALTER TABLE [dbo].[Dim_Medico] WITH NOCHECK
    ADD FOREIGN KEY ([codHospital]) REFERENCES [dbo].[Dim_Hospital] ([codHospital]);


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[Hecho_Atencion_Medica]...';


GO
ALTER TABLE [dbo].[Hecho_Atencion_Medica] WITH NOCHECK
    ADD FOREIGN KEY ([codHist]) REFERENCES [dbo].[Dim_Paciente] ([codHist]);


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[Hecho_Atencion_Medica]...';


GO
ALTER TABLE [dbo].[Hecho_Atencion_Medica] WITH NOCHECK
    ADD FOREIGN KEY ([idMedico]) REFERENCES [dbo].[Dim_Medico] ([idMedico]);


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[Hecho_Atencion_Medica]...';


GO
ALTER TABLE [dbo].[Hecho_Atencion_Medica] WITH NOCHECK
    ADD FOREIGN KEY ([codHospital]) REFERENCES [dbo].[Dim_Hospital] ([codHospital]);


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[Hecho_Atencion_Medica]...';


GO
ALTER TABLE [dbo].[Hecho_Atencion_Medica] WITH NOCHECK
    ADD FOREIGN KEY ([idServicio]) REFERENCES [dbo].[Dim_Servicio] ([idServicio]);


GO
PRINT N'Creando Clave externa restricción sin nombre en [dbo].[Hecho_Atencion_Medica]...';


GO
ALTER TABLE [dbo].[Hecho_Atencion_Medica] WITH NOCHECK
    ADD FOREIGN KEY ([idTiempo]) REFERENCES [dbo].[Dim_Tiempo] ([idTiempo]);


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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Dim_Medico'), OBJECT_ID(N'dbo.Hecho_Atencion_Medica'))
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
