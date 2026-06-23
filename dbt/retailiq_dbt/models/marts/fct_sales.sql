SELECT
    s.order_id,
    s.order_date,
    s.customer_id,
    s.product_id,
    s.store_code,
    s.quantity,
    s.unit_price,
    s.discount_pct,
    s.total_amount,
    s.payment_method,
    s.order_status,
    -- From dim_products
    p.product_name,
    p.category_clean,
    p.brand,
    p.unit_cost,
    -- Calculated fields
    s.total_amount - (s.quantity * p.unit_cost) AS gross_margin,
    CASE
        WHEN s.total_amount > 500 THEN 'High'
        WHEN s.total_amount > 100 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_tier,
    -- From dim_stores
    st.store_name,
    st.city,
    st.province,
    st.region
FROM RETAILIQ_DB.STAGING.SALE_CLEAN s
LEFT JOIN RETAILIQ_DB.STAGING.PRODUCT_CLEAN p
    ON s.product_id = p.product_id
LEFT JOIN RETAILIQ_DB.STAGING.STORES_CLEAN st
    ON s.store_code = st.store_code