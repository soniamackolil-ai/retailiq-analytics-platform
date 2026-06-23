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

    -- From customer_segments

    cs.segment,

    cs.segment_score,

    cs.clv_predicted,

    cs.churn_risk,

    cs.last_purchase_date,

    cs.purchase_frequency,

    cs.avg_order_value,

    cs.preferred_category,

    cs.preferred_channel

FROM RETAILIQ_DB.STAGING.CUSTOMER_MASTER_CLEAN cm

LEFT JOIN RETAILIQ_DB.STAGING.CUSTOMER_SEGMENTS_CLEAN cs

    ON cm.customer_id = cs.customer_id
 

 