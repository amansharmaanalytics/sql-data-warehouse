CREATE OR ALTER VIEW gold.sales_report AS
SELECT

    fs.order_number,
    fs.order_date,

    dc.customer_number,
    dc.first_name,
    dc.last_name,
    dc.country,

    dp.product_name,
    dp.category,
    dp.sub_category,

    fs.quantity_sold,
    fs.unit_price,
    fs.sales_amount

FROM gold.fact_sales fs

LEFT JOIN gold.dim_customers dc
    ON fs.customer_id = dc.customer_id

LEFT JOIN gold.dim_products dp
    ON fs.product_number = dp.product_number;
GO
