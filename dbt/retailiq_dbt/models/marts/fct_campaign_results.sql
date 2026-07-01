SELECT
    result_id,
    campaign_id,
    channel,
    start_date,
    end_date,
    total_spend_cad,
    total_revenue_cad,
    conversions,
    conversion_rate,
    roas,
    new_customers,
    returning_customers,
    province
FROM RETAILIQ_DB.STAGING.CAMPAIGN_RESULTS_CLEAN