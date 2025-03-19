CREATE TABLE Hospital (
    codHospital INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    telefono VARCHAR(15),
    directorDNI VARCHAR(10) UNIQUE
);


GO

CREATE INDEX [IX_Hospital_Nombre] ON [dbo].[Hospital] (nombre)
