CREATE TABLE [dbo].[DIMHospital]
(
	HospitalSK INT IDENTITY(1,1) PRIMARY KEY,
    codHospital INT NOT NULL,  
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    telefono VARCHAR(15),
    codDirector INT 
)
