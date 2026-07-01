SELECT
    product_id,
    product_name,
    category_clean                                    AS category,
    sub_category,
    brand,
    -- Fix DQ-005: estimate unit_cost if NULL
    COALESCE(unit_cost, unit_price * 0.5)            AS unit_cost,
    unit_price,
    unit_price - COALESCE(unit_cost, unit_price * 0.5) AS unit_margin,
    sku,
    is_active,
    launch_date,
    supplier_country
FROM RETAILIQ_DB.STAGING.PRODUCT_CLEAN