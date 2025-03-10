CREATE TABLE [dbo].[DIMMedico]
(
	MedicoSK INT IDENTITY(1,1) PRIMARY KEY,
    codMedico INT NOT NULL,
    DNI VARCHAR(10) NOT NULL UNIQUE,
    apellidosnombre VARCHAR(100) NOT NULL,
    fechaNacimiento DATE,
    HospitalSK INT, 
    CONSTRAINT FK_DIMMedico_DIMHospital FOREIGN KEY (HospitalSK) REFERENCES DIMHospital(HospitalSK)
)
