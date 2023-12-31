-- USE [RBI]
-- GO
-- /****** Object:  StoredProcedure [dbo].[CostService2019_GetCosts]    Script Date: 5/12/2022 2:58:40 PM ******/
-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
-- -- =============================================
-- -- Author:		Daniel Schoettelkotte
-- -- Create date: 2019-03-01
-- -- Description:	Consolidated Cost Procedures
-- -- =============================================
-- ALTER PROCEDURE [dbo].[CostService2019_GetCosts]
	@Company nvarchar(8) = '',
	@Division int,				-- Nullable
	@OrderNum int,				-- Nullable
	@ProjectID int,				-- Nullable
	@StartDate date,			-- Nullable
	@EndDate date,				-- Nullable
	@SalesCatID nvarchar(4),	-- Nullable
	@SalesRepCode nvarchar(8),	-- Nullable
	@PostFlag bit,
	@OpenOrders bit,
	@IgnorePrePost bit,
	@ValidatePrePost bit
AS
BEGIN	
	SET NOCOUNT ON;	
	DECLARE @OrderList as OrderNumberList

---- If @IgnorePrePost = 0 and there exist unposted PrePostOrderCostHeaders, return the PrePosted results	
	IF (@IgnorePrePost = 0 AND (SELECT COUNT(Posted) as Count FROM [RBI].[dbo].PrePostOrderCostHeader WHERE Posted = 0 AND Company = @Company) > 1)	
	BEGIN	
		IF @PostFlag = 0	
		BEGIN	
			CREATE TABLE #TempLines (Company nvarchar(8), OrderNum int, OrderLine int, ProjectID int)	
			CREATE TABLE #TempHeaders (Company nvarchar(8), OrderNum int)

			INSERT INTO #TempLines 	
			SELECT DISTINCT pl.Company, pl.OrderNum, OrderLine, ProjectID	
			FROM [RBI].[dbo].[PrePostOrderCostLines] pl	
			INNER JOIN [ERPDB].[Erp].OrderHed oh	
			ON oh.OrderNum = pl.OrderNum AND oh.Company = pl.Company	
			WHERE oh.Company = @Company AND	
			-- Including either a specified Division or all of them	
			((ISNULL(@Division,-1) = -1) OR 	
			(	
				(	
					(ProjectID IN (	
						SELECT OrderNum 	
						FROM [ERPDB].[Erp].OrderHed 	
						INNER JOIN [ERPDB].[ERp].OrderHed_UD 	
							ON SysRowID = ForeignSysRowID 	
						WHERE Division_c = @Division AND @Company = Company)	
					) OR 	
					(ProjectID = 0 AND @Division = Division)	
				)	
			)) AND	
			(ISNULL(@SalesCatID,'NULL') = 'NULL' OR @SalesCatID = SalesCatID) AND	
			(ISNULL(@SalesRepCode,'NULL') = 'NULL' OR oh.SalesRepList LIKE '%' + @SalesRepCode + '%') AND	
			(ISNULL(@OrderNum,0) = 0 OR @OrderNum = pl.OrderNum) AND	
			(ISNULL(@ProjectID,0) = 0 OR CAST(@ProjectID as nvarchar) = ProjectID) AND	
			-- If @OpenOrders = 1, account for UserDate (if StartDate is not null) and OpenOrders	
			(	
				-- If either @OrderNum or @ProjectID aren't NULL, avoid the Open/Closed distinction	
				ISNULL(@OrderNum,0) != 0 OR 	
				ISNULL(@ProjectID,0) != 0 OR	
				(@OpenOrders = 1 AND 	
					(	
						-- Orders with Open Projects OR Open Orders with no ProjectID OR Orders with their Project closed in the Date Range			
						ProjectID IN (SELECT OrderNum FROM [ERPDB].[Erp].OrderHed WHERE OpenOrder = 1 AND Company = @Company) OR	
						(ProjectID = 0 AND oh.OpenOrder = 1) OR 	
						-- Orders closed between the date range	
						(	
							(ISNULL(@StartDate,'0001/01/01') != '0001/01/01') AND 	
							(	
								(ProjectID = 0 AND oh.UserDate1 BETWEEN @StartDate AND @EndDate) OR	
								ProjectID IN (SELECT OrderNum FROM [ERPDB].[Erp].OrderHed WHERE Company = @Company AND UserDate1 BETWEEN @StartDate AND @EndDate)	
							)	
						) 	
					)	
				) OR	
				-- If @OpenOrders = 0, then grab @OpenOrders AND BETWEEN StartDate/EndDate	
				(@OpenOrders = 0 AND 	
					(	
						-- Orders with Closed Projects between the dates OR Closed Orders with no ProjectID	
						(	
							ProjectID IN (SELECT OrderNum FROM [ERPDB].[Erp].OrderHed WHERE UserDate1 BETWEEN @StartDate AND @EndDate AND OpenOrder = 0 AND Company = @Company) OR 	
							(ProjectID = 0 AND oh.OpenOrder = 0 AND oh.UserDate1 BETWEEN @StartDate AND @EndDate)	
						)	
					)	
				)	
			)	

			-- If PrePost needs to be Validated, run Order Numbers through the validatePrePost SP	
			If @ValidatePrePost = 1	
			BEGIN 	
				INSERT INTO @OrderList SELECT OrderNum FROM #TempLines	

				CREATE TABLE #TempJobProdErrors (Company nvarchar(8), JobNum nvarchar(14))	
				INSERT INTO #TempJobProdErrors EXEC [RBI].[dbo].CostService2019_ValidatePrePost @Company, @OrderList	

				SELECT * FROM #TempJobProdErrors	

				DROP TABLE #TempJobProdErrors	
			END	
			ELSE BEGIN	

				INSERT INTO #TempHeaders	
				SELECT DISTINCT Company, CASE WHEN ProjectID = '0'	
								THEN OrderNum	
								ELSE ProjectID	
							END as OrderNum	
				FROM #TempLines	
				SELECT ph.Company,ph.OrderNum,SellPrice,MaterialCost,LaborCost,OverHeadCost,OutsideCost,TotalCost,CurrentEstimate,OriginalEstimate,PercentComplete,	
					GrossMargin,GrossMarginOriginal,GrossMarginPercent,GrossMarginOriginalPercent,MarkUp,MarkUpOriginal,TotalBillings,RevenueReceived,PullBack,	
					BackLog,OverUnder,CustNum,ShipToNum,NotSetProjectID,EmptyProjectID,OrderDate,OpenOrder,SalesRepList,FOB,EntryPerson,PONum,ClosedDate,	
					AddToWatchedJobs,Address1,Address2,Address3,City,Name,PhoneNum,ShipViaCode,State,ZIP,Division	
				FROM [RBI].[dbo].[PrePostOrderCostHeader] ph	
				INNER JOIN #TempHeaders th	
					ON ph.Company = th.Company AND ph.OrderNum = th.OrderNum	
				WHERE Posted = 0	
				ORDER BY Company, OrderNum	

				SELECT pl.Company,pl.OrderNum,pl.OrderLine,SellPrice,MaterialCost,LaborCost,OutsideCost,OverHeadCost,TotalCost,CurrentEstimate,OriginalEstimate,	
					PercentComplete,GrossMargin,GrossMarginOriginal,GrossMarginOriginalPercent,GrossMarginPercent,MarkUp,MarkUpOriginal,RevenueReceived,	
					TotalBillings,PullBack,OverUnder,LineHours,FieldPriorityCount,AdvanceBillBal,Discount,OpenLine,OrderQty,PartNum,ProdCode,pl.ProjectID,SalesCatID,	
					UnitPrice,PickListComment,OrderComment,LineDesc,Division	
				FROM [RBI].[dbo].[PrePostOrderCostLines] pl	
				INNER JOIN #TempLines tl	
					ON tl.Company = pl.Company AND tl.OrderNum = pl.OrderNum AND tl.OrderLine = pl.OrderLine	
				WHERE Posted = 0	
				ORDER BY Company, OrderNum, OrderLine	

				SELECT ps.Company,ps.OrderNum,Address1,Address2,Address3,City,Name, PhoneNum, ShipViaCode,State,ZIP,CustNum,ShipToNum 	
				FROM [RBI].[dbo].[PrePostOrderCostShipTo] ps	
				INNER JOIN #TempHeaders th	
					ON ps.Company = th.Company AND ps.OrderNum = th.OrderNum	
				WHERE Posted = 0	
				ORDER BY Company, OrderNum	

				SELECT DISTINCT pp.Company,pp.OrderNum,pp.ProjectID,pp.Name 
				FROM [RBI].[dbo].[PrePostOrderCostProjectIDs] pp	
				INNER JOIN #TempLines tl	
					ON tl.Company = pp.Company AND tl.OrderNum = pp.OrderNum	
				WHERE Posted = 0	
				ORDER BY Company, OrderNum	

				SELECT DISTINCT ps.Company,ps.OrderNum,SalesCatID 	
				FROM [RBI].[dbo].[PrePostOrderCostSalesCatIDs] ps	
				INNER JOIN #TempLines tl	
					ON tl.Company = ps.Company AND tl.OrderNum = ps.OrderNum	
				WHERE Posted = 0	
				ORDER BY Company, OrderNum	

				SELECT DISTINCT ph.Company,ph.OrderNum	
				FROM [RBI].[dbo].[PrePostOrderCostOrderNumbers] ph	
				INNER JOIN #TempLines tl	
					ON tl.Company = ph.Company AND tl.OrderNum = ph.OrderNum 	
				WHERE Posted = 0	
				ORDER BY Company, OrderNum	

				SELECT pc.Company,pc.OrderNum,Address1,City,Comment,CustID,FaxNum,Name,PhoneNum,State,ZIP,CustNum,CustomerType,SalesRepCode,TerritoryID,SalesRep 	
				FROM [RBI].[dbo].[PrePostOrderCostCustomers] pc	
				INNER JOIN #TempHeaders th	
					ON th.Company = pc.Company AND th.OrderNum = pc.OrderNum	
				WHERE Posted = 0	
				ORDER BY Company, OrderNum	

				DROP TABLE #TempLines	
				DROP TABLE #TempHeaders	
			END	
		END	
	END	
	-- If the SQLQuery returns no rows, the SP proceeds to generate the data	
	ELSE BEGIN	

		-- Order Lines table	
		CREATE TABLE #TLines (	
			Company nvarchar(8),OrderNum int,OrderLine int,SellPrice decimal(22,8),MaterialCost decimal(22,8),LaborCost decimal(22,8),OutsideCost decimal(22,8),	
			OverHeadCost decimal(22,8),TotalCost decimal(22,8),CurrentEstimate decimal(22,8),OriginalEstimate decimal(12,2),PercentComplete decimal(22,8),	
			GrossMargin decimal(22,8),GrossMarginOriginal decimal(22,8),GrossMarginOriginalPercent decimal(22,8),GrossMarginPercent decimal(22,8),	
			MarkUp decimal(22,8),MarkUpOriginal decimal(22,8),RevenueReceived decimal(22,8),TotalBillings decimal(22,8),PullBack decimal(22,8),	
			OverUnder decimal(22,8),LineHours decimal(22,8),FieldPriorityCount int,AdvanceBillBal decimal(19,5),Discount decimal(17,3),OpenLine bit,	
			OrderQty decimal(22,8),PartNum nvarchar(50),ProdCode nvarchar(8),ProjectID int,SalesCatID nvarchar(4),UnitPrice decimal(17,5), 	
			PickListComment nvarchar(MAX),OrderComment nvarchar(MAX),LineDesc nvarchar(MAX),	
			MaterialEstCost decimal(22,8),LaborEstCost decimal(22,8),OverHeadEstCost decimal(22,8),	
			OutsideEstCost decimal(22,8),TotalShippedQty decimal(22,8),ShippedQtyEst decimal(22,8), Division int, OpenOrder bit, ExchangeRate decimal(20,10)	
			)	

		-- Order Head table	
		CREATE TABLE #THeader (	
			Company nvarchar(8),OrderNum int,SellPrice decimal(22,8),MaterialCost decimal(22,8),LaborCost decimal(22,8),OverHeadCost decimal(22,8),	
			OutsideCost decimal(22,8),TotalCost decimal(22,8),CurrentEstimate decimal(22,8),OriginalEstimate decimal(22,8),PercentComplete decimal(22,8),	
			GrossMargin decimal(22,8),GrossMarginOriginal decimal(22,8),GrossMarginPercent decimal(22,8),GrossMarginOriginalPercent decimal(22,8),	
			MarkUp decimal(22,8),MarkUpOriginal decimal(22,8),TotalBillings decimal(22,8),RevenueReceived decimal(22,8),PullBack decimal(22,8),	
			BackLog decimal(22,8),OverUnder decimal(22,8),CustNum int,ShipToNum nvarchar(14),NotSetProjectID bit, EmptyProjectID bit,OrderDate date,	
			OpenOrder bit,SalesRepList nvarchar(MAX),FOB nvarchar(15),EntryPerson nvarchar(75),PONum nvarchar(50),ClosedDate date,AddToWatchedJobs int,	
			Address1 nvarchar(50),Address2 nvarchar(50),Address3 nvarchar(50),City nvarchar(50),Name nvarchar(50),PhoneNum nvarchar(20),ShipViaCode nvarchar(4),	
			State nvarchar(50),ZIP nvarchar(10), Division int	
			)	

		INSERT INTO #TLines	
		SELECT DISTINCT	
			-- Data returned	
			od.Company, od.OrderNum, od.OrderLine,	
			od.UnitPrice * od.OrderQty - od.Discount AS SellPrice,	
			CAST(0 AS decimal(22,8)) AS MaterialCost,	
			CAST(0 AS decimal(22,8)) AS LaborCost,	
			CAST(0 AS decimal(22,8)) AS OutsideCost,	
			CAST(0 AS decimal(22,8)) AS OverHeadCost,	
			CAST(0 AS decimal(22,8)) AS TotalCost,	
			CAST(0 AS decimal(22,8)) AS CurrentEstimate,	
			odu.EstUnitCost_c AS OriginalEstimate,	
			CAST(0 AS decimal(22,8)) AS PercentComplete,	
			CAST(0 AS decimal(22,8)) AS GrossMargin,	
			CAST(0 AS decimal(22,8)) AS GrossMarginOriginal,	
			CAST(0 AS decimal(22,8)) AS GrossMarginOriginalPercent, 	
			CAST(0 AS decimal(22,8)) AS GrossMarginPercent,	
			CAST(0 AS decimal(22,8)) AS MarkUp,	
			CAST(0 AS decimal(22,8)) AS MarkUpOriginal,	
			CAST(0 AS decimal(22,8)) AS RevenueReceived,	
			CAST(0 AS decimal(22,8)) AS TotalBillings,	
			CAST(0 AS decimal(22,8)) AS PullBack,	
			CAST(0 AS decimal(22,8)) AS OverUnder,	
			CAST(0 AS decimal(22,8)) AS LineHours,	
			CAST(0 AS int) AS FieldPriorityCount,	
			od.AdvanceBillBal AS AdvanceBillBal, od.Discount AS Discount, od.OpenLine AS OpenLine,	
			od.OrderQty AS OrderQty, od.PartNum AS PartNum, od.ProdCode, CAST(od.ProjectID as int), od.SalesCatID,	
			od.UnitPrice AS UnitPrice, od.PickListComment, od.OrderComment, od.LineDesc,	
			-- Data not returned	
			CAST(0 AS decimal(22,8)) AS MaterialEstCost,	
			CAST(0 AS decimal(22,8)) AS LaborEstCost,	
			CAST(0 AS decimal(22,8)) AS OverHeadEstCost,	
			CAST(0 AS decimal(22,8)) AS OutsideEstCost,	
			CAST(0 AS decimal(22,8)) AS TotalShippedQty,	
			CAST(0 AS decimal(22,8)) AS ShippedQtyEst,	
			ohu.Division_c, oh.OpenOrder, oh.ExchangeRate	
		FROM	
			[ERPDB].[Erp].OrderHed oh	
			INNER JOIN [ERPDB].[Erp].OrderHed_UD ohu	
				ON oh.SysRowID = ohu.ForeignSysRowID	
			INNER JOIN [ERPDB].[Erp].OrderDtl od 	
				ON oh.Company = od.Company AND oh.OrderNum = od.OrderNum	
			INNER JOIN [ERPDB].[Erp].OrderDtl_UD odu	
				ON od.SysRowID = odu.ForeignSysRowID 	
			INNER JOIN [ERPDB].[Erp].OrderRel orl	
				ON oh.Company = orl.Company AND oh.OrderNum = orl.OrderNum AND od.OrderLine = orl.OrderLine	
			INNER JOIN [ERPDB].[Erp].ShipTo s	
				ON oh.Company = s.Company AND oh.CustNum = s.CustNum AND oh.ShipToNum = s.ShipToNum	
			LEFT OUTER JOIN [ERPDB].[Erp].JobProd jp 	
				ON jp.Company = orl.Company AND jp.OrderNum = orl.OrderNum AND jp.OrderLine = orl.OrderLine AND jp.OrderRelNum = orl.OrderRelNum 	
			LEFT OUTER JOIN [ERPDB].[Erp].JobHead jh	
				ON oh.Company = jh.Company AND jp.JobNum = jh.JobNum	
			LEFT OUTER JOIN [ERPDB].[Erp].JobAsmbl ja	
				ON ja.Company = orl.Company AND ja.JobNum = jp.JobNum	
			LEFT OUTER JOIN [ERPDB].[Erp].PartTran pt	
				ON pt.Company = oh.Company AND pt.OrderNum = oh.OrderNum AND pt.OrderLine = od.OrderLine AND pt.OrderRelNum = orl.OrderRelNum	
			INNER JOIN [ERPDB].[Ice].UD02_UD ud	
				ON ud.Division_c = ohu.Division_c AND ud.Company_c = oh.Company	
		WHERE	
			oh.Company = @Company AND	
			ud.DoNotFinance_c = 0 AND	
			-- Including either a specified Division or all of them	
			((ISNULL(@Division,-1) = -1) OR 	
			(	
				(	
					(od.ProjectID IN (	
						SELECT OrderNum 	
						FROM [ERPDB].[Erp].OrderHed 	
						INNER JOIN [ERPDB].[ERp].OrderHed_UD 	
							ON SysRowID = ForeignSysRowID 	
						WHERE Division_c = @Division AND @Company = Company)	
					) OR 	
					(od.ProjectID = '' AND @Division = ohu.Division_c)	
				)	
			)) AND	
			(ISNULL(@SalesCatID,'NULL') = 'NULL' OR @SalesCatID = od.SalesCatID) AND	
			(ISNULL(@SalesRepCode,'NULL') = 'NULL' OR oh.SalesRepList LIKE '%' + @SalesRepCode + '%') AND	
			(ISNULL(@OrderNum,0) = 0 OR @OrderNum = od.OrderNum) AND	
			(ISNULL(@ProjectID,0) = 0 OR CAST(@ProjectID as nvarchar) = od.ProjectID) AND	
			-- If @OpenOrders = 1, account for UserDate (if StartDate is not null) and OpenOrders	
			(	
				-- If either @OrderNum or @ProjectID aren't NULL, avoid the Open/Closed distinction	
				ISNULL(@OrderNum,0) != 0 OR 	
				ISNULL(@ProjectID,0) != 0 OR	
				(@OpenOrders = 1 AND 	
					(	
						-- Orders with Open Projects OR Open Orders with no ProjectID OR Orders with their Project closed in the Date Range			
						od.ProjectID IN (SELECT OrderNum FROM [ERPDB].[Erp].OrderHed WHERE OpenOrder = 1 AND Company = @Company) OR	
						(od.ProjectID = '' AND oh.OpenOrder = 1) OR 	
						-- Orders closed between the date range	
						(	
							(ISNULL(@StartDate,'0001/01/01') != '0001/01/01') AND 	
							(	
								(od.ProjectID = '' AND oh.UserDate1 BETWEEN @StartDate AND @EndDate) OR	
								od.ProjectID IN (SELECT OrderNum FROM [ERPDB].[Erp].OrderHed WHERE Company = @Company AND UserDate1 BETWEEN @StartDate AND @EndDate)	
							)	
						) 	
					)	
				) OR	
				-- If @OpenOrders = 0, then grab @OpenOrders AND BETWEEN StartDate/EndDate	
				(@OpenOrders = 0 AND 	
					(	
						-- Orders with Closed Projects between the dates OR Closed Orders with no ProjectID	
						(	
							od.ProjectID IN (SELECT OrderNum FROM [ERPDB].[Erp].OrderHed WHERE UserDate1 BETWEEN @StartDate AND @EndDate AND OpenOrder = 0 AND Company = @Company) OR 	
							(od.ProjectID = '' AND oh.OpenOrder = 0 AND oh.UserDate1 BETWEEN @StartDate AND @EndDate)	
						)	
					)	
				)	
			)	

		-- Accounting for Thermo Currency Exchange Rate
		UPDATE #TLines
		SET AdvanceBillBal = AdvanceBillBal*ExchangeRate, 
			Discount = Discount*ExchangeRate, 
			OriginalEstimate = OriginalEstimate*ExchangeRate
		WHERE Company = 'TES'

		--Updating the Division to be set from the projectID 	
        UPDATE #TLines	
        SET Division = ohu.Division_c	
        FROM #TLines T	
        INNER JOIN [ERPDB].[ERP].OrderHed oh on	
            oh.OrderNum = T.ProjectID and oh.Company = T.Company	
        INNER JOIN [ERPDB].[ERP].OrderHed_UD ohu on	
            oh.SysRowID = ohu.ForeignSysRowID	

        --DELETE Order Lines that actually belong to other divisions.	
        IF ISNULL(@Division,-1) != -1	
        BEGIN	
                DELETE FROM #TLines where Company = @Company and Division != @Division	
        END	

		-- If PrePost needs to be Validated, run Order Numbers through the validatePrePost SP	
		If @ValidatePrePost = 1	
		BEGIN 	
			INSERT INTO @OrderList SELECT OrderNum FROM #TLines	
			CREATE TABLE #JobProdErrors (Company nvarchar(8), JobNum nvarchar(14))	
			INSERT INTO #JobProdErrors EXEC [RBI].[dbo].CostService2019_ValidatePrePost @Company, @OrderList	
			SELECT * FROM #JobProdErrors	
			DROP TABLE #JobProdErrors	
		END	
		ELSE BEGIN	
			 	
			-- UPDATING the costs to be a sum of PartTrans costs when OrderRel Make = 0	
			UPDATE #TLines	
			SET MaterialCost += pt.MaterialCost,	
				LaborCost += pt.LaborCost,	
				OverheadCost += pt.OverheadCost,	
				OutsideCost += pt.OutsideCost	
			FROM #TLines T	
			INNER JOIN (	
				SELECT 	
					SUM(TranQty*(MtlBurUnitCost + MtlUnitCost)) AS MaterialCost,	
					SUM(TranQty*LbrUnitCost) AS LaborCost,	
					SUM(TranQty*BurUnitCost) AS OverHeadCost,	
					SUM(TranQty*SubUnitCost) AS OutsideCost,	
					pt.Company, pt.OrderNum, pt.OrderLine	
				FROM 	
					[ERPDB].[Erp].PartTran pt	
					INNER JOIN #TLines T	
						ON T.Company = pt.company AND T.OrderNum = pt.OrderNum AND T.OrderLine = pt.OrderLine	
					INNER JOIN [ERPDB].[Erp].OrderRel orl	
						ON T.Company = orl.Company AND T.OrderNum = orl.OrderNum AND T.OrderLine = orl.OrderLine AND orl.OrderRelNum = pt.OrderRelNum	
				WHERE orl.Make = 0	
				GROUP BY 	
					pt.Company, pt.OrderNum, pt.OrderLine) as pt	
				ON T.Company = pt.company AND T.OrderNum = pt.OrderNum AND T.OrderLine = pt.OrderLine	

			-- UPDATING the costs to be a sum of JobAsmbls costs when OrderRel Make = 1	
			UPDATE #TLines	
			SET MaterialCost += jc.MaterialCost,	
				LaborCost += jc.LaborCost,	
				OverheadCost += jc.OverheadCost,	
				OutsideCost += jc.OutsideCost,	
				MaterialEstCost += jc.MaterialEstCost,	
				LaborEstCost += jc.LaborEstCost,	
				OverheadEstCost += jc.OverheadEstCost,	
				OutsideEstCost += jc.OutsideEstCost,	
				LineHours += jc.LineHours	
			FROM #TLines T	
			INNER JOIN (	
				SELECT	
					SUM(TLAMaterialCost + TLAMtlBurCost) AS MaterialCost,	
					SUM(TLALaborCost) AS LaborCost,	
					SUM(TLABurdenCost) AS OverHeadCost,	
					SUM(TLASubcontractCost)  AS OutsideCost,	
					SUM(IIF(TLEMaterialCost + TLEMtlBurCost > TLAMaterialCost + TLAMtlBurCost,	
						TLEMaterialCost + TLEMtlBurCost, TLAMaterialCost + TLAMtlBurCost)) AS MaterialEstCost,	
					SUM(IIF(TLELaborCost > TLALaborCost, TLELaborCost, TLALaborCost)) AS LaborEstCost,	
					SUM(IIF(TLEBurdenCost > TLABurdenCost, TLEBurdenCost, TLABurdenCost)) AS OverHeadEstCost,	
					SUM(IIF(TLESubcontractCost > TLASubcontractCost, TLESubcontractCost, TLASubcontractCost)) AS OutsideEstCost,	
					SUM(TLAProdHours + TLASetupHours) AS LineHours, 	
					orl.OrderNum, orl.OrderLine, ja.Company	
				FROM 	
					#TLines T	
					INNER JOIN [ERPDB].[Erp].OrderRel orl	
						ON T.Company = orl.Company AND T.OrderNum = orl.OrderNum AND T.OrderLine = orl.OrderLine	
					INNER JOIN [ERPDB].[ERp].JobProd jp	
						ON jp.Company = orl.Company AND jp.OrderNum = orl.OrderNum AND jp.OrderLine = orl.OrderLine AND jp.OrderRelNum = orl.OrderRelNum 	
					INNER JOIN [ERPDB].[Erp].JobAsmbl ja	
						ON ja.Company = T.Company AND ja.JobNum = jp.JobNum	
				WHERE orl.Make = 1	
				GROUP BY ja.Company, orl.OrderNum, orl.OrderLine	
				) as jc	
				ON jc.Company = T.Company AND jc.Ordernum = T.OrderNum AND jc.OrderLine = T.OrderLine
					
			-- Summing up the various costs to get TotalCost	
			UPDATE #TLines	
			SET TotalCost = MaterialCost + LaborCost + OverHeadCost + OutsideCost	

			-- Calculating the TotalShippedQty 	
			UPDATE #TLines	
			SET TotalShippedQty = TSQty	
			FROM #TLines T	
			INNER JOIN (	
				SELECT	
					SUM(OurJobShippedQty + OurStockShippedQty) AS TSQty,	
					orl.Company, orl.OrderNum, orl.OrderLine	
				FROM #TLines T 	
				INNER JOIN [ERPDB].[Erp].OrderRel orl 	
					ON T.Company = orl.Company AND T.OrderNum = orl.OrderNum AND T.OrderLine = orl.OrderLine	
				GROUP BY	
					orl.Company, orl.OrderNum, orl.OrderLine	
			) orl 	
			ON T.Company = orl.Company AND T.OrderNum = orl.OrderNum AND T.OrderLine = orl.OrderLine	
			
			-- Calculating ShippedQty (for later CurrentEstimate comparison)	
			UPDATE #TLines	
			SET ShippedQtyEst = IIF(TotalShippedQty > 0, TotalCost * OrderQty / TotalShippedQty, 0)	

			-- Setting initial CurrentEstimate to the TotalCost, ShippedQtyEst, or sum of EstCosts	
			UPDATE #TLines	
			SET CurrentEstimate = 	
				IIF(OpenLine = 0, TotalCost, 	
					IIF(	
						(	
							SELECT TOP 1 ja.JobNum	
							FROM #TLines T	
							INNER JOIN [ERPDB].[Erp].OrderRel orl	
								ON T.Company = orl.Company AND T.OrderNum = orl.OrderNum AND T.OrderLine = orl.OrderLine	
							INNER JOIN [ERPDB].[ERp].JobProd jp	
								ON jp.Company = orl.Company AND jp.OrderNum = orl.OrderNum AND jp.OrderLine = orl.OrderLine AND jp.OrderRelNum = orl.OrderRelNum  	
							INNER JOIN [ERPDB].[Erp].JobAsmbl ja	
								ON T.Company = ja.Company AND jp.JobNum = ja.JobNum	
						)IS NULL, ShippedQtyEst, MaterialEstCost + LaborEstCost + OverHeadEstCost + OutsideEstCost))	

			-- Setting CurrentEstimate to larger of OriginalEstimate or TotalCost if either is larger than itself	
			UPDATE #TLines	
			SET CurrentEstimate = 	
				IIF(OpenLine = 0, CurrentEstimate,	
					(IIF(OriginalEstimate > TotalCost AND OriginalEstimate > CurrentEstimate, OriginalEstimate,	
						(IIF(TotalCost > CurrentEstimate, TotalCost, CurrentEstimate)))))	

			-- Calculating the Gross Margins	
			UPDATE #TLines	
			SET OverUnder = OriginalEstimate - CurrentEstimate,	
				GrossMargin = SellPrice - CurrentEstimate,	
				GrossMarginOriginal = SellPrice - OriginalEstimate,	
				GrossMarginPercent = IIF(SellPrice > 0, GrossMargin / SellPrice, 0),	
				GrossMarginOriginalPercent = IIF(SellPrice > 0, GrossMarginOriginal / SellPrice, 0)	

			-- Calculating the MarkUps, PercentComplete, TotalBillings and FieldPriorityCount	
			UPDATE #TLines	
			SET	TotalBillings = TotalShippedQty * UnitPrice - IIF(OrderQty > 0, Discount * TotalShippedQty / OrderQty, 0),	
				FieldPriorityCount = IIF(PartNum LIKE '%FIELD PRIORITY%', TotalShippedQty, 0),	
				MarkUp = IIF(CurrentEstimate > 0, GrossMargin / CurrentEstimate, 0),	
				MarkUpOriginal = IIF(OriginalEstimate > 0, GrossMargin / OriginalEstimate, 0),	
				PercentComplete = 	
					IIF(CurrentEstimate = 0, 0,	
						IIF(TotalCost / CurrentEstimate > 1, 1, TotalCost / CurrentEstimate))	

			-- Setting TotalBillings to AdvanceBillBal if it is positive, calculating RevenueReceived	
			UPDATE #TLines 	
			SET TotalBillings = IIF(AdvanceBillBal > 0, AdvanceBillBal, TotalBillings),	
				RevenueReceived = SellPrice * PercentComplete	

			--Calculating PullBack	
			UPDATE #TLines	
			SET PullBack = SellPrice * RevenueReceived	

			-- Summing appropriate Order Lines values into Order Head table	
			INSERT INTO #THeader	
			SELECT	
				Company,	
				CASE WHEN IsNull(@OrderNum, 0) = 0	
					THEN	
					CASE WHEN ProjectID = 0	
						THEN OrderNum	
						ELSE ProjectID	
					END	
					ELSE OrderNum	
				END as OrderNum,	
				IsNull(CAST(SUM(SellPrice) AS decimal(22,8)), 0) AS SellPrice,	
				IsNull(CAST(SUM(MaterialCost) AS decimal(22,8)), 0) AS MaterialCost,	
				IsNull(CAST(SUM(LaborCost) AS decimal(22,8)), 0) AS LaborCost,	
				IsNull(CAST(SUM(OverHeadCost) AS decimal(22,8)), 0) AS OverHeadCost,	
				IsNull(CAST(SUM(OutsideCost) AS decimal(22,8)), 0) AS OutsideCost,	
				IsNull(CAST(SUM(TotalCost) AS decimal(22,8)), 0) AS TotalCost,	
				IsNull(CAST(SUM(CurrentEstimate) AS decimal(22,8)), 0) AS CurrentEstimate,	
				IsNull(CAST(SUM(OriginalEstimate) AS decimal(22,8)), 0) AS OriginalEstimate,	
				CAST(0 AS decimal(22,8)) AS PercentComplete,	
				IsNull(CAST(SUM(GrossMargin) AS decimal(22,8)), 0) AS GrossMargin,	
				IsNull(CAST(SUM(GrossMarginOriginal) AS decimal(22,8)), 0) AS GrossMarginOriginal,	
				CAST(0 AS decimal(22,8)) AS GrossMarginPercent,	
				CAST(0 AS decimal(22,8)) AS GrossMarginOriginalPercent,	
				CAST(0 AS decimal(22,8)) AS MarkUp,	
				CAST(0 AS decimal(22,8)) AS MarkUpOriginal,	
				IsNull(CAST(SUM(TotalBillings) AS decimal(22,8)), 0) AS TotalBillings,	
				CAST(0 AS decimal(22,8)) AS RevenueReceived,	
				CAST(0 AS decimal(22,8)) AS PullBack,	
				CAST(0 AS decimal(22,8)) AS BackLog,	
				IsNull(CAST(SUM(OverUnder) AS decimal(22,8)), 0) AS OverUnder,	
				CAST(0 AS int) AS CustNum,	
				CAST('' AS nvarchar(14)) AS ShipToNum,	
				CAST(0 as bit) AS NotSetProjectID, 	
				CAST(0 as bit) AS EmptyProjectID,	
				CAST('' AS date) AS OrderDate,	
				CAST(0 AS bit) AS OpenOrder,	
				CAST('' AS nvarchar(MAX)) AS SalesRepList,	
				CAST('' AS nvarchar(15)) AS FOB,	
				CAST('' AS nvarchar(75)) AS EntryPerson,	
				CAST('' AS nvarchar(50)) AS PONum,	
				CAST('' AS date) AS ClosedDate,	
				CAST(0 AS int) AS AddToWatchedJobs,	
				CAST( '' AS nvarchar(50)) Address1 ,	
				CAST( '' AS nvarchar(50)) Address2,	
				CAST( '' AS nvarchar(50)) Address3,	
				CAST( '' AS nvarchar(50)) City,	
				CAST( '' AS nvarchar(50)) Name,	
				CAST( '' AS nvarchar(20)) PhoneNum,	
				CAST( '' AS nvarchar(4)) ShipViaCode,	
				CAST( '' AS nvarchar(50)) State,	
				CAST( '' AS nvarchar(10)) ZIP,	
				CAST(0 AS int) AS Division	
			FROM #TLines	
			GROUP BY Company, CASE WHEN IsNull(@OrderNum, 0) = 0	
					THEN	
					CASE WHEN ProjectID = 0	
						THEN OrderNum	
						ELSE ProjectID	
					END	
					ELSE OrderNum	
				END	
			Order By Company, OrderNum	

			-- Retrieving relevant OrderHed information	
			UPDATE #THeader	
			SET 	
				CustNum = oh.CustNum, ShipToNum = oh.ShipToNum,	
				OrderDate = oh.OrderDate, OpenOrder = oh.OpenOrder, SalesRepList = oh.SalesRepList, 	
				FOB = oh.FOB, EntryPerson = oh.EntryPerson, PONum = oh.PONum, ClosedDate = oh.UserDate1,	
				AddToWatchedJobs = oh.UserInteger1, Division = ohu.Division_c	
			FROM	
				[ERPDB].[Erp].OrderHed oh	
				INNER JOIN [ERPDB].[Erp].OrderHed_UD ohu	
					ON oh.SysRowID = ohu.ForeignSysRowID	
				INNER JOIN #THeader th 	
					ON th.Company = oh.Company AND th.OrderNum = oh.OrderNum
						
			-- Retrieving relevant ShipTo information	
			UPDATE #THeader	
			SET	
				Address1 = s.Address1, Address2 = s.Address2, Address3 = s.Address3, City = s.City, Name = s.Name,	
				PhoneNum = s.PhoneNum, ShipViaCode = s.ShipViaCode, State = s.State, ZIP = s.ZIP	
			FROM	
				[ERPDB].[Erp].ShipTo s	
				INNER JOIN #THeader th	
					ON th.Company = s.Company AND th.ShipToNum = s.ShipToNum AND th.CustNum = s.CustNum	

			-- Calculating the GrossMargins, BackLog, MarkUps, and PercentComplete	
			UPDATE #THeader	
			SET GrossMarginPercent = IIF(SellPrice > 0, GrossMargin / SellPrice, 0),	
				GrossMarginOriginalPercent = IIF(SellPrice > 0, GrossMarginOriginal / SellPrice, 0),	
				BackLog = SellPrice - TotalBillings,	
				MarkUp = IIF(CurrentEstimate > 0, 1 + GrossMargin / CurrentEstimate, 0),	
				MarkUpOriginal = IIF(OriginalEstimate > 0, 1 + GrossMarginOriginal / OriginalEstimate, 0),	
				PercentComplete = IIF(CurrentEstimate = 0, 0, IIF(TotalCost / CurrentEstimate > 1, 100, TotalCost / CurrentEstimate))
					
			-- Calculating the RevenueReceived	
			UPDATE #THeader	
			SET RevenueReceived = SellPrice * PercentComplete	

			-- Calculating the PullBack	
			UPDATE #THeader	
			SET PullBack = ROUND(RevenueReceived - TotalBillings, 0)
				
			-- Creating Shipping Information	
			CREATE TABLE #ShipTo (Company nvarchar(8), OrderNum int, Address1 nvarchar(50), Address2 nvarchar(50), Address3 nvarchar(50), City nvarchar(50),	
			Name nvarchar(50), PhoneNum nvarchar(20), ShipViaCode nvarchar(4), State nvarchar(50), ZIP nvarchar(10), CustNum int, ShipToNum nvarchar(14))	
			INSERT INTO #ShipTo 	
			SELECT Company, OrderNum, Address1, Address2, Address3, City, Name, PhoneNum, ShipViaCode, State, ZIP, CustNum, ShipToNum	
			FROM #THeader	
			Order By Company, OrderNum	
			
			-- Creating Project IDs	
			CREATE TABLE #ProjectIDs (Company nvarchar(8), OrderNum int,ProjectID int, Name nvarchar(35))	
			INSERT INTO #ProjectIDs	
			SELECT DISTINCT tl.Company, OrderNum, tl.ProjectID, Name	
			FROM #TLines tl
			LEFT OUTER JOIN [ERPDB].[ERp].Project p
				ON p.Company = tl.Company AND p.ProjectID = CAST(tl.ProjectID as nvarchar(25))
			LEFT OUTER JOIN [ERPDB].[ERP].EmpBasic e
				ON e.Company = tl.Company AND e.EmpID = p.ConProjMgr
			WHERE tl.ProjectID != '' AND tl.Company = @Company	
			ORDER BY Company, OrderNum	

			-- Creating Sales Information	
			CREATE TABLE #SalesCatIDs (Company nvarchar(8), OrderNum int, SalesCatID nvarchar(4))	
			INSERT INTO #SalescatIDs	
			SELECT DISTINCT T.Company, T.OrderNum, SalesCatID	
			FROM #THeader T	
			INNER JOIN [ERPDB].[Erp].OrderDtl  od	
				ON T.Company = od.Company AND T.OrderNum = od.OrderNum	
			ORDER BY T.Company, T.OrderNum	
			
			-- Creating Order Information (Order Numbers that are in the OrderLines but not the OrderHeader)	
			CREATE TABLE #OrderNums (Company nvarchar(8), OrderNum int)	
			INSERT INTO #OrderNums	
			SELECT DISTINCT Company, OrderNum	
			FROM #TLines 	
			WHERE OrderNum IN (SELECT OrderNum FROM #TLines) AND 	
				OrderNum NOT IN (SELECT OrderNum FROM #THeader)	

			-- Creating Customer Information	
			CREATE TABLE #Customer (Company nvarchar(8), OrderNum int, Address1 nvarchar(50), City nvarchar(50), Comment nvarchar(MAX), CustID nvarchar(10),	
			FaxNum nvarchar(20), Name nvarchar(50), PhoneNum nvarchar(20), State nvarchar(50), ZIP nvarchar(10),CustNum int,CustomerType nvarchar(3),	
			SalesRepCode nvarchar(8), TerritoryID nvarchar(8), SalesRep nvarchar(50))	
			INSERT INTO #Customer	
			SELECT 	
				T.Company, OrderNum, c.Address1, c.City, c.Comment, CustID, FaxNum, c.Name, c.PhoneNum, c.State, c.Zip,	
				T.CustNum,CustomerType,c.SalesRepCode,TerritoryID,	
				CASE 	
					WHEN sr.EmailAddress != '' THEN SUBSTRING(sr.EmailAddress, 1, CHARINDEX('@', sr.EmailAddress) - 1) 	
					ELSE ''	
				END as SalesRep	
			FROM 	
				#THeader T	
				INNER JOIN [ERPDB].[Erp].Customer c	
					ON T.Company = c.Company AND T.CustNum = c.CustNum	
				LEFT JOIN [ERPDB].[ERp].SalesRep sr	
					ON sr.Company = c.Company AND sr.SalesRepCode = c.SalesRepCode	
			Order By Company, OrderNum	
			
			-- If PostFlag is true, insert costs into the temp PrePost Tables; otherwise return table information	
			IF @PostFlag = 1 	
			BEGIN	

				BEGIN TRANSACTION	
				INSERT INTO [RBI].[dbo].PrePostOrderCostHeader 	
				SELECT Company,OrderNum,0 as Posted,SellPrice,MaterialCost,	
					LaborCost,OverHeadCost,OutsideCost,TotalCost,CurrentEstimate,OriginalEstimate,PercentComplete,GrossMargin,GrossMarginOriginal,	
					GrossMarginPercent,GrossMarginOriginalPercent,MarkUp,MarkUpOriginal,TotalBillings,RevenueReceived,PullBack,BackLog,OverUnder,	
					CustNum,ShipToNum,NotSetProjectID,EmptyProjectID,OrderDate,OpenOrder,SalesRepList,FOB,EntryPerson,PONum,ClosedDate,AddToWatchedJobs,	
					Address1,Address2,Address3,City,Name,PhoneNum,ShipViaCode,State,ZIP,Division,GETDATE() as PrePostTime 	
				FROM #THeader	

				INSERT INTO [RBI].[dbo].PrePostOrderCostLines	
				SELECT Company,OrderNum,0 as Posted,OrderLine,SellPrice,MaterialCost,LaborCost,OutsideCost,OverHeadCost,TotalCost,	
					CurrentEstimate,OriginalEstimate,PercentComplete,GrossMargin,GrossMarginOriginal,GrossMarginOriginalPercent,GrossMarginPercent,MarkUp,	
					MarkUpOriginal,RevenueReceived,TotalBillings,PullBack,OverUnder,LineHours,FieldPriorityCount,AdvanceBillBal,Discount,OpenLine,OrderQty,	
					PartNum,ProdCode,ProjectID,SalesCatID,UnitPrice,PickListComment,OrderComment,LineDesc,Division,GETDATE() as PrePostTime,OpenOrder 	
				FROM #TLines	

				INSERT INTO [RBI].[dbo].PrePostOrderCostShipTo 	
				SELECT Company,OrderNum,0 as Posted,Address1,Address2,Address3,City,Name, PhoneNum, ShipViaCode,State,ZIP,CustNum,ShipToNum,GETDATE() as PrePostTime 	
				FROM #ShipTo	

				INSERT INTO [RBI].[dbo].PrePostOrderCostProjectIDs 	
				SELECT Company,OrderNum,0 as Posted,ProjectID,GETDATE() as PrePostTime,Name
				FROM #ProjectIDs	

				INSERT INTO [RBI].[dbo].PrePostOrderCostSalesCatIDs 	
				SELECT Company,OrderNum,0 as Posted,SalesCatID,GETDATE() as PrePostTime 	
				FROM #SalesCatIDs	

				INSERT INTO [RBI].[dbo].PrePostOrderCostOrderNumbers 	
				SELECT Company,OrderNum,0 as Posted,GETDATE() as PrePostTime 	
				FROM #OrderNums	

				INSERT INTO [RBI].[dbo].PrePostOrderCostCustomers 	
				SELECT Company,OrderNum,0 as Posted,Address1,City,Comment,CustID,FaxNum,Name,PhoneNum,State,ZIP,CustNum,CustomerType,SalesRepCode,	
					TerritoryID,SalesRep,GETDATE() as PrePostTime 	
				FROM #Customer	

				COMMIT TRANSACTION	
			END	
			ELSE BEGIN	

				-- Outputting the Result Tables	
				SELECT Company,OrderNum,SellPrice,MaterialCost,LaborCost,OverHeadCost,OutsideCost,TotalCost,CurrentEstimate,OriginalEstimate,PercentComplete,	
					GrossMargin,GrossMarginOriginal,GrossMarginPercent,GrossMarginOriginalPercent,MarkUp,MarkUpOriginal,TotalBillings,RevenueReceived,PullBack,	
					BackLog,OverUnder,CustNum,ShipToNum,NotSetProjectID,EmptyProjectID,OrderDate,OpenOrder,SalesRepList,FOB,EntryPerson,PONum,ClosedDate,	
					AddToWatchedJobs,Address1,Address2,Address3,City,Name,PhoneNum,ShipViaCode,State,ZIP,Division 	
				FROM #THeader ORDER BY Company, OrderNum	

				SELECT Company,OrderNum,OrderLine,SellPrice,MaterialCost,LaborCost,	
					OutsideCost,OverHeadCost,TotalCost,CurrentEstimate,OriginalEstimate, 	
					PercentComplete,GrossMargin,GrossMarginOriginal,GrossMarginOriginalPercent, 	
					GrossMarginPercent,MarkUp,MarkUpOriginal,RevenueReceived,TotalBillings,	
					PullBack,OverUnder,LineHours,FieldPriorityCount,AdvanceBillBal,	
					Discount,OpenLine,OrderQty,PartNum,ProdCode,ProjectID,	
					SalesCatID,UnitPrice,PickListComment,OrderComment,LineDesc,OpenOrder,Division	
				FROM #TLines ORDER BY Company, OrderNum, OrderLine	
				SELECT Company,OrderNum,Address1,Address2,Address3,City,Name, PhoneNum, ShipViaCode,State,ZIP,CustNum,ShipToNum FROM #ShipTo ORDER BY Company, OrderNum	

				SELECT Company,OrderNum,ProjectID,Name FROM #ProjectIDs ORDER BY Company, OrderNum	

				SELECT Company,OrderNum,SalesCatID FROM #SalesCatIDs ORDER BY Company, OrderNum	

				SELECT Company,OrderNum FROM #OrderNums ORDER BY Company, OrderNum	

				SELECT Company,OrderNum,Address1,City,Comment,CustID,FaxNum,Name,PhoneNum,State,ZIP,CustNum,CustomerType,SalesRepCode,	
					TerritoryID,SalesRep FROM #Customer Order By Company, OrderNum	

			END	
			DROP TABLE #TLines	
			DROP TABLE #THeader	
			DROP TABLE #ShipTo	
			DROP TABLE #ProjectIDs	
			DROP TABLE #SalesCatIDs	
			DROP TABLE #OrderNums	
			DROP TABLE #Customer	
		END	
	END	
END