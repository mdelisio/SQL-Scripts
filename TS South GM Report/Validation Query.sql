Declare @ProjectID Varchar(50)
Set @ProjectID = '2046773';
Declare @Company Varchar(50)
Set @Company = 'Solar';


--Sell Price Summary
With OrderDetail
as (Select od.Company,
           od.OrderNum,
           od.ProjectID,
           od.OrderLine,
           od.UnitPrice,
           od.OrderQty,
           (od.UnitPrice * od.OrderQty) as OrderLineSellPrice
    FROM [ERPDB].[etl].[vwOrderdetail] as od
   )

Select Company,
       ProjectID,
       Sum(OrderLineSellPrice) as SellPrice
From OrderDetail
Where ProjectID = @ProjectID
      and company = @Company
Group By Company,
         ProjectID;


--Quoted Costs
With ProjectPhaseEst
AS (SELECT Company,
           ProjectID,
           OrderNum,
           OrderLine,
           Sum(BudTotLbrCost + BudTotBurCost + BudTotSubCost + BudTotMtlCost + BudTotMtlBurCost + BudTotODCCost) as EstimatedCosts,
           Sum(TotQuotODCCost) as QuotedOtherDirectCosts,
           Sum(TotQuotODCCost + TotQuotLbrCost + TotQuotBurCost + TotQuotSubContCost + TotQuotMtlCost
               + TotQuotMtlBurCost
              ) as QuotedCosts
    From ERPDB.ERP.ProjPhase
    -- Where clause for Level only includes project phases at the top level which are already summarized from lower levels
    Where Level = 1
    Group By Company,
             ProjectID,
             OrderNum,
             OrderLine
   )

Select od.Company,
       od.ProjectID,
       sum(pp.QuotedCosts) as TotalQuotedCosts
FROM [ERPDB].[etl].[vwOrderdetail] as od
    LEFT Join ProjectPhaseEst as pp
        ON od.OrderNum = pp.OrderNum
           and od.OrderLine = pp.Orderline
Where od.ProjectID = @ProjectID
      and od.Company = @Company
Group by od.ProjectID,
         od.Company;


--Estimated Costs
Select 
Company, 
ProjectID,
Sum(EstUnitCost*RequiredQty) as EstimatedJobDemands
FROM [ERPDB].[etl].[vwJobMtlChange]
Where ProjectID = @ProjectID
and Company = @Company
Group by Company, ProjectID;


--Actual = Open Demand
With OpenJobDemandsDetail AS
(Select Company, 
    ProjectID,
    OrderNum,
    OrderNumLine,
    (Case
         When (EstUnitCost*(RequiredQty-IssuedQty)) >= 0 Then  (EstUnitCost*(RequiredQty-IssuedQty))
         Else 0
    ENd) as OpenJobDemands,
    (EstUnitCost*RequiredQty) as EstimatedJobDemands
FROM [ERPDB].[etl].[vwJobMtlChange]
),

--Summarize the Open Job Demands by orderline for comparison vs the actual costs on each order line
OpenJobDemands AS
(Select Company,
    ProjectID,
    OrderNum,
    OrderNumline,
    Sum(OpenJobDemands) as OpenJobDemands,
    Sum(EstimatedJobDemands) as EstimatedJobDemands
From OpenJobDemandsDetail
Group by Company, ProjectID, OrderNum, OrderNumline
),

-- Summarize the Part Costs on each Order Line
PartSummary
as (Select Company,
       ProjectID,
       OrderNum,
       Ordernumline,
       Sum(ExtCost) as OrderLinePartCosts
FROM [ERPDB].[etl].[vwPartTran]
Group by Company, ProjectID, OrderNum, OrderNumLine
),

-- Summarize the Labor Costs on each Order Line
LaborSummary
as (Select Company,
       ProjectID,
       OrderNum,
       Ordernumline,
       Sum((LaborHrs*LaborRate)+(BurdenHrs*BurdenRate)) as OrderLineLaborCosts
FROM [ERPDB].[etl].[vwLaborDtl]
Group by Company, ProjectID, OrderNum, OrderNumLine
),

--Summarize the Actual Costs on each Order line
ActualCost 
as (Select od.Company,
    od.ProjectID,
    od.OrderNum,
    od.Ordernumline,
    COALESCE(Sum(ps.OrderLinePartCosts),0) as TotalPartCosts,
    COALESCE(Sum(ls.OrderLineLaborCosts),0) as TotalLaborCosts,
    COALESCE(Sum(ps.OrderLinePartCosts),0)+COALESCE(Sum(ls.OrderLineLaborCosts),0) as ActualCosts
From [ERPDB].[etl].[vwOrderdetail] as od
Left Join PartSummary ps 
    on od.Company = ps.company and od.OrderNumLine = ps.OrderNumLine
Left Join LaborSummary ls 
    on od.Company = ls.company and od.OrderNumLine = ls.OrderNumLine
Group by od.Company, od.ProjectID, od.OrderNum, od.Ordernumline
)

Select 
    od.Company,
    od.ProjectID,
    Sum(OpenJobDemands) as OpenJobDemands,
    Sum(ActualCosts) as ActualCosts,
    Sum(COALESCE(OpenJobDemands,0) + COALESCE(ActualCosts,0)) as ActualCostsandOpenJobDemands,
    Sum(COALESCE(EstimatedJobDemands,0)) as EstimatedJobDemands
From [ERPDB].[etl].[vwOrderdetail] as od
Left Join ActualCost ac
on od.OrderNumLine = ac.OrderNumLine and od.Company = ac.Company
Left Join OpenJobDemands ojd
on od.OrderNumLine = ojd.OrderNumLine and od.Company = ojd.Company
Where od.ProjectID = @ProjectID
      and od.Company = @Company
Group by od.Company, od.ProjectID;


-- Budgeted Costs
With ProjectPhaseEst
AS (SELECT Company,
           ProjectID,
           OrderNum,
           OrderLine,
           Sum(BudTotLbrCost) as BudgetedLaborCosts,
           Sum(BudTotBurCost) as BudgetedBurdenCosts,
           Sum(BudTotSubCost) as BudgetedSubCosts,
           Sum(BudTotMtlCost) as BudgetedMaterialCosts,
           Sum(BudTotMtlBurCost) as BudgetedMaterialBurdenCosts,
           Sum(BudTotODCCost) as BudgetedOtherDirectCosts,
           Sum(BudTotLbrCost + BudTotBurCost + BudTotSubCost + BudTotMtlCost + BudTotMtlBurCost + BudTotODCCost) as BudgetedCosts
    From ERPDB.ERP.ProjPhase
    -- Where clause for Level only includes project phases at the top level which are already summarized from lower levels
    Where Level = 1
    Group By Company,
             ProjectID,
             OrderNum,
             OrderLine
   )

Select od.Company,
       od.ProjectID,
       sum(pp.BudgetedCosts) as TotalBudgetedCosts
FROM [ERPDB].[etl].[vwOrderdetail] as od
    LEFT Join ProjectPhaseEst as pp
        ON od.OrderNum = pp.OrderNum
           and od.OrderLine = pp.Orderline
Where od.ProjectID = @ProjectID
      and od.Company = @Company
Group by od.ProjectID,
         od.Company;


-- Billing Total
 With InvoiceSummary
 as (Select Company,
    OrderNum,
   Sum(InvoiceAmt) as Billed,
   Sum(InvoiceBal) as InvoiceBalance,
   (Sum(InvoiceAmt) - Sum(INvoiceBal)) as CustomerPaid
    FROM [ERPDB].[Erp].[InvcHead]

  Group by Company, OrderNum
 )

Select
oh.Company,
oh.ProjectID_c as ProjectID,
oh.Division_c,
Sum(inv.Billed) as Billed,
Sum(inv.InvoiceBalance) as InvoiceBalance,
sum(inv.CustomerPaid) as CustomerPaid
FROM [ERPDB].[dbo].[orderhed] oh
Left Join InvoiceSummary inv
on oh.OrderNum = inv.OrderNum and oh.Company = inv.Company
Where oh.Company = @Company
  and oh.ProjectID_c = @ProjectID
Group by oh.Company, oh.ProjectID_c, oh.Division_c;

--Project Info
Select top (100) p.Company,
       p.ProjectID,
       p.[Description] as ProjectName,
       p.ActiveProject,
       p.SalesCatID,
       sc.[Description] as SalesCategory,
       p.ConProjMgr,
       eb.Name as PMName,
       p.ConBTCustNum,
       c.Name as CustomerName
FROM [ERPDB].[Erp].[Project] p
    LEFT JOIN [ERPDB].[Erp].[SalesCat] sc
        on p.company = sc.company
           and p.SalesCatID = sc.SalesCatID
     LEFT JOIN [ERPDB].[Erp].[EmpBasic] eb
        on p.ConProjMgr = eb.EmpID
          and p.company = eb.company
    LEFT JOIN [ERPDB].[Erp].[Customer] c
        on p.ConBTCustNum = c.CustNum
          and p.Company = c.Company
where p.Company = @Company
      and ProjectID = @ProjectID;

--Ship to State
   Select Distinct
    oh.Company,
    oh.ProjectID_c as ProjectID,
    st.State as ShipToState,
    st.Zip as ShipToZip
  FROM [ERPDB].[dbo].[orderhed] oh
Left Join [ERPDB].[Erp].[ShipTo] st 
    on oh.shiptoNum = st.ShipToNum and oh.company = st.company and oh.CustNum = st.CustNum

  WHERE oh.Company = @Company
   and oh.ProjectID_c = @ProjectID