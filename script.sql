USE [master]
GO
/****** Object:  Database [QL_PKTPHONE]    Script Date: 12/04/2017 8:52:19 CH ******/
CREATE DATABASE [QL_PKTPHONE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QL_PKTPHONE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QL_PKTPHONE.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QL_PKTPHONE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QL_PKTPHONE_log.ldf' , SIZE = 3456KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QL_PKTPHONE] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QL_PKTPHONE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QL_PKTPHONE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET ARITHABORT OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QL_PKTPHONE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QL_PKTPHONE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QL_PKTPHONE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QL_PKTPHONE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QL_PKTPHONE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QL_PKTPHONE] SET  MULTI_USER 
GO
ALTER DATABASE [QL_PKTPHONE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QL_PKTPHONE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QL_PKTPHONE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QL_PKTPHONE] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QL_PKTPHONE] SET DELAYED_DURABILITY = DISABLED 
GO
USE [QL_PKTPHONE]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_NextID]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- @lastid là mã cuối cùng (fixwidth)
-- @prefix là tiền tố mã: vd HS0001 => HS
-- @size là số lượng ký tự trong mã HS0001 => 6
CREATE function [dbo].[fn_NextID] (@lastid varchar(10),@prefix varchar(10),@size int)
  returns varchar(10)
as
    BEGIN
        IF(@lastid = '')
            set @lastid = @prefix + REPLICATE (0,@size - LEN(@prefix))
        declare @num_nextid int, @nextid varchar(10)
        set @lastid = LTRIM(RTRIM(@lastid))
        -- number next id
        set @num_nextid = replace(@lastid,@prefix,'') + 1
        -- bo di so luong ky tu tien to
        set @size = @size - len(@prefix)
        -- replicate số lượng số 0 REPLICATE(0,3) => 000
        set @nextid = @prefix + REPLICATE (0,@size - LEN(@prefix))
        set @nextid = @prefix + RIGHT(REPLICATE(0, @size) + CONVERT (VARCHAR(MAX), @num_nextid), @size)
        return @nextid
    END;
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Admin](
	[MaAD] [char](4) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[CMND] [nvarchar](9) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[DT] [nvarchar](11) NULL,
	[Email] [nvarchar](50) NULL,
	[UserName] [nvarchar](30) NULL,
	[PassWord] [nvarchar](15) NULL,
	[Manager] [nvarchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChiTietHoaDonBan]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChiTietHoaDonBan](
	[MaHDBan] [nvarchar](10) NULL,
	[MaSP] [char](6) NULL,
	[GiaBan] [int] NULL,
	[SLBan] [int] NULL,
	[MaKM] [char](4) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChiTietHoaDonMua]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDonMua](
	[MaHDMua] [nvarchar](10) NULL,
	[MaSP] [nvarchar](10) NOT NULL,
	[MaSX] [nvarchar](10) NULL,
	[SLMua] [int] NULL,
	[GiaMua] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FeedBack]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedBack](
	[MaFB] [nvarchar](10) NOT NULL,
	[ChuDe] [nvarchar](100) NULL,
	[HoTen] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[DT] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Ngay] [date] NULL CONSTRAINT [DF_Table_1_Ngay]  DEFAULT (getdate()),
	[NoiDung] [nvarchar](1000) NULL,
	[TinhTrang] [nvarchar](20) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDonBan]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonBan](
	[MaHDBan] [nvarchar](10) NOT NULL,
	[NgayBan] [date] NULL CONSTRAINT [NgayBan]  DEFAULT (getdate()),
	[MaKH] [nvarchar](10) NOT NULL,
	[TinhTrang] [nvarchar](30) NULL,
	[NguoiGiao] [nvarchar](4) NULL,
	[NgayGiao] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDonMua]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonMua](
	[MaHDMua] [nvarchar](10) NULL,
	[NgayMua] [date] NULL,
	[NguoiDat] [nvarchar](10) NULL,
	[NguoiNhan] [nvarchar](10) NULL,
	[TinhTrang] [nvarchar](50) NULL,
	[NhaCungUng] [nvarchar](10) NULL,
	[NgayNhan] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [nvarchar](10) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[CMND] [nvarchar](9) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[DT] [nvarchar](11) NULL,
	[Email] [nvarchar](50) NULL,
	[Diem] [int] NULL,
	[UserName] [nvarchar](30) NULL,
	[PassWord] [nvarchar](50) NULL,
	[Ngay] [date] NULL CONSTRAINT [N]  DEFAULT (getdate())
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhuyenMai]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhuyenMai](
	[MaKM] [char](4) NULL,
	[NgayBD] [datetime] NULL,
	[NgayKT] [datetime] NULL,
	[NoiDung] [nvarchar](100) NULL,
	[KhuyenMai] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Manager]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manager](
	[MaM] [nvarchar](10) NULL,
	[TenM] [nvarchar](50) NULL,
	[MASTER] [bit] NULL,
	[MI_VIEW] [bit] NULL,
	[MI_CHANGE] [bit] NULL,
	[ME_DIRECTOR] [bit] NULL,
	[ME_VIEW] [bit] NULL CONSTRAINT [DF_Manager1_XemMI]  DEFAULT ('false'),
	[ME_CHANGE] [bit] NULL,
	[ME_ADD] [bit] NULL CONSTRAINT [DF_Manager1_SuaMI]  DEFAULT (N'false'),
	[ME_DELETE] [bit] NULL,
	[MP_DIRECTOR] [bit] NULL,
	[MP_VIEW] [bit] NULL,
	[MP_CHANGE] [bit] NULL,
	[MP_ADD] [bit] NULL,
	[MP_DELETE] [bit] NULL,
	[MM_VIEW] [bit] NULL,
	[MM_CHANGE] [bit] NULL,
	[MM_ADD] [bit] NULL,
	[MN_DELETE] [bit] NULL,
	[MC_DIRECTOR] [bit] NULL,
	[MC_VIEW] [bit] NULL,
	[MC_CHANGE] [bit] NULL,
	[MC_ADD] [bit] NULL,
	[MC_DELETE] [bit] NULL,
	[MS_DIRECTOR] [bit] NULL,
	[MS_VIEW] [bit] NULL,
	[MS_CHANGE] [bit] NULL,
	[MS_ADD] [bit] NULL,
	[MS_DELETE] [bit] NULL,
	[MB_DIRECTOR] [bit] NULL,
	[MB_VIEW] [bit] NULL,
	[MB_CHANGE] [bit] NULL,
	[MB_ADD] [bit] NULL,
	[MB_DELETE] [bit] NULL,
	[ST_VIEW] [bit] NULL,
	[ST_PRINT] [bit] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Nam]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nam](
	[Nam] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NamNhuan]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NamNhuan](
	[Nam] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ngay]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ngay](
	[Ngay] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhaCungUng]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungUng](
	[MaCU] [nvarchar](50) NULL,
	[TenNCU] [nvarchar](100) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[DT] [nchar](10) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhaSanXuat]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaSanXuat](
	[MaSX] [nvarchar](4) NOT NULL,
	[TenSX] [nvarchar](30) NOT NULL,
	[DiaChi] [nvarchar](100) NULL,
	[DT] [int] NULL,
	[Email] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSP] [char](6) NOT NULL,
	[MaSX] [char](4) NULL,
	[TenSP] [nvarchar](50) NULL,
	[GiaMua] [int] NULL CONSTRAINT [GiaMua]  DEFAULT ((0)),
	[GiaBan] [int] NULL CONSTRAINT [GiaBan]  DEFAULT ((0)),
	[NgayNhap] [date] NULL,
	[SLTon] [int] NULL CONSTRAINT [SLTon]  DEFAULT ((0)),
	[HinhAnh] [nvarchar](200) NULL,
	[PhanLoai] [nvarchar](100) NULL,
	[GhiChu] [nvarchar](100) NULL,
	[CT1] [nvarchar](100) NULL CONSTRAINT [CT1]  DEFAULT ('-'),
	[CT2] [nvarchar](100) NULL CONSTRAINT [CT2]  DEFAULT ('-'),
	[CT3] [nvarchar](100) NULL CONSTRAINT [CT3]  DEFAULT ('-'),
	[CT4] [nvarchar](100) NULL CONSTRAINT [CT4]  DEFAULT ('-'),
	[CT5] [nvarchar](100) NULL CONSTRAINT [CT5]  DEFAULT ('-'),
	[CT6] [nvarchar](100) NULL CONSTRAINT [CT6]  DEFAULT ('-'),
	[CT7] [nvarchar](100) NULL CONSTRAINT [CT7]  DEFAULT ('-'),
	[CT8] [nvarchar](100) NULL CONSTRAINT [CT8]  DEFAULT ('-'),
	[CT9] [nvarchar](100) NULL CONSTRAINT [CT9]  DEFAULT ('-'),
	[CT10] [nvarchar](100) NULL CONSTRAINT [CT10]  DEFAULT ('-'),
	[CT11] [nvarchar](100) NULL CONSTRAINT [CT11]  DEFAULT ('-'),
	[CT12] [nvarchar](100) NULL CONSTRAINT [CT12]  DEFAULT ('-'),
	[CT13] [nvarchar](100) NULL CONSTRAINT [CT13]  DEFAULT ('-'),
	[CT14] [nvarchar](100) NULL CONSTRAINT [CT14]  DEFAULT ('-'),
	[CT15] [nvarchar](100) NULL CONSTRAINT [CT15]  DEFAULT ('-'),
	[CT16] [nvarchar](100) NULL CONSTRAINT [CT16]  DEFAULT ('-'),
	[CT17] [nvarchar](100) NULL CONSTRAINT [CT17]  DEFAULT ('-'),
	[CT18] [nvarchar](100) NULL CONSTRAINT [CT18]  DEFAULT ('-'),
	[CT19] [nvarchar](100) NULL CONSTRAINT [CT19]  DEFAULT ('-'),
	[CT20] [nvarchar](100) NULL CONSTRAINT [CT20]  DEFAULT ('-'),
	[CT21] [nvarchar](100) NULL CONSTRAINT [CT21]  DEFAULT ('-'),
	[CT22] [nvarchar](100) NULL CONSTRAINT [CT22]  DEFAULT ('-'),
	[CT23] [nvarchar](100) NULL CONSTRAINT [CT23]  DEFAULT ('-'),
	[CT24] [nvarchar](100) NULL CONSTRAINT [CT24]  DEFAULT ('-'),
	[CT25] [nvarchar](100) NULL CONSTRAINT [CT25]  DEFAULT ('-'),
	[CT26] [nvarchar](100) NULL CONSTRAINT [CT26]  DEFAULT ('-'),
	[CT27] [nvarchar](100) NULL CONSTRAINT [CT27]  DEFAULT ('-'),
	[CT28] [nvarchar](100) NULL CONSTRAINT [CT28]  DEFAULT ('-'),
	[CT29] [nvarchar](100) NULL CONSTRAINT [CT29]  DEFAULT ('-'),
	[CT30] [nvarchar](100) NULL CONSTRAINT [CT30]  DEFAULT ('-'),
	[NoiBat] [nvarchar](1000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Thang]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thang](
	[Ngay] [int] NULL,
	[Thang] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThongKeTaiChinh]    Script Date: 12/04/2017 8:52:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongKeTaiChinh](
	[Nam] [int] NULL,
	[Quy] [int] NULL,
	[Thang] [int] NULL,
	[GiaTriTonKho] [money] NULL,
	[DoanhThu] [money] NULL,
	[Lai] [money] NULL,
	[TienMat] [money] NULL
) ON [PRIMARY]

GO
INSERT [dbo].[Admin] ([MaAD], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [UserName], [PassWord], [Manager]) VALUES (N'AD01', N'Nguyễn Kiệt', CAST(N'1960-01-01' AS Date), 0, N'012346532', N'số 4 le duan', N'1234567890', N'dsada@sda.info', N'admin', N'1', N'Boss')
INSERT [dbo].[Admin] ([MaAD], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [UserName], [PassWord], [Manager]) VALUES (N'AD02', N'Huỳnh Phong', CAST(N'1990-12-11' AS Date), 1, N'012345678', N'số 1 Lê Duẫn', N'0993307780', N'lang_tu2972@yahoo.com', NULL, N'123456', N'M05')
INSERT [dbo].[Admin] ([MaAD], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [UserName], [PassWord], [Manager]) VALUES (N'AD03', N'Luong Van Thai', CAST(N'1991-12-11' AS Date), 1, N'012345677', N'số 2 le duan', N'1234567890', N'sdads@yyy.ccc', NULL, N'123456', N'M06')
INSERT [dbo].[Admin] ([MaAD], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [UserName], [PassWord], [Manager]) VALUES (N'AD04', N'dsadsadsa', CAST(N'1960-01-01' AS Date), 0, N'123456742', N'dsadasdsa', N'1234567890', N'ddddd@dsd.ccc', NULL, N'123456', N'M05')
INSERT [dbo].[Admin] ([MaAD], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [UserName], [PassWord], [Manager]) VALUES (N'AD05', N'bnbjsd', CAST(N'1960-01-01' AS Date), 1, N'123123123', N'sdsfas', N'1234567890', N'sdfsdf@dfsdf.sd', NULL, N'123456', N'M05')
INSERT [dbo].[Admin] ([MaAD], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [UserName], [PassWord], [Manager]) VALUES (N'AD06', N'dsdsads', CAST(N'1960-01-01' AS Date), 1, N'123456788', N'dsadassd', N'0908764567', N'dss111@dsds.cc', NULL, N'1234567', N'M06')
INSERT [dbo].[Admin] ([MaAD], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [UserName], [PassWord], [Manager]) VALUES (N'AD07', N'dsdsads', CAST(N'1960-01-01' AS Date), 1, N'123456789', N'dsadassd', N'0908764567', N'dss111@dsds.cc', NULL, N'1234567', N'M06')
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00001', N'SP0013', 1999000, 1, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00002', N'SP0018', 1749000, 1, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00003', N'SP0038', 5789000, 2, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00004', N'SP0051', 2199000, 2, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00005', N'SP0018', 1749000, 3, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00006', N'SP0018', 1749000, 2, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00007', N'SP0028', 1249000, 1, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00008', N'SP0041', 7000000, 1, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00009', N'SP0041', 7000000, 1, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00009', N'SP0040', 17693000, 2, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00010', N'SP0040', 17693000, 2, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00010', N'SP0039', 19998000, 1, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00011', N'SP0040', 17693000, 2, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00011', N'SP0038', 5789000, 1, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00012', N'SP0045', 3489000, 1, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00012', N'SP0040', 17693000, 1, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00013', N'SP0040', 17693000, 4, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00014', N'SP0040', 17693000, 6, NULL)
INSERT [dbo].[ChiTietHoaDonBan] ([MaHDBan], [MaSP], [GiaBan], [SLBan], [MaKM]) VALUES (N'HDB00015', N'SP0040', 17693000, 4, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0001', N'SP0051', N'SX01', 10, 1900000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0001', N'SP0050', N'SX01', 12, 1850000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0001', N'SP0049', N'SX01', 10, 2500000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0001', N'SP0047', N'SX01', 15, 2000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0001', N'SP0046', N'SX01', 10, 3000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0001', N'SP0044', N'SX01', 10, 3000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0002', N'SP0038', N'SX03', 15, 5000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0002', N'SP0035', N'SX03', 10, 6500000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0002', N'SP0025', N'SX03', 20, 1100000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0002', N'SP0018', N'SX03', 20, 1500000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0003', N'SP0041', N'SX04', 10, 6300000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0003', N'SP0040', N'SX04', 10, 16600000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0003', N'SP0039', N'SX04', 10, 19000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0004', N'SP0045', N'SX05', 10, 3000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0004', N'SP0043', N'SX05', 10, 3500000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0004', N'SP0033', N'SX05', 10, 7000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0004', N'SP0028', N'SX05', 15, 1000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0004', N'SP0022', N'SX05', 15, 1300000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0004', N'SP0020', N'SX05', 15, 1300000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0005', N'SP0048', N'SX06', 10, 2500000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0005', N'SP0034', N'SX06', 10, 6500000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0005', N'SP0032', N'SX06', 10, 8300000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0005', N'SP0031', N'SX06', 10, 9400000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0005', N'SP0030', N'SX06', 10, 9800000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0005', N'SP0029', N'SX06', 10, 9000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0006', N'SP0051', N'SX01', 10, 2000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0007', N'SP0045', N'SX05', 10, 2000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHDMua], [MaSP], [MaSX], [SLMua], [GiaMua]) VALUES (N'HDM0008', N'SP0040', N'SX04', 10, 10000000)
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00001   ', N'cd', N'ht', N'@dc', N'@dt        ', N'@email                                            ', CAST(N'2012-07-23' AS Date), N'@nd', N'Đã đọc')
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00002   ', N'Góp ý về Website', N'', N'', N'           ', N'                                                  ', CAST(N'2012-07-23' AS Date), N'aaaaaaaaaaaaaaaaaa', N'Đã đọc')
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00003   ', N'Góp ý khác', N'', N'', N'           ', N'                                                  ', CAST(N'2012-07-23' AS Date), N'aaaaaaaaaaaaaaaaaaaa', N'Đã đọc')
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00004   ', N'Góp ý về Website', N'', N'', N'           ', N'                                                  ', CAST(N'2012-07-23' AS Date), N'dddddddđ', N'Đã đọc')
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00005', N'Góp ý về Website', N'', N'', N'', N'', CAST(N'2012-08-24' AS Date), N'', N'Chưa đọc')
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00006', N'Góp ý về Website', N'ewrwe', N'ewrew', N'ewrew', N'ewrwer', CAST(N'2012-08-24' AS Date), N'ewrwer', N'Chưa đọc')
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00007', N'Góp ý về Website', N'dasd', N'', N'ad', N'ada', CAST(N'2012-08-24' AS Date), N'adasd', N'Đã đọc')
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00008', N'Góp ý về Website', N'fewf', N'sfsd', N'đsf', N'fdsf', CAST(N'2012-08-24' AS Date), N'sff', N'Chưa đọc')
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00009', N'Góp ý về Website', N'', N'', N'', N'', CAST(N'2012-08-24' AS Date), N'', N'Chưa đọc')
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00010', N'Góp ý về Website', N'hghg', N'', N'', N'fsafsaf@vsfs.dsf', CAST(N'2012-08-24' AS Date), N'kkjkjkjk', N'Chưa đọc')
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00011', N'Góp ý về Website', N'dsadsa', N'', N'', N'fsafsaf@vsfs.dsf', CAST(N'2012-08-24' AS Date), N'dsadasda', N'Chưa đọc')
INSERT [dbo].[FeedBack] ([MaFB], [ChuDe], [HoTen], [DiaChi], [DT], [Email], [Ngay], [NoiDung], [TinhTrang]) VALUES (N'FB00012', N'Góp ý về Website', N'dsadsa', N'', N'', N'fsafsaf@vsfs.dsf', CAST(N'2012-08-24' AS Date), N'ds', N'Chưa đọc')
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00001', CAST(N'2012-08-24' AS Date), N'KH00000', N'Chưa xác nhận', NULL, NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00002', CAST(N'2012-08-24' AS Date), N'KH00000', N'Chưa xác nhận', NULL, NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00003', CAST(N'2012-08-25' AS Date), N'KH00001', N'Đã giao hàng', N'AD01', NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00004', CAST(N'2012-08-25' AS Date), N'KH00002', N'Đã giao hàng', N'AD01', NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00005', CAST(N'2012-08-25' AS Date), N'KH00001', N'Đã giao hàng', N'AD01', NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00006', CAST(N'2012-08-25' AS Date), N'KH00001', N'Đã giao hàng', N'AD01', NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00007', CAST(N'2012-08-25' AS Date), N'KH00001', N'Đã giao hàng', N'AD01', NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00008', CAST(N'2012-08-25' AS Date), N'KH00001', N'Đã giao hàng', N'AD01', NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00009', CAST(N'2012-08-25' AS Date), N'KH00014', N'Đã giao hàng', N'AD01', NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00010', CAST(N'2012-08-25' AS Date), N'KH00001', N'Chưa giao hàng', N'AD01', NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00011', CAST(N'2012-08-25' AS Date), N'KH00015', N'Xác nhận đặt hàng', NULL, NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00012', CAST(N'2012-08-25' AS Date), N'KH00017', N'Xác nhận đặt hàng', NULL, NULL)
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00013', CAST(N'2012-07-07' AS Date), N'KH00014', N'Đã giao hàng', N'AD01', CAST(N'2012-07-07' AS Date))
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00014', CAST(N'2012-07-07' AS Date), N'KH00001', N'Đã giao hàng', N'AD01', CAST(N'2012-07-07' AS Date))
INSERT [dbo].[HoaDonBan] ([MaHDBan], [NgayBan], [MaKH], [TinhTrang], [NguoiGiao], [NgayGiao]) VALUES (N'HDB00015', CAST(N'2012-09-07' AS Date), N'KH00001', N'Đã giao hàng', N'AD01', CAST(N'2012-09-07' AS Date))
INSERT [dbo].[HoaDonMua] ([MaHDMua], [NgayMua], [NguoiDat], [NguoiNhan], [TinhTrang], [NhaCungUng], [NgayNhan]) VALUES (N'HDM0001', CAST(N'2012-08-24' AS Date), N'AD01', N'AD01', N'Đã xác nhận', N'NCU01', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[HoaDonMua] ([MaHDMua], [NgayMua], [NguoiDat], [NguoiNhan], [TinhTrang], [NhaCungUng], [NgayNhan]) VALUES (N'HDM0002', CAST(N'2012-08-24' AS Date), N'AD01', N'AD01', N'Đã xác nhận', N'NCU01', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[HoaDonMua] ([MaHDMua], [NgayMua], [NguoiDat], [NguoiNhan], [TinhTrang], [NhaCungUng], [NgayNhan]) VALUES (N'HDM0003', CAST(N'2012-06-24' AS Date), N'AD01', N'AD01', N'Đã xác nhận', N'NCU01', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[HoaDonMua] ([MaHDMua], [NgayMua], [NguoiDat], [NguoiNhan], [TinhTrang], [NhaCungUng], [NgayNhan]) VALUES (N'HDM0004', CAST(N'2012-08-24' AS Date), N'AD01', N'AD01', N'Đã xác nhận', N'NCU01', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[HoaDonMua] ([MaHDMua], [NgayMua], [NguoiDat], [NguoiNhan], [TinhTrang], [NhaCungUng], [NgayNhan]) VALUES (N'HDM0005', CAST(N'2012-08-24' AS Date), N'AD01', N'AD01', N'Đã xác nhận', N'NCU01', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[HoaDonMua] ([MaHDMua], [NgayMua], [NguoiDat], [NguoiNhan], [TinhTrang], [NhaCungUng], [NgayNhan]) VALUES (N'HDM0006', CAST(N'2012-08-25' AS Date), N'AD02', N'AD03', N'Chưa xác nhận', N'NCU01', NULL)
INSERT [dbo].[HoaDonMua] ([MaHDMua], [NgayMua], [NguoiDat], [NguoiNhan], [TinhTrang], [NhaCungUng], [NgayNhan]) VALUES (N'HDM0007', CAST(N'2012-08-25' AS Date), N'AD01', N'AD01', N'Đã xác nhận', N'NCU02', CAST(N'2012-08-25' AS Date))
INSERT [dbo].[HoaDonMua] ([MaHDMua], [NgayMua], [NguoiDat], [NguoiNhan], [TinhTrang], [NhaCungUng], [NgayNhan]) VALUES (N'HDM0008', CAST(N'2012-09-07' AS Date), N'AD01', N'AD01', N'Đã xác nhận', N'NCU02', CAST(N'2012-09-07' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00001', N'Nguyễn Văn A', CAST(N'1990-01-01' AS Date), 1, N'123456789', N'số 3 Lê Duẫn', N'0998874563', N'nguyenvana@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00002', N'Nguyễn Văn B', CAST(N'1990-01-02' AS Date), 0, N'123456788', N'số 3 Lê Duẫn', N'0998874563', N'nguyenvanb@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00003', N'Nguyễn Tiến Dũng', CAST(N'1990-02-01' AS Date), 1, N'123456787', N'số 3 Lê Duẫn', N'0998874563', N'nguyentiendung@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00004', N'Diệp Thanh Tâm', CAST(N'1990-03-01' AS Date), 1, N'123456786', N'số 3 Lê Duẫn', N'0998874563', N'diepthanhtam@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00005', N'Lương Văn Thái', CAST(N'1990-05-01' AS Date), 1, N'123456785', N'số 3 Lê Duẫn', N'0998874563', N'luongvanthai@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00006', N'Huỳnh Mai', CAST(N'1990-01-04' AS Date), 0, N'123456784', N'số 3 Lê Duẫn', N'0998874563', N'huynhmai@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00007', N'Nguyễn Quang Tiến', CAST(N'1990-01-05' AS Date), 1, N'123456783', N'số 3 Lê Duẫn', N'0998874563', N'nguyenquangtien@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00008', N'Hoàng Giang', CAST(N'1990-09-06' AS Date), 1, N'123456782', N'số 3 Lê Duẫn', N'0998874563', N'hoanggiang@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00009', N'Đinh Thanh Huy', CAST(N'1990-04-03' AS Date), 0, N'123456781', N'số 3 Lê Duẫn', N'0998874563', N'dinhthanhhuy@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00010', N'Phạm Thanh Tùng', CAST(N'1990-02-04' AS Date), 1, N'123456770', N'số 3 Lê Duẫn', N'0998874563', N'phamthanhtung@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00011', N'Lương Xương Nguyên', CAST(N'1990-07-03' AS Date), 1, N'123456771', N'số 3 Lê Duẫn', N'0998874563', N'luongxuongnguyen@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00012', N'Bùi Tiến Dũng', CAST(N'1990-07-08' AS Date), 0, N'123456772', N'số 3 Lê Duẫn', N'0998874563', N'buitiendung@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00013', N'Nguyễn Quốc Cường', CAST(N'1990-07-09' AS Date), 1, N'123456773', N'số 3 Lê Duẫn', N'0998874563', N'nguyenquoccuong@yahoo.com', NULL, NULL, N'123456', CAST(N'2012-08-24' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00014', N'', CAST(N'2012-08-25' AS Date), NULL, N'', N'', N'', NULL, NULL, NULL, NULL, CAST(N'2012-08-25' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00015', N'dsadsa', CAST(N'1990-06-04' AS Date), 1, N'464833211', N'so 1 le duan', N'0999333221', N'sdsad@ddd.ccc', NULL, NULL, N'123456', CAST(N'2012-08-25' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00016', N'dsadsa', CAST(N'1990-06-04' AS Date), 1, N'464833211', N'so 1 le duan', N'0999333221', N'sdsad@ddd.ccc', NULL, NULL, N'123456', CAST(N'2012-08-25' AS Date))
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [NgaySinh], [GioiTinh], [CMND], [DiaChi], [DT], [Email], [Diem], [UserName], [PassWord], [Ngay]) VALUES (N'KH00017', N'Nguyen Van a', NULL, NULL, N'123456789', N'dsfsdf', N'1234567890', N'sdfsdf@sdsf.df', NULL, NULL, N'123456abcdef', CAST(N'2012-08-25' AS Date))
INSERT [dbo].[Manager] ([MaM], [TenM], [MASTER], [MI_VIEW], [MI_CHANGE], [ME_DIRECTOR], [ME_VIEW], [ME_CHANGE], [ME_ADD], [ME_DELETE], [MP_DIRECTOR], [MP_VIEW], [MP_CHANGE], [MP_ADD], [MP_DELETE], [MM_VIEW], [MM_CHANGE], [MM_ADD], [MN_DELETE], [MC_DIRECTOR], [MC_VIEW], [MC_CHANGE], [MC_ADD], [MC_DELETE], [MS_DIRECTOR], [MS_VIEW], [MS_CHANGE], [MS_ADD], [MS_DELETE], [MB_DIRECTOR], [MB_VIEW], [MB_CHANGE], [MB_ADD], [MB_DELETE], [ST_VIEW], [ST_PRINT]) VALUES (N'M06', N'NV', 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Manager] ([MaM], [TenM], [MASTER], [MI_VIEW], [MI_CHANGE], [ME_DIRECTOR], [ME_VIEW], [ME_CHANGE], [ME_ADD], [ME_DELETE], [MP_DIRECTOR], [MP_VIEW], [MP_CHANGE], [MP_ADD], [MP_DELETE], [MM_VIEW], [MM_CHANGE], [MM_ADD], [MN_DELETE], [MC_DIRECTOR], [MC_VIEW], [MC_CHANGE], [MC_ADD], [MC_DELETE], [MS_DIRECTOR], [MS_VIEW], [MS_CHANGE], [MS_ADD], [MS_DELETE], [MB_DIRECTOR], [MB_VIEW], [MB_CHANGE], [MB_ADD], [MB_DELETE], [ST_VIEW], [ST_PRINT]) VALUES (N'M07', N'Aaaa', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
INSERT [dbo].[Manager] ([MaM], [TenM], [MASTER], [MI_VIEW], [MI_CHANGE], [ME_DIRECTOR], [ME_VIEW], [ME_CHANGE], [ME_ADD], [ME_DELETE], [MP_DIRECTOR], [MP_VIEW], [MP_CHANGE], [MP_ADD], [MP_DELETE], [MM_VIEW], [MM_CHANGE], [MM_ADD], [MN_DELETE], [MC_DIRECTOR], [MC_VIEW], [MC_CHANGE], [MC_ADD], [MC_DELETE], [MS_DIRECTOR], [MS_VIEW], [MS_CHANGE], [MS_ADD], [MS_DELETE], [MB_DIRECTOR], [MB_VIEW], [MB_CHANGE], [MB_ADD], [MB_DELETE], [ST_VIEW], [ST_PRINT]) VALUES (N'M05', N'Boss', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
INSERT [dbo].[Nam] ([Nam]) VALUES (1960)
INSERT [dbo].[Nam] ([Nam]) VALUES (1961)
INSERT [dbo].[Nam] ([Nam]) VALUES (1962)
INSERT [dbo].[Nam] ([Nam]) VALUES (1963)
INSERT [dbo].[Nam] ([Nam]) VALUES (1964)
INSERT [dbo].[Nam] ([Nam]) VALUES (1965)
INSERT [dbo].[Nam] ([Nam]) VALUES (1966)
INSERT [dbo].[Nam] ([Nam]) VALUES (1967)
INSERT [dbo].[Nam] ([Nam]) VALUES (1968)
INSERT [dbo].[Nam] ([Nam]) VALUES (1969)
INSERT [dbo].[Nam] ([Nam]) VALUES (1970)
INSERT [dbo].[Nam] ([Nam]) VALUES (1971)
INSERT [dbo].[Nam] ([Nam]) VALUES (1972)
INSERT [dbo].[Nam] ([Nam]) VALUES (1973)
INSERT [dbo].[Nam] ([Nam]) VALUES (1974)
INSERT [dbo].[Nam] ([Nam]) VALUES (1975)
INSERT [dbo].[Nam] ([Nam]) VALUES (1976)
INSERT [dbo].[Nam] ([Nam]) VALUES (1977)
INSERT [dbo].[Nam] ([Nam]) VALUES (1978)
INSERT [dbo].[Nam] ([Nam]) VALUES (1979)
INSERT [dbo].[Nam] ([Nam]) VALUES (1980)
INSERT [dbo].[Nam] ([Nam]) VALUES (1981)
INSERT [dbo].[Nam] ([Nam]) VALUES (1982)
INSERT [dbo].[Nam] ([Nam]) VALUES (1983)
INSERT [dbo].[Nam] ([Nam]) VALUES (1984)
INSERT [dbo].[Nam] ([Nam]) VALUES (1985)
INSERT [dbo].[Nam] ([Nam]) VALUES (1986)
INSERT [dbo].[Nam] ([Nam]) VALUES (1987)
INSERT [dbo].[Nam] ([Nam]) VALUES (1988)
INSERT [dbo].[Nam] ([Nam]) VALUES (1989)
INSERT [dbo].[Nam] ([Nam]) VALUES (1990)
INSERT [dbo].[Nam] ([Nam]) VALUES (1991)
INSERT [dbo].[Nam] ([Nam]) VALUES (1992)
INSERT [dbo].[Nam] ([Nam]) VALUES (1993)
INSERT [dbo].[Nam] ([Nam]) VALUES (1994)
INSERT [dbo].[Nam] ([Nam]) VALUES (1995)
INSERT [dbo].[Nam] ([Nam]) VALUES (1996)
INSERT [dbo].[Nam] ([Nam]) VALUES (1997)
INSERT [dbo].[Nam] ([Nam]) VALUES (1998)
INSERT [dbo].[Nam] ([Nam]) VALUES (1999)
INSERT [dbo].[Nam] ([Nam]) VALUES (2000)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (1960)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (1964)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (1968)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (1972)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (1976)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (1980)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (1984)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (1988)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (1992)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (1996)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (2000)
INSERT [dbo].[NamNhuan] ([Nam]) VALUES (2004)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (1)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (2)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (3)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (4)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (5)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (6)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (7)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (8)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (9)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (10)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (11)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (12)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (13)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (14)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (15)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (16)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (17)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (18)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (19)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (20)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (21)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (23)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (24)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (25)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (26)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (27)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (28)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (29)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (30)
INSERT [dbo].[Ngay] ([Ngay]) VALUES (31)
INSERT [dbo].[NhaCungUng] ([MaCU], [TenNCU], [DiaChi], [DT]) VALUES (N'NCU01', N'FPT', N'1 Lê Lai', N'0123456789')
INSERT [dbo].[NhaCungUng] ([MaCU], [TenNCU], [DiaChi], [DT]) VALUES (N'NCU02', N'Phong Vu', N'aaaa', N'1234567890')
INSERT [dbo].[NhaCungUng] ([MaCU], [TenNCU], [DiaChi], [DT]) VALUES (N'NCU00', N'Thêm nhà cung ứng mới', N'', N'          ')
INSERT [dbo].[NhaSanXuat] ([MaSX], [TenSX], [DiaChi], [DT], [Email]) VALUES (N'SX01', N'Nokia', N'', 0, N'')
INSERT [dbo].[NhaSanXuat] ([MaSX], [TenSX], [DiaChi], [DT], [Email]) VALUES (N'SX02', N'HTC', N'', 0, N'')
INSERT [dbo].[NhaSanXuat] ([MaSX], [TenSX], [DiaChi], [DT], [Email]) VALUES (N'SX03', N'Samsung', N'', 0, N'')
INSERT [dbo].[NhaSanXuat] ([MaSX], [TenSX], [DiaChi], [DT], [Email]) VALUES (N'SX04', N'Apple', N'', 0, N'')
INSERT [dbo].[NhaSanXuat] ([MaSX], [TenSX], [DiaChi], [DT], [Email]) VALUES (N'SX06', N'Sony', N'', 0, N'')
INSERT [dbo].[NhaSanXuat] ([MaSX], [TenSX], [DiaChi], [DT], [Email]) VALUES (N'SX00', N'Chọn Hãng', NULL, NULL, NULL)
INSERT [dbo].[NhaSanXuat] ([MaSX], [TenSX], [DiaChi], [DT], [Email]) VALUES (N'SX05', N'LG', N'', 0, N'')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0001', N'SX02', N'HTC Desire S', 0, 9999000, CAST(N'2012-07-10' AS Date), 0, N'Data Image/Dese1rt.jpg', N'Phổ thông', NULL, N'5.0 MP (2592 x 1944 pixels)', N'VGA (0.3 Mpx)', N'HD 720p@30fps', N'DivX, H.263, H.264(MPEG4-AVC), MP4, WMV', N'AAC+, MP3, WAV, WMA', N'FM radio với RDS', N'Có', N'-', N'-', N'-', N'1.1 GB', N'768 MB', N'Qualcomm MSM8255 Snapdragon 1 GHz processor', N'MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'Up to 114 kbps', N'Wi-Fi 802.11 b/g/n, DLNA, Wi-Fi hotspot', N'Có', N'Micro USB', N'A-GPS', N'Android OS, v2.3 (Gingerbread)', N'Cảm ứng', N'-', N'115 x 59.8 x 11.6 mm', N'130', N'-', N'-', N' - Hệ điệu hành Android OS, v2.3 (Gingerbread)<br /> - CPU Qualcomm MSM8255 Snapdragon 1 GHz processor<br /> - RAM 768 MB<br /> - Bộ nhớ trong 1.1 GB<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0002', N'SX02', N'HTC Sensation', 0, 9899000, CAST(N'2012-08-10' AS Date), 0, N'Data Image/desireS_b.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'VGA (0.3 Mpx)', N'HD 720p@30fps', N'DivX, H.263, H.264(MPEG4-AVC), MP4, WMV', N'AAC+, MP3, WAV, WMA', N'FM radio với RDS', N'Có', N'-', N'-', N'Xem file văn bản', N'1 GB', N'768 MB', N'CPU 1.2 GHz dual-core', N'MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'Up to 114 kbps', N'Wi-Fi 802.11 b/g/n, DLNA, Wi-Fi hotspot', N'Có', N'Micro USB', N'A-GPS', N' Hệ điều hành Android 2.3', N'Cảm ứng', N'-', N'115 x 59.8 x 11.6 mm', N'130', N'-', N'-', N' - Hệ điệu hành Android OS, v2.3 (Gingerbread)<br /> - CPU Qualcomm MSM8255 Snapdragon 1 GHz processor<br /> - RAM 768 MB<br /> - Bộ nhớ trong 1.1 GB<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hệ điệu hành  Hệ điều hành Android 2.3<br /> - CPU CPU 1.2 GHz dual-core<br /> - RAM 768 MB<br /> - Bộ nhớ trong 1 GB<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Hỗ trợ tối đa thẻ 32 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0003', N'SX02', N'HTC One V', 0, 7498000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/dien-thoai-di-dong-htc-one-v-dienmay.com-l.jpg', N'Smart phone', NULL, N'5.0 MP (2592 x 1944 pixels)', N'-', N'HD 720p@24fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'-', N'-', N'Xem file văn bản, Mạng xã hội', N'4 GB', N'512 MB', N'Qualcomm MSM8255 Snapdragon 1 GHz processor', N'Thẻ nhớ ngoài MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 2100', N'-', N'Có', N'Wi-Fi 802.11 b/g/n, Wi-Fi hotspot', N'Có', N'Micro USB', N'A-GPS', N'Android 4.0', N'Thanh (thẳng) + Cảm ứng', N'Phím ảo', N'120.3 x 59.7 x 9.2 mm', N'115', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Android 4.0<br /> - CPU Qualcomm MSM8255 Snapdragon 1 GHz processor<br /> - RAM 512 MB<br /> - Thẻ nhớ ngoài Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 32 GB<br /> - Quay phim HD 720p@24fps<br /> - Bộ nhớ trong 4 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0004', N'SX02', N'HTC One V', 0, 7498000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/dien-thoai-di-dong-htc-one-v-dienmay.com-l.jpg', N'Smart phone', NULL, N'5.0 MP (2592 x 1944 pixels)', N'-', N'HD 720p@24fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'-', N'-', N'Xem file văn bản, Mạng xã hội', N'4 GB', N'512 MB', N'Qualcomm MSM8255 Snapdragon 1 GHz processor', N'Thẻ nhớ ngoài MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 2100', N'-', N'Có', N'Wi-Fi 802.11 b/g/n, Wi-Fi hotspot', N'Có', N'Micro USB', N'A-GPS', N'Android 4.0', N'Thanh (thẳng) + Cảm ứng', N'Phím ảo', N'120.3 x 59.7 x 9.2 mm', N'115', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Android 4.0<br /> - CPU Qualcomm MSM8255 Snapdragon 1 GHz processor<br /> - RAM 512 MB<br /> - Thẻ nhớ ngoài Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 32 GB<br /> - Quay phim HD 720p@24fps<br /> - Bộ nhớ trong 4 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0005', N'SX02', N'HTC Desire V', 0, 8599000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/HTC-Desire-V-l.jpg', N'Smart phone', NULL, N'5.0 MP (2592 x 1944 pixels)', N'-', N'HD 720p@24fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'-', N'-', N'Xem file văn bản, Mạng xã hội', N'4 GB', N'512 MB', N'Qualcomm MSM7227A 1 GHz Processor', N'Thẻ nhớ ngoài MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 2100', N'-', N'Có', N'Wi-Fi 802.11 b/g/n, Wi-Fi hotspot', N'Có', N'Micro USB', N'A-GPS', N'Android 4.0', N'Thanh (thẳng) + Cảm ứng', N'Phím ảo', N'120.3 x 59.7 x 9.2 mm', N'115', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Android 4.0<br /> - CPU Qualcomm MSM7227A 1 GHz Processor<br /> - RAM 512 MB<br /> - Thẻ nhớ ngoài Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 32 GB<br /> - Quay phim HD 720p@24fps<br /> - Bộ nhớ trong 4 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0006', N'SX02', N'HTC Wildfire S', 0, 4998000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/HTC-Desire-V-l.jpg', N'Smart phone', NULL, N'5.0 MP (2592 x 1944 pixels)', N'-', N'HD 720p@24fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'-', N'-', N'Xem file văn bản, Mạng xã hội', N'512 MB', N'512 MB', N'CPU Qualcomm MSM 7227 600 MHz', N'Thẻ nhớ ngoài MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 2100', N'-', N'Có', N'Wi-Fi 802.11 b/g/n, Wi-Fi hotspot', N'Có', N'Micro USB', N'A-GPS', N'Android 2.3', N'Thanh (thẳng) + Cảm ứng', N'Phím ảo', N'120.3 x 59.7 x 9.2 mm', N'115', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Android 2.3<br /> - CPU CPU Qualcomm MSM 7227 600 MHz<br /> - RAM 512 MB<br /> - Thẻ nhớ ngoài Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 32 GB<br /> - Quay phim HD 720p@24fps<br /> - Bộ nhớ trong 512 MB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0007', N'SX02', N'HTC Rhyme', 0, 10989000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/dien-thoai-di-dong-HTC-Rhymedock-dienmay.com-l.jpg', N'Smart phone', NULL, N'5.0 MP (2592 x 1944 pixels)', N'-', N'HD 720p@24fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'-', N'-', N'Xem file văn bản, Mạng xã hội', N'768 MB', N'512 MB', N'Qualcomm MSM8255 Snapdragon, 1 GHz Scorpion', N'Thẻ nhớ ngoài MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 2100', N'-', N'Có', N'Wi-Fi 802.11 b/g/n, Wi-Fi hotspot', N'Có', N'Micro USB', N'A-GPS', N'Android 2.3.4 (Gingerbread)', N'Thanh (thẳng) + Cảm ứng', N'Phím ảo', N'120.3 x 59.7 x 9.2 mm', N'115', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Android 2.3.4 (Gingerbread)<br /> - CPU Qualcomm MSM8255 Snapdragon, 1 GHz Scorpion<br /> - RAM 512 MB<br /> - Thẻ nhớ ngoài Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 32 GB<br /> - Quay phim HD 720p@24fps<br /> - Bộ nhớ trong 768 MB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0008', N'SX02', N'HTC HD7', 0, 9889000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/htc-hd7_b.jpg', N'Smart phone', NULL, N'5.0 MP (2592 x 1944 pixels)', N'-', N'HD 720p@24fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'-', N'-', N'Xem file văn bản, Mạng xã hội', N'8 GB', N'576 MB', N'CPU Qualcomm Snapdragon QSD8250 1 GHz', N'Thẻ nhớ ngoài MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 2100', N'-', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'Wi-Fi 802.11 b/g/n', N'Có', N'Micro USB', N'A-GPS', N'Microsoft Windows Phone 7', N'Thanh (thẳng) + Cảm ứng', N'Phím ảo', N'120.3 x 59.7 x 9.2 mm', N'115', N'Tiếng Anh', N'-', N' - Hệ điệu hành Microsoft Windows Phone 7<br /> - CPU CPU Qualcomm Snapdragon QSD8250 1 GHz<br /> - RAM 576 MB<br /> - Thẻ nhớ ngoài Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 32 GB<br /> - Quay phim HD 720p@24fps<br /> - Bộ nhớ trong 8 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0012', N'SX01', N'Nokia N9 16GB', 0, 8999000, CAST(N'2012-07-24' AS Date), 0, N'Data Image/dien-thoai-di-dong-nokia-N9-00-dienmay.com-den-b.jpg', N'Smart phone', NULL, N'8.0 MP với ống kính Carl Zeiss ', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'-', N'Có', N'Có', N'-', N'Xem file văn bản,  Soạn thảo văn bản', N'16 GB', N'1GB', N'ARM Cortex A8 1GHz processor', N'-', N'-', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 2100', N'-', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP, EDR', N'Micro USB', N'A-GPS', N'MeeGo 1.2 Harmattan ', N'Thanh (thẳng) + Cảm ứng', N'Phím ảo', N'127.8 x 68.5 x 11.5 mm', N'115', N'Tiếng Anh', N'-', N' - Hệ điệu hành MeeGo 1.2 Harmattan <br /> - CPU ARM Cortex A8 1GHz processor<br /> - RAM 1GB<br /> - Thẻ nhớ ngoài <br /> - Hỗ trợ tối đa thẻ <br /> - Quay phim FullHD 1080p@30fps<br /> - Bộ nhớ trong 16 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0013', N'SX01', N'Nokia Asha 306', 0, 1999000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/Nokia-Asha-306-l.jpg', N'Phổ thông', NULL, N'2.0 MP (1600x1200 pixels)', N'-', N'Có', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có', N'Có', N'-', N'64 MB', N'32 MB', N'-', N'MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'-', N'-', N'Có', N'Hỗ trợ Wifi tốc độ cao Wi-Fi 802.11 b/g', N'Có, V2.1 với A2DP, EDR', N'Micro USB', N'-', N'-', N'Thanh (thẳng) + Cảm ứng', N'Phím ảo', N'127.8 x 68.5 x 11.5 mm', N'115', N'Tiếng Anh, Tiếng Việt', N'-', N' - WiFi Hỗ trợ Wifi tốc độ cao Wi-Fi 802.11 b/g<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 32 GB<br /> - Máy ảnh 2.0 MP (1600x1200 pixels)<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br /> - FM radio FM radio với RDS<br /> - Bộ nhớ trong 64 MB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0019', N'SX01', N'Nokia Asha 202', 0, 1899000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/dien-thoai-di-dong-Nokia-asha202-dienmay.com-l.jpg', N'Phổ thông', NULL, N'Máy ảnh 1.3 MP (1280 x 1024 pixels) ', N'-', N'-', N'MP4', N'MP3', N'Đài FM tích hợp sẵn ', N'-', N'-', N'-', N'Xem file văn bản ', N'10 MB', N'-', N'-', N'MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'-', N'2 Sim 2 sóng', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'-', N'Có, V3.0 với A2DP', N' 	Micro USB', N'-', N'-', N'Dạng thanh kết hợp với màn hình cảm ứng', N'-', N'102 x 55 x 12 mm', N'100', N'Tiếng Việt, Tiếng Anh', N'-', N' - Kiểu dáng Dạng thanh kết hợp với màn hình cảm ứng<br /> - Đa sim 2 Sim 2 sóng<br /> - Máy ảnh Máy ảnh 1.3 MP (1280 x 1024 pixels) <br /> - FM radio Đài FM tích hợp sẵn <br /> - Nghe nhạc MP3<br /> - Xem phim MP4<br /> - GPRS Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps<br /> - Ứng dụng khác Xem file văn bản <br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 32 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0010', N'SX01', N'Lumia 900', 0, 12249000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/dien-thoai-di-dong-nokia-lumina808pureview-dienmay.com-l.jpg', N'Smart phone', NULL, N'41 MP (7152 x 5368 pixels)', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có', N'-', N'Xem file văn bản,  Soạn thảo văn bản', N'16 GB', N'512 MB', N'ARM 11 1.3 GHz Processor', N'Có', N'32 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 2100', N'-', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'Wi-Fi 802.11 b/g/n', N'Chỉ kết nối với tai nghe bluetooth', N'Micro USB', N'A-GPS', N'Symbian Belle OS', N'Thanh (thẳng) + Cảm ứng', N'Phím ảo', N'127.8 x 68.5 x 11.5 mm', N'115', N'Tiếng Anh', N'-', N' - Hệ điệu hành Symbian Belle OS<br /> - CPU ARM 11 1.3 GHz Processor<br /> - RAM 512 MB<br /> - Thẻ nhớ ngoài Có<br /> - Hỗ trợ tối đa thẻ 32 GB<br /> - Quay phim FullHD 1080p@30fps<br /> - Bộ nhớ trong 16 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0011', N'SX01', N'Nokia Lumia 800', 0, 10599000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/dien-thoai-di-dong-Nokia-lumia-800-dienmay.com-b.jpg', N'Smart phone', NULL, N'41 MP (7152 x 5368 pixels)', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có', N'-', N'Xem file văn bản,  Soạn thảo văn bản', N'16 GB', N'512 MB', N'1.4 GHz processor', N'-', N'-', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 2100', N'-', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'Wi-Fi 802.11 b/g/n', N'Chỉ kết nối với tai nghe bluetooth', N'Micro USB', N'A-GPS', N'Microsoft Windows Phone 7.5 Mango', N'Thanh (thẳng) + Cảm ứng', N'Phím ảo', N'127.8 x 68.5 x 11.5 mm', N'115', N'Tiếng Anh', N'-', N' - Hệ điệu hành Microsoft Windows Phone 7.5 Mango<br /> - CPU 1.4 GHz processor<br /> - RAM 512 MB<br /> - Thẻ nhớ ngoài <br /> - Hỗ trợ tối đa thẻ <br /> - Quay phim FullHD 1080p@30fps<br /> - Bộ nhớ trong 16 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0029', N'SX06', N'XPERIA Arc LT15i', 9000000, 9981000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/sony_arc_b.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'-', N'HD 720p@25fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy', N'MIDP 3.0', N'Xem file văn bản', N'320 MB', N'512 MB', N'CPU Qualcomm MSM8255 Snapdragon 1 GHz', N'MicroSD (T-Flash)', N'32 GB ', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'Micro USB', N'A-GPS', N'Android 2.3', N'Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Android 2.3<br /> - CPU CPU Qualcomm MSM8255 Snapdragon 1 GHz<br /> - RAM 512 MB<br /> - Bộ nhớ trong 320 MB<br /> - Hỗ trợ tối đa thẻ 32 GB <br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Quay phim HD 720p@25fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0028', N'SX05', N'LG A290', 1000000, 1249000, CAST(N'2012-07-24' AS Date), 22, N'Data Image/LG-A290-l.jpg', N'Phổ thông', NULL, N'1.3 MP (1280 x 1024 pixels)', N'-', N'-', N'MP4', N'MP3', N'Đài FM tích hợp sẵn ', N'Có', N'Adobe Flash 3.0', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'19 MB', N'-', N'-', N'MicroSD (T-Flash)', N'4 GB', N'GSM 850/900/1800/1900', N'-', N'3 Sim 3 Sóng ', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'-', N'Có, V3.0 với A2DP', N'Micro USB', N'-', N'-', N'Thanh (thẳng)', N'Phím số', N'102 x 55 x 12 mm', N'100', N'Tiếng Việt, Tiếng Anh', N'-', N' - Kiểu dáng Thanh (thẳng)<br /> - Đa sim 3 Sim 3 Sóng <br /> - Máy ảnh 1.3 MP (1280 x 1024 pixels)<br /> - FM radio Đài FM tích hợp sẵn <br /> - Nghe nhạc MP3<br /> - Xem phim MP4<br /> - GPRS Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps<br /> - Ứng dụng khác Hỗ trợ mạng xã hội<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 4 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0014', N'SX01', N'Nokia C2-03', 0, 1799000, CAST(N'2012-07-24' AS Date), 0, N'Data Image/dien-thoai-di-dong-nokia-c2-03-dienmay.com-b.jpg', N'Phổ thông', NULL, N'2.0 MP (1600x1200 pixels)', N'-', N'Có', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy, có thể cài thêm', N'MIDP 2.1', N'Dễ dàng thay đổi Sim với khe cắm bên ngoài', N'10 MB', N'32 MB', N'-', N'MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'-', N'2 Sim 2 Sóng online ', N'Có', N'Hỗ trợ Wifi tốc độ cao Wi-Fi 802.11 b/g', N'Có, V2.1 với A2DP, EDR', N'Micro USB', N'-', N'-', N'Trượt', N'Phím số', N'127.8 x 68.5 x 11.5 mm', N'115', N'Tiếng Anh, Tiếng Việt', N'-', N' - WiFi Hỗ trợ Wifi tốc độ cao Wi-Fi 802.11 b/g<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 32 GB<br /> - Máy ảnh 2.0 MP (1600x1200 pixels)<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br /> - FM radio FM radio với RDS<br /> - Bộ nhớ trong 10 MB<br /> - Đa sim 2 Sim 2 Sóng online <br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0017', N'SX01', N'Nokia C2-01', 0, 1789000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/nokia_C2-01_b.jpg', N'Phổ thông', NULL, N'3.2 MP (2048 x 1536 pixels)', N'-', N'QVGA@15fp', N'3GP, MP4', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy, có thể cài thêm', N'MIDP 2.1', N'Flash Lite v3.0', N'43 MB', N'-', N'-', N'MicroSD (T-Flash)', N'16 GB', N'GSM 850/900/1800/1900', N'UMTS 384 Kbps', N'-', N'Có', N'-', N'Có, V2.1 với A2DP, EDR', N'Micro USB', N'-', N'-', N'Thanh (thẳng)', N'Phím số', N'127.8 x 68.5 x 11.5 mm', N'115', N'Tiếng Anh, Tiếng Việt', N'-', N' - Máy ảnh 3.2 MP (2048 x 1536 pixels)<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 16 GB<br /> - Băng tần 3G UMTS 384 Kbps<br /> - Bộ nhớ trong 43 MB<br /> - Quay phim QVGA@15fp<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0016', N'SX01', N'Asha 305', 0, 1899000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/Nokia-Asha-305-l.jpg', N'Phổ thông', NULL, N'2.0 MP (1600x1200 pixels)', N'-', N'Có', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy, có thể cài thêm', N'MIDP 2.1', N'Dễ dàng thay đổi Sim với khe cắm bên ngoài', N'10 MB', N'32 MB', N'-', N'MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'-', N'2 Sim 2 Sóng online ', N'Có', N'Hỗ trợ Wifi tốc độ cao Wi-Fi 802.11 b/g', N'Có, V2.1 với A2DP, EDR', N'Micro USB', N'-', N'-', N'Trượt', N'Phím số', N'127.8 x 68.5 x 11.5 mm', N'115', N'Tiếng Anh, Tiếng Việt', N'-', N' - WiFi Hỗ trợ Wifi tốc độ cao Wi-Fi 802.11 b/g<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 32 GB<br /> - Máy ảnh 2.0 MP (1600x1200 pixels)<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br /> - FM radio FM radio với RDS<br /> - Bộ nhớ trong 10 MB<br /> - Đa sim 2 Sim 2 Sóng online <br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0018', N'SX03', N'Samsung C3312', 1500000, 1749000, CAST(N'2012-08-24' AS Date), 20, N'Data Image/dien-thoai-did-dong-samsung-c3312-dienmay.com-l.jpg', N'Phổ thông', NULL, N'Máy ảnh 1.3 MP (1280 x 1024 pixels) ', N'-', N'-', N'MP4', N'MP3', N'Đài FM tích hợp sẵn ', N'-', N'-', N'-', N'Xem file văn bản ', N'10 MB', N'-', N'-', N'MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'-', N'2 Sim 2 sóng', N'Có', N'-', N'Có, V3.0 với A2DP', N' 	Micro USB', N'-', N'-', N'Dạng thanh cảm ứng thời trang ', N'-', N'102 x 55 x 12 mm', N'100', N'Tiếng Việt, Tiếng Anh', N'-', N' - Kiểu dáng Dạng thanh cảm ứng thời trang <br /> - Đa sim 2 Sim 2 sóng<br /> - Máy ảnh Máy ảnh 1.3 MP (1280 x 1024 pixels) <br /> - FM radio Đài FM tích hợp sẵn <br /> - Nghe nhạc MP3<br /> - Xem phim MP4<br /> - GPRS Có<br /> - Ứng dụng khác Xem file văn bản <br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0020', N'SX05', N'LG T500', 1300000, 1689000, CAST(N'2012-08-24' AS Date), 15, N'Data Image/dien-thoai-di-dong-LG-Ego-T500-dienmay.com-den-b.jpg', N'Phổ thông', NULL, N'2.0 MP (1600x1200 pixels)', N'-', N'-', N'MP4', N'MP3', N'Đài FM tích hợp sẵn ', N'-', N'-', N'-', N'Hỗ trợ mạng xã hội', N'50 MB', N'-', N'-', N'MicroSD (T-Flash)', N'4 GB', N'GSM 850/900/1800/1900', N'-', N'2 Sim 2 sóng', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'-', N'Có, V3.0 với A2DP', N' 	Micro USB', N'-', N'-', N'Thanh (thẳng) + Cảm ứng', N'-', N'102 x 55 x 12 mm', N'100', N'Tiếng Việt, Tiếng Anh', N'-', N' - Kiểu dáng Thanh (thẳng) + Cảm ứng<br /> - Đa sim 2 Sim 2 sóng<br /> - Máy ảnh 2.0 MP (1600x1200 pixels)<br /> - FM radio Đài FM tích hợp sẵn <br /> - Nghe nhạc MP3<br /> - Xem phim MP4<br /> - GPRS Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps<br /> - Ứng dụng khác Hỗ trợ mạng xã hội<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 4 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0022', N'SX05', N'LG S365', 1300000, 1679000, CAST(N'2012-08-24' AS Date), 15, N'Data Image/dien-thoai-di-dong-LG-S365-dienmay.com-b.jpg', N'Phổ thông', NULL, N'2.0 MP (1600x1200 pixels)', N'-', N'-', N'MP4', N'MP3', N'Đài FM tích hợp sẵn ', N'-', N'Có', N'Có', N'Hỗ trợ mạng xã hội', N'10 MB', N'-', N'-', N'MicroSD (T-Flash)', N'4 GB', N'GSM 850/900/1800/1900', N'-', N'2 Sim 2 sóng', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'-', N'Có, V3.0 với A2DP', N' 	Micro USB', N'-', N'-', N'Thanh (thẳng) + Cảm ứng', N'-', N'102 x 55 x 12 mm', N'100', N'Tiếng Việt, Tiếng Anh', N'-', N' - Kiểu dáng Thanh (thẳng) + Cảm ứng<br /> - Đa sim 2 Sim 2 sóng<br /> - Máy ảnh 2.0 MP (1600x1200 pixels)<br /> - FM radio Đài FM tích hợp sẵn <br /> - Nghe nhạc MP3<br /> - Xem phim MP4<br /> - GPRS Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps<br /> - Ứng dụng khác Hỗ trợ mạng xã hội<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 4 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0023', N'SX01', N'Nokia X2-01', 0, 1669000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/Nokia_X2-01_b.jpg', N'Phổ thông', NULL, N'VGA (480 x 640 pixcels)', N'-', N'-', N'MP4', N'MP3', N'Đài FM tích hợp sẵn ', N'-', N'Adobe Flash 3.0', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'50 MB', N'-', N'-', N'MicroSD (T-Flash)', N'8 GB', N'GSM 850/900/1800/1900', N'-', N'2 Sim 2 sóng', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'-', N'Có, V3.0 với A2DP', N'Micro USB', N'-', N'-', N'Thiết kế mạnh mẽ với bàn phím Qwerty', N'Bàn phím Qwerty', N'102 x 55 x 12 mm', N'100', N'Tiếng Việt, Tiếng Anh', N'-', N' - Kiểu dáng Thiết kế mạnh mẽ với bàn phím Qwerty<br /> - Đa sim 2 Sim 2 sóng<br /> - Máy ảnh VGA (480 x 640 pixcels)<br /> - FM radio Đài FM tích hợp sẵn <br /> - Nghe nhạc MP3<br /> - Xem phim MP4<br /> - GPRS Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps<br /> - Ứng dụng khác Hỗ trợ mạng xã hội<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 8 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0024', N'SX01', N'Nokia X2-02', 0, 1649000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/Nokia-X2-02-l.jpg', N'Phổ thông', NULL, N'2.0 MP (1600x1200 pixels)', N'-', N'-', N'MP4', N'MP3', N'Đài FM tích hợp sẵn ', N'-', N'Adobe Flash 3.0', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'10 MB', N'-', N'-', N'MicroSD (T-Flash)', N'32 GB', N'GSM 850/900/1800/1900', N'-', N'2 Sim 2 sóng', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'-', N'Có, V3.0 với A2DP', N'Micro USB', N'-', N'-', N'Thanh (thẳng)', N'Bàn phím Qwerty', N'102 x 55 x 12 mm', N'100', N'Tiếng Việt, Tiếng Anh', N'-', N' - Kiểu dáng Thanh (thẳng)<br /> - Đa sim 2 Sim 2 sóng<br /> - Máy ảnh 2.0 MP (1600x1200 pixels)<br /> - FM radio Đài FM tích hợp sẵn <br /> - Nghe nhạc MP3<br /> - Xem phim MP4<br /> - GPRS Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps<br /> - Ứng dụng khác Hỗ trợ mạng xã hội<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 32 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0025', N'SX03', N'Samsung C3520', 1100000, 1486000, CAST(N'2012-08-24' AS Date), 20, N'Data Image/Samsung-C3520-l.jpg', N'Phổ thông', NULL, N'1.3 MP (1280 x 1024 pixels)', N'-', N'-', N'MP4', N'MP3', N'Đài FM tích hợp sẵn ', N'-', N'Adobe Flash 3.0', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'28 MB', N'-', N'-', N'MicroSD (T-Flash)', N'16 GB', N'GSM 850/900/1800/1900', N'-', N'-', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'-', N'Có, V3.0 với A2DP', N'Micro USB', N'-', N'-', N'Gập', N'Phím số', N'102 x 55 x 12 mm', N'100', N'Tiếng Việt, Tiếng Anh', N'-', N' - Kiểu dáng Gập<br /> - Đa sim <br /> - Máy ảnh 1.3 MP (1280 x 1024 pixels)<br /> - FM radio Đài FM tích hợp sẵn <br /> - Nghe nhạc MP3<br /> - Xem phim MP4<br /> - GPRS Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps<br /> - Ứng dụng khác Hỗ trợ mạng xã hội<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 16 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0026', N'SX01', N'Nokia 112', 0, 1486000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/Nokia-112-l.jpg', N'Phổ thông', NULL, N'VGA (480 x 640 pixcels)', N'-', N'-', N'MP4', N'MP3', N'Đài FM tích hợp sẵn ', N'Có', N'Adobe Flash 3.0', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'16 MB', N'-', N'-', N'MicroSD (T-Flash)', N'16 GB', N'GSM 850/900/1800/1900', N'-', N'2 Sim 2 sóng ', N'Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps', N'-', N'Có, V3.0 với A2DP', N'Micro USB', N'-', N'-', N'Thanh (thẳng)', N'Phím số', N'102 x 55 x 12 mm', N'100', N'Tiếng Việt, Tiếng Anh', N'-', N' - Kiểu dáng Thanh (thẳng)<br /> - Đa sim 2 Sim 2 sóng <br /> - Máy ảnh VGA (480 x 640 pixcels)<br /> - FM radio Đài FM tích hợp sẵn <br /> - Nghe nhạc MP3<br /> - Xem phim MP4<br /> - GPRS Class 12 (4+1/3+2/2+3/1+4 slots), 32 - 48 kbps<br /> - Ứng dụng khác Hỗ trợ mạng xã hội<br /> - Thẻ nhớ ngoài MicroSD (T-Flash)<br /> - Hỗ trợ tối đa thẻ 16 GB<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0030', N'SX06', N'Galaxy S Advance I9070', 9800000, 9597000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/dien-thoai-di-dong-samsung-I9070GalaxySAdvance-dienmay.com-l.jpg', N'Smart phone', NULL, N'5.0 MP (2592 x 1944 pixels)', N'-', N'HD 720p@25fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy', N'MIDP 3.0', N'Xem file văn bản', N'8 GB', N'768 MB', N'Dual-core 1 GHz Cortex-A9', N'MicroSD (T-Flash)', N'32 GB ', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'Micro USB', N'A-GPS', N'Android 2.3.6 (Gingerbread)', N'Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Android 2.3.6 (Gingerbread)<br /> - CPU Dual-core 1 GHz Cortex-A9<br /> - RAM 768 MB<br /> - Bộ nhớ trong 8 GB<br /> - Hỗ trợ tối đa thẻ 32 GB <br /> - Máy ảnh 5.0 MP (2592 x 1944 pixels)<br /> - Quay phim HD 720p@25fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0031', N'SX06', N'Xperia arc S LT18i', 9400000, 9150000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/dien-thoai-di-dong-Sony-Ericsson-Xperia-Arc-Si-dienmay.com-b.jpg', N'Smart phone', NULL, N'8.1 MP', N'-', N'HD 720p@25fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy', N'MIDP 3.0', N'Xem file văn bản', N'1 GB', N'512 MB', N'Qualcomm MSM8255T Snapdragon 1.4 GHz Scorpion', N'MicroSD (T-Flash)', N'32 GB ', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'Micro USB', N'A-GPS', N'Android 2.3.4 (Gingerbread)', N'Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Android 2.3.4 (Gingerbread)<br /> - CPU Qualcomm MSM8255T Snapdragon 1.4 GHz Scorpion<br /> - RAM 512 MB<br /> - Bộ nhớ trong 1 GB<br /> - Hỗ trợ tối đa thẻ 32 GB <br /> - Máy ảnh 8.1 MP<br /> - Quay phim HD 720p@25fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0032', N'SX06', N'Sony Ericsson LT22i', 8300000, 8990000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/dien-thoai-di-dong-sony-xperia-p-dienmay.com-l.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'-', N'HD 720p@25fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy', N'MIDP 3.0', N'Xem file văn bản', N'16 GB', N'1GB', N'Dual-core 1 GHz Cortex-A9', N'MicroSD (T-Flash)', N'32 GB ', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'Micro USB', N'A-GPS', N'Android 2.3.4 (Gingerbread)', N'Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Android 2.3.4 (Gingerbread)<br /> - CPU Dual-core 1 GHz Cortex-A9<br /> - RAM 1GB<br /> - Bộ nhớ trong 16 GB<br /> - Hỗ trợ tối đa thẻ 32 GB <br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Quay phim HD 720p@25fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0033', N'SX05', N'LG Optimus L7 P705', 7000000, 7449000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/LG-Optimus-L7-P700-l.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'-', N'HD 720p@25fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy', N'MIDP 3.0', N'Xem file văn bản', N'4 GB', N'512 MB', N'Qualcomm MSM7227A Snapdragon, 1 GHz Cortex-A5', N'MicroSD (T-Flash)', N'32 GB ', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'Micro USB', N'A-GPS', N'Android 4.0', N'Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Android 4.0<br /> - CPU Qualcomm MSM7227A Snapdragon, 1 GHz Cortex-A5<br /> - RAM 512 MB<br /> - Bộ nhớ trong 4 GB<br /> - Hỗ trợ tối đa thẻ 32 GB <br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Quay phim HD 720p@25fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0037', N'SX01', N'Nokia 700', 0, 5999000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/dien-thoai-di-dong-nokia-700--dienmay.com-l.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'-', N'HD 720p@25fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy', N'MIDP 3.0', N'Xem file văn bản', N'2 GB', N'512 MB', N'1GHz processor', N'MicroSD (T-Flash)', N'32 GB ', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'Micro USB', N'A-GPS', N'Symbian Belle', N'Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Symbian Belle<br /> - CPU 1GHz processor<br /> - RAM 512 MB<br /> - Bộ nhớ trong 2 GB<br /> - Hỗ trợ tối đa thẻ 32 GB <br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Quay phim HD 720p@25fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0034', N'SX06', N'Xperia active ST17i', 6500000, 6990000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/dien-thoai-di-dong-sonyericsson-active-dienmay.com-l.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'-', N'HD 720p@25fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy', N'MIDP 3.0', N'Xem file văn bản', N'4 GB', N'512 MB', N'Qualcomm MSM7227A Snapdragon, 1 GHz Cortex-A5', N'MicroSD (T-Flash)', N'32 GB ', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'Micro USB', N'A-GPS', N'Hệ điều hành Android 2.3', N'Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Hệ điều hành Android 2.3<br /> - CPU Qualcomm MSM7227A Snapdragon, 1 GHz Cortex-A5<br /> - RAM 512 MB<br /> - Bộ nhớ trong 4 GB<br /> - Hỗ trợ tối đa thẻ 32 GB <br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Quay phim HD 720p@25fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0035', N'SX03', N'Galaxy Ace 2 I8160', 6500000, 6898000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/dien-thoai-di-dong-samsung-GalaxyAce2-dienmay.com-l.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'-', N'HD 720p@25fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy', N'MIDP 3.0', N'Xem file văn bản', N'4 GB', N'512 MB', N'Qualcomm MSM7227A Snapdragon, 1 GHz Cortex-A5', N'MicroSD (T-Flash)', N'32 GB ', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'Micro USB', N'A-GPS', N'Hệ điều hành Android 2.3', N'Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Hệ điều hành Android 2.3<br /> - CPU Qualcomm MSM7227A Snapdragon, 1 GHz Cortex-A5<br /> - RAM 512 MB<br /> - Bộ nhớ trong 4 GB<br /> - Hỗ trợ tối đa thẻ 32 GB <br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Quay phim HD 720p@25fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0036', N'SX01', N'Nokia Lumia 710', 0, 6299000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/dien-thoai-di-dong-Nokia-lumia-710-dienmay.com-b.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'-', N'HD 720p@25fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy', N'MIDP 3.0', N'Xem file văn bản', N'8 GB', N'512 MB', N'Qualcomm MSM8255T Snapdragon 1.4 GHz', N'MicroSD (T-Flash)', N'32 GB ', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'Micro USB', N'A-GPS', N'Microsoft Windows Phone 7.5 Mango', N'Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Microsoft Windows Phone 7.5 Mango<br /> - CPU Qualcomm MSM8255T Snapdragon 1.4 GHz<br /> - RAM 512 MB<br /> - Bộ nhớ trong 8 GB<br /> - Hỗ trợ tối đa thẻ 32 GB <br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Quay phim HD 720p@25fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0038', N'SX03', N'Samsung S5830 Ace', 5000000, 5789000, CAST(N'2012-08-24' AS Date), 12, N'Data Image/dien-thoai-di-dong-samsung-galaxy-ace-s5830-dienmay.com-l.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'-', N'HD 720p@25fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Cài đặt sẵn trong máy', N'MIDP 3.0', N'Xem file văn bản', N'160 GB', N'512 MB', N'QCT MSM7227-1 Turbo 800 MHz', N'MicroSD (T-Flash)', N'32 GB ', N'GSM 850/900/1800/1900', N'HSDPA 900/2100', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'Micro USB', N'A-GPS', N'Andoird 2.2 Froyo', N'Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Andoird 2.2 Froyo<br /> - CPU QCT MSM7227-1 Turbo 800 MHz<br /> - RAM 512 MB<br /> - Bộ nhớ trong 160 GB<br /> - Hỗ trợ tối đa thẻ 32 GB <br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Quay phim HD 720p@25fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0053', N'SX07', N'aaaaa', 0, 12121, CAST(N'2012-08-25' AS Date), 0, N'Data Image/none.png', N'Phổ thông', NULL, N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0039', N'SX04', N'iPhone 4S 32GB', 19000000, 19998000, CAST(N'2012-08-24' AS Date), 9, N'Data Image/dien-thoai-di-dong-iphone-4s-dienmay.com-l.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'-', N'Xem file văn bản', N'32 GB', N'-', N'ARM Cortex A9 1GHz dual-core processor', N'MicroSD (T-Flash)', N'-', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'iOS 5 ', N'Thanh (thẳng) + Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành iOS 5 <br /> - CPU ARM Cortex A9 1GHz dual-core processor<br /> - RAM <br /> - Bộ nhớ trong 32 GB<br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Ứng dụng khác Xem file văn bản<br /> - Quay phim FullHD 1080p@30fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0040', N'SX04', N'iPhone 4S 16GB', 10000000, 17693000, CAST(N'2012-08-24' AS Date), 0, N'Data Image/dien-thoai-di-dong-apple-iphone-4S-dienmay.com-b.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'-', N'Xem file văn bản', N'16 GB', N'-', N'ARM Cortex A9 1GHz dual-core processor', N'MicroSD (T-Flash)', N'-', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'iOS 5 ', N'Thanh (thẳng) + Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành iOS 5 <br /> - CPU ARM Cortex A9 1GHz dual-core processor<br /> - RAM <br /> - Bộ nhớ trong 16 GB<br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Ứng dụng khác Xem file văn bản<br /> - Quay phim FullHD 1080p@30fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0041', N'SX04', N'iPhone 3GS 8GB', 6300000, 7000000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/iphone_3GS_b.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'-', N'Xem file văn bản', N'8 GB', N'256 MB', N'ARM Cortex A8 600 MHz', N'MicroSD (T-Flash)', N'-', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'iOS 5 ', N'Thanh (thẳng) + Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành iOS 5 <br /> - CPU ARM Cortex A8 600 MHz<br /> - RAM 256 MB<br /> - Bộ nhớ trong 8 GB<br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Ứng dụng khác Xem file văn bản<br /> - Quay phim FullHD 1080p@30fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0052', N'SX04', N'aaaa', 0, 0, NULL, 0, N'Data Image/none.png', NULL, NULL, N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', N'-', NULL)
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0048', N'SX06', N'Sony Ericsson W20i Zylo', 2500000, 2950000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/SE_zylo_b.jpg', N'Phổ thông', NULL, N'Máy ảnh 3.2 MP', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'1GB', N'128 MB', N'ARM 11 450 MHz processor', N'MicroSD (T-Flash)', N'16 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'-', N'Thanh (thẳng) + Cảm ứng', N'Qwerty sành điệu ', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Máy ảnh Máy ảnh 3.2 MP<br /> - Quay phim FullHD 1080p@30fps<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br /> - FM radio FM radio với RDS<br /> - Hỗ trợ tối đa thẻ 16 GB<br /> - Bộ nhớ trong 1GB<br /> - Xem phim H.263, H.264(MPEG4-AVC), MP4, WMV<br /> - Hệ điệu hành <br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0043', N'SX05', N'LG Optimus Net P698', 3500000, 3999000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/dien-thoai-di-dong-LG-Optimus-Net-P698-dienmay.com-l.jpg', N'Smart phone', NULL, N'8.0 MP (3264x2448 pixels)', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'-', N'Hỗ trợ mạng xã hội', N'8 GB', N'512 MB', N'Qualcomm MSM7227T 800 MHz ARM v6', N'MicroSD (T-Flash)', N'-', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'Android 2.3.4 (Gingerbread)', N'Thanh (thẳng) + Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Hệ điệu hành Android 2.3.4 (Gingerbread)<br /> - CPU Qualcomm MSM7227T 800 MHz ARM v6<br /> - RAM 512 MB<br /> - Bộ nhớ trong 8 GB<br /> - Máy ảnh 8.0 MP (3264x2448 pixels)<br /> - Ứng dụng khác Hỗ trợ mạng xã hội<br /> - Quay phim FullHD 1080p@30fps<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0044', N'SX01', N'Nokia X3-02.5', 3000000, 3499000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/dien-thoai-di-dong-Nokia-X3-02.5-dienmay.com-metal-b.jpg', N'Phổ thông', NULL, N'5.0 MP (2592 x 1944 pixels)', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'140 MB', N'128 MB', N'-', N'MicroSD (T-Flash)', N'16 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'-', N'Thanh (thẳng) + Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Máy ảnh 5.0 MP (2592 x 1944 pixels)<br /> - Quay phim FullHD 1080p@30fps<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br /> - FM radio FM radio với RDS<br /> - Hỗ trợ tối đa thẻ 16 GB<br /> - Bộ nhớ trong 140 MB<br /> - Xem phim H.263, H.264(MPEG4-AVC), MP4, WMV<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0045', N'SX05', N'LG Optimus L3 E405', 2000000, 3489000, CAST(N'2012-08-24' AS Date), 19, N'Data Image/LG-Optimus-L3-E405-l.jpg', N'Phổ thông', NULL, N'5.0 MP (2592 x 1944 pixels)', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'1GB', N'128 MB', N'-', N'MicroSD (T-Flash)', N'16 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'Android 2.3.6 (Gingerbread)', N'Thanh (thẳng) + Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Máy ảnh 5.0 MP (2592 x 1944 pixels)<br /> - Quay phim FullHD 1080p@30fps<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br /> - FM radio FM radio với RDS<br /> - Hỗ trợ tối đa thẻ 16 GB<br /> - Bộ nhớ trong 1GB<br /> - Xem phim H.263, H.264(MPEG4-AVC), MP4, WMV<br /> - Hệ điệu hành Android 2.3.6 (Gingerbread)<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0049', N'SX01', N'Nokia Asha 311', 2500000, 2950000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/Nokia-311-l.jpg', N'Phổ thông', NULL, N'Máy ảnh 3.2 MP', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'1GB', N'128 MB', N'ARM 11 450 MHz processor', N'MicroSD (T-Flash)', N'16 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'-', N'Thanh (thẳng) + Cảm ứng', N'Qwerty sành điệu ', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Máy ảnh Máy ảnh 3.2 MP<br /> - Quay phim FullHD 1080p@30fps<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br /> - FM radio FM radio với RDS<br /> - Hỗ trợ tối đa thẻ 16 GB<br /> - Bộ nhớ trong 1GB<br /> - Xem phim H.263, H.264(MPEG4-AVC), MP4, WMV<br /> - Hệ điệu hành <br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0046', N'SX01', N'Nokia C5-03', 3000000, 3489000, CAST(N'2012-08-24' AS Date), 10, N'Data Image/nokia_c5-03_b.jpg', N'Phổ thông', NULL, N'5.0 MP (2592 x 1944 pixels)', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'1GB', N'128 MB', N'ARM 11 450 MHz processor', N'MicroSD (T-Flash)', N'16 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'Symbian Series 60, 5th', N'Thanh (thẳng) + Cảm ứng', N'Có, phím ảo', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Máy ảnh 5.0 MP (2592 x 1944 pixels)<br /> - Quay phim FullHD 1080p@30fps<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br /> - FM radio FM radio với RDS<br /> - Hỗ trợ tối đa thẻ 16 GB<br /> - Bộ nhớ trong 1GB<br /> - Xem phim H.263, H.264(MPEG4-AVC), MP4, WMV<br /> - Hệ điệu hành Symbian Series 60, 5th<br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0047', N'SX01', N'Nokia 303', 2000000, 2489000, CAST(N'2012-08-24' AS Date), 15, N'Data Image/dien-thoai-di-dong-nokia-Asha-303-dienmay.com-b.jpg', N'Phổ thông', NULL, N'Máy ảnh 3.2 MP', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'1GB', N'128 MB', N'ARM 11 450 MHz processor', N'MicroSD (T-Flash)', N'16 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'-', N'Thanh (thẳng) + Cảm ứng', N'Qwerty sành điệu ', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Máy ảnh Máy ảnh 3.2 MP<br /> - Quay phim FullHD 1080p@30fps<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br /> - FM radio FM radio với RDS<br /> - Hỗ trợ tối đa thẻ 16 GB<br /> - Bộ nhớ trong 1GB<br /> - Xem phim H.263, H.264(MPEG4-AVC), MP4, WMV<br /> - Hệ điệu hành <br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0050', N'SX01', N'Nokia X2', 1850000, 2199000, CAST(N'2012-08-24' AS Date), 12, N'Data Image/dien-thoai-di-dong-Nokia-X2-dienmay.com-l.jpg', N'Phổ thông', NULL, N'Máy ảnh 3.2 MP', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'1GB', N'128 MB', N'ARM 11 450 MHz processor', N'MicroSD (T-Flash)', N'16 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'-', N'Thanh (thẳng) + Cảm ứng', N'Qwerty sành điệu ', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Máy ảnh Máy ảnh 3.2 MP<br /> - Quay phim FullHD 1080p@30fps<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br /> - FM radio FM radio với RDS<br /> - Hỗ trợ tối đa thẻ 16 GB<br /> - Bộ nhớ trong 1GB<br /> - Xem phim H.263, H.264(MPEG4-AVC), MP4, WMV<br /> - Hệ điệu hành <br />')
INSERT [dbo].[SanPham] ([MaSP], [MaSX], [TenSP], [GiaMua], [GiaBan], [NgayNhap], [SLTon], [HinhAnh], [PhanLoai], [GhiChu], [CT1], [CT2], [CT3], [CT4], [CT5], [CT6], [CT7], [CT8], [CT9], [CT10], [CT11], [CT12], [CT13], [CT14], [CT15], [CT16], [CT17], [CT18], [CT19], [CT20], [CT21], [CT22], [CT23], [CT24], [CT25], [CT26], [CT27], [CT28], [CT29], [CT30], [NoiBat]) VALUES (N'SP0051', N'SX01', N'Nokia C3-00', 1900000, 2199000, CAST(N'2012-08-24' AS Date), 8, N'Data Image/no_c3dienmay.com_b.jpg', N'Phổ thông', NULL, N'Máy ảnh 3.2 MP', N'VGA (0.3 Mpx)', N'FullHD 1080p@30fps', N'H.263, H.264(MPEG4-AVC), MP4, WMV', N'MP3, WAV, WMA, eAAC+', N'FM radio với RDS', N'Có', N'Có thể cài thêm', N'MIDP 2.1', N'Hỗ trợ mạng xã hội', N'1GB', N'128 MB', N'ARM 11 450 MHz processor', N'MicroSD (T-Flash)', N'16 GB', N'GSM 850/900/1800/1900', N'HSDPA 850 / 900 / 1900 / 2100, CDMA2000 1xEV', N'-', N'86 kbps', N'Wi-Fi 802.11 b/g/n', N'Có, V2.1 với A2DP', N'USB 2.0', N'A-GPS', N'-', N'Thanh (thẳng) + Cảm ứng', N'Qwerty sành điệu ', N'125 x 63 x 8.7 mm', N'117', N'Tiếng Anh, Tiếng Việt', N'-', N' - Máy ảnh Máy ảnh 3.2 MP<br /> - Quay phim FullHD 1080p@30fps<br /> - Nghe nhạc MP3, WAV, WMA, eAAC+<br /> - FM radio FM radio với RDS<br /> - Hỗ trợ tối đa thẻ 16 GB<br /> - Bộ nhớ trong 1GB<br /> - Xem phim H.263, H.264(MPEG4-AVC), MP4, WMV<br /> - Hệ điệu hành <br />')
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (31, 1)
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (29, 2)
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (31, 3)
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (30, 4)
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (31, 5)
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (30, 6)
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (31, 7)
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (31, 8)
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (30, 9)
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (31, 10)
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (30, 11)
INSERT [dbo].[Thang] ([Ngay], [Thang]) VALUES (31, 12)
INSERT [dbo].[ThongKeTaiChinh] ([Nam], [Quy], [Thang], [GiaTriTonKho], [DoanhThu], [Lai], [TienMat]) VALUES (2012, 1, 1, 3000000000,0000, NULL, 10000000,0000, NULL)
INSERT [dbo].[ThongKeTaiChinh] ([Nam], [Quy], [Thang], [GiaTriTonKho], [DoanhThu], [Lai], [TienMat]) VALUES (2012, 1, 2, 1000000000,0000, NULL, 12000000,0000, NULL)
INSERT [dbo].[ThongKeTaiChinh] ([Nam], [Quy], [Thang], [GiaTriTonKho], [DoanhThu], [Lai], [TienMat]) VALUES (2012, 1, 3, 1000000000,0000, NULL, 15000000,0000, NULL)
INSERT [dbo].[ThongKeTaiChinh] ([Nam], [Quy], [Thang], [GiaTriTonKho], [DoanhThu], [Lai], [TienMat]) VALUES (2012, 2, 4, 1000000000,0000, NULL, 13000000,0000, NULL)
INSERT [dbo].[ThongKeTaiChinh] ([Nam], [Quy], [Thang], [GiaTriTonKho], [DoanhThu], [Lai], [TienMat]) VALUES (2012, 2, 5, 1000000000,0000, NULL, 20000000,0000, NULL)
INSERT [dbo].[ThongKeTaiChinh] ([Nam], [Quy], [Thang], [GiaTriTonKho], [DoanhThu], [Lai], [TienMat]) VALUES (2012, 2, 6, 2000000000,0000, NULL, 21000000,0000, NULL)
INSERT [dbo].[ThongKeTaiChinh] ([Nam], [Quy], [Thang], [GiaTriTonKho], [DoanhThu], [Lai], [TienMat]) VALUES (2012, 3, 7, 100000000,0000, NULL, 25000000,0000, NULL)
INSERT [dbo].[ThongKeTaiChinh] ([Nam], [Quy], [Thang], [GiaTriTonKho], [DoanhThu], [Lai], [TienMat]) VALUES (2012, 3, 8, 1000000000,0000, NULL, 45000000,0000, NULL)
INSERT [dbo].[ThongKeTaiChinh] ([Nam], [Quy], [Thang], [GiaTriTonKho], [DoanhThu], [Lai], [TienMat]) VALUES (2012, 3, 9, 1000000000,0000, NULL, 120000000,0000, NULL)
INSERT [dbo].[ThongKeTaiChinh] ([Nam], [Quy], [Thang], [GiaTriTonKho], [DoanhThu], [Lai], [TienMat]) VALUES (NULL, NULL, NULL, 30000000,0000, NULL, 60000000,0000, NULL)
/****** Object:  StoredProcedure [dbo].[CAU1]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CAU1] (@n int)
AS
	DECLARE @i INT
	DECLARE @kq int
	SET @kq=0
	SET @i=0
	WHILE(@i<=@n)
		BEGIN
			SET @kq=@kq+@i
			SET @i=@i+1
		END
	RETURN @kq
GO
/****** Object:  StoredProcedure [dbo].[doanhthu]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[doanhthu] (@from date, @to date)
as
select sum(ThanhTien) from (select ChiTietHoaDonBan.MaHDBan, SUM(SLBan*GiaBan) as ThanhTien from HoaDonBan join ChiTietHoaDonBan 
on HoaDonBan.MaHDBan=ChiTietHoaDonBan.MaHDBan
where NgayBan between @from and @to
group by ChiTietHoaDonBan.MaHDBan) as a
GO
/****** Object:  Trigger [dbo].[tr_NextID_Test]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_NextID_Test] on [dbo].[Admin]
for insert
as
    begin
        DECLARE @lastid nvarchar(10)
        SET @lastid  = (SELECT TOP 1 MaAD from Admin order by MaAD desc)
        UPDATE Admin set MaAD = dbo.fn_NextID (@lastid,'AD',4) where MaAD = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_NextID_FeedBack]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[tr_NextID_FeedBack] on [dbo].[FeedBack]
for insert
as
    begin
        DECLARE @lastid nvarchar(10)
        SET @lastid  = (SELECT TOP 1 MaFB from FeedBack order by MaFB desc)
        UPDATE FeedBack set MaFB = dbo.fn_NextID (@lastid,'FB',7) where MaFB = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_NextID_HoaDon]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_NextID_HoaDon] on [dbo].[HoaDonBan]
for insert
as
    begin
        DECLARE @lastid nvarchar(10)
        SET @lastid  = (SELECT TOP 1 MaHDBan from HoaDonBan order by MaHDBan desc)
        UPDATE HoaDonBan set MaHDBan = dbo.fn_NextID (@lastid,'HDB',8) where MaHDBan = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_NextID_HoaDonMua]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[tr_NextID_HoaDonMua] on [dbo].[HoaDonMua]
for insert
as
    begin
        DECLARE @lastid nvarchar(10)
        SET @lastid  = (SELECT TOP 1 MaHDMua from HoaDonMua order by MaHDMua desc)
        UPDATE HoaDonMua set MaHDMua = dbo.fn_NextID (@lastid,'HDM',7) where MaHDMua = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_NextID_KhachHang]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[tr_NextID_KhachHang] on [dbo].[KhachHang]
for insert
as
    begin
        DECLARE @lastid nvarchar(10)
        SET @lastid  = (SELECT TOP 1 MaKH from KhachHang order by MaKH desc)
        UPDATE KhachHang set MaKH = dbo.fn_NextID (@lastid,'KH',7) where MaKH = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_NextID_Manager]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[tr_NextID_Manager] on [dbo].[Manager]
for insert
as
    begin
        DECLARE @lastid nvarchar(10)
        SET @lastid  = (SELECT TOP 1 MaM from Manager order by MaM desc)
        UPDATE Manager set MaM = dbo.fn_NextID (@lastid,'M',3) where MaM = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_NextID_NhaCungUng]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[tr_NextID_NhaCungUng] on [dbo].[NhaCungUng]
for insert
as
    begin
        DECLARE @lastid nvarchar(10)
        SET @lastid  = (SELECT TOP 1 MaCU from NhaCungUng order by MaCU desc)
        UPDATE NhaCungUng set MaCU = dbo.fn_NextID (@lastid,'NCU',5) where MaCU = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_NextID_SanXuat]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_NextID_SanXuat] on [dbo].[NhaSanXuat]
for insert
as
    begin
        DECLARE @lastid nvarchar(10)
        SET @lastid  = (SELECT TOP 1 MaSX from NhaSanXuat order by MaSX desc)
        UPDATE NhaSanXuat set MaSX = dbo.fn_NextID (@lastid,'SX',4) where MaSX = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_NextID_SanPham]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_NextID_SanPham] on [dbo].[SanPham]
for insert
as
    begin
        DECLARE @lastid nvarchar(10)
        SET @lastid  = (SELECT TOP 1 MaSP from SanPham order by MaSP desc)
        UPDATE SanPham set MaSP = dbo.fn_NextID (@lastid,'SP',6) where MaSP = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_SanPham]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[tr_SanPham] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT1='-' where CT1 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham10]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham10] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT10='-' where CT10 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham11]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham11] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT11='-' where CT11 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham12]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham12] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT12='-' where CT12 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham13]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham13] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT13='-' where CT13 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham14]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham14] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT14='-' where CT14 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham15]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham15] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT15='-' where CT15 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham16]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham16] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT16='-' where CT16 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham17]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create trigger [dbo].[tr_SanPham17] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT17='-' where CT17 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham18]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham18] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT18='-' where CT18 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham19]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham19] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT19='-' where CT19 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham2]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[tr_SanPham2] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT2='-' where CT2 = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_SanPham20]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham20] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT20='-' where CT20 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham21]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham21] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT21='-' where CT21 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham22]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham22] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT22='-' where CT22 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham23]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham23] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT23='-' where CT23 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham24]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham24] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT24='-' where CT24 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham25]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham25] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT25='-' where CT25 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham26]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham26] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT26='-' where CT26 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham27]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham27] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT27='-' where CT27 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham28]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham28] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT28='-' where CT28 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham29]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham29] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT29='-' where CT29 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham3]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create trigger [dbo].[tr_SanPham3] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT3='-' where CT3 = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_SanPham30]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham30] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT30='-' where CT30 = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_SanPham4]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create trigger [dbo].[tr_SanPham4] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT4='-' where CT4 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham5]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham5] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT5='-' where CT5 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham6]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham6] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT6='-' where CT6 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham7]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham7] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT7='-' where CT7 = ''
    end
GO
/****** Object:  Trigger [dbo].[tr_SanPham8]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham8] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT8='-' where CT8 = ''
    end

GO
/****** Object:  Trigger [dbo].[tr_SanPham9]    Script Date: 12/04/2017 8:52:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_SanPham9] on [dbo].[SanPham]
for insert
as
    begin
        UPDATE SanPham set CT9='-' where CT9 = ''
    end
GO
USE [master]
GO
ALTER DATABASE [QL_PKTPHONE] SET  READ_WRITE 
GO
