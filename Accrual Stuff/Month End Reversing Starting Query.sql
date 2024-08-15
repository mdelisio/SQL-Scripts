Declare @DateStart DATETIME = '2024-06-30'
Declare @DateEnd   DATETIME = '2024-07-31' 


Select 
pd.ProjectID,
pd.ProjectDescription,
pgmaaf.ProjectGrossMarginAdjustmentActivityFactKey,
pgmaaf.BusinessDateDimKey as TransactionDate,
pgmaaf.ProjectChangeInSellPrice as SellPrice,
pgmaaf.ProjectChangeInActualCost as ActualCost,
pgmaaf.ProjectChangeinCurrentBudgetAmount as Budget,
pgmaaf.ProjectChangeInRevenueEarnedAmount as Revenue,
pgmaaf.ProjectChangeinBacklogAmount as Backlog,
pgmaaf.AdjustmentType,
pgmaaf.ProjectGrossMarginAdjustmentActivityFactKey,
pgmaaf.SourceSystemRecordState,
pgmaaf.CreateUTCDateTime,
pgmaaf.UpdateUser,
pgmaaf.UpdateUTCDateTime
FROM dw.ProjectGrossMarginAdjustmentActivityFact pgmaaf
INNER JOIN edw.ProjectDim pd
    ON pgmaaf.ProjectDimKey = pd.ProjectDimKey
INNER JOIN edw.DateDim dd
    ON pgmaaf.BusinessDateDimKey = dd.DateDimKey
WHERE pd.CompanyID = 'Solar'
AND (pgmaaf.BusinessDateDimKey >= @DateStart AND pgmaaf.BusinessDateDimKey <= @DateEnd)
AND pgmaaf.AdjustmentType <> 'Month-End Reversing'
Order by BusinessDateDimKey Desc