CREATE TABLE [dbo].[stagingMedico]
(
	MedicoSK INT,
    DNI VARCHAR(10) NOT NULL UNIQUE,
    apellidosnombre VARCHAR(100) NOT NULL,
    fechaNacimiento DATE,
    nombre varchar (100)
)
