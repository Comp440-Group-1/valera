/*counts new features and if:
1)There are new features - display their number + corresponding patchnote
2)There are ZERO new features displays "This is a bug-fix release....."*/

CREATE PROCEDURE [dbo].[new_feature_count]

	@version_id int
AS
BEGIN

	SET NOCOUNT ON;
	
	BEGIN
		DECLARE @new_feature_count smallint
		DECLARE @release_id int
		DECLARE @patchnote varchar(500)   /*it should be a text, but text can't be a local variable.
											dont know the way around it*/

		SET @release_id = (SELECT release_id FROM dbo.version WHERE version_id=@version_id)


		SELECT @new_feature_count = COUNT(*) FROM release WHERE release_id = @release_id AND new_features >0
		IF @new_feature_count > 0
		BEGIN
			PRINT CONVERT(varchar(4),@new_feature_count) + ' new features are in the ' + CONVERT(varchar(4),@release_id) + ' release.'
			SET @patchnote = (SELECT pachnote FROM patchnote WHERE version_id = @version_id)
			PRINT @patchnote
		END
		ELSE
			PRINT 'This is a bug-fix release. There are no new features.'

	END 
END
