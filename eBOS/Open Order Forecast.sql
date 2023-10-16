SELECT 
    c.Name as CustomerName,
    oh.Division_C as Division,
    oh.Ordernum,
    orel.orderline,
    orel.OrderRelNum,
    oh.OrderDate,
    orel.ReqDate,
    od.UnitPrice,
    orel.ourReqQty,
    (od.UnitPrice * orel.ourReqQty) as OrderReleaseSalePrice,
    orel.NeedbyDate,
    orel.OpenRelease,
    orel.SellingJobShippedQty as JobShippedQuantity,
    orel.SellingStockShippedQty as StockShippedQuanity,
    (orel.SellingJobShippedQty + orel.SellingStockShippedQty) as ShippedQuantity,
    ((orel.SellingJobShippedQty + orel.SellingStockShippedQty) * od.UnitPrice) as ShippedShipped,
    (orel.ourReqQty - orel.SellingJobShippedQty + orel.SellingStockShippedQty) as OpenQuantity,
    ((orel.ourreqQty - orel.SellingJobShippedQty + orel.SellingStockShippedQty) * od.UnitPrice) as OpenSellPrice
FROM dbo.OrderRel orel
LEFT JOIN dbo.Orderhed oh
    on orel.Ordernum = oh.OrderNum
        and orel.Company = oh.Company
LEFT JOIN dbo.orderdtl od
    on orel.Ordernum = od.OrderNum
        and orel.OrderLine = od.OrderLine
        and orel.Company = od.Company
LEFT JOIN erp.customer c
    on oh.custnum = c.CustNum
        and oh.Company = c.Company
WHERE 1=1
AND oh.Company = 'Solar'
AND oh.Division_c = 6
Order by OrderDate desc
