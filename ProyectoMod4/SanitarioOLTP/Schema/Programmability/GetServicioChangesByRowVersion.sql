CREATE PROCEDURE [dbo].[GetServicioChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN
SELECT codServicio
       ,nombre
       ,comentario
 FROM Servicio
	  WHERE [rowversion] > CONVERT(ROWVERSION,@startRow) 
	  AND [rowversion] <= CONVERT(ROWVERSION,@endRow)
END

