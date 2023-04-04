Select 
	[COASegValues].[Company] as [COASegValues_Company],
	[COASegValues].[COACode] as [COASegValues_COACode],
	[COASegValues].[SegmentNbr] as [COASegValues_SegmentNbr],
	[COASegValues].[SegmentCode] as [COASegValues_SegmentCode],
	[COASegValues].[SegmentName] as [COASegValues_SegmentName],
	[COASegValues].[SegmentDesc] as [COASegValues_SegmentDesc],
	[COAActCat].[CategoryID] as [COAActCat_CategoryID],
	[COAActCat].[Description] as [COAActCat_Description]
from Erp.COASegValues as COASegValues
Left join Erp.COAActCat as COAActCat on 
	COASegValues.Company = COAActCat.Company
	and COASegValues.COACode = COAActCat.COACode
	and COASegValues.Category = COAActCat.CategoryID

Where [COASegValues].[Company] = 'Solar'
Order By [COASegValues].[SegmentNbr], [COASegValues].[SegmentCode]


