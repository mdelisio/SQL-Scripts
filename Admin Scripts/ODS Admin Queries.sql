SELECT * FROM Logs.ODSExtractDeltasExtendedLog ORDER BY 1 DESC
SELECT * FROM Logs.ODSProcessDeltasExtendedLog ORDER BY 1 DESC
SELECT * FROM Report.ODSMaxSourceChangedDateTime
SELECT * FROM ETL.ChangeCaptureState
SELECT * FROM Config.ODSControl_Columns ORDER BY SourceServerEnvironmentVariable, SourceDatabase, SourceSchema, SourceTable, OrdinalPosition
SELECT * FROM Config.ODSControl_Tables
---------------------------------------------------------------------
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_CurrExRate
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_CurrExRateDeltaHistory ORDER BY 1 DESC
--
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_JobHead
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_JobHeadBase WHERE IsSourceDeleted = 1
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_JobHeadDeltaHistory ORDER BY 1 DESC
--
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_OrderDtl
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_OrderDtlDeltaHistory ORDER BY 1 DESC
--
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_OrderHed
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_OrderHedDeltaHistory ORDER BY 1 DESC
--
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_OrderRel
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_OrderRelDeltaHistory ORDER BY 1 DESC
--
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_ProjPhase
SELECT TOP 1000 * FROM ODS_ERPDB.Erp_ProjPhaseDeltaHistory ORDER BY 1 DESC