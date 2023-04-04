-- Declare @ProjectID Varchar(50)
-- Set @ProjectID = '21819693';
-- Declare @Company Varchar(50)
-- -- Set @Company = 'Solar';

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [etl].[vwProjectScopeCostSummary] AS


--Get the Distinct List of Project Scopes
With ProjectScope 
AS (
SELECT Distinct
    Company,
    ProjectID,
    PhaseID,
    [Description] AS ProjectScope
FROM ERPDB.ERP.ProjPhase
    WHERE Level = 1
    AND OrderNum <> 0
),


--Get the Parent PhaseID on a project with the related Order AND Lines
ProjectPhaseOrders
AS (
    SELECT DISTINCT 
        Company,
        ProjectID,
        CASE 
        WHEN DATALENGTH(ParentPhase) > 0 THEN ParentPhase
        ELSE PhaseID
        END AS PhaseID,
        OrderNum,
        OrderLine
    FROM ERPDB.ERP.ProjPhase
 WHERE OrderNum <> 0),

--Get the ProjectPhaseEst
ProjectPhaseEst
AS (
    SELECT Company,
           ProjectID,
           PhaseID,
           OrderNum,
           OrderLine,
           Sum(BudTotLbrCost + BudTotBurCost + BudTotSubCost + BudTotMtlCost + BudTotMtlBurCost + BudTotODCCost) AS BudgetedCosts
    FROM ERPDB.ERP.ProjPhase
    -- WHERE clause for Level only includes project Phases at the top level which are already summarized FROM lower levels
    WHERE Level = 1
    GROUP BY Company,
             ProjectID,
             PhaseID,
             OrderNum,
             OrderLine
),


-- Summarize the Part Costs on each Order Line
PartSummary
AS (SELECT Company,
       ProjectID,
       OrderNum,
       OrderLine,
       Sum(ExtCost) AS OrderLinePartCosts
FROM [ERPDB].[etl].[vwPartTran]
GROUP BY Company, ProjectID, OrderNum, OrderLine
),


-- Summarize the Labor Costs on each Order Line
LaborSummary
AS (SELECT Company,
       ProjectID,
       OrderNum,
       OrderLine,
       Sum((LaborHrs*LaborRate)+(BurdenHrs*BurdenRate)) AS OrderLineLaborCosts
FROM [ERPDB].[etl].[vwLaborDtl]
GROUP BY Company, ProjectID, OrderNum, OrderLine
),


--Summarize the Actual Costs on each Order line
ActualCost 
AS (SELECT od.Company,
    od.ProjectID,
    od.OrderNum,
    od.Orderline,
    COALESCE(Sum(ps.OrderLinePartCosts),0)+COALESCE(Sum(ls.OrderLineLaborCosts),0) AS ActualCosts
FROM
 [ERPDB].[etl].[vwOrderdetail] AS od
Left Join PartSummary ps 
    on od.Company = ps.company 
        AND od.OrderNum = ps.OrderNum
        AND od.OrderLine = ps.Orderline
Left Join LaborSummary ls 
    on od.Company = ls.company 
        AND od.OrderNum = ls.OrderNum
        AND od.Orderline = ls.Orderline
GROUP BY od.Company, od.ProjectID, od.OrderNum, od.OrderLine
),

--Summary of ProjectTotal with Actual Costs, Budgeted Costs and Remaining Budget
 ProjectTotal
 AS (SELECT
        ppo.Company,
        ppo.ProjectID,
        SUM(COALESCE(ac.ActualCosts,0)) AS ActualCosts,
        SUM(COALESCE(ppe.BudgetedCosts,0)) AS BudgetedCosts,
        SUM(COALESCE(ppe.BudgetedCosts,0)) - SUM(COALESCE(ac.ActualCosts,0)) AS RemainingProjectBudget
    FROM
     ProjectPhaseOrders ppo
    LEFT JOIN ActualCost ac 
        on ppo.Company = ac.Company
            AND ppo.OrderNum = ac.OrderNum
            AND ppo.OrderLine = ac.OrderLine
    LEFT JOIN ProjectPhaseEst ppe
        on ppo.Company = ppe.Company
            AND ppo.OrderNum = ppe.OrderNum
            AND ppo.OrderLine = ppe.OrderLine
     LEFT JOIN ProjectScope ps 
        ON ppo.Company = ps.Company
        AND ppo.ProjectID = ps.ProjectID
        AND ppo.PhaseID = ps.PhaseID
    GROUP BY ppo.Company, ppo.ProjectID
 )


--Summary of Project Scope lines with Actual Costs, Budgeted Costs and Remaining Budget
    SELECT 
        ppo.Company,
        ppo.ProjectID,
        ppo.PhaseID,
        ps.ProjectScope,
        SUM(COALESCE(ac.ActualCosts,0)) AS ActualScopeCosts,
        SUM(COALESCE(ppe.BudgetedCosts,0)) AS BudgetedScopeCosts,
        SUM(COALESCE(ppe.BudgetedCosts,0)) - SUM(COALESCE(ac.ActualCosts,0)) AS RemainingScopeBudget,
        MAX(pt.RemainingProjectBudget) as RemainingProjectBudget,
        Case
        When MAX(pt.RemainingProjectBudget) = 0 THEN NULL
        ELSE (SUM(COALESCE(ppe.BudgetedCosts,0)) - SUM(COALESCE(ac.ActualCosts,0)))/MAX(pt.RemainingProjectBudget) 
        END AS ScopeShareRemainingBudget
    FROM
     ProjectPhaseOrders ppo
    LEFT JOIN ActualCost ac 
        ON ppo.Company = ac.Company
            AND ppo.OrderNum = ac.OrderNum
            AND ppo.OrderLine = ac.OrderLine
    LEFT JOIN ProjectPhaseEst ppe
        ON ppo.Company = ppe.Company
            AND ppo.OrderNum = ppe.OrderNum
            AND ppo.OrderLine = ppe.OrderLine
     LEFT JOIN ProjectScope ps 
        ON ppo.Company = ps.Company
        AND ppo.ProjectID = ps.ProjectID
        AND ppo.PhaseID = ps.PhaseID
     LEFT JOIN ProjectTotal pt
        ON ppo.Company = pt.Company
        AND ppo.ProjectID = pt.ProjectID
   WHERE ppo.Company = 'Solar'
      --  AND ppo.ProjectID = @ProjectID
      --  AND (ac.ActualCosts > 0 OR ppe.BudgetedCosts > 0)
      -- and pt.RemainingProjectBudget > 10000
      -- and ps.ProjectScope = 'Install'
    GROUP BY ppo.Company, ppo.ProjectID, ppo.PhaseID, ps.ProjectScope
    


