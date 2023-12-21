SELECT 
       od.[VoidLine]
      ,od.[OpenLine]
      ,od.[Company]
      ,od.OrderNum
      ,od.[OrderLine]
      ,oh.Orderdate
      ,od.[LineType]
      ,od.[PartNum]
      ,od.[LineDesc]
      ,od.SalesCatID
      ,[DocUnitPrice]
      ,[OrderQty]
      ,[ProdCode]
      ,CAST(SUBSTRING(ProdCode,2,1) as varchar) as ProdCode2ndCharacter
      ,oh.Division_c
      ,oh.ProjectID_c
   FROM ERPDB.ERP.[OrderDtl] as od
  INNER JOIN ERPDB.dbo.Orderhed as oh
    ON od.Company = oh.Company
    AND od.OrderNum = oh.Ordernum
  Where 1=1
  AND od.Company = 'solar'
  and oh.Division_c in (2,3,4,7,8,9)
  and ProjectID_c = '21817923'
  Order by OrderDate Desc

  