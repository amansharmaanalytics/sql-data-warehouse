CREATE OR ALTER VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER(ORDER BY p.prd_id) AS product_key,
    p.prd_id AS product_id,
    p.prd_key AS product_number,
    p.prd_nm AS product_name,
    p.prd_cost AS product_cost,
    p.prd_line AS product_line,
    c.cat AS category,
    c.subcat AS sub_category,
    c.maintenance
FROM silver.crm_prd_info p
LEFT JOIN silver.erp_px_cat_g1v2 c
    ON p.prd_key = c.id;
GO
