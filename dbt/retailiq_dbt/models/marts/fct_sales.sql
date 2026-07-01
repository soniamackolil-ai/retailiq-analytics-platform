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

    -- From dim_products (handle missing products)

    COALESCE(p.product_name, 'UNKNOWN_PRODUCT')              AS product_name,

    COALESCE(p.category_clean, 'UNKNOWN_CATEGORY')           AS category,

    COALESCE(p.brand, 'UNKNOWN_BRAND')                       AS brand,

    COALESCE(p.unit_cost, s.unit_price * 0.5)                AS unit_cost,

    -- Gross margin with NULL protection

    s.total_amount - (s.quantity * COALESCE(p.unit_cost, s.unit_price * 0.5)) AS gross_margin,

    -- Revenue tier

    CASE

        WHEN s.total_amount > 500 THEN 'High'

        WHEN s.total_amount > 100 THEN 'Medium'

        ELSE 'Low'

    END AS revenue_tier,

    -- From dim_stores (handle ONLINE orders)

    COALESCE(st.store_name, 'Online Store')                  AS store_name,

    COALESCE(st.city, 'Online')                              AS city,

    COALESCE(st.province, 'Online')                          AS province,

    COALESCE(st.region, 'Online')                            AS region

FROM RETAILIQ_DB.STAGING.SALE_CLEAN s

LEFT JOIN RETAILIQ_DB.STAGING.PRODUCT_CLEAN p

    ON s.product_id = p.product_id

LEFT JOIN RETAILIQ_DB.STAGING.STORES_CLEAN st

    ON s.store_code = st.store_code
 