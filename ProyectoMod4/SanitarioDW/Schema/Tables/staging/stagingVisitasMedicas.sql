CREATE TABLE [dbo].[stagingVisitasMedicas]
(
    VisitaKey INT,
    HospitalSK INT,
    ServicioSK INT,
    MedicoSK INT,
    PacienteSK INT,
    DateKey INT,
    codVisita INT NOT NULL, 
    diagnostico VARCHAR(150),
    tratamiento VARCHAR(150),

)
