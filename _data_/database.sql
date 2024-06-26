USE [master]
GO
/****** Object:  Database [MyShop]    Script Date: 3/30/2024 5:34:24 PM ******/
CREATE DATABASE [MyShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MyShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MyShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MyShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MyShop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MyShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyShop] SET RECOVERY FULL 
GO
ALTER DATABASE [MyShop] SET  MULTI_USER 
GO
ALTER DATABASE [MyShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MyShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MyShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MyShop', N'ON'
GO
ALTER DATABASE [MyShop] SET QUERY_STORE = ON
GO
ALTER DATABASE [MyShop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MyShop]
GO
/****** Object:  Table [dbo].[Coupons]    Script Date: 3/30/2024 5:34:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Coupons](
	[CouponID] [int] IDENTITY(1,1) NOT NULL,
	[CouponCode] [varchar](20) NULL,
	[Discount] [decimal](5, 2) NULL,
	[StartDate] [date] NULL,
	[ExpiryDate] [date] NULL,
	[Status] [varchar](20) NULL,
 CONSTRAINT [PK__Coupons__384AF1DA2A2E9C08] PRIMARY KEY CLUSTERED 
(
	[CouponID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 3/30/2024 5:34:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Email] [varchar](100) NULL,
	[Phone] [varchar](20) NULL,
	[Address] [nvarchar](100) NULL,
 CONSTRAINT [PK__Customer__A4AE64B8A3AA6C09] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 3/30/2024 5:34:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] NOT NULL,
	[PlantID] [int] NOT NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](10, 2) NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[PlantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3/30/2024 5:34:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[Quantity] [int] NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[OrderDate] [date] NULL,
	[CouponID] [int] NULL,
	[Status] [varchar](20) NULL,
 CONSTRAINT [PK__Orders__C3905BAFFA06AE45] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlantCategories]    Script Date: 3/30/2024 5:34:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlantCategories](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [varchar](50) NULL,
	[CategoryImages] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plants]    Script Date: 3/30/2024 5:34:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plants](
	[PlantID] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[Price] [decimal](10, 2) NULL,
	[Description] [text] NULL,
	[StockQuantity] [int] NULL,
	[CategoryID] [int] NULL,
	[PlantImage] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[PlantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccounts]    Script Date: 3/30/2024 5:34:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAccounts](
	[UserID] [int] NOT NULL,
	[Username] [varchar](50) NULL,
	[Password] [varchar](2048) NULL,
	[Email] [varchar](100) NULL,
	[FullName] [varchar](100) NULL,
	[Role] [varchar](50) NULL,
	[Entropy] [varchar](50) NULL,
 CONSTRAINT [PK__UserAcco__1788CCACF29E35FF] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Coupons] ON 

INSERT [dbo].[Coupons] ([CouponID], [CouponCode], [Discount], [StartDate], [ExpiryDate], [Status]) VALUES (100001, N'HAPPYNEWYEAR', CAST(6.00 AS Decimal(5, 2)), CAST(N'2024-01-01' AS Date), CAST(N'2024-01-07' AS Date), N'Expired')
INSERT [dbo].[Coupons] ([CouponID], [CouponCode], [Discount], [StartDate], [ExpiryDate], [Status]) VALUES (100002, N'COSLUX03', CAST(3.00 AS Decimal(5, 2)), CAST(N'2024-03-24' AS Date), CAST(N'2024-03-31' AS Date), N'Active')
INSERT [dbo].[Coupons] ([CouponID], [CouponCode], [Discount], [StartDate], [ExpiryDate], [Status]) VALUES (100003, N'AFFGIM', CAST(2.00 AS Decimal(5, 2)), CAST(N'2024-03-27' AS Date), CAST(N'2024-04-30' AS Date), N'Active')
INSERT [dbo].[Coupons] ([CouponID], [CouponCode], [Discount], [StartDate], [ExpiryDate], [Status]) VALUES (100004, N'HOTSUMER', CAST(5.00 AS Decimal(5, 2)), CAST(N'2024-05-01' AS Date), CAST(N'2024-06-30' AS Date), N'Pending')
SET IDENTITY_INSERT [dbo].[Coupons] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100001, N'Lâm Tân Bình', N'Branson9@gmail.com', N'0927335388', N'7 Phố Lã, Thôn Di Vịnh, Huyện Bạch Cường, 
Đà Nẵng')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100002, N'Yên Bá Cường', N'Moises_Tillman@gmail.com', N'0250487602', N'8 Phố Phi Thuận Quảng, Phường Kha Phương, Quận Chinh Đoàn
, Hưng Yên')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100003, N'Vương Khánh Duy', N'Keon15@gmail.com', N'0585286165', N'3552, Thôn Bạch Ân, Ấp Phi Vu, Huyện Sơn Trinh Đài
, Thanh Hóa')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100004, N'Vương Giao Linh', N'Rafael_Halvorson57@gmail.com', N'0274111744', N'26, Ấp Uông Oanh Thuận, Xã Kiều Quảng Cúc, Huyện 89, 
Bắc Giang')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100005, N'Đổng Ngọc Oanh', N'Randi_Swift56@gmail.com', N'0731113503', N'4 Phố Ma Phú Huấn, Xã Giao Bạch Long, Quận Thôi Vọng Nhạn
, Hải Phòng')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100006, N'Tạ Ngọc Phụng', N'Reymundo4@gmail.com', N'0305613612', N'612 Phố Bạc Mỹ Nghĩa, Thôn Hồng Thanh, Huyện Nhiệm, 
Cần Thơ')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100007, N'Hồ Tuấn Anh', N'Nathaniel_Bartell@gmail.com', N'0726184260', N'45 Phố Nhậm, Phường Hà Thúy Cát, Huyện Lỳ Hội Triết
, Hải Phòng')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100008, N'Phạm Vũ Minh', N'Shanel_Konopelski30@gmail.com', N'0268913404', N'72 Phố Bình, Xã 1, Huyện Nhậm Hòa
, Hồ Chí Minh')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100009, N'Tăng Hữu Vượng', N'Javier22@gmail.com', N'0666611058', N'2294 Phố Dương Tấn Phong, Phường Toản, Quận 6, 
Hà Nội')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100010, N'Lý Mỹ Thuần', N'Laurie19@gmail.com', N'0528760910', N'592 Phố Giáp Ẩn Hòa, Xã 19, Huyện Khúc Thiên Chiêu, 
Quảng Trị')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100011, N'Liêu Ngọc Thơ', N'Delfina_Friesen@gmail.com', N'0863737810', N'2, Ấp Ma Dao Hoa, Xã Hy Khang Nhã, Huyện Khiêm Bảo, 
Kon Tum')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100012, N'Thái Thu Ngọc', N'Golden7@gmail.com', N'0703012519', N'8, Thôn Nhạn, Ấp Đại Diễm, Huyện Bình Tiếp
, 
Ninh Bình')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100013, N'Tô Thùy Giang', N'Claudine29@gmail.com', N'0595454092', N'871 Phố Đồng Cương Ngôn, Thôn Diêm Quân, Huyện Xuyến Vọng
, Kiên Giang')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100014, N'Từ Nhật Tấn', N'	Name_Hamill@gmail.com', N'0315303350', N'4 Phố Tăng Tiền Dao, Phường Hỷ Ân, Huyện Huệ Giáp, 
Đà Nẵng')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100015, N'Cổ Bích Hiền', N'	Jeramie51@gmail.com', N'0976986238', N'1, Ấp Trác Thanh, Phường Tuấn, Quận Phát Khôi
, Khánh Hòa')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100016, N'Mai Phi Yến', N'Hayley30@gmail.com', N'0568905229', N'254 Phố Khâu Tú Văn, Thôn Tâm Bào, Huyện 4
, 
Đà Nẵng')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100017, N'Thục Diễm Châu', N'Richard87@gmail.com', N'0549940761', N'36 Phố Thanh, Xã 8, Quận Bạch Hoài
, 
Bạc Liêu')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100018, N'Tô Trung Dũng', N'Kacie14@gmail.com', N'0582414352', N'31 Phố Cầm Yên Mỹ, Ấp Diễm Kiều, Huyện Thêu Ngôn, 
Hà Giang')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100019, N'Chương Tuấn Minh', N'Breana_Aufderhar21@gmail.com', N'0370268055', N'9558 Phố Mang Chinh Bửu, Xã 59, Huyện 5
, 
Quảng Ninh')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100020, N'Lộ Cát Tiên', N'Isabella44@gmail.com', N'0521462819', N'8219, Ấp My, Phường 32, Huyện 10
, Sơn La')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100021, N'Hồ Phương Loan', N'Benton86@gmail.com', N'0951966099', N'659 Phố Liễu, Xã 74, Quận Vừ Khuê
, 
Cần Thơ')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100022, N'Lục Minh Huyền', N'Telly6@gmail.com', N'0273040210', N'57, Thôn Đàm, Ấp Lò Kim, Quận Vọng Thôi
, Đồng Nai')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100023, N'Lô Ðăng An', N'Valentin_Haley21@gmail.com', N'0722679088', N'7793 Phố Lại Thiên Thục, Thôn Tụ Bửu, Huyện Trâm Ân
, Cao Bằng')
INSERT [dbo].[Customers] ([CustomerID], [Name], [Email], [Phone], [Address]) VALUES (100024, N'Kha Cẩm Yến', N'Ollie98@gmail.com', N'0980534354', N'7815 Phố Bàng, Phường 3, Huyện 13, 
Phú Thọ')
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100001, 1, 1, CAST(15.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100001, 3, 2, CAST(19.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100001, 14, 1, CAST(10.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100002, 11, 1, CAST(39.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100003, 7, 3, CAST(38.97 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100003, 31, 2, CAST(49.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100004, 12, 2, CAST(11.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100004, 24, 2, CAST(33.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100005, 12, 1, CAST(5.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100005, 18, 3, CAST(20.97 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100005, 27, 2, CAST(37.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100005, 30, 1, CAST(5.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100006, 25, 4, CAST(91.96 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100007, 18, 10, CAST(69.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100008, 22, 6, CAST(83.94 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100009, 10, 10, CAST(49.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100009, 29, 10, CAST(99.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100010, 8, 5, CAST(44.95 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100011, 16, 2, CAST(55.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100011, 25, 2, CAST(45.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100012, 2, 3, CAST(89.97 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100013, 32, 10, CAST(79.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100014, 23, 1, CAST(34.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100015, 18, 10, CAST(69.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100015, 19, 10, CAST(79.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100016, 4, 20, CAST(119.80 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100017, 26, 5, CAST(109.95 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100018, 9, 10, CAST(69.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100019, 20, 6, CAST(71.94 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100020, 5, 5, CAST(64.95 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100020, 6, 5, CAST(89.95 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100021, 13, 7, CAST(104.93 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100022, 15, 10, CAST(199.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100023, 17, 4, CAST(99.96 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100024, 21, 3, CAST(149.97 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100025, 28, 3, CAST(119.97 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100026, 11, 2, CAST(79.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100026, 21, 2, CAST(99.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100026, 31, 2, CAST(49.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100027, 6, 3, CAST(53.97 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100027, 14, 2, CAST(21.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100027, 25, 4, CAST(91.96 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100027, 27, 5, CAST(94.95 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100028, 15, 4, CAST(79.96 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100028, 21, 2, CAST(99.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100029, 3, 10, CAST(99.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100029, 4, 10, CAST(59.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100029, 8, 10, CAST(89.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100029, 9, 10, CAST(69.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100029, 10, 10, CAST(49.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100029, 12, 10, CAST(59.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100029, 18, 10, CAST(69.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100029, 19, 10, CAST(79.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100029, 29, 10, CAST(99.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100029, 30, 10, CAST(59.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100029, 32, 10, CAST(79.90 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100030, 2, 5, CAST(149.95 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100030, 11, 5, CAST(199.95 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100030, 16, 5, CAST(139.95 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100030, 17, 5, CAST(124.95 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100030, 21, 5, CAST(249.95 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100030, 23, 2, CAST(69.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100031, 10, 100, CAST(499.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100032, 3, 20, CAST(199.80 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100032, 29, 20, CAST(199.80 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100033, 1, 1, CAST(15.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100033, 5, 1, CAST(12.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100033, 6, 1, CAST(17.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100033, 7, 1, CAST(12.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100033, 13, 1, CAST(14.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100033, 14, 1, CAST(10.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100033, 15, 1, CAST(19.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100033, 20, 1, CAST(11.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100033, 22, 1, CAST(13.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100033, 24, 1, CAST(16.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100033, 27, 1, CAST(18.99 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100034, 2, 2, CAST(59.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100034, 16, 2, CAST(55.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100034, 17, 2, CAST(49.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100034, 25, 2, CAST(45.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100034, 26, 2, CAST(43.98 AS Decimal(10, 2)))
INSERT [dbo].[OrderDetails] ([OrderID], [PlantID], [Quantity], [Price]) VALUES (100034, 31, 2, CAST(49.98 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100001, 100001, 4, CAST(40.96 AS Decimal(10, 2)), CAST(N'2024-01-01' AS Date), 100001, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100002, 100002, 1, CAST(33.99 AS Decimal(10, 2)), CAST(N'2024-01-01' AS Date), 100001, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100003, 100003, 5, CAST(82.95 AS Decimal(10, 2)), CAST(N'2024-01-01' AS Date), 100001, N'Cancelled')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100004, 100004, 4, CAST(39.96 AS Decimal(10, 2)), CAST(N'2024-01-01' AS Date), 100001, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100005, 100005, 7, CAST(64.93 AS Decimal(10, 2)), CAST(N'2024-01-02' AS Date), 100001, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100006, 100006, 4, CAST(85.96 AS Decimal(10, 2)), CAST(N'2024-01-02' AS Date), 100001, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100007, 100007, 10, CAST(63.90 AS Decimal(10, 2)), CAST(N'2024-01-03' AS Date), 100001, N'Cancelled')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100008, 100008, 6, CAST(77.94 AS Decimal(10, 2)), CAST(N'2024-01-05' AS Date), 100001, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100009, 100009, 20, CAST(143.80 AS Decimal(10, 2)), CAST(N'2024-01-07' AS Date), 100001, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100010, 100010, 5, CAST(44.95 AS Decimal(10, 2)), CAST(N'2024-01-15' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100011, 100011, 4, CAST(101.96 AS Decimal(10, 2)), CAST(N'2024-01-20' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100012, 100012, 3, CAST(89.97 AS Decimal(10, 2)), CAST(N'2024-01-24' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100013, 100013, 10, CAST(79.90 AS Decimal(10, 2)), CAST(N'2024-01-30' AS Date), NULL, N'Cancelled')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100014, 100014, 1, CAST(34.99 AS Decimal(10, 2)), CAST(N'2024-01-31' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100015, 100015, 20, CAST(149.80 AS Decimal(10, 2)), CAST(N'2024-02-02' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100016, 100016, 20, CAST(119.80 AS Decimal(10, 2)), CAST(N'2024-02-07' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100017, 100017, 5, CAST(109.95 AS Decimal(10, 2)), CAST(N'2024-02-14' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100018, 100018, 10, CAST(69.90 AS Decimal(10, 2)), CAST(N'2024-02-19' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100019, 100019, 6, CAST(71.94 AS Decimal(10, 2)), CAST(N'2024-02-21' AS Date), NULL, N'Cancelled')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100020, 100020, 10, CAST(154.90 AS Decimal(10, 2)), CAST(N'2024-02-28' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100021, 100021, 7, CAST(104.93 AS Decimal(10, 2)), CAST(N'2024-03-06' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100022, 100022, 10, CAST(199.90 AS Decimal(10, 2)), CAST(N'2024-03-08' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100023, 100023, 4, CAST(99.96 AS Decimal(10, 2)), CAST(N'2024-03-11' AS Date), NULL, N'Cancelled')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100024, 100024, 3, CAST(149.97 AS Decimal(10, 2)), CAST(N'2024-03-14' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100025, 100024, 3, CAST(119.97 AS Decimal(10, 2)), CAST(N'2024-03-15' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100026, 100024, 6, CAST(229.94 AS Decimal(10, 2)), CAST(N'2024-03-19' AS Date), NULL, N'Cancelled')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100027, 100024, 14, CAST(262.86 AS Decimal(10, 2)), CAST(N'2024-03-20' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100028, 100024, 6, CAST(179.94 AS Decimal(10, 2)), CAST(N'2024-03-22' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100029, 100024, 110, CAST(818.90 AS Decimal(10, 2)), CAST(N'2024-03-23' AS Date), NULL, N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100030, 100024, 27, CAST(934.73 AS Decimal(10, 2)), CAST(N'2024-03-24' AS Date), NULL, N'Delivering')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100031, 100024, 100, CAST(499.00 AS Decimal(10, 2)), CAST(N'2024-03-25' AS Date), NULL, N'Delivering')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100032, 100024, 40, CAST(399.60 AS Decimal(10, 2)), CAST(N'2024-03-26' AS Date), NULL, N'Delivering')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100033, 100024, 12, CAST(165.89 AS Decimal(10, 2)), CAST(N'2024-03-27' AS Date), 100003, N'Delivering')
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [Quantity], [TotalAmount], [OrderDate], [CouponID], [Status]) VALUES (100034, 100024, 12, CAST(303.88 AS Decimal(10, 2)), CAST(N'2024-03-27' AS Date), 100003, N'Delivering')
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (1, N'Indoor Plants', N'Images/ProductTypes/ProductCategory01.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (2, N'Outdoor Plants', N'Images/ProductTypes/ProductCategory02.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (3, N'Flowering Plants', N'Images/ProductTypes/ProductCategory03.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (4, N'Succulents', N'Images/ProductTypes/ProductCategory04.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (5, N'Herbs', N'Images/ProductTypes/ProductCategory05.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (6, N'Fruit Trees', N'Images/ProductTypes/ProductCategory06.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (7, N'Vegetables', N'Images/ProductTypes/ProductCategory07.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (8, N'Trees', N'Images/ProductTypes/ProductCategory08.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (9, N'Climbers', N'Images/ProductTypes/ProductCategory09.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (10, N'Shrub', N'Images/ProductTypes/ProductCategory10.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (11, N'Aquatic plants', N'Images/ProductTypes/ProductCategory11.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (12, N'Annuals', N'Images/ProductTypes/ProductCategory12.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (13, N'Flowers', N'Images/ProductTypes/ProductCategory13.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (14, N'Grasses', N'Images/ProductTypes/ProductCategory14.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (15, N'Mosses', N'Images/ProductTypes/ProductCategory15.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (16, N'Perennials', N'Images/ProductTypes/ProductCategory16.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (17, N'
Bryophyta', N'Images/ProductTypes/ProductCategory17.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (18, N'
Cycads', N'Images/ProductTypes/ProductCategory18.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (19, N'
Groundcovers', N'Images/ProductTypes/ProductCategory19.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (20, N'Gymnosperms', N'Images/ProductTypes/ProductCategory20.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (21, N'Hornwort', N'Images/ProductTypes/ProductCategory21.png')
INSERT [dbo].[PlantCategories] ([CategoryID], [CategoryName], [CategoryImages]) VALUES (22, N'
Vascular Plants', N'Images/ProductTypes/ProductCategory22.png')
GO
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (1, N'Snake Plant', CAST(15.99 AS Decimal(10, 2)), N'A popular indoor plant with long, pointed leaves.', 50, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (2, N'Fiddle Leaf Fig', CAST(29.99 AS Decimal(10, 2)), N'A trendy indoor tree with large, fiddle-shaped leaves.', 30, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (3, N'Lavender', CAST(9.99 AS Decimal(10, 2)), N'A fragrant herb with purple flowers, often used in aromatherapy.', 40, 5, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (4, N'Tomato Plant', CAST(5.99 AS Decimal(10, 2)), N'A small plant that produces tomatoes.', 60, 7, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (5, N'Succulent Mix', CAST(12.99 AS Decimal(10, 2)), N'A variety pack of assorted succulent plants.', 20, 4, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (6, N'Peace Lily', CAST(17.99 AS Decimal(10, 2)), N'A popular indoor plant with white flowers and glossy green leaves.', 25, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (7, N'Spider Plant', CAST(12.99 AS Decimal(10, 2)), N'An easy-to-care-for indoor plant with long, arching leaves.', 35, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (8, N'Aloe Vera', CAST(8.99 AS Decimal(10, 2)), N'A succulent plant known for its medicinal properties and spiky leaves.', 45, 4, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (9, N'Rosemary', CAST(6.99 AS Decimal(10, 2)), N'An aromatic herb with needle-like leaves, often used in cooking.', 50, 5, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (10, N'Mint', CAST(4.99 AS Decimal(10, 2)), N'A fragrant herb with bright green leaves, commonly used in teas and desserts.', 55, 5, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (11, N'Lemon Tree', CAST(39.99 AS Decimal(10, 2)), N'A small citrus tree that produces fragrant yellow fruits.', 20, 6, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (12, N'Basil', CAST(5.99 AS Decimal(10, 2)), N'A popular herb with large, green leaves, commonly used in Italian cuisine.', 60, 5, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (13, N'Jade Plant', CAST(14.99 AS Decimal(10, 2)), N'A succulent plant with thick, fleshy leaves, often associated with good luck.', 30, 4, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (14, N'Pothos', CAST(10.99 AS Decimal(10, 2)), N'An easy-to-care-for indoor plant with heart-shaped leaves, often trailing.', 40, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (15, N'Cactus Mix', CAST(19.99 AS Decimal(10, 2)), N'A variety pack of assorted cactus plants, known for their low maintenance.', 25, 4, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (16, N'Monstera', CAST(27.99 AS Decimal(10, 2)), N'A popular indoor plant with large, fenestrated leaves, often called the "Swiss cheese plant".', 30, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (17, N'Orchid', CAST(24.99 AS Decimal(10, 2)), N'A delicate flowering plant known for its exotic blooms, often used as a decorative houseplant.', 20, 3, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (18, N'Sage', CAST(6.99 AS Decimal(10, 2)), N'An herb with grayish-green leaves, commonly used in cooking and smudging ceremonies.', 40, 5, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (19, N'Chili Pepper Plant', CAST(7.99 AS Decimal(10, 2)), N'A small plant that produces spicy chili peppers.', 50, 7, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (20, N'Fern', CAST(11.99 AS Decimal(10, 2)), N'A leafy green plant with delicate fronds, often grown as a houseplant.', 35, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (21, N'Palm Tree', CAST(49.99 AS Decimal(10, 2)), N'A tropical tree with large, fan-shaped leaves, commonly used as a decorative indoor plant.', 15, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (22, N'English Ivy', CAST(13.99 AS Decimal(10, 2)), N'A climbing vine with small, lobed leaves, often used as a trailing houseplant or ground cover.', 30, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (23, N'Bird of Paradise', CAST(34.99 AS Decimal(10, 2)), N'A striking tropical plant with large, bird-shaped flowers and broad leaves.', 25, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (24, N'Peperomia', CAST(16.99 AS Decimal(10, 2)), N'A compact indoor plant with small, succulent-like leaves, often grown for its ornamental foliage.', 30, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (25, N'Lily of the Valley', CAST(22.99 AS Decimal(10, 2)), N'A fragrant flowering plant with delicate white bell-shaped blooms, often used in bouquets and floral arrangements.', 20, 3, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (26, N'ZZ Plant', CAST(21.99 AS Decimal(10, 2)), N'A low-maintenance indoor plant with glossy, dark green leaves, known for its air-purifying properties.', 25, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (27, N'String of Pearls', CAST(18.99 AS Decimal(10, 2)), N'A trailing succulent with round, bead-like leaves, often grown in hanging baskets or as a trailing plant.', 25, 4, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (28, N'Fiddle Leaf Fig Bush', CAST(39.99 AS Decimal(10, 2)), N'A compact version of the popular Fiddle Leaf Fig tree, ideal for smaller spaces.', 15, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (29, N'Snapdragon', CAST(9.99 AS Decimal(10, 2)), N'A colorful flowering plant with tall spikes of snapdragon-like blooms, commonly used in gardens and floral arrangements.', 30, 3, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (30, N'Marigold', CAST(5.99 AS Decimal(10, 2)), N'A cheerful annual flower with bright orange or yellow blooms, often planted in gardens and containers.', 40, 3, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (31, N'Bamboo', CAST(24.99 AS Decimal(10, 2)), N'A fast-growing plant with tall, slender stalks and lush green foliage, often used as a decorative indoor plant or in landscaping.', 20, 1, NULL)
INSERT [dbo].[Plants] ([PlantID], [Name], [Price], [Description], [StockQuantity], [CategoryID], [PlantImage]) VALUES (32, N'Carnation', CAST(7.99 AS Decimal(10, 2)), N'A popular flowering plant with ruffled, multi-petaled blooms in various colors, commonly used in bouquets and floral arrangements.', 30, 3, NULL)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Coupons__D34908008A20869E]    Script Date: 3/30/2024 5:34:25 PM ******/
ALTER TABLE [dbo].[Coupons] ADD  CONSTRAINT [UQ__Coupons__D34908008A20869E] UNIQUE NONCLUSTERED 
(
	[CouponCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__UserAcco__536C85E4DD1B542F]    Script Date: 3/30/2024 5:34:25 PM ******/
ALTER TABLE [dbo].[UserAccounts] ADD  CONSTRAINT [UQ__UserAcco__536C85E4DD1B542F] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK__OrderDeta__Order__47DBAE45] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK__OrderDeta__Order__47DBAE45]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK__OrderDeta__Plant__44FF419A] FOREIGN KEY([PlantID])
REFERENCES [dbo].[Plants] ([PlantID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK__OrderDeta__Plant__44FF419A]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__CouponID__440B1D61] FOREIGN KEY([CouponID])
REFERENCES [dbo].[Coupons] ([CouponID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__CouponID__440B1D61]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__Customer__44FF419A] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__Customer__44FF419A]
GO
ALTER TABLE [dbo].[Plants]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[PlantCategories] ([CategoryID])
GO
USE [master]
GO
ALTER DATABASE [MyShop] SET  READ_WRITE 
GO
