Declare @OrderNum Varchar(50)
Set @Ordernum = '4000195';
--2030026 or 4000195
Declare @Company Varchar(50)
Set @Company = 'Solar';
 
 With InvoiceSummary
 as (Select Company,
    OrderNum,
    InvoiceNum,
    Sum(InvoiceAmt) as Billed,
    Sum(InvoiceBal) as InvoiceBalance,
   (Sum(InvoiceAmt) - Sum(INvoiceBal)) as CustomerPaid
    FROM [ERPDB].[etl].[vwInvcHead]
  Group by Company, OrderNum, InvoiceNum
 ),

 InvoiceDetail
 as (Select id.Company,
    id.OrderNum,
    id.InvoiceNum,
    Sum(COALESCE(it.TaxAmt,0)) as TaxAmount
    FROM [ERPDB].[etl].[vwInvcDtl]  id
    LEFT JOIN etl.vwInvcTax it
    on id.company = it.company 
    and id.InvoiceNum = it.InvoiceNum
    and id.InvoiceLine = it.InvoiceLine
  Group by id.Company, id.OrderNum, id.InvoiceNum
 )


Select
invs.Company,
invs.OrderNum,
Invs.InvoiceNum,
Sum(invs.Billed) as Billed,
SUM(invd.TaxAmount) as Tax,
Sum(invs.InvoiceBalance) as InvoiceBalance,
sum(invs.CustomerPaid) as CustomerPaid
FROM InvoiceSummary invs
Left Join InvoiceDetail invd
on invs.Company = invd.Company
and invs.OrderNum = invd.OrderNum 
and invs.InvoiceNum = invd.InvoiceNum
Where invs.Company = @Company
  and invs.OrderNum = @OrderNum
Group by invs.Company, invs.OrderNum, invs.InvoiceNum


Select Company,
    OrderNum,
    InvoiceNum,
    Sum(InvoiceAmt) as Billed,
    Sum(InvoiceBal) as InvoiceBalance,
    (Sum(InvoiceAmt) - Sum(INvoiceBal)) as CustomerPaid
    FROM [ERPDB].[etl].[vwInvcHead]
  Where Company = @Company
  And OrderNum = @OrderNum
  Group by Company, OrderNum, InvoiceNum


/*
Select Top (10) * from etl.vwInvcHead
order by ChangeDateTime Desc

Select Top (10) * from etl.vwInvcDtl
order by ChangeDateTime Desc

Select Top (10)
*
from etl.vwInvcDtl
Where 1=1
and OrderNum in ('4000401', '4000009')
and Company = 'Solar'


Select Top (1000) *
From Erp.InvcTax
Where 1=1
and Company = 'Solar'
order by ChangeDate Desc

Select Count (*)
From Erp.InvcTax
*/

/*
Select *
from etl.vwInvcDtl
Where 1=1
and InvoiceNum = 1693246
and Company = 'Solar'

Select *
from etl.vwInvcHead
Where 1=1
and InvoiceNum = 1693246
and Company = 'Solar'

Select *
From Erp.InvcTax
Where 1=1
and InvoiceNum = 219130
and Company = 'Solar'
*/

Select Top (100) *
from etl.vwInvcHead
Where 1=1
and Company = 'Solar'
and SoldtoCustNum <> CustNum
order by ChangeDate Desc