DECLARE @Company AS NVARCHAR(8)  = 'solar'
, @PartNum AS NVARCHAR(50) = '116770' -- fill this in
, @Plant AS NVARCHAR(8)   = 'COLU' -- fill this in
, @CutoffDate AS DATE     = '05-13-2024' -- fill this in (YYYY-MM-DD)
, @RunningTotal AS DECIMAL(12,2) = 0;

SELECT 
@CutoffDate AS 'CutoffDate'
, SUM(
CASE 
-- NEGATIVE ADJUSTMENTS
WHEN pt.TranType IN ('STK-ASM', 'STK-CUS', 'STK-INS', 'STK-KIT', 'STK-FAM', 
'STK-MTL', 'STK-PLT', 'STK-STK', 'STK-UKN', 'STK-DMR') 
THEN @RunningTotal + (-1 * pt.TranQty)

-- NO ADJUSTMENTS
WHEN pt.TranType IN ('ADJ-DRP', 'ADJ-MTL', 'ADJ-PUR', 'ADJ-SUB', 'ASM-INS', 'DMR-MTL',
'DMR-REJ', 'DMR-SUB', 'DRP-CUS', 'INS-ASM', 'INS-DMR', 'INS-MTL',
'INS-REJ', 'INS-SUB', 'KIT-CUS', 'MFG-CUS', 'MFG-PLT', 'MFG-VAR', 
'MFG-VEN', 'MFG-WIP', 'MTL-INS', 'MTL-DMR', 'PLT-MTL', 'PUR-CUS',
'PUR-DRP', 'PUR-INS', 'PUR-MTL', 'PUR-SUB', 'PUR-UKN', 'RMA-INS',
'SUB-INS', 'SUB-DMR', 'UKN-CUS', 'WIP-MFG') 
THEN 0 

-- POSITIVE ADJUSTMENTS
WHEN pt.TranType IN ('ADJ-CST', 'ADJ-QTY', 'AST-STK', 'DMR-STK', 'INS-STK', 
'MFG-STK', 'PLT-STK', 'PUR-STK', 'STK-STK', 'SVG-STK') 
THEN @RunningTotal + (1 * pt.TranQty)			
	
END ) AS 'BalanceAtCutoff'

FROM [erp].PartTran AS pt 

WHERE pt.Company = @Company 
AND pt.PartNum = @PartNum 
AND pt.Plant   = @Plant
AND pt.TranDate <= @CutoffDate


Select *
From erp.PartTran As pt
WHERE pt.Company = @Company 
AND pt.PartNum = @PartNum 
AND pt.Plant   = @Plant
AND pt.TranDate <= @CutoffDate
Order by Trandate DESC
