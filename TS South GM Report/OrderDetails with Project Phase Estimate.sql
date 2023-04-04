With ProjectPhaseEst
AS
(SELECT
  Company,
  ProjectID,
  OrderNum,
  OrderLine,
  Sum(BudTotLbrCost) as BudgetedLaborCosts,
  Sum(BudTotBurCost) as BudgetedBurdenCosts,
  Sum(BudTotSubCost) as BudgetedSubCosts,
  Sum(BudTotMtlCost) as BudgetedMaterialCosts,
  Sum(BudTotMtlBurCost) as BudgetedMaterialBurdenCosts,
  Sum(BudTotODCCost) as BudgetedOtherDirectCosts,
  Sum(BudTotLbrCost + BudTotBurCost + BudTotSubCost + BudTotMtlCost + BudTotMtlBurCost + BudTotODCCost) as EstimatedCosts
   From ERPDB.ERP.ProjPhase
   -- Where clause for Level only includes project phases at the top level which are already summarized from lower levels
   Where Level = 1
   Group By Company, ProjectID, OrderNum, OrderLine)
  

Select od.*, pp.EstimatedCosts
FROM [ERPDB].[etl].[vwOrderdetail] as od 
LEFT Join ProjectPhaseEst as pp
ON od.OrderNum = pp.OrderNum and od.OrderLine = pp.Orderline
Where od.ProjectID = '2026273'
and od.company = 'Solar'

--Test For Summary Projects validated SellPrice and Budget/EstimatedCosts match 1/5/2023
    -- Select 
    -- od.ProjectID,
    -- Sum(UnitPrice) as SellPrice,
    -- Sum(EstimatedCosts) as Budgetecosts 
    -- FROM [ERPDB].[etl].[vwOrderdetail] as od 
    -- LEFT Join ProjectPhaseEst as pp
    -- ON od.OrderNum = pp.OrderNum and od.OrderLine = pp.Orderline
    -- Where od.ProjectID in (
    --     '2026722',
    --     '2127530',
    --     '2087311',
    --     '2084853',
    --     '2128153',
    --     '22221186',
    --     '2026273',
    --     '2127593'
    -- )
    -- and od.Company = 'Solar'
    -- Group By od.ProjectID

