CREATE PROCEDURE [dbo].[DW_MergeDimPaciente]
AS
BEGIN
	UPDATE dp
	SET [DNI]=sp.[DNI],
		[apellidosnombre]=sp.[apellidosnombre],
		[fechaNacimiento]=sp.[fechaNacimiento],
		[numSS]=sp.[numSS],
		[datosOpcionales]=sp.[datosOpcionales]
	FROM [dbo].[DIMPaciente]    dp
	INNER JOIN stagingPaciente sp ON (dp.[PacienteSK] =sp.[PacienteSK])
END
