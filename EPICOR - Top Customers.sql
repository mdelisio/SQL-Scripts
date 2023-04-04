SELECT
    datepart(yyyy, oh.OrderDate) AS OrderYear,
    c.Name,
    SUM(oh.OrderAmt) as TotalOrderAmount
FROM [ERPDB].[Erp].[Customer] AS c
INNER JOIN [ERPDB].[Erp].[OrderHed] AS oh 
ON c.CustNum = oh.CustNum
WHERE oh.Company = 'SOLAR' And oh.OrderDate >= '01/01/2019' AND c.Company = 'SOLAR'
GROUP BY c.Name, datepart(yyyy, oh.OrderDate)
ORDER BY TotalOrderAmount DESC
