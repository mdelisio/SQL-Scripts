DECLARE @OrderNum Varchar(50)
SET @OrderNum = '2330003';
DECLARE @Company Varchar(50)
SET @Company = 'RBMI';


SELECT TOP (1000) [Company]
      ,[OrderNum]
      ,[OrderLine]
      ,[OrderRelNum]
      ,CONCAT(OrderNum,'-',OrderLine,'-',OrderRelNum) as JobNum
      ,[ReqDate]
      ,[OurReqQty]
      ,[OpenRelease]
      ,[FirmRelease]
      ,[OurJobQty]
      ,[OurJobShippedQty]
      ,[VoidRelease]
      ,[OurStockQty]
      ,[WarehouseCode]
      ,[OurStockShippedQty]
      ,[PartNum]
      ,[NeedByDate]
      ,[ChangedBy]
      ,[ChangeDate]
      ,[ChangeTime]
      ,[PrevNeedByDate]
      ,[PrevReqDate]
      ,[MFCustNum]
      FROM [ERPDB].[Erp].[OrderRel]
  Where 1=1
  and Ordernum = @OrderNum
  and Company = @Company
  Order by company, ReqDate desc