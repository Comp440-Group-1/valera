USE [s16guest56]
GO
/****** Object:  StoredProcedure [dbo].[depricate_version]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[get_customers_by_company]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_customers_by_company] 

@company_name varchar(50)

AS
BEGIN
	
	SET NOCOUNT ON;

	
	BEGIN TRY
	DECLARE @company_id int;
	SET @company_id = (SELECT company_id FROM company WHERE name = @company_name)
	SELECT first_name, last_name, email FROM customer WHERE company_id = @company_id
	

		GROUP BY last_name, first_name, email
	END TRY

	
	BEGIN CATCH
		PRINT 'ERROR'
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[insert_new_customer]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_new_customer]

	@first_name varchar(50),
	@last_name varchar(50),
	@email varchar(250),
	@company_id int,     /*can be NULL*/
	@title_id tinyint	 /*can be NULL*/
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRANSACTION
BEGIN TRY
INSERT INTO customer VALUES (@first_name,
							 @last_name,
							 @email,
							 @company_id,
							 @title_id)
COMMIT TRANSACTION
END TRY
BEGIN CATCH
	PRINT 'ERROR'
	ROLLBACK TRANSACTION
END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[number_of_support_requests]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[number_of_support_requests]

	@version_id int
AS
BEGIN
	SET NOCOUNT ON;

BEGIN TRANSACTION
BEGIN TRY
    
	SELECT COUNT(version_id) AS number_of_support_requests, version_id FROM customer_actions
	WHERE (version_id = version_id) AND (action_type_id=3)  
	GROUP BY version_id
	COMMIT TRANSACTION
END TRY
BEGIN CATCH 
        PRINT 'ERROR'
    ROLLBACK TRANSACTION
END CATCH
END

GO
/****** Object:  Table [dbo].[action_type]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[action_type](
	[action_type_id] [tinyint] NOT NULL,
	[action_type_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_action_type] PRIMARY KEY CLUSTERED 
(
	[action_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[address]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[address](
	[adress_id] [int] IDENTITY(1,1) NOT NULL,
	[street] [varchar](50) NOT NULL,
	[city_id] [int] NOT NULL,
	[state_id] [tinyint] NULL,
	[zip] [int] NULL,
	[country_id] [int] NOT NULL,
 CONSTRAINT [PK_address] PRIMARY KEY CLUSTERED 
(
	[adress_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[city]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[city](
	[city_id] [int] IDENTITY(1,1) NOT NULL,
	[city_name] [varchar](50) NOT NULL,
	[state_id] [tinyint] NULL,
 CONSTRAINT [PK_city] PRIMARY KEY CLUSTERED 
(
	[city_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[company]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[company](
	[company_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_company] PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[company_address]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company_address](
	[company_id] [int] NOT NULL,
	[address_id] [int] NOT NULL,
 CONSTRAINT [PK_company_address] PRIMARY KEY CLUSTERED 
(
	[company_id] ASC,
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[country]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[country](
	[country_id] [int] NOT NULL,
	[country_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_country] PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[country_phone_codes]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country_phone_codes](
	[country_id] [int] NOT NULL,
	[country_code] [int] NOT NULL,
 CONSTRAINT [PK_country_phone_codes] PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[customer]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[customer](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[email] [varchar](250) NOT NULL,
	[company_id] [int] NULL,
	[title_id] [tinyint] NULL,
 CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[customer_actions]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer_actions](
	[action_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[date] [date] NOT NULL,
	[version_id] [int] NOT NULL,
	[action_type_id] [tinyint] NOT NULL,
 CONSTRAINT [PK_customer_actions] PRIMARY KEY CLUSTERED 
(
	[action_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[customer_address]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer_address](
	[customer_id] [int] NOT NULL,
	[address_id] [int] NOT NULL,
 CONSTRAINT [PK_customer_address] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC,
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cutomer_title]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cutomer_title](
	[title_id] [tinyint] NOT NULL,
	[title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_cutomer_title] PRIMARY KEY CLUSTERED 
(
	[title_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[depricated]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[depricated](
	[version_id] [int] NOT NULL,
	[depricated] [bit] NOT NULL,
 CONSTRAINT [PK_depricated] PRIMARY KEY CLUSTERED 
(
	[version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[download]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[download](
	[version_id] [int] NOT NULL,
	[url] [varchar](200) NOT NULL,
 CONSTRAINT [PK_download] PRIMARY KEY CLUSTERED 
(
	[version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[patchnote]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[patchnote](
	[version_id] [int] NOT NULL,
	[pachnote] [text] NOT NULL,
 CONSTRAINT [PK_patchnote] PRIMARY KEY CLUSTERED 
(
	[version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[phone]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phone](
	[phone_type] [tinyint] NOT NULL,
	[customer_id] [int] NOT NULL,
	[phone_number] [int] NOT NULL,
	[area_code] [tinyint] NULL,
	[country_code] [int] NULL,
 CONSTRAINT [PK_phone] PRIMARY KEY CLUSTERED 
(
	[phone_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[phone_type]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[phone_type](
	[phone_type] [tinyint] NOT NULL,
	[description] [varchar](20) NOT NULL,
 CONSTRAINT [PK_phone_type] PRIMARY KEY CLUSTERED 
(
	[phone_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[product]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[product_id] [smallint] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product_description]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_description](
	[product_id] [smallint] NOT NULL,
	[product_description] [text] NULL,
 CONSTRAINT [PK_product_description] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product_housekeeping]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_housekeeping](
	[product_id] [smallint] NOT NULL,
	[date_introduced] [date] NOT NULL,
	[employee_id] [int] NOT NULL,
 CONSTRAINT [PK_product_housekeeping] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[release]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[release](
	[iteration_id] [int] NOT NULL,
	[product_id] [smallint] NOT NULL,
	[date] [date] NOT NULL,
	[release_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_version] PRIMARY KEY CLUSTERED 
(
	[release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[release_to_version]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[release_to_version](
	[version_id] [int] NOT NULL,
	[release_id] [int] NOT NULL,
 CONSTRAINT [PK_iteration_to_release] PRIMARY KEY CLUSTERED 
(
	[version_id] ASC,
	[release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[state]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[state](
	[state_id] [tinyint] NOT NULL,
	[state_abbreviation] [nchar](2) NULL,
	[state_name] [nchar](15) NULL,
 CONSTRAINT [PK_state] PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[version]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[version](
	[version_id] [int] IDENTITY(1,1) NOT NULL,
	[date] [date] NOT NULL,
	[release_id] [int] NOT NULL,
 CONSTRAINT [PK_release_table] PRIMARY KEY CLUSTERED 
(
	[version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[version_number]    Script Date: 5/5/2016 6:47:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[version_number](
	[version_id] [int] NOT NULL,
	[version_number] [varchar](50) NOT NULL,
 CONSTRAINT [PK_version_number] PRIMARY KEY CLUSTERED 
(
	[version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[address]  WITH CHECK ADD  CONSTRAINT [FK_address_city] FOREIGN KEY([city_id])
REFERENCES [dbo].[city] ([city_id])
GO
ALTER TABLE [dbo].[address] CHECK CONSTRAINT [FK_address_city]
GO
ALTER TABLE [dbo].[address]  WITH CHECK ADD  CONSTRAINT [FK_address_country1] FOREIGN KEY([country_id])
REFERENCES [dbo].[country] ([country_id])
GO
ALTER TABLE [dbo].[address] CHECK CONSTRAINT [FK_address_country1]
GO
ALTER TABLE [dbo].[address]  WITH CHECK ADD  CONSTRAINT [FK_address_state] FOREIGN KEY([state_id])
REFERENCES [dbo].[state] ([state_id])
GO
ALTER TABLE [dbo].[address] CHECK CONSTRAINT [FK_address_state]
GO
ALTER TABLE [dbo].[city]  WITH CHECK ADD  CONSTRAINT [FK_city_state] FOREIGN KEY([state_id])
REFERENCES [dbo].[state] ([state_id])
GO
ALTER TABLE [dbo].[city] CHECK CONSTRAINT [FK_city_state]
GO
ALTER TABLE [dbo].[company_address]  WITH CHECK ADD  CONSTRAINT [FK_company_address_address] FOREIGN KEY([address_id])
REFERENCES [dbo].[address] ([adress_id])
GO
ALTER TABLE [dbo].[company_address] CHECK CONSTRAINT [FK_company_address_address]
GO
ALTER TABLE [dbo].[company_address]  WITH CHECK ADD  CONSTRAINT [FK_company_address_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[company_address] CHECK CONSTRAINT [FK_company_address_company]
GO
ALTER TABLE [dbo].[country_phone_codes]  WITH CHECK ADD  CONSTRAINT [FK_country_phone_codes_country] FOREIGN KEY([country_id])
REFERENCES [dbo].[country] ([country_id])
GO
ALTER TABLE [dbo].[country_phone_codes] CHECK CONSTRAINT [FK_country_phone_codes_country]
GO
ALTER TABLE [dbo].[customer]  WITH CHECK ADD  CONSTRAINT [FK_customer_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[customer] CHECK CONSTRAINT [FK_customer_company]
GO
ALTER TABLE [dbo].[customer]  WITH CHECK ADD  CONSTRAINT [FK_customer_cutomer_title] FOREIGN KEY([title_id])
REFERENCES [dbo].[cutomer_title] ([title_id])
GO
ALTER TABLE [dbo].[customer] CHECK CONSTRAINT [FK_customer_cutomer_title]
GO
ALTER TABLE [dbo].[customer_actions]  WITH CHECK ADD  CONSTRAINT [FK_customer_actions_action_type] FOREIGN KEY([action_type_id])
REFERENCES [dbo].[action_type] ([action_type_id])
GO
ALTER TABLE [dbo].[customer_actions] CHECK CONSTRAINT [FK_customer_actions_action_type]
GO
ALTER TABLE [dbo].[customer_actions]  WITH CHECK ADD  CONSTRAINT [FK_customer_actions_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[customer_actions] CHECK CONSTRAINT [FK_customer_actions_customer]
GO
ALTER TABLE [dbo].[customer_actions]  WITH CHECK ADD  CONSTRAINT [FK_customer_actions_release] FOREIGN KEY([version_id])
REFERENCES [dbo].[version] ([version_id])
GO
ALTER TABLE [dbo].[customer_actions] CHECK CONSTRAINT [FK_customer_actions_release]
GO
ALTER TABLE [dbo].[customer_address]  WITH CHECK ADD  CONSTRAINT [FK_customer_address_address] FOREIGN KEY([address_id])
REFERENCES [dbo].[address] ([adress_id])
GO
ALTER TABLE [dbo].[customer_address] CHECK CONSTRAINT [FK_customer_address_address]
GO
ALTER TABLE [dbo].[customer_address]  WITH CHECK ADD  CONSTRAINT [FK_customer_address_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[customer_address] CHECK CONSTRAINT [FK_customer_address_customer]
GO
ALTER TABLE [dbo].[depricated]  WITH CHECK ADD  CONSTRAINT [FK_depricated_version] FOREIGN KEY([version_id])
REFERENCES [dbo].[version] ([version_id])
GO
ALTER TABLE [dbo].[depricated] CHECK CONSTRAINT [FK_depricated_version]
GO
ALTER TABLE [dbo].[download]  WITH CHECK ADD  CONSTRAINT [FK_download_version] FOREIGN KEY([version_id])
REFERENCES [dbo].[version] ([version_id])
GO
ALTER TABLE [dbo].[download] CHECK CONSTRAINT [FK_download_version]
GO
ALTER TABLE [dbo].[patchnote]  WITH CHECK ADD  CONSTRAINT [FK_patchnote_version] FOREIGN KEY([version_id])
REFERENCES [dbo].[version] ([version_id])
GO
ALTER TABLE [dbo].[patchnote] CHECK CONSTRAINT [FK_patchnote_version]
GO
ALTER TABLE [dbo].[phone]  WITH CHECK ADD  CONSTRAINT [FK_phone_country_phone_codes] FOREIGN KEY([country_code])
REFERENCES [dbo].[country_phone_codes] ([country_code])
GO
ALTER TABLE [dbo].[phone] CHECK CONSTRAINT [FK_phone_country_phone_codes]
GO
ALTER TABLE [dbo].[phone]  WITH CHECK ADD  CONSTRAINT [FK_phone_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[phone] CHECK CONSTRAINT [FK_phone_customer]
GO
ALTER TABLE [dbo].[phone]  WITH CHECK ADD  CONSTRAINT [FK_phone_phone_type] FOREIGN KEY([phone_type])
REFERENCES [dbo].[phone_type] ([phone_type])
GO
ALTER TABLE [dbo].[phone] CHECK CONSTRAINT [FK_phone_phone_type]
GO
ALTER TABLE [dbo].[product_description]  WITH CHECK ADD  CONSTRAINT [FK_product_description_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[product_description] CHECK CONSTRAINT [FK_product_description_product]
GO
ALTER TABLE [dbo].[product_housekeeping]  WITH CHECK ADD  CONSTRAINT [FK_product_housekeeping_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[product_housekeeping] CHECK CONSTRAINT [FK_product_housekeeping_product]
GO
ALTER TABLE [dbo].[release]  WITH CHECK ADD  CONSTRAINT [FK_release_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[release] CHECK CONSTRAINT [FK_release_product]
GO
ALTER TABLE [dbo].[version]  WITH CHECK ADD  CONSTRAINT [FK_version_release] FOREIGN KEY([release_id])
REFERENCES [dbo].[release] ([release_id])
GO
ALTER TABLE [dbo].[version] CHECK CONSTRAINT [FK_version_release]
GO
ALTER TABLE [dbo].[version_number]  WITH CHECK ADD  CONSTRAINT [FK_version_number_version] FOREIGN KEY([version_id])
REFERENCES [dbo].[version] ([version_id])
GO
ALTER TABLE [dbo].[version_number] CHECK CONSTRAINT [FK_version_number_version]
GO
