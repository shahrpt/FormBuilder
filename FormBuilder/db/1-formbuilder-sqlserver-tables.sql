SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[form_fields]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[form_fields](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](50) NULL,
	[Text] [nvarchar](100) NULL,
	[FieldType] [varchar](20) NULL CONSTRAINT [DF_form_fields_FieldType]  DEFAULT ('TEXTBOX'),
	[IsRequired] [bit] NULL CONSTRAINT [DF_form_fields_IsRequired]  DEFAULT ((0)),
	[MaxChars] [int] NULL CONSTRAINT [DF_form_fields_MaxCharacters]  DEFAULT ((50)),
	[HoverText] [nvarchar](150) NULL,
	[Hint] [nvarchar](150) NULL,
	[SubLabel] [nvarchar](50) NULL,
	[Size] [varchar](10) NULL,
	[SelectedOption] [nvarchar](50) NOT NULL,
	[Columns] [int] NULL,
	[Rows] [int] NULL,
	[Options] [nvarchar](300) NULL,
	[Validation] [varchar](50) NULL,
	[DomId] [int] NULL CONSTRAINT [DF_form_fields_DomId]  DEFAULT ((0)),
	[Order] [int] NULL CONSTRAINT [DF_form_fields_Order]  DEFAULT ((0)),
	[MinimumAge] [int] NULL,
	[MaximumAge] [int] NULL,
	[HelpText] [nvarchar](50) NULL,
	[DateAdded] [datetime] NOT NULL CONSTRAINT [DF_form_fields_DateAdded]  DEFAULT (getutcdate()),
 CONSTRAINT [PK_form_fields] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[form]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[form](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Slug] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](50) NULL,
	[ConfirmationMessage] [nvarchar](300) NOT NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_form] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[form_field_values]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[form_field_values](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FieldId] [int] NOT NULL,
	[EntryId] [uniqueidentifier] NOT NULL,
	[Value] [nvarchar](500) NULL,
	[DateAdded] [datetime] NOT NULL CONSTRAINT [DF_form_field_values_DateAdded]  DEFAULT (getutcdate()),
 CONSTRAINT [PK_form_field_values] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[form_form_fields]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[form_form_fields](
	[formId] [int] NOT NULL,
	[fieldId] [int] NOT NULL,
 CONSTRAINT [PK_form_form_fields] PRIMARY KEY CLUSTERED 
(
	[formId] ASC,
	[fieldId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_form_field_values_form_fields]') AND parent_object_id = OBJECT_ID(N'[dbo].[form_field_values]'))
ALTER TABLE [dbo].[form_field_values]  WITH CHECK ADD  CONSTRAINT [FK_form_field_values_form_fields] FOREIGN KEY([FieldId])
REFERENCES [dbo].[form_fields] ([ID])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK form_fields_form_form_fields]') AND parent_object_id = OBJECT_ID(N'[dbo].[form_form_fields]'))
ALTER TABLE [dbo].[form_form_fields]  WITH CHECK ADD  CONSTRAINT [FK form_fields_form_form_fields] FOREIGN KEY([fieldId])
REFERENCES [dbo].[form_fields] ([ID])
ON DELETE CASCADE
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_form_fields]') AND parent_object_id = OBJECT_ID(N'[dbo].[form_form_fields]'))
ALTER TABLE [dbo].[form_form_fields]  WITH CHECK ADD  CONSTRAINT [FK_form_fields] FOREIGN KEY([formId])
REFERENCES [dbo].[form] ([ID])
