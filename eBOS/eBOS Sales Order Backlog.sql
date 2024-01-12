/*  
 * Disclaimer!!! 
 * This is not a real query being executed, but a simplified version for general vision. 
 * Executing it with any other tool may produce a different result. 
 */

select  
	[OrderHed].[Division_c] as [OrderHed_Division_c], 
	[Customer].[Name] as [Customer_Name], 
	[OrderRel].[OrderNum] as [OrderRel_OrderNum], 
	[OrderRel].[OrderLine] as [OrderRel_OrderLine], 
	[OrderRel].[OrderRelNum] as [OrderRel_OrderRelNum], 
	[OrderRel].[PartNum] as [OrderRel_PartNum], 
	[OrderRel].[RevisionNum] as [OrderRel_RevisionNum], 
	[OrderDtl].[DocUnitPrice] as [OrderDtl_DocUnitPrice], 
	[OrderRel].[SellingReqQty] as [OrderRel_SellingReqQty], 
	[OrderRel].[ReqDate] as [OrderRel_ReqDate], 
	[OrderRel].[NeedByDate] as [OrderRel_NeedByDate], 
	((OrderRel.SellingReqQty - OrderRel.SellingJobShippedQty - OrderRel.SellingStockShippedQty)) as [Calculated_OpenQty], 
	(((case 
    when  (OrderDtl.PricePerCode = 'M')  then  ((((
        case 
        when    (OrderRel.SellingReqQty - OrderRel.SellingJobShippedQty - OrderRel.SellingStockShippedQty) > 0 then 
                (OrderRel.SellingReqQty - OrderRel.SellingJobShippedQty- OrderRel.SellingStockShippedQty)
                else  0 end))/ 1000) * OrderDtl.DocUnitPrice * (1 - (OrderDtl.DiscountPercent / 100)))  
        else 
           ((case 
           when  (OrderDtl.PricePerCode = 'C')  then ((((case when  (OrderRel.SellingReqQty - OrderRel.SellingJobShippedQty - OrderRel.SellingStockShippedQty) > 0
            then (OrderRel.SellingReqQty - OrderRel.SellingJobShippedQty - OrderRel.SellingStockShippedQty)
                else  0 end))/ 100) * OrderDtl.DocUnitPrice * (1 - (OrderDtl.DiscountPercent / 100)))  else 
        ((((case when  (OrderRel.SellingReqQty - OrderRel.SellingJobShippedQty
        - OrderRel.SellingStockShippedQty) > 0
        then 
        (OrderRel.SellingReqQty - OrderRel.SellingJobShippedQty
        - OrderRel.SellingStockShippedQty)
        else  0 end))/ 1) * OrderDtl.DocUnitPrice * (1 - (OrderDtl.DiscountPercent / 100))) end)) end)))
    as [Calculated_OpenValue], 
	[ShipVia].[Description] as [ShipVia_Description], 
	[OrderDtl].[LineDesc] as [OrderDtl_LineDesc], 
	[OrderDtl].[XPartNum] as [OrderDtl_XPartNum], 
	[OrderDtl].[XRevisionNum] as [OrderDtl_XRevisionNum], 
	[OrderHed].[PONum] as [OrderHed_PONum], 
	[OrderDtl].[OpenLine] as [OrderDtl_OpenLine], 
	[OrderRel].[OpenRelease] as [OrderRel_OpenRelease], 
	[Customer].[CustID] as [Customer_CustID], 
	[OrderHed].[OrderNum] as [OrderHed_OrderNum], 
	[OrderHed].[CustNum] as [OrderHed_CustNum], 
	[Customer].[Company] as [Customer_Company], 
	[OrderDtl].[Company] as [OrderDtl_Company], 
	[OrderHed].[Company] as [OrderHed_Company], 
	[OrderRel].[Company] as [OrderRel_Company], 
	[ShipVia].[Company] as [ShipVia_Company], 
	[OrderRel].[ShipToNum] as [OrderRel_ShipToNum], 
	[OrderRel].[ShipViaCode] as [OrderRel_ShipViaCode] 

from dbo.OrderHed as [OrderHed]
inner join Erp.OrderDtl as [OrderDtl] on 
	  OrderHed.Company = OrderDtl.Company
	and  OrderHed.OrderNum = OrderDtl.OrderNum
inner join Erp.OrderRel as [OrderRel] on 
	  OrderDtl.Company = OrderRel.Company
	and  OrderDtl.OrderNum = OrderRel.OrderNum
	and  OrderDtl.OrderLine = OrderRel.OrderLine
left outer join Erp.ShipVia as [ShipVia] on 
	  OrderRel.Company = ShipVia.Company
	and  OrderRel.ShipViaCode = ShipVia.ShipViaCode
inner join Erp.Customer as [Customer] on 
	  OrderHed.Company = Customer.Company
	and  OrderHed.CustNum = Customer.CustNum
where ( OrderHed.OpenOrder = 1  )
AND OrderHed.Division_C = 6
order by OrderHed.Company, OrderHed.OrderNum, OrderRel.OrderLine, OrderRel.OrderRelNum