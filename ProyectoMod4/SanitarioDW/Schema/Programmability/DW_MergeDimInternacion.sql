CREATE PROCEDURE [dbo].[DW_MergeDimInternacion]

AS
UPDATE di
	SET 

    VisitaKey =si.VisitaSK,
    HospitalSK =si.HospitalSK,
    PacienteSK =si.PacienteSK,
    TiempoIngresoKey= si.TiempoIngresoKey,
    TiempoSalidaKey =si.TiempoSalidaKey,
    codInternacion=si.codInternacion,
    numHabitacion=si.numHabitacion,
    numCama=si.numCama
	FROM [dbo].[FactInternaciones] di
	INNER JOIN stagingInternacion si ON (di.[InternacionKey] =si.[InternacionKey])
