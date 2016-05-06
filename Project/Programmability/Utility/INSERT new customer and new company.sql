DECLARE @company_id int;
DECLARE @exists tinyint;
DECLARE @adress_id int;
DECLARE @company_name varchar(50);
SET @company_name = '470db NOW II!'

IF NOT EXISTS( SELECT 1 FROM company WHERE name=@company_name )
BEGIN
	INSERT INTO company ([name]) VALUES (@company_name);
	INSERT INTO dbo.address([street], [city_id], [state_id], [zip], [country_id]) VALUES ('6 Rodeo Dr.', 1,1, 90201,1)
	SET @adress_id = (SELECT adress_id FROM dbo.address WHERE (city_id=1) AND (state_id=1) AND (zip=90201) AND (country_id=1) AND (street='6 Rodeo Dr.'))
	SET @company_id = (SELECT company_id FROM company WHERE name = @company_name)
	INSERT INTO company_address ([company_id], [address_id]) VALUES (@company_id, @adress_id)

END	
SET @company_id = (SELECT company_id FROM company WHERE name = @company_name)

INSERT INTO customer ([first_name],[last_name], [email], [company_id], [title_id]) VALUES ('Billy', 'Bob','Billy@csun.com', @company_id, 1)
