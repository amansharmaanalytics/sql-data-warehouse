CREATE OR ALTER VIEW gold.fact_sales AS
SELECT
    s.sls_ord_num AS order_number,
    s.sls_prd_key AS product_number,
    s.sls_cust_id AS customer_id,
    s.sls_order_dt AS order_date,
    s.sls_ship_dt AS ship_date,
    s.sls_due_dt AS due_date,
    s.sls_quantity AS quantity_sold,
    s.sls_price AS unit_price,
    s.sls_sales AS sales_amount
FROM silver.crm_sales_details s;
GO
