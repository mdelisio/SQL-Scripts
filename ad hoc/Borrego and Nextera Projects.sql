SELECT 
      oh.[OrderNum]
      ,oh.[CustNum]
      ,c.name
      ,oh.[Division_c]
      ,oh.[ProjectID_c]
  FROM [ERPDB].[etl].[vwOrderHead] as oh
  Left Join [ERPDB].[Erp].[Customer] AS c
  on c.CustNum = oh.custnum
  Where oh.Company = 'solar' and
  (c.name = 'Nexamp' OR c.name =  'BORREGO ENERGY, LLC') and 
  ProjectID_c <> '1823057C' 
  Order by c.name ,Ordernum desc

  --and Division_c IN(2,8,4)