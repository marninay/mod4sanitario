CREATE TABLE [dbo].[FactVisitasMedicas]
(
	VisitaKey INT IDENTITY(1,1) PRIMARY KEY,
    HospitalSK INT,
    ServicioSK INT,
    MedicoSK INT,
    PacienteSK INT,
    DateKey INT,
    codVisita INT NOT NULL, 
    diagnostico VARCHAR(150),
    tratamiento VARCHAR(150),
    CONSTRAINT FK_FactVisitasMedicas_DIMHospital FOREIGN KEY (HospitalSK) REFERENCES DIMHospital(HospitalSK),
        CONSTRAINT FK_FactVisitasMedicas_DimServicio FOREIGN KEY (ServicioSK) REFERENCES DIMServicio(ServicioSK),
        CONSTRAINT FK_FactVisitasMedicas_DimMedico FOREIGN KEY (MedicoSK) REFERENCES DIMMedico(MedicoSK),
        CONSTRAINT FK_FactVisitasMedicas_DimPaciente FOREIGN KEY (PacienteSK) REFERENCES DIMPaciente(PacienteSK),
       CONSTRAINT FK_FactVisitasMedicas_DimDate  FOREIGN KEY (DateKey) REFERENCES DIMDate(DateKey)
)
