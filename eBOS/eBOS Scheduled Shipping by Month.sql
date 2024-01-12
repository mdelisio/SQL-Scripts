select  
	[JobHead].[JobNum] as [JobHead_JobNum], 
	[JobHead].[PartNum] as [JobHead_PartNum], 
	[JobHead].[PartDescription] as [JobHead_PartDescription], 
	[OrderDtl].[PartNum] as [OrderDtl_PartNum], 
	[OrderDtl].[LineDesc] as [OrderDtl_LineDesc], 
	(OrderRel.OurReqQty - OrderRel.OurJobShippedQty - OrderRel.OurStockShippedQty) as [Calculated_RemQty], 
    Orderhed.OrderDate,
    OrderRel.MFCustNum as OrderReleaseCustomerNumber,
    OrderHed.CustNum as OrderHeaderCustomerNumber,
	[Customer].[Name] as [Customer_Name], 
	[OrderRel].[ReqDate] as [OrderRel_ShipDate],
    [OrderRel].[NeedByDate] as [OrderRel_NeedByDate],
	[JobHead].[StartDate] as [JobHead_StartDate], 
	(case when OrderHed.TermsCode = 'PPAY' then 1 else 0
        end) as [Calculated_Prepaid], 
	[OrderDtl].[DocUnitPrice] as [OrderDtl_DocUnitPrice], 
    -- added the discounted unit price
    OrderDtl.DocOrdBasedPrice as DiscountedUnitPrice,
	((OrderRel.OurReqQty - OrderRel.OurJobShippedQty - OrderRel.OurStockShippedQty) * OrderDtl.DocUnitPrice) as [Calculated_OpenExtendedPrice],
    -- added the Open Discoutned Total Price
    ((OrderRel.OurReqQty - OrderRel.OurJobShippedQty - OrderRel.OurStockShippedQty) * OrderDtl.DocOrdBasedPrice) as [Calculated_OpenDiscountedPrice],
	[OrderHed].[SalesRepList] as [OrderHed_SalesRepList], 
	[SalesRep].[Name] as [SalesRep_Name], 
	[OrderRel].[Plant] as [OrderRel_Plant], 
	(datepart(month, OrderRel.ReqDate)) as [Calculated_MonthBucket], 
	(case 

        when (datepart(month, OrderRel.ReqDate)) = 1 then '01 - January'
        when (datepart(month, OrderRel.ReqDate)) = 2 then '02 - February'
        when (datepart(month, OrderRel.ReqDate)) = 3 then '03 - March'
        when (datepart(month, OrderRel.ReqDate)) = 4 then '04 - April'
        when (datepart(month, OrderRel.ReqDate)) = 5 then '05 - May'
        when (datepart(month, OrderRel.ReqDate)) = 6 then '06 - June'
        when (datepart(month, OrderRel.ReqDate)) = 7 then '07 - July'
        when (datepart(month, OrderRel.ReqDate)) = 8 then '08 - August'
        when (datepart(month, OrderRel.ReqDate)) = 9 then '09 - September'
        when (datepart(month, OrderRel.ReqDate)) = 10 then '10 - October'
        when (datepart(month, OrderRel.ReqDate)) = 11 then '11 - November'
        when (datepart(month, OrderRel.ReqDate)) = 12 then '12 - December' else ''

    end) as [Calculated_MonthAlpha], 
        (datepart(year, OrderRel.ReqDate)) as [Calculated_Yearbucket], 
        [OrderRel].[OrderNum] as [OrderRel_OrderNum], 
        [OrderRel].[OrderLine] as [OrderRel_OrderLine], 
        [OrderRel].[OrderRelNum] as [OrderRel_OrderRelNum], 
        [JobHead].[JobEngineered] as [JobHead_JobEngineered], 
        [JobHead].[Designed_c] as [JobHead_Designed_c], 
        [JobHead].[JobReleased] as [JobHead_JobReleased], 
        (case 

    when pplan.Calculated_Shortage > 0 then 1 else 0 
    end) as [Calculated_Shortage] 
from Erp.OrderRel as [OrderRel]
--This section eliminates rows that should be included becasue it doesn't find a join to the customer table if the CustomerNum didn't push down to the release
/*
Inner join Erp.Customer as [Customer] on 
	  OrderRel.Company = Customer.Company
    AND OrderRel.MFCustNum =   Customer.CustNum
*/
left outer join Erp.JobProd as [JobProd] on 
	  OrderRel.Company = JobProd.Company
	and  OrderRel.OrderNum = JobProd.OrderNum
	and  OrderRel.OrderLine = JobProd.OrderLine
	and  OrderRel.OrderRelNum = JobProd.OrderRelNum
left outer join dbo.JobHead as [JobHead] on 
	  JobProd.Company = JobHead.Company
	and  JobProd.JobNum = JobHead.JobNum
left outer join  (select  
	[PPlanMtl].[Company] as [PPlanMtl_Company], 
	[PPlanMtl].[JobNum] as [PPlanMtl_JobNum], 
	(count(PPlanMtl.Shortage)) as [Calculated_Shortage] 

    from Erp.PPlanMtl as [PPlanMtl]
    where (PPlanMtl.Shortage = 1)
    group by 
        [PPlanMtl].[Company], 
        [PPlanMtl].[JobNum])  as [pplan] on 
        JobHead.Company = pplan.PPlanMtl_Company
        and  JobHead.JobNum = pplan.PPlanMtl_JobNum
inner join DBO.OrderHed as [OrderHed] on 
	  OrderRel.Company = OrderHed.Company
	and  OrderRel.OrderNum = OrderHed.OrderNum
	and ( OrderHed.Division_c = 06  )
-- Added this section for correct Join   
Left Outer JOIN Erp.Customer as [Customer] on 
	  OrderHed.Company = Customer.Company
    AND OrderHed.CustNum =   Customer.CustNum
left outer join Erp.SalesRep as [SalesRep] on 
	  OrderHed.Company = SalesRep.Company
	and  OrderHed.SalesRepList = SalesRep.SalesRepCode
inner join Erp.OrderDtl as [OrderDtl] on 
	  OrderRel.Company = OrderDtl.Company
	and  OrderRel.OrderNum = OrderDtl.OrderNum
	and  OrderRel.OrderLine = OrderDtl.OrderLine
where (OrderRel.OpenRelease = 1)
Order by Orderhed.OrderDate Desc


---------------------------------------------------------------

/*
Select top (10) *
From erp.Customer
Where Company = 'solar'
*/

---------------------------------------------------------------
-- CURRENT Dashboard QUERY Inner Join on MFCustNum


/*
select  
	[JobHead].[JobNum] as [JobHead_JobNum], 
	[JobHead].[PartNum] as [JobHead_PartNum], 
	[JobHead].[PartDescription] as [JobHead_PartDescription], 
	[OrderDtl].[PartNum] as [OrderDtl_PartNum], 
	[OrderDtl].[LineDesc] as [OrderDtl_LineDesc], 
	(OrderRel.OurReqQty - OrderRel.OurJobShippedQty - OrderRel.OurStockShippedQty) as [Calculated_RemQty], 
    orderhed.OrderDate,
    OrderRel.MFCustNum as ReleaseCustomerNumber,
    OrderHed.CustNum as HeaderCustomerNumber,
	[Customer].[Name] as [Customer_Name], 
	[OrderRel].[ReqDate] as [OrderRel_ReqDate], 
	[JobHead].[StartDate] as [JobHead_StartDate], 
	(case
        when OrderHed.TermsCode = 'PPAY' then 1 else 0
        end) as [Calculated_Prepaid], 
	[OrderDtl].[DocUnitPrice] as [OrderDtl_DocUnitPrice], 
	((OrderRel.OurReqQty - OrderRel.OurJobShippedQty - OrderRel.OurStockShippedQty) * OrderDtl.DocUnitPrice) as [Calculated_OpenExtendedPrice],
	[OrderHed].[SalesRepList] as [OrderHed_SalesRepList], 
	[SalesRep].[Name] as [SalesRep_Name], 
	[OrderRel].[Plant] as [OrderRel_Plant], 
	(datepart(month, OrderRel.ReqDate)) as [Calculated_MonthBucket], 
	(case 

        when (datepart(month, OrderRel.ReqDate)) = 1 then '01 - January'
        when (datepart(month, OrderRel.ReqDate)) = 2 then '02 - February'
        when (datepart(month, OrderRel.ReqDate)) = 3 then '03 - March'
        when (datepart(month, OrderRel.ReqDate)) = 4 then '04 - April'
        when (datepart(month, OrderRel.ReqDate)) = 5 then '05 - May'
        when (datepart(month, OrderRel.ReqDate)) = 6 then '06 - June'
        when (datepart(month, OrderRel.ReqDate)) = 7 then '07 - July'
        when (datepart(month, OrderRel.ReqDate)) = 8 then '08 - August'
        when (datepart(month, OrderRel.ReqDate)) = 9 then '09 - September'
        when (datepart(month, OrderRel.ReqDate)) = 10 then '10 - October'
        when (datepart(month, OrderRel.ReqDate)) = 11 then '11 - November'
        when (datepart(month, OrderRel.ReqDate)) = 12 then '12 - December' else ''

    end) as [Calculated_MonthAlpha], 
	(datepart(year, OrderRel.ReqDate)) as [Calculated_Yearbucket], 
	[OrderRel].[OrderNum] as [OrderRel_OrderNum], 
	[OrderRel].[OrderLine] as [OrderRel_OrderLine], 
	[OrderRel].[OrderRelNum] as [OrderRel_OrderRelNum], 
	[JobHead].[JobEngineered] as [JobHead_JobEngineered], 
	[JobHead].[Designed_c] as [JobHead_Designed_c], 
	[JobHead].[JobReleased] as [JobHead_JobReleased], 
	(case 

    when pplan.Calculated_Shortage > 0 then 1 else 0 

    end) as [Calculated_Shortage] 
from Erp.OrderRel as [OrderRel]
Inner join Erp.Customer as [Customer] on 
	  OrderRel.Company = Customer.Company
    AND OrderRel.MFCustNum =   Customer.CustNum
left outer join Erp.JobProd as [JobProd] on 
	  OrderRel.Company = JobProd.Company
	and  OrderRel.OrderNum = JobProd.OrderNum
	and  OrderRel.OrderLine = JobProd.OrderLine
	and  OrderRel.OrderRelNum = JobProd.OrderRelNum
left outer join dbo.JobHead as [JobHead] on 
	  JobProd.Company = JobHead.Company
	and  JobProd.JobNum = JobHead.JobNum
left outer join  (select  
	[PPlanMtl].[Company] as [PPlanMtl_Company], 
	[PPlanMtl].[JobNum] as [PPlanMtl_JobNum], 
	(count(PPlanMtl.Shortage)) as [Calculated_Shortage] 
    from Erp.PPlanMtl as [PPlanMtl]
    where (PPlanMtl.Shortage = 1)
    group by 
	[PPlanMtl].[Company], 
	[PPlanMtl].[JobNum])  as [pplan] on 
	  JobHead.Company = pplan.PPlanMtl_Company
	and  JobHead.JobNum = pplan.PPlanMtl_JobNum
inner join DBO.OrderHed as [OrderHed] on 
	  OrderRel.Company = OrderHed.Company
	and  OrderRel.OrderNum = OrderHed.OrderNum
	and ( OrderHed.Division_c = 06  )
left outer join Erp.SalesRep as [SalesRep] on 
	  OrderHed.Company = SalesRep.Company
	and  OrderHed.SalesRepList = SalesRep.SalesRepCode
inner join Erp.OrderDtl as [OrderDtl] on 
	  OrderRel.Company = OrderDtl.Company
	and  OrderRel.OrderNum = OrderDtl.OrderNum
	and  OrderRel.OrderLine = OrderDtl.OrderLine
where (OrderRel.OpenRelease = 1)
Order by Orderhed.OrderDate Desc
*/


-----------------------------------------------------------------------
-- Outer Join on MFCustNum

/*
select  
	[JobHead].[JobNum] as [JobHead_JobNum], 
	[JobHead].[PartNum] as [JobHead_PartNum], 
	[JobHead].[PartDescription] as [JobHead_PartDescription], 
	[OrderDtl].[PartNum] as [OrderDtl_PartNum], 
	[OrderDtl].[LineDesc] as [OrderDtl_LineDesc], 
	(OrderRel.OurReqQty - OrderRel.OurJobShippedQty - OrderRel.OurStockShippedQty) as [Calculated_RemQty], 
    orderhed.OrderDate,
    OrderRel.MFCustNum as ReleaseCustomerNumber,
    OrderHed.CustNum as HeaderCustomerNumber,
	[Customer].[Name] as [Customer_Name], 
	[OrderRel].[ReqDate] as [OrderRel_ReqDate], 
	[JobHead].[StartDate] as [JobHead_StartDate], 
	(case
        when OrderHed.TermsCode = 'PPAY' then 1 else 0
        end) as [Calculated_Prepaid], 
	[OrderDtl].[DocUnitPrice] as [OrderDtl_DocUnitPrice], 
    -- added the discounted unit price
    OrderDtl.DocOrdBasedPrice as DiscountedUnitPrice,
	((OrderRel.OurReqQty - OrderRel.OurJobShippedQty - OrderRel.OurStockShippedQty) * OrderDtl.DocUnitPrice) as [Calculated_OpenExtendedPrice],
    -- added the Open Discoutned Total Price
    ((OrderRel.OurReqQty - OrderRel.OurJobShippedQty - OrderRel.OurStockShippedQty) * OrderDtl.DocOrdBasedPrice) as [Calculated_OpenDiscountedPrice],
	[OrderHed].[SalesRepList] as [OrderHed_SalesRepList], 
	[SalesRep].[Name] as [SalesRep_Name], 
	[OrderRel].[Plant] as [OrderRel_Plant], 
	(datepart(month, OrderRel.ReqDate)) as [Calculated_MonthBucket], 
	(case 

        when (datepart(month, OrderRel.ReqDate)) = 1 then '01 - January'
        when (datepart(month, OrderRel.ReqDate)) = 2 then '02 - February'
        when (datepart(month, OrderRel.ReqDate)) = 3 then '03 - March'
        when (datepart(month, OrderRel.ReqDate)) = 4 then '04 - April'
        when (datepart(month, OrderRel.ReqDate)) = 5 then '05 - May'
        when (datepart(month, OrderRel.ReqDate)) = 6 then '06 - June'
        when (datepart(month, OrderRel.ReqDate)) = 7 then '07 - July'
        when (datepart(month, OrderRel.ReqDate)) = 8 then '08 - August'
        when (datepart(month, OrderRel.ReqDate)) = 9 then '09 - September'
        when (datepart(month, OrderRel.ReqDate)) = 10 then '10 - October'
        when (datepart(month, OrderRel.ReqDate)) = 11 then '11 - November'
        when (datepart(month, OrderRel.ReqDate)) = 12 then '12 - December' else ''
    end) as [Calculated_MonthAlpha], 
	(datepart(year, OrderRel.ReqDate)) as [Calculated_Yearbucket], 
	[OrderRel].[OrderNum] as [OrderRel_OrderNum], 
	[OrderRel].[OrderLine] as [OrderRel_OrderLine], 
	[OrderRel].[OrderRelNum] as [OrderRel_OrderRelNum], 
	[JobHead].[JobEngineered] as [JobHead_JobEngineered], 
	[JobHead].[Designed_c] as [JobHead_Designed_c], 
	[JobHead].[JobReleased] as [JobHead_JobReleased], 
	(case 

    when pplan.Calculated_Shortage > 0 then 1 else 0 
    end) as [Calculated_Shortage] 
from Erp.OrderRel as [OrderRel]
LEFT OUTER JOIN Erp.Customer as [Customer] on 
	  OrderRel.Company = Customer.Company
    AND OrderRel.MFCustNum =   Customer.CustNum
left outer join Erp.JobProd as [JobProd] on 
	  OrderRel.Company = JobProd.Company
	and  OrderRel.OrderNum = JobProd.OrderNum
	and  OrderRel.OrderLine = JobProd.OrderLine
	and  OrderRel.OrderRelNum = JobProd.OrderRelNum
left outer join dbo.JobHead as [JobHead] on 
	  JobProd.Company = JobHead.Company
	and  JobProd.JobNum = JobHead.JobNum
left outer join  (select  
	[PPlanMtl].[Company] as [PPlanMtl_Company], 
	[PPlanMtl].[JobNum] as [PPlanMtl_JobNum], 
	(count(PPlanMtl.Shortage)) as [Calculated_Shortage] 
    from Erp.PPlanMtl as [PPlanMtl]
    where (PPlanMtl.Shortage = 1)
    group by 
	[PPlanMtl].[Company], 
	[PPlanMtl].[JobNum])  as [pplan] on 
	  JobHead.Company = pplan.PPlanMtl_Company
	and  JobHead.JobNum = pplan.PPlanMtl_JobNum
inner join DBO.OrderHed as [OrderHed] on 
	  OrderRel.Company = OrderHed.Company
	and  OrderRel.OrderNum = OrderHed.OrderNum
	and ( OrderHed.Division_c = 06  )
left outer join Erp.SalesRep as [SalesRep] on 
	  OrderHed.Company = SalesRep.Company
	and  OrderHed.SalesRepList = SalesRep.SalesRepCode
inner join Erp.OrderDtl as [OrderDtl] on 
	  OrderRel.Company = OrderDtl.Company
	and  OrderRel.OrderNum = OrderDtl.OrderNum
	and  OrderRel.OrderLine = OrderDtl.OrderLine
where (OrderRel.OpenRelease = 1)
Order by Orderhed.OrderDate Desc
*/


select  
	COUNT(*)
from Erp.OrderRel as [OrderRel]
INNER JOIN Erp.Customer as [Customer] on 
	  OrderRel.Company = Customer.Company
    AND OrderRel.MFCustNum =   Customer.CustNum
left outer join Erp.JobProd as [JobProd] on 
	  OrderRel.Company = JobProd.Company
	and  OrderRel.OrderNum = JobProd.OrderNum
	and  OrderRel.OrderLine = JobProd.OrderLine
	and  OrderRel.OrderRelNum = JobProd.OrderRelNum
left outer join dbo.JobHead as [JobHead] on 
	  JobProd.Company = JobHead.Company
	and  JobProd.JobNum = JobHead.JobNum
left outer join  (select  
	[PPlanMtl].[Company] as [PPlanMtl_Company], 
	[PPlanMtl].[JobNum] as [PPlanMtl_JobNum], 
	(count(PPlanMtl.Shortage)) as [Calculated_Shortage] 
    from Erp.PPlanMtl as [PPlanMtl]
    where (PPlanMtl.Shortage = 1)
    group by 
	[PPlanMtl].[Company], 
	[PPlanMtl].[JobNum])  as [pplan] on 
	  JobHead.Company = pplan.PPlanMtl_Company
	and  JobHead.JobNum = pplan.PPlanMtl_JobNum
inner join DBO.OrderHed as [OrderHed] on 
	  OrderRel.Company = OrderHed.Company
	and  OrderRel.OrderNum = OrderHed.OrderNum
	and ( OrderHed.Division_c = 06  )
left outer join Erp.SalesRep as [SalesRep] on 
	  OrderHed.Company = SalesRep.Company
	and  OrderHed.SalesRepList = SalesRep.SalesRepCode
inner join Erp.OrderDtl as [OrderDtl] on 
	  OrderRel.Company = OrderDtl.Company
	and  OrderRel.OrderNum = OrderDtl.OrderNum
	and  OrderRel.OrderLine = OrderDtl.OrderLine
where (OrderRel.OpenRelease = 1)

select  
	COUNT(*)
from Erp.OrderRel as [OrderRel]
LEFT OUTER JOIN Erp.Customer as [Customer] on 
	  OrderRel.Company = Customer.Company
    AND OrderRel.MFCustNum =   Customer.CustNum
left outer join Erp.JobProd as [JobProd] on 
	  OrderRel.Company = JobProd.Company
	and  OrderRel.OrderNum = JobProd.OrderNum
	and  OrderRel.OrderLine = JobProd.OrderLine
	and  OrderRel.OrderRelNum = JobProd.OrderRelNum
left outer join dbo.JobHead as [JobHead] on 
	  JobProd.Company = JobHead.Company
	and  JobProd.JobNum = JobHead.JobNum
left outer join  (select  
	[PPlanMtl].[Company] as [PPlanMtl_Company], 
	[PPlanMtl].[JobNum] as [PPlanMtl_JobNum], 
	(count(PPlanMtl.Shortage)) as [Calculated_Shortage] 
    from Erp.PPlanMtl as [PPlanMtl]
    where (PPlanMtl.Shortage = 1)
    group by 
	[PPlanMtl].[Company], 
	[PPlanMtl].[JobNum])  as [pplan] on 
	  JobHead.Company = pplan.PPlanMtl_Company
	and  JobHead.JobNum = pplan.PPlanMtl_JobNum
inner join DBO.OrderHed as [OrderHed] on 
	  OrderRel.Company = OrderHed.Company
	and  OrderRel.OrderNum = OrderHed.OrderNum
	and ( OrderHed.Division_c = 06  )
left outer join Erp.SalesRep as [SalesRep] on 
	  OrderHed.Company = SalesRep.Company
	and  OrderHed.SalesRepList = SalesRep.SalesRepCode
inner join Erp.OrderDtl as [OrderDtl] on 
	  OrderRel.Company = OrderDtl.Company
	and  OrderRel.OrderNum = OrderDtl.OrderNum
	and  OrderRel.OrderLine = OrderDtl.OrderLine
where (OrderRel.OpenRelease = 1)


