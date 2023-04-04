select 
ProjectID,
Company,
date,
DailyBaseEstimate,
DailyBaseEstimateChg,
DailySellPrice,
DailySellPriceChg,
DailyCost,
DailyCostChg,
DailyCurrentEstimate,
DailyCurrentEstimateChg,
DailyPctComplete,
DailyRevenue,
DailyRevenueChg,
DailyGrossMargin,
DailyGrossMarginChg,
DAilyGrossMarginpct
From dw.FactGrossMargin
WHERE ProjectID = 2230088
and company = 'solar'