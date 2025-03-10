CREATE TABLE [dbo].[Internacion]
(
	codinternacion INT PRIMARY KEY,
    codVisita INT,
    numHabitacion INT,
    fechaInternacion DATE,
    fechaSalida DATE,
	numCama INT,
    CONSTRAINT FK_Internacion_VisitaMedica FOREIGN KEY (codVisita) REFERENCES VisitaMedica(codVisita) ,
    rowversion TIMESTAMP NOT NULL
)

