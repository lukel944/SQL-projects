USE [lukaszbase]
GO
/****** Object:  Table [dbo].[SIMSTMS]    Script Date: 06.06.2022 15:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIMSTMS](
	[Title] [nvarchar](max) NULL,
	[Location] [nchar](3) NULL,
	[Society] [nchar](2) NULL,
	[Amount_sign] [numeric](18, 2) NULL,
	[Acc_period] [nchar](6) NULL,
	[Authors] [nvarchar](max) NULL,
	[Catalog_no] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SOCSTATS]    Script Date: 06.06.2022 15:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOCSTATS](
	[Title] [nvarchar](max) NULL,
	[Location] [nchar](3) NULL,
	[Society] [nchar](2) NULL,
	[Amount] [numeric](18, 2) NULL,
	[Acc_period] [nchar](6) NULL,
	[Composer] [nvarchar](max) NULL,
	[Catalogue_no_M3] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SUISASTS]    Script Date: 06.06.2022 15:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUISASTS](
	[Title] [nvarchar](max) NULL,
	[Location] [nchar](3) NULL,
	[Society] [nchar](2) NULL,
	[Amount] [numeric](18, 2) NULL,
	[Acc_period] [nchar](6) NULL,
	[Composer] [nvarchar](max) NULL,
	[Catalogue_no_M] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tabela_slownikowa]    Script Date: 06.06.2022 15:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tabela_slownikowa](
	[ID] [nchar](1) NULL,
	[Society] [nchar](3) NULL,
	[nazwa_tabeli] [nchar](50) NULL,
	[nazwa_dochod] [nchar](50) NULL,
	[nazwa_Carrier] [nchar](50) NULL,
	[nazwa_Title] [nchar](50) NULL,
	[nazwa_Composer] [nchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[uio]    Script Date: 06.06.2022 15:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[uio](
	[Work] [nchar](20) NOT NULL,
	[Location] [nchar](3) NULL,
	[Society] [nchar](2) NOT NULL,
	[Code] [nchar](10) NULL,
	[Description] [nvarchar](max) NULL,
	[Type] [nchar](1) NULL,
	[Acc_period] [nchar](6) NULL,
	[Archive_no] [nchar](3) NULL,
	[Share%] [numeric](18, 2) NULL,
	[Units] [nchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WYNIK]    Script Date: 06.06.2022 15:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WYNIK](
	[Work] [nchar](20) NULL,
	[Location] [nchar](3) NULL,
	[Society] [nchar](3) NULL,
	[Code] [nchar](10) NULL,
	[Description] [nvarchar](max) NULL,
	[Type] [nchar](1) NULL,
	[Acc_period] [nchar](6) NULL,
	[Archive_no] [nchar](3) NULL,
	[Share%] [numeric](18, 2) NULL,
	[Units] [nchar](10) NULL,
	[dochod] [numeric](18, 2) NULL,
	[Carier] [nvarchar](max) NULL,
	[Title] [nvarchar](max) NULL,
	[Label] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ZAIKSSTT]    Script Date: 06.06.2022 15:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZAIKSSTT](
	[Title1_C] [nvarchar](max) NULL,
	[Location] [nchar](3) NULL,
	[Society] [nchar](2) NULL,
	[Amount_work_G] [numeric](18, 2) NULL,
	[Acc_period] [nchar](6) NULL,
	[Artist_E] [nvarchar](max) NULL,
	[Carrier_id_prog_P] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Procedura]    Script Date: 06.06.2022 15:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[Procedura]

AS
 
 
 declare @Carieer varchar(17)
declare @dochod varchar(13)
 declare @Table_name varchar(12)
 declare @sql varchar(255)
declare @i int = 1
declare @society varchar(2)
declare @Title varCHAr(8)
declare @Label varchar(8)


truncate table dbo.WYNIK


while @i < 5
begin

set @Table_name = (select nazwa_tabeli
from dbo.Tabela_slownikowa
where id = @i)


set @society = ( select Society 
from dbo.Tabela_slownikowa
where id = @i)

set @dochod = (select nazwa_dochod
from dbo.Tabela_slownikowa
where id = @i)

set @Carieer =(select  nazwa_Carrier
from dbo.Tabela_slownikowa
where id = @i)


set @Title =(select  nazwa_Title
from dbo.Tabela_slownikowa
where id = @i)



set @Label =(select  nazwa_Composer
from dbo.Tabela_slownikowa
where id = @i)




set @sql = 'insert into dbo.WYNIK select distinct a.*,  b.'+@dochod+', b.' +@Carieer+',  b.'+@Title+', b.'+@Label+'
from dbo.uio a
inner join ' +@Table_name+' b on a.Acc_period=b.Acc_period
where a.Society =' +@society

exec (@sql)



set @i+=1

End
GO
/****** Object:  StoredProcedure [dbo].[proceduraxml]    Script Date: 06.06.2022 15:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[proceduraxml]
as
declare @xml XML
SELECT @xml=BulkColumn From OPENROWSET (BULK 'C:\Users\ll\Desktop\plik.xml', SINGLE_CLOB) AS Content
SELECT @xml


DECLARE @idoc INT  

EXEC sp_xml_preparedocument @idoc OUTPUT, @xml;

SELECT *
FROM OPENXML (@idoc, '/ROOT/Customer/Order/OrderDetail',2)   
         WITH (OrderID       int         '@OrderID',
               CustomerID  varchar(10) '../@CustomerID',
               OrderDate   datetime    '../@OrderDate',
               ProdID      int         '@ProductID',
               Qty         int         '@Quantity');
EXEC sp_XML_removedocument @idoc
GO
