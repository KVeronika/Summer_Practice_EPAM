USE [master]
GO
/****** Object:  Database [TestingSystem]    Script Date: 7/31/2016 7:25:27 PM ******/
CREATE DATABASE [TestingSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestingSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TestingSystem.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TestingSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TestingSystem_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TestingSystem] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestingSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestingSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestingSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestingSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestingSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestingSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestingSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestingSystem] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [TestingSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestingSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestingSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestingSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestingSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestingSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestingSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestingSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestingSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestingSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestingSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestingSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestingSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestingSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestingSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestingSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestingSystem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TestingSystem] SET  MULTI_USER 
GO
ALTER DATABASE [TestingSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestingSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestingSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestingSystem] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [TestingSystem]
GO
/****** Object:  StoredProcedure [dbo].[add_question]    Script Date: 7/31/2016 7:25:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[add_question] 
	@id_test int, @question nvarchar(max), @answer varbinary(max)
AS
BEGIN
	INSERT INTO Question(id_test, question, answer)
	VALUES(@id_test, @question, @answer);
END


GO
/****** Object:  StoredProcedure [dbo].[add_test]    Script Date: 7/31/2016 7:25:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[add_test] 
	@name nvarchar(max)
AS
BEGIN
	INSERT INTO Test(name)
	VALUES(@name);
END


GO
/****** Object:  StoredProcedure [dbo].[add_user]    Script Date: 7/31/2016 7:25:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[add_user]
@login nvarchar(max), @password varbinary(max)
AS
BEGIN
	INSERT INTO Client(c_login, c_password)
	VALUES(@login, @password);
END


GO
/****** Object:  StoredProcedure [dbo].[delete_test]    Script Date: 7/31/2016 7:25:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delete_test]
	@id_test int
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM Question WHERE id_test = @id_test;
	DELETE FROM Test WHERE id_test = @id_test;
END;

GO
/****** Object:  StoredProcedure [dbo].[existing_username]    Script Date: 7/31/2016 7:25:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[existing_username]
@username nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT c.c_login FROM Client as c WHERE c.c_login = @username;
END

GO
/****** Object:  StoredProcedure [dbo].[get_all_questions_in_test]    Script Date: 7/31/2016 7:25:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_all_questions_in_test] 
@id_test int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT q.question, q.answer,q.id FROM Question as q WHERE q.id_test = @id_test;
END


GO
/****** Object:  StoredProcedure [dbo].[get_all_tests]    Script Date: 7/31/2016 7:25:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[get_all_tests]
AS
BEGIN
	SELECT t.id_test,t.name From dbo.Test as t
END


GO
/****** Object:  StoredProcedure [dbo].[get_password_for_user]    Script Date: 7/31/2016 7:25:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_password_for_user]
@login nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT c.c_password FROM Client as c WHERE c.c_login = @login;
END

GO
/****** Object:  Table [dbo].[Client]    Script Date: 7/31/2016 7:25:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Client](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[c_login] [nvarchar](max) NOT NULL,
	[c_password] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Question]    Script Date: 7/31/2016 7:25:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Question](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_test] [int] NOT NULL,
	[question] [nvarchar](max) NOT NULL,
	[answer] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Test]    Script Date: 7/31/2016 7:25:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test](
	[id_test] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Test] PRIMARY KEY CLUSTERED 
(
	[id_test] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (1, N'f,jdnlfjd', 0x000F42A4)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (2, N'fhjd', 0x4978FD04A7E8E3444EFD57E34E863582BA7DD0CF7047F9E12BBC23D110B20B8B)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (3, N'fd,f ', 0x0908A9CD76D8FF44036AD57C9695FDAC6EAAF481A86864AC46B1B3AB2842F38E)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (4, N'алва рл', 0xDA01E568D56BFBACCE6E11E7902D9F972C566853B8C7A795E342002D203C525F)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (5, N'hfkd', 0x4F6A0CCEDB78C0FD31AB21B4AAE1551AD65099763412799239983E7673E4EC74)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (6, N'Admin', 0x836DF144D7A11DB119EF2C6619469A28D3E99DA0B503F44D76DF3784F38F3897)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (7, N'user1', 0x8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (8, N'user2', 0x8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (9, N'user3', 0xA665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (10, N'123', 0xA665A45920422F9D417E4867EFDC4FB8A04A1F3FFF1FA07E998E86F7F7A27AE3)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (11, N'Veronika', 0xE78F27AB3EF177A9926E6B90E572B9853CE6CF4D87512836E9AE85807EC9D7FE)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (12, N'user20', 0xF5CA38F748A1D6EAF726B8A42FB575C3C71F1864A8143301782DE13DA2D9202B)
INSERT [dbo].[Client] ([id], [c_login], [c_password]) VALUES (13, N'eto', 0x03AC674216F3E15C761EE1A5E255F067953623C8B388B4459E13F978D7C846F4)
SET IDENTITY_INSERT [dbo].[Client] OFF
SET IDENTITY_INSERT [dbo].[Test] ON 

INSERT [dbo].[Test] ([id_test], [name]) VALUES (2, N'Thfbbd')
SET IDENTITY_INSERT [dbo].[Test] OFF
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Test] FOREIGN KEY([id_test])
REFERENCES [dbo].[Test] ([id_test])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Test]
GO
USE [master]
GO
ALTER DATABASE [TestingSystem] SET  READ_WRITE 
GO
