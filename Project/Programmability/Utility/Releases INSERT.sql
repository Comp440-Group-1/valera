DECLARE @version_id int;
DECLARE @release_id int;

BEGIN TRY
	SET @release_id=12
	INSERT INTO version([release_id], [date]) VALUES (@release_id, '01/03/2000')
	SET @version_id = (SELECT version_id FROM version WHERE release_id=@release_id)

	INSERT INTO download([version_id], [url]) VALUES (@version_id, 'www.download.com/1')
	INSERT INTO patchnote([version_id], [pachnote]) VALUES (@version_id, 'Everything os fixed')
	INSERT INTO depricated([version_id], [depricated]) VALUES (@version_id, 0)
	INSERT INTO version_number([version_id], [version_number]) VALUES (@version_id, '1.1b beta test')
END TRY
BEGIN CATCH
	PRINT 'Error!'
END Catch

BEGIN TRY
	SET @release_id=11
	INSERT INTO version([release_id], [date]) VALUES (@release_id, '01/03/2001')
	SET @version_id = (SELECT version_id FROM version WHERE release_id=@release_id)

	INSERT INTO download([version_id], [url]) VALUES (@version_id, 'www.download.com/2')
	INSERT INTO patchnote([version_id], [pachnote]) VALUES (@version_id, 'Everything os fixed')
	INSERT INTO depricated([version_id], [depricated]) VALUES (@version_id, 0)
	INSERT INTO version_number([version_id], [version_number]) VALUES (@version_id, '1.2b beta test')
END TRY
BEGIN CATCH
	PRINT 'Error!'
END Catch


BEGIN TRY
	SET @release_id=9
	INSERT INTO version([release_id], [date]) VALUES (@release_id, '01/03/2000')
	SET @version_id = (SELECT version_id FROM version WHERE release_id=@release_id)

	INSERT INTO download([version_id], [url]) VALUES (@version_id, 'www.download.com/3')
	INSERT INTO patchnote([version_id], [pachnote]) VALUES (@version_id, 'Nothing is fixed')
	INSERT INTO depricated([version_id], [depricated]) VALUES (@version_id, 0)
	INSERT INTO version_number([version_id], [version_number]) VALUES (@version_id, '0000001.z/x alpha test')
END TRY
BEGIN CATCH
	PRINT 'Error!'
END Catch 