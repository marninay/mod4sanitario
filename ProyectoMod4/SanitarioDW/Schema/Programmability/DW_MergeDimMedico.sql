CREATE PROCEDURE [dbo].[DW_MergeDimMedico]
AS
BEGIN
	UPDATE dm
	SET [DNI]=sm.[DNI],
		[apellidosnombre]=sm.[apellidosnombre],
		[fechaNacimiento]=sm.[fechaNacimiento],
        [HospitalSK]=[HospitalSK]
	FROM [dbo].[DIMMedico]    dm
	INNER JOIN stagingMedico sm ON (dm.[MedicoSK] =sm.[MedicoSK])
END