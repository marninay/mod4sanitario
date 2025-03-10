CREATE TABLE [dbo].[VisitaMedica]
(
	codVisita INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_VisitaMedica PRIMARY KEY,
    fechahora DATETIME NOT NULL,
    codHospital INT,
    codServicio INT,
    codMedico INT,
    codHist INT,
    diagnostico VARCHAR(150),
    tratamiento VARCHAR(150),
    CONSTRAINT FK_VisitaMedica_Hospital FOREIGN KEY (codHospital) REFERENCES Hospital(codHospital),
    CONSTRAINT FK_VisitaMedica_Servicio FOREIGN KEY (codServicio) REFERENCES Servicio(codServicio),
    CONSTRAINT FK_VisitaMedica_Medico FOREIGN KEY (codMedico) REFERENCES Medico(codMedico),
    CONSTRAINT FK_VisitaMedica_HistoriaClinica FOREIGN KEY (codHist) REFERENCES HistoriaClinica(codHist) ,
    rowversion TIMESTAMP NOT NULL
)

