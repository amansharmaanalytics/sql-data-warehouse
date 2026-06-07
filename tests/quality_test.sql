-- Null Check
SELECT *
FROM silver.crm_cust_info
WHERE cst_id IS NULL;

-- Duplicate Check
SELECT cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;

-- Date Validation
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt;

-- Negative Values
SELECT *
FROM silver.crm_sales_details
WHERE sls_sales < 0;

-- Referential Integrity
SELECT *
FROM silver.crm_sales_details s
LEFT JOIN silver.crm_cust_info c
ON s.sls_cust_id = c.cst_id
WHERE c.cst_id IS NULL;


USE Datawarehouse;
GO

CREATE OR ALTER PROCEDURE silver.quality_checks
AS
BEGIN

    PRINT '=================================';
    PRINT 'QUALITY CHECKS';
    PRINT '=================================';

    --------------------------------------------------
    -- CRM CUSTOMER INFO
    --------------------------------------------------

    PRINT 'Checking crm_cust_info';

    SELECT *
    FROM silver.crm_cust_info
    WHERE cst_id IS NULL;

    SELECT cst_id, COUNT(*)
    FROM silver.crm_cust_info
    GROUP BY cst_id
    HAVING COUNT(*) > 1;

    --------------------------------------------------
    -- CRM PRODUCT INFO
    --------------------------------------------------

    PRINT 'Checking crm_prd_info';

    SELECT *
    FROM silver.crm_prd_info
    WHERE prd_id IS NULL;

    SELECT prd_key, COUNT(*)
    FROM silver.crm_prd_info
    GROUP BY prd_key
    HAVING COUNT(*) > 1;

    SELECT *
    FROM silver.crm_prd_info
    WHERE prd_cost < 0;

    --------------------------------------------------
    -- CRM SALES DETAILS
    --------------------------------------------------

    PRINT 'Checking crm_sales_details';

    SELECT *
    FROM silver.crm_sales_details
    WHERE sls_order_dt > sls_ship_dt;

    SELECT *
    FROM silver.crm_sales_details
    WHERE sls_sales < 0;

    SELECT *
    FROM silver.crm_sales_details
    WHERE sls_quantity < 0;

    --------------------------------------------------
    -- ERP CUSTOMER
    --------------------------------------------------

    PRINT 'Checking erp_cust_az12';

    SELECT *
    FROM silver.erp_cust_az12
    WHERE bdate > GETDATE();

    --------------------------------------------------
    -- ERP LOCATION
    --------------------------------------------------

    PRINT 'Checking erp_loc_a101';

    SELECT *
    FROM silver.erp_loc_a101
    WHERE cntry IS NULL;

    --------------------------------------------------
    -- ERP PRODUCT CATEGORY
    --------------------------------------------------

    PRINT 'Checking erp_px_cat_g1v2';

    SELECT *
    FROM silver.erp_px_cat_g1v2
    WHERE cat IS NULL
       OR subcat IS NULL;

    PRINT '=================================';
    PRINT 'QUALITY CHECK COMPLETED';
    PRINT '=================================';

END;
GO
