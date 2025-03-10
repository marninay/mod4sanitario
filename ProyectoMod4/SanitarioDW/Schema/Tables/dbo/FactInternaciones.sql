CREATE TABLE [dbo].[FactInternaciones]
(
	    InternacionKey INT IDENTITY(1,1) PRIMARY KEY,
    VisitaKey INT,
    HospitalSK INT,
    PacienteSK INT,
    TiempoIngresoKey INT,
    TiempoSalidaKey INT NULL,
    codInternacion INT NOT NULL, 
    numHabitacion INT,
    numCama INT,
    CONSTRAINT FK_FactInternaciones_FactVisitasMedicas  FOREIGN KEY (VisitaKey) REFERENCES FactVisitasMedicas(VisitaKey),
   CONSTRAINT FK_FactInternaciones_DimHospital FOREIGN KEY (HospitalSK) REFERENCES DIMHospital(HospitalSK),
  CONSTRAINT FK_FactInternaciones_DimPaciente  FOREIGN KEY (PacienteSK) REFERENCES DIMPaciente(PacienteSK),
 CONSTRAINT FK_FactInternaciones_DimTiempo_TiempoIngreso   FOREIGN KEY (TiempoIngresoKey) REFERENCES DIMDate(DateKey),
CONSTRAINT FK_FactInternaciones_DimTiempo_TiempoSalida  FOREIGN KEY (TiempoSalidaKey) REFERENCES DIMDate(DateKey)

)
