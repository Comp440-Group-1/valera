INSERT INTO dbo.cutomer_title([title_id], [title]) VALUES (1, 'Mr.')
INSERT INTO dbo.cutomer_title([title_id], [title]) VALUES (2, 'Ms.')
INSERT INTO dbo.cutomer_title([title_id], [title]) VALUES (3, 'Dr.')

INSERT INTO dbo.country([country_id], [country_name]) VALUES (1, 'USA')
INSERT INTO dbo.country([country_id], [country_name]) VALUES (2, 'Rhodesia')


INSERT INTO dbo.country_phone_codes([country_id], [country_code]) VALUES (1, 1)
INSERT INTO dbo.country_phone_codes([country_id], [country_code]) VALUES (2, 263)


INSERT INTO dbo.state([state_id], [state_abbreviation], [state_name]) VALUES (1, 'CA', 'California')
INSERT INTO dbo.state([state_id], [state_abbreviation], [state_name]) VALUES (2, 'HI', 'Hawaii')

INSERT INTO phone_type([phone_type], [description]) VALUES (1, 'cell')
INSERT INTO phone_type([phone_type], [description]) VALUES (2, 'work')
INSERT INTO phone_type([phone_type], [description]) VALUES (3, 'home')
GO