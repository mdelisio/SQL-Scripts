Declare @Company Varchar(50)
Set @Company = 'Solar';

-- Select Distinct
--     od.Company,
--     od.ProjectID,
--     od.OrderNum,
--     oh.shiptoNum,
--     st.State as ShipToState,
--     st.Zip as ShipToZip
--   FROM [ERPDB].[etl].vwOrderDetail od
-- Left JOIN [ERPDB].[Erp].[orderhed] oh
--     on od.ordernum = oh.ordernum and od.company=oh.Company
-- Left Join [ERPDB].[Erp].[ShipTo] st 
--     on oh.shiptoNum = st.ShipToNum and oh.company = st.company and oh.CustNum = st.CustNum

--   WHERE od.Company = @Company


   Select Distinct
    oh.Company,
    oh.ProjectID_c as ProjectID,
    oh.OrderNum,
    oh.shiptoNum,
    st.State as ShipToState,
    st.Zip as ShipToZip
  FROM [ERPDB].[dbo].[orderhed] oh
Left Join [ERPDB].[Erp].[ShipTo] st 
    on oh.shiptoNum = st.ShipToNum and oh.company = st.company and oh.CustNum = st.CustNum

  WHERE oh.Company = @Company



