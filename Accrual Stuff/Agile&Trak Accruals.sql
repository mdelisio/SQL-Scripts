SELECT TOP (1000) pt.company
    ,[projectID]
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
    ,pt.VendorNum
    ,v.Name as VendorName
    ,[InvoiceNum]
    ,[InvoiceLine]
    ,[Plant]
FROM [ERPDB].[etl].[vwPartTran] pt
Left Join [ERPDB].[Erp].[Vendor] v 
    on pt.VendorNum = v.VendorNum and pt.company = v.company 
WHERE pt.company = 'Solar'
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


  