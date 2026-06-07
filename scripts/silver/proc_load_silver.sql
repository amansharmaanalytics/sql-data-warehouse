USE Datawarehouse;
GO

--------------------------------------------------
-- CREATE SCHEMA SILVER
--------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
BEGIN
    EXEC('CREATE SCHEMA silver');
END
GO

--------------------------------------------------
-- CREATE PROCEDURE
--------------------------------------------------

IF OBJECT_ID('silver.load_silver', 'P') IS NOT NULL
    DROP PROCEDURE silver.load_silver;
GO

CREATE PROCEDURE silver.load_silver
AS
BEGIN

    --------------------------------------------------
    -- CRM CUSTOMER INFO
    --------------------------------------------------

TRUNCATE TABLE silver.crm_cust_info;

INSERT INTO silver.crm_cust_info
SELECT
    cst_id,
    cst_key,
    TRIM(cst_firstname),
    TRIM(cst_lastname),

    CASE
        WHEN cst_marital_status = 'S' THEN 'Single'
        WHEN cst_marital_status = 'M' THEN 'Married'
        ELSE 'n/a'
    END,

    CASE
        WHEN cst_gndr = 'M' THEN 'Male'
        WHEN cst_gndr = 'F' THEN 'Female'
        ELSE 'n/a'
    END,

    cst_create_date
FROM bronze.crm_cust_info;

    --------------------------------------------------
    -- CRM PRODUCT INFO
    --------------------------------------------------

    TRUNCATE TABLE silver.crm_prd_info;

    INSERT INTO silver.crm_prd_info
    (
        prd_id,
        prd_key,
        prd_nm,
        prd_cost,
        prd_line,
        prd_start_dt,
        prd_end_dt
    )
    SELECT
        prd_id,
        SUBSTRING(prd_key,7,LEN(prd_key)),
        pr_nm,
        ISNULL(prd_cost,0),
        CASE
            WHEN UPPER(TRIM(prd_line))='M' THEN 'Mountain'
            WHEN UPPER(TRIM(prd_line))='R' THEN 'Road'
            WHEN UPPER(TRIM(prd_line))='S' THEN 'Other Sales'
            WHEN UPPER(TRIM(prd_line))='T' THEN 'Touring'
            ELSE 'n/a'
        END,
        CAST(prd_start_dt AS DATE),
        CAST(
            LEAD(prd_start_dt)
            OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1
            AS DATE
        )
    FROM bronze.crm_prd_info;

    --------------------------------------------------
    -- CRM SALES DETAILS
    --------------------------------------------------

    TRUNCATE TABLE silver.crm_sales_details;

    INSERT INTO silver.crm_sales_details
    (
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,
        sls_order_dt,
        sls_ship_dt,
        sls_due_dt,
        sls_quantity,
        sls_sales,
        sls_price
    )
    SELECT
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,

        CASE
            WHEN sls_order_dt = 0 OR LEN(CAST(sls_order_dt AS VARCHAR(20))) <> 8
            THEN NULL
            ELSE CAST(CAST(sls_order_dt AS VARCHAR(8)) AS DATE)
        END,

        CASE
            WHEN sls_ship_dt = 0 OR LEN(CAST(sls_ship_dt AS VARCHAR(20))) <> 8
            THEN NULL
            ELSE CAST(CAST(sls_ship_dt AS VARCHAR(8)) AS DATE)
        END,

        CASE
            WHEN sls_due_dt = 0 OR LEN(CAST(sls_due_dt AS VARCHAR(20))) <> 8
            THEN NULL
            ELSE CAST(CAST(sls_due_dt AS VARCHAR(8)) AS DATE)
        END,

        sls_qualitity,

        CASE
            WHEN sls_sales IS NULL
              OR sls_sales <= 0
              OR sls_sales <> sls_qualitity * ABS(sls_price)
            THEN sls_qualitity * ABS(sls_price)
            ELSE sls_sales
        END,

        CASE
            WHEN sls_price IS NULL
              OR sls_price <= 0
            THEN sls_sales / NULLIF(sls_qualitity,0)
            ELSE sls_price
        END

    FROM bronze.crm_sales_details;

    --------------------------------------------------
    -- ERP CUSTOMER
    --------------------------------------------------

    TRUNCATE TABLE silver.erp_cust_az12;

    INSERT INTO silver.erp_cust_az12
    (
        cid,
        bdate,
        gen
    )
    SELECT
        cid,
        bdate,
        CASE
            WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
            WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
            ELSE 'n/a'
        END
    FROM bronze.erp_cust_az12;

    --------------------------------------------------
    -- ERP LOCATION
    --------------------------------------------------

    TRUNCATE TABLE silver.erp_loc_a101;

    INSERT INTO silver.erp_loc_a101
    (
        cid,
        cntry
    )
    SELECT
        REPLACE(cid,'-',''),
        CASE
            WHEN cntry='DE' THEN 'Germany'
            WHEN cntry IN ('US','USA') THEN 'United States'
            WHEN cntry IS NULL OR cntry='' THEN 'n/a'
            ELSE cntry
        END
    FROM bronze.erp_loc_a101;

    --------------------------------------------------
    -- ERP PRODUCT CATEGORY
    --------------------------------------------------

    TRUNCATE TABLE silver.erp_px_cat_g1v2;

    INSERT INTO silver.erp_px_cat_g1v2
    (
        id,
        cat,
        subcat,
        maintenance
    )
    SELECT
        id,
        cat,
        subcat,
        maintenance
    FROM bronze.erp_px_cat_g1v2;

END
GO

