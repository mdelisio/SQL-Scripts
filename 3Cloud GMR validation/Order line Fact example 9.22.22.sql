Select 
company,
projectID,
Date,
ChangeDAteTime,
OrderNumLine,
SellPrice,
DailySellPriceChg,
BaseEstimate,
DailyEstimateChg,
EffectiveStartDateRow,
EffectiveEndDateRow,
CreatedDateRow,
LastUpdateDateRow
from [dw].[FactOrderDetails]
WHERE ProjectID = 2230088
Order by Date
--and Ordernumline = '2236361-11'