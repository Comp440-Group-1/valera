/*The procedure depricates the version by its
human-readable "version number"*/


CREATE PROCEDURE [dbo].[depricate_version]
	@version_number varchar(50)

AS
BEGIN TRANSACTION
BEGIN TRY

	UPDATE depricated
	SET depricated=1
	WHERE @version_number=@version_number
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	PRINT 'ERROR'
	ROLLBACK TRANSACTION
END CATCH