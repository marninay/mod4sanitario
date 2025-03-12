CREATE TABLE [dbo].[stagingInternacion]
(
    InternacionKey INT,
    VisitaSK INT,
    HospitalSK INT,
    PacienteSK INT,
    TiempoIngresoKey INT,
    TiempoSalidaKey INT NULL,
    codInternacion INT NOT NULL, 
    numHabitacion INT,
    numCama INT,
)
