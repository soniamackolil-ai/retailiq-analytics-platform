SELECT
    cm.customer_id,
    cm.first_name,
    cm.last_name,
    cm.email,
    cm.phone,
    cm.date_of_birth,
    cm.gender,
    cm.city,
    cm.province,
    cm.postal_code,
    cm.customer_segment,
    cm.registration_date,
    cm.is_active,
    cm.loyalty_points,
    cm.lifetime_value,
    -- From customer_segments with NULL handling
    COALESCE(cs.segment, 'Unknown')              AS segment,
    COALESCE(cs.segment_score, 0)                AS segment_score,
    COALESCE(cs.clv_predicted, 0)                AS clv_predicted,
    COALESCE(cs.churn_risk, 'Unknown')           AS churn_risk,
    cs.last_purchase_date,
    COALESCE(cs.purchase_frequency, 0)           AS purchase_frequency,
    COALESCE(cs.avg_order_value, 0)              AS avg_order_value,
    COALESCE(cs.preferred_category, 'Unknown')   AS preferred_category,
    COALESCE(cs.preferred_channel, 'Unknown')    AS preferred_channel,
    CASE
    WHEN clv_predicted <= 6413  THEN 'Bronze'
    WHEN clv_predicted <= 12803 THEN 'Silver'
    WHEN clv_predicted <= 18959 THEN 'Gold'
    WHEN clv_predicted > 18959  THEN 'Platinum'
    ELSE 'Unknown'
END AS clv_tier,
-- Full province name for Power BI map
CASE province
    WHEN 'ON' THEN 'Ontario'
    WHEN 'BC' THEN 'British Columbia'
    WHEN 'AB' THEN 'Alberta'
    WHEN 'QC' THEN 'Quebec'
    WHEN 'MB' THEN 'Manitoba'
    WHEN 'SK' THEN 'Saskatchewan'
    WHEN 'NS' THEN 'Nova Scotia'
    WHEN 'NB' THEN 'New Brunswick'
    WHEN 'NL' THEN 'Newfoundland and Labrador'
    WHEN 'PE' THEN 'Prince Edward Island'
    WHEN 'YT' THEN 'Yukon'
    WHEN 'NT' THEN 'Northwest Territories'
    WHEN 'NU' THEN 'Nunavut'
    ELSE province
END AS province_name
FROM RETAILIQ_DB.STAGING.CUSTOMER_MASTER_CLEAN cm
LEFT JOIN RETAILIQ_DB.STAGING.CUSTOMER_SEGMENTS_CLEAN cs
    ON cm.customer_id = cs.customer_id