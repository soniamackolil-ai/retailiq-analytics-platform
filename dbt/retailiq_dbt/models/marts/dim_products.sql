SELECT
    product_id,
    product_name,
    category_clean      AS category,
    sub_category,
    brand,
    unit_cost,
    unit_price,
    unit_price - unit_cost  AS unit_margin,
    sku,
    is_active,
    launch_date,
    supplier_country
FROM RETAILIQ_DB.STAGING.PRODUCT_CLEAN