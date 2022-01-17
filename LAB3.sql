USE [master]
GO
/****** Object:  Database [BookMalen]    Script Date: 2022-01-10 12:43:12 ******/
CREATE DATABASE [BookMalen]
GO
ALTER DATABASE [BookMalen] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookMalen].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookMalen] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookMalen] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookMalen] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookMalen] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookMalen] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookMalen] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookMalen] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookMalen] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookMalen] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookMalen] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookMalen] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookMalen] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookMalen] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookMalen] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookMalen] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BookMalen] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookMalen] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookMalen] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookMalen] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookMalen] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookMalen] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookMalen] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookMalen] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BookMalen] SET  MULTI_USER 
GO
ALTER DATABASE [BookMalen] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookMalen] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookMalen] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookMalen] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookMalen] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BookMalen] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BookMalen] SET QUERY_STORE = OFF
GO
USE [BookMalen]
GO
/****** Object:  Table [dbo].[Författare]    Script Date: 2022-01-10 12:43:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Författare](
	[ID] [nvarchar](50) NOT NULL,
	[Förnamn] [nvarchar](50) NULL,
	[Efternamn] [nvarchar](50) NULL,
	[Födelsedatum] [date] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Böcker]    Script Date: 2022-01-10 12:43:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Böcker](
	[ISBN13] [nvarchar](50) NOT NULL,
	[Titel] [nvarchar](50) NULL,
	[Språk] [nvarchar](50) NULL,
	[Pris] [int] NULL,
	[FörfattareID] [nvarchar](50) NULL,
 CONSTRAINT [PK_Table_2] PRIMARY KEY CLUSTERED 
(
	[ISBN13] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LagerSaldo]    Script Date: 2022-01-10 12:43:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LagerSaldo](
	[ButikID] [int] NULL,
	[ISBN13] [nvarchar](50) NULL,
	[Antal] [int] NULL,
	[Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_TitlarPerFörfattare]    Script Date: 2022-01-10 12:43:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_TitlarPerFörfattare]   
AS SELECT 

		CONCAT(Författare.Förnamn,' ',Författare.Efternamn) AS [Name] ,
		DATEDIFF(YEAR,Författare.Födelsedatum,GETDATE()) AS [Ålder],
		COUNT (DISTINCT Böcker.Titel) AS Titlar,
		SUM(Böcker.Pris * LagerSaldo.Antal)as Lagervärde
		  
	FROM Författare

	JOIN Böcker
	on 	Författare.ID = Böcker.FörfattareID

	left JOIN  LagerSaldo	
	on Böcker.ISBN13 = LagerSaldo.ISBN13


	GROUP BY
	Författare.Förnamn,Författare.Efternamn,Författare.Födelsedatum

	
GO
/****** Object:  Table [dbo].[BokInkomst]    Script Date: 2022-01-10 12:43:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BokInkomst](
	[ISBN13] [nvarchar](50) NULL,
	[Solda] [int] NULL,
	[ButikID] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Butiker]    Script Date: 2022-01-10 12:43:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Butiker](
	[ID] [int] NOT NULL,
	[Butiksnamn] [nvarchar](50) NULL,
	[Adressuppgifter] [nvarchar](50) NULL,
 CONSTRAINT [PK_Butiker] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Förlag]    Script Date: 2022-01-10 12:43:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Förlag](
	[ID] [nvarchar](50) NULL,
	[Förlagnamn] [nvarchar](50) NULL,
	[Adressuppgifter] [nvarchar](50) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Böcker] ([ISBN13], [Titel], [Språk], [Pris], [FörfattareID]) VALUES (N'9780141346809', N'The Lightning Thief', N'Engelska', 99, N'4')
INSERT [dbo].[Böcker] ([ISBN13], [Titel], [Språk], [Pris], [FörfattareID]) VALUES (N'9780575089914', N'Mistborn: The Final Empire', N'Engelska', 119, N'1')
INSERT [dbo].[Böcker] ([ISBN13], [Titel], [Språk], [Pris], [FörfattareID]) VALUES (N'9780755322817', N'American Gods', N'Engelska', 129, N'3')
INSERT [dbo].[Böcker] ([ISBN13], [Titel], [Språk], [Pris], [FörfattareID]) VALUES (N'9780765326362', N'Words of Radiance', N'Engelska', 329, N'1')
INSERT [dbo].[Böcker] ([ISBN13], [Titel], [Språk], [Pris], [FörfattareID]) VALUES (N'9781408891957', N'Norse Mythology', N'Engelska', 139, N'3')
INSERT [dbo].[Böcker] ([ISBN13], [Titel], [Språk], [Pris], [FörfattareID]) VALUES (N'9781473211513', N'The Way of Kings', N'Engelska', 199, N'1')
INSERT [dbo].[Böcker] ([ISBN13], [Titel], [Språk], [Pris], [FörfattareID]) VALUES (N'9781473214712', N'Good Omens', N'Engelska', 219, N'3')
INSERT [dbo].[Böcker] ([ISBN13], [Titel], [Språk], [Pris], [FörfattareID]) VALUES (N'9781473226173', N'Warriors of God', N'Engelska', 219, N'2')
INSERT [dbo].[Böcker] ([ISBN13], [Titel], [Språk], [Pris], [FörfattareID]) VALUES (N'9789163882869', N'Den försvunne hjälten', N'Svenska', 159, N'4')
INSERT [dbo].[Böcker] ([ISBN13], [Titel], [Språk], [Pris], [FörfattareID]) VALUES (N'9789198616828', N'Den sista önskningen', N'Svenska', 179, N'2')
GO
INSERT [dbo].[BokInkomst] ([ISBN13], [Solda], [ButikID]) VALUES (N'9789163882869', 5, N'3')
INSERT [dbo].[BokInkomst] ([ISBN13], [Solda], [ButikID]) VALUES (N'9789163882869', 2, N'2')
INSERT [dbo].[BokInkomst] ([ISBN13], [Solda], [ButikID]) VALUES (N'9781473214712', 7, N'1')
INSERT [dbo].[BokInkomst] ([ISBN13], [Solda], [ButikID]) VALUES (N'9781473214712', 5, N'2')
INSERT [dbo].[BokInkomst] ([ISBN13], [Solda], [ButikID]) VALUES (N'9781473226173', 3, N'2')
INSERT [dbo].[BokInkomst] ([ISBN13], [Solda], [ButikID]) VALUES (N'9781473226173', 9, N'3')
INSERT [dbo].[BokInkomst] ([ISBN13], [Solda], [ButikID]) VALUES (N'9781473211513', 4, N'1')
INSERT [dbo].[BokInkomst] ([ISBN13], [Solda], [ButikID]) VALUES (N'9781473211513', 8, N'3')
GO
INSERT [dbo].[Butiker] ([ID], [Butiksnamn], [Adressuppgifter]) VALUES (1, N'Adlibris', N'Kungsgatan 15, 111 35 Stockholm')
INSERT [dbo].[Butiker] ([ID], [Butiksnamn], [Adressuppgifter]) VALUES (2, N'science fiction bokhandeln', N'Västerlånggatan 48, 111 29 Stockholm')
INSERT [dbo].[Butiker] ([ID], [Butiksnamn], [Adressuppgifter]) VALUES (3, N'akademibokhandeln', N'V.Storgatan 32, Nyköping')
GO
INSERT [dbo].[Författare] ([ID], [Förnamn], [Efternamn], [Födelsedatum]) VALUES (N'1', N'Brandon', N'Sanderson', CAST(N'1975-12-19' AS Date))
INSERT [dbo].[Författare] ([ID], [Förnamn], [Efternamn], [Födelsedatum]) VALUES (N'2', N'Andrzej', N'Sapkowski', CAST(N'1948-06-21' AS Date))
INSERT [dbo].[Författare] ([ID], [Förnamn], [Efternamn], [Födelsedatum]) VALUES (N'3', N'Neil', N'Gaiman', CAST(N'1960-11-10' AS Date))
INSERT [dbo].[Författare] ([ID], [Förnamn], [Efternamn], [Födelsedatum]) VALUES (N'4', N'Rick', N'Riordan', CAST(N'1964-06-05' AS Date))
GO
INSERT [dbo].[Förlag] ([ID], [Förlagnamn], [Adressuppgifter]) VALUES (N'1', N'Penguin Books', N'8 Viaduct Gardens, London, SW11 7BW')
INSERT [dbo].[Förlag] ([ID], [Förlagnamn], [Adressuppgifter]) VALUES (N'2', N'Tor Books', N'120 Broadway, New York, NY 10271')
GO
INSERT [dbo].[LagerSaldo] ([ButikID], [ISBN13], [Antal], [Id]) VALUES (1, N'9780141346809', 4, 1)
INSERT [dbo].[LagerSaldo] ([ButikID], [ISBN13], [Antal], [Id]) VALUES (3, N'9780141346809', 8, 2)
INSERT [dbo].[LagerSaldo] ([ButikID], [ISBN13], [Antal], [Id]) VALUES (2, N'9780575089914', 10, 3)
INSERT [dbo].[LagerSaldo] ([ButikID], [ISBN13], [Antal], [Id]) VALUES (3, N'9780575089914', 7, 4)
INSERT [dbo].[LagerSaldo] ([ButikID], [ISBN13], [Antal], [Id]) VALUES (1, N'9780755322817', 5, 5)
INSERT [dbo].[LagerSaldo] ([ButikID], [ISBN13], [Antal], [Id]) VALUES (2, N'9780755322817', 11, 6)
INSERT [dbo].[LagerSaldo] ([ButikID], [ISBN13], [Antal], [Id]) VALUES (3, N'9780755322817', 9, 7)
INSERT [dbo].[LagerSaldo] ([ButikID], [ISBN13], [Antal], [Id]) VALUES (1, N'9789198616828', 11, 8)
INSERT [dbo].[LagerSaldo] ([ButikID], [ISBN13], [Antal], [Id]) VALUES (2, N'9789198616828', 3, 9)
INSERT [dbo].[LagerSaldo] ([ButikID], [ISBN13], [Antal], [Id]) VALUES (2, N'9781408891957', 3, 10)
GO
ALTER TABLE [dbo].[Böcker]  WITH CHECK ADD  CONSTRAINT [FK_Table_2_Table_1] FOREIGN KEY([FörfattareID])
REFERENCES [dbo].[Författare] ([ID])
GO
ALTER TABLE [dbo].[Böcker] CHECK CONSTRAINT [FK_Table_2_Table_1]
GO
ALTER TABLE [dbo].[BokInkomst]  WITH CHECK ADD  CONSTRAINT [FK_Table_5_Table_2] FOREIGN KEY([ISBN13])
REFERENCES [dbo].[Böcker] ([ISBN13])
GO
ALTER TABLE [dbo].[BokInkomst] CHECK CONSTRAINT [FK_Table_5_Table_2]
GO
ALTER TABLE [dbo].[LagerSaldo]  WITH CHECK ADD  CONSTRAINT [FK_LagerSaldo_Butiker] FOREIGN KEY([ButikID])
REFERENCES [dbo].[Butiker] ([ID])
GO
ALTER TABLE [dbo].[LagerSaldo] CHECK CONSTRAINT [FK_LagerSaldo_Butiker]
GO
ALTER TABLE [dbo].[LagerSaldo]  WITH CHECK ADD  CONSTRAINT [FK_LagerSaldo_Table_2] FOREIGN KEY([ISBN13])
REFERENCES [dbo].[Böcker] ([ISBN13])
GO
ALTER TABLE [dbo].[LagerSaldo] CHECK CONSTRAINT [FK_LagerSaldo_Table_2]
GO
USE [master]
GO
ALTER DATABASE [BookMalen] SET  READ_WRITE 
GO
SELECT * FROM LagerSaldo
