CREATE TABLE [dbo].[MedicoServicio]
(
    codMedico INT NOT NULL,
    codServicio INT NOT NULL,
    codHospital INT  NOT NULL,
    CONSTRAINT PK_MedicoServicio PRIMARY KEY (codMedico, codServicio, codHospital),
    CONSTRAINT FK_MedicoServicio_Medico FOREIGN KEY (codMedico) REFERENCES Medico(codMedico),
    CONSTRAINT FK_MedicoServicio_Servicio FOREIGN KEY (codServicio) REFERENCES Servicio(codServicio),
    CONSTRAINT FK_MedicoServicio_Hospital FOREIGN KEY (codHospital) REFERENCES Hospital(codHospital),
    rowversion TIMESTAMP NOT NULL
)
