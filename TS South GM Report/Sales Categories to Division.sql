-- Logic to Map SalesCatID to Division with Case Statment for Agile, TerraTrak, TrackerInterface Divisions included
Select Distinct 
    od.Company,
    CASE
        WHEN od.SalesCatID = 'TT' THEN 8
        WHEN od.SalesCatID = 'TINT' THEN 4
        WHEN od.SalesCatID = 'AGIL' THEN 2
        ELSE oh.Division_c
    END as Division,
    od.SalesCatID,
    sc.[Description] as SalesCategory
   FROM [ERPDB].[etl].vwOrderDetail od
Left JOIN [ERPDB].[dbo].[orderhed] oh
    on od.ordernum = oh.ordernum and od.company=oh.Company
LEFT JOIN [ERPDB].[Erp].[SalesCat] sc
     on od.company = sc.company
           and od.SalesCatID = sc.SalesCatID
Where sc.Company != 'APEKS'
Order by od.Company, Division
