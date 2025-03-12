CREATE PROCEDURE [dbo].[DW_MergeDimVisitasMedicas]

AS
UPDATE dvm
	SET 
    HospitalSK=svm.HospitalSK,
    ServicioSK = svm.ServicioSK,
    MedicoSK=svm.MedicoSK,
    PacienteSK=svm.PacienteSK,
    DateKey=svm.DateKey,
    codVisita =svm.codVisita,
    diagnostico=svm.diagnostico,
    tratamiento =svm.tratamiento

	FROM [dbo].[FactVisitasMedicas]    dvm
	INNER JOIN stagingVisitasMedicas svm ON (dvm.[VisitaKey] =svm.[VisitaKey])
