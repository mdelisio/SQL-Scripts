SELECT TOP (100) [Company]
      ,[SysDate]
      ,[SystemDateTime]
      ,[TranNum]
      ,[PartNum]
      ,[WareHouseCode]
      ,[BinNum]
      ,[TranClass]
      ,[TranType]
      ,[InventoryTrans]
      ,[TranDate]
      ,[TranQty]
      ,[UM]
      ,[ExtCost]
      ,[JobNum]  
      ,[OrderNum]
      ,[OrderLine]
      ,[OrderNumLine]
      ,[EntryPerson]
      ,[TranReference]
      ,[PartDescription]
      ,[VendorNum]
      ,[InvoiceNum]
      ,[InvoiceLine]
      ,[Plant]
      ,[projectID]
  FROM [ERPDB].[etl].[vwPartTran]
  Where Company = 'Solar' 
  and SysDate >= '2023-02-01'
  and ProjectID in 
('1984263',
'2085999',
'21819693',
'22221336',
'22222411',
'22223705',
'22223840',
'22224465',
'22224978',
'22821406',
'21218225',
'22222849',
'1984386',
'21818418',
'22223843',
'21818418')

