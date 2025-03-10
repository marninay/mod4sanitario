CREATE TABLE [dbo].[Medico]
(
	codMedico INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_Medico PRIMARY KEY,
    DNI VARCHAR(10) NOT NULL UNIQUE ,
    apellidosnombre VARCHAR(100) NOT NULL,
    fechaNacimiento DATE,
    codHospital INT,
    esDirector BIT,
    CONSTRAINT FK_Medico  FOREIGN KEY (codHospital) REFERENCES Hospital(codHospital)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    rowversion TIMESTAMP NOT NULL
)
