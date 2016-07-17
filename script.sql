USE [master]
GO
/****** Object:  Database [TestingSystem]    Script Date: 7/15/2016 2:26:24 AM ******/
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
/****** Object:  StoredProcedure [dbo].[add_question]    Script Date: 7/15/2016 2:26:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[add_test]    Script Date: 7/15/2016 2:26:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[add_user]    Script Date: 7/15/2016 2:26:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[add_user]
@login nvarchar(max), @password nvarchar(max)
AS
BEGIN
	INSERT INTO Client(c_login, c_password)
	VALUES(@login, @password);
END

GO
/****** Object:  StoredProcedure [dbo].[get_all_questions_in_test]    Script Date: 7/15/2016 2:26:25 AM ******/
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
/****** Object:  StoredProcedure [dbo].[get_all_tests]    Script Date: 7/15/2016 2:26:25 AM ******/
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
/****** Object:  Table [dbo].[Client]    Script Date: 7/15/2016 2:26:25 AM ******/
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
/****** Object:  Table [dbo].[Question]    Script Date: 7/15/2016 2:26:25 AM ******/
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
/****** Object:  Table [dbo].[Test]    Script Date: 7/15/2016 2:26:25 AM ******/
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
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([id], [id_test], [question], [answer]) VALUES (1, 1, N'hdnfnd', 0x6A64666E2064)
INSERT [dbo].[Question] ([id], [id_test], [question], [answer]) VALUES (2, 1, N'nf d', 0x6E64206664)
INSERT [dbo].[Question] ([id], [id_test], [question], [answer]) VALUES (3, 2, N'2+3', 0x35)
SET IDENTITY_INSERT [dbo].[Question] OFF
SET IDENTITY_INSERT [dbo].[Test] ON 

INSERT [dbo].[Test] ([id_test], [name]) VALUES (1, N'hdnd')
INSERT [dbo].[Test] ([id_test], [name]) VALUES (2, N'Test')
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
