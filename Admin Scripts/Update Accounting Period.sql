-- Update the AccountingPeriodName and AccountingPeriodName then execute SP
EXEC EDWConfig.usp_AccountingPeriodEndDate_Modify
@AccountingPeriodName		= 'Feb 2023'
,@AccountingPeriodEndDate	=  '2023-03-01'


/*********************************************************************************************
	-- Usage (Upsert)
	EXEC EDWConfig.usp_AccountingPeriodEndDate_Modify
		@AccountingPeriodName		= 'Apr 2023'
		,@AccountingPeriodEndDate	= '2023-05-02'

	-- Usage (Delete)
	EXEC EDWConfig.usp_AccountingPeriodEndDate_Modify
		@AccountingPeriodName		= 'Apr 2023'
		,@AccountingPeriodEndDate	= NULL


**********************************************************************************************/

-- Update DateDim with staged PeriodEndDate
EXEC [EDWETL].[usp_DateDim_AccountingPeriod_Update]