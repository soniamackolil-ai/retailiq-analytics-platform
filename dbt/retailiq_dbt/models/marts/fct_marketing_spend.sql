SELECT
    spend_id,
    campaign_id,
    channel,
    spend_date,
    spend_amount_cad,
    impressions,
    clicks,
    ctr,
    province,
    budget_allocated,
    budget_remaining
FROM RETAILIQ_DB.STAGING.MARKETING_SPEND_CLEAN