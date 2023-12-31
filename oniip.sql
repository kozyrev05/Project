USE [master]
GO
/****** Object:  Database [ONIIP]    Script Date: 20.12.2023 21:17:46 ******/
CREATE DATABASE [ONIIP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ONIIP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERV\MSSQL\DATA\ONIIP.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ONIIP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERV\MSSQL\DATA\ONIIP_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ONIIP] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ONIIP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ONIIP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ONIIP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ONIIP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ONIIP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ONIIP] SET ARITHABORT OFF 
GO
ALTER DATABASE [ONIIP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ONIIP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ONIIP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ONIIP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ONIIP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ONIIP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ONIIP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ONIIP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ONIIP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ONIIP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ONIIP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ONIIP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ONIIP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ONIIP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ONIIP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ONIIP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ONIIP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ONIIP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ONIIP] SET  MULTI_USER 
GO
ALTER DATABASE [ONIIP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ONIIP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ONIIP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ONIIP] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ONIIP] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ONIIP] SET QUERY_STORE = OFF
GO
USE [ONIIP]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 20.12.2023 21:17:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[Patronymic] [varchar](50) NULL,
	[Title] [varchar](50) NULL,
	[Department] [varchar](50) NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Research]    Script Date: 20.12.2023 21:17:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Research](
	[ResearchID] [int] IDENTITY(1,1) NOT NULL,
	[ResearchName] [varchar](100) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Description] [varchar](200) NULL,
	[DateBegin] [date] NOT NULL,
	[DateEnd] [date] NULL,
 CONSTRAINT [PK_Research] PRIMARY KEY CLUSTERED 
(
	[ResearchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ResearchFull]    Script Date: 20.12.2023 21:17:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ResearchFull] as
select ResearchName, Description, LastName, FirstName, Title, DateBegin, DateEnd
from Research, Employees
where Research.EmployeeID = Employees.EmployeeID
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 20.12.2023 21:17:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[ProjectID] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [varchar](50) NOT NULL,
	[Description] [varchar](100) NULL,
	[EmployeeID] [int] NOT NULL,
	[DateBegin] [date] NOT NULL,
	[DateEnd] [date] NULL,
	[Status] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[ProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProjectFull]    Script Date: 20.12.2023 21:17:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ProjectFull] as
select ProjectName, Description, LastName, FirstName, Title, DateBegin, DateEnd, Status
from Projects, Employees
where Projects.EmployeeID = Employees.EmployeeID
GO
/****** Object:  Table [dbo].[Equipments]    Script Date: 20.12.2023 21:17:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipments](
	[EquipmentID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentName] [varchar](max) NOT NULL,
	[Specifications] [varchar](max) NOT NULL,
	[ProjectID] [int] NOT NULL,
	[DateManufacture] [date] NOT NULL,
	[Status] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Equipments] PRIMARY KEY CLUSTERED 
(
	[EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[EquipmentsFull]    Script Date: 20.12.2023 21:17:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[EquipmentsFull] as
select EquipmentName, Specifications, ProjectName, LastName, FirstName, Title, DateManufacture, Equipments.Status
from Projects, Employees, Equipments
where Projects.ProjectID = Equipments.ProjectID and Employees.EmployeeID = Projects.EmployeeID
GO
/****** Object:  Table [dbo].[Users]    Script Date: 20.12.2023 21:17:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[AccessID] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccessLevels]    Script Date: 20.12.2023 21:17:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccessLevels](
	[AccessID] [int] IDENTITY(1,1) NOT NULL,
	[AccessLevelName] [varchar](50) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [PK_AccessLevels] PRIMARY KEY CLUSTERED 
(
	[AccessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[UserFull]    Script Date: 20.12.2023 21:17:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[UserFull] as
select UserID, UserName, Password, LastName, FirstName, Patronymic,  AccessLevelName
from Users, Employees, AccessLevels
where Users.EmployeeID = Employees.EmployeeID and Users.AccessID = AccessLevels.AccessID
GO
ALTER TABLE [dbo].[Equipments]  WITH CHECK ADD  CONSTRAINT [FK_Equipments_Projects] FOREIGN KEY([ProjectID])
REFERENCES [dbo].[Projects] ([ProjectID])
GO
ALTER TABLE [dbo].[Equipments] CHECK CONSTRAINT [FK_Equipments_Projects]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_Employees]
GO
ALTER TABLE [dbo].[Research]  WITH CHECK ADD  CONSTRAINT [FK_Research_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Research] CHECK CONSTRAINT [FK_Research_Employees]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_AccessLevels] FOREIGN KEY([AccessID])
REFERENCES [dbo].[AccessLevels] ([AccessID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_AccessLevels]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Employees]
GO
USE [master]
GO
ALTER DATABASE [ONIIP] SET  READ_WRITE 
GO
