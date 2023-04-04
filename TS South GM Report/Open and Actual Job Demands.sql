-- Declare @ProjectID Varchar(50)
-- Set @ProjectID = '2128153';
-- Declare @Company Varchar(50)
-- Set @Company = 'Solar';


Declare @ProjectID Varchar(50)
Set @ProjectID = '22221929';
Declare @Company Varchar(50)
Set @Company = 'Solar';

--Get Open Job Demands for Project for each job Assembly and Material sequent for each Order Line
With OpenJobDemandsDetail AS
(Select
    Company, 
    ProjectID,
    jobNum,
    AssemblySeq,
    MtlSeq,
    OrderNum,
    OrderNumLine,
    (Case
         When (EstUnitCost*(RequiredQty-IssuedQty)) >= 0 Then  (EstUnitCost*(RequiredQty-IssuedQty))
         Else 0
    ENd) as OpenJobDemands,
    (EstUnitCost*RequiredQty) as EstimatedJobDemands
FROM [ERPDB].[etl].[vwJobMtlChange]
Where ProjectID = @ProjectID
and Company = @Company
),

--Summarize the Open Job Demands by orderline for comparison vs the actual costs on each order line
OpenJobDemands AS
(Select
    Company,
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
Where ProjectID = @ProjectID
      and Company = @Company
Group by Company,
         ProjectID,
         OrderNum,
         OrderNumLine
),

-- Summarize the Labor Costs on each Order Line
LaborSummary
as (Select Company,
       ProjectID,
       OrderNum,
       Ordernumline,
       Sum((LaborHrs*LaborRate)+(BurdenHrs*BurdenRate)) as OrderLineLaborCosts
FROM [ERPDB].[etl].[vwLaborDtl]
Where ProjectID = @ProjectID
      and Company =  @Company
Group by Company,
         ProjectID,
         OrderNum,
         OrderNumLine
),

--Summarize the Actual Costs on each Order line
ActualCost as
(Select 
    ps.Company,
    ps.ProjectID,
    ps.OrderNum,
    ps.Ordernumline,
    Sum(ps.OrderLinePartCosts) as TotalPartCosts,
    Sum(ls.OrderLineLaborCosts) as TotalLaborCosts,
    Sum(ps.OrderLinePartCosts)+Sum(ls.OrderLineLaborCosts) as ActualCosts
From PartSummary ps 
LEft Join LaborSummary ls 
    on ps.Company = ls.company and ps.OrderNumLine = ls.OrderNumLine
Where ps.ProjectID = @ProjectID
      and ps.Company = @Company
Group by ps.Company,
         ps.ProjectID,
         ps.OrderNum,
         ps.Ordernumline
)

--Query below summaries by Project

-- Select 
-- ac.Company,
-- ac.ProjectID,
-- Sum(OpenJobDemands) as OpenJobDemands,
-- Sum(ActualCosts) as ActualCosts,
-- Sum(OpenJobDemands + ActualCosts) as ActualCostsandOpenJobDemands,
-- Sum(EstimatedJobDemands) as EstimatedJobDemands
-- From ActualCost ac
-- Left Join OpenJobDemands ojd
-- on ojd.OrderNumLine = ac.OrderNumLine and ojd.Company = ac.Company
-- Group by ac.Company, ac.ProjectID

--Query below summaries by OrderNumLine

-- Select 
-- ac.Company,
-- ac.ProjectID,
-- ac.OrderNumLine,
-- Sum(OpenJobDemands) as OpenJobDemands,
-- Sum(ActualCosts) as ActualCosts,
-- Sum(OpenJobDemands + ActualCosts) as ActualCostsandOpenJobDemands,
-- Sum(EstimatedJobDemands) as EstimatedJobDemands
-- From ActualCost ac
-- Left Join OpenJobDemands ojd
-- on ojd.OrderNumLine = ac.OrderNumLine and ojd.Company = ac.Company
-- Group by ac.Company, ac.ProjectID, ac.OrderNumLine

-- Select 
-- ac.Company,
-- ac.ProjectID,
-- ac.OrderNumLine,
-- Sum(ActualCosts) as ActualCosts
-- From ActualCost ac
-- Where ac.ProjectID = @ProjectID
--       and ac.Company = @Company
-- Group by ac.Company, ac.ProjectID, ac.OrderNumLine

SELECT
ps.Company,
ps.ProjectID,
ps.OrderNumLine,
Sum(OrderLinePartCosts) as TotalPartCosts
From partsummary ps
Where ps.ProjectID = @ProjectID
      and ps.Company = @Company
Group by ps.Company, ps.ProjectID, ps.OrderNumLine
