CREATE PROCEDURE [dbo].[DW_MergeDimServicio]
AS
BEGIN
	UPDATE ds
	SET [nombre]=ss.[nombre],
		[comentario]=ss.[comentario]

	FROM [dbo].[DIMServicio]    ds
	INNER JOIN stagingServicio ss ON (ds.[ServicioSK] =ss.[ServicioSK])
END
