SELECT

    cr.result_id,

    cr.campaign_id,

    cr.campaign_name,

    cr.channel,

    cr.start_date,

    cr.end_date,

    cr.total_spend_cad,

    cr.total_revenue_cad,

    cr.conversions,

    cr.conversion_rate,

    cr.roas,

    cr.new_customers,

    cr.returning_customers,

    cr.province,

    -- From marketing_spend

    ms.spend_date,

    ms.spend_amount_cad,

    ms.impressions,

    ms.clicks,

    ms.ctr,

    ms.budget_allocated,

    ms.budget_remaining

FROM RETAILIQ_DB.STAGING.CAMPAIGN_RESULTS_CLEAN cr

LEFT JOIN RETAILIQ_DB.STAGING.MARKETING_SPEND_CLEAN ms

    ON cr.campaign_id = ms.campaign_id
 

 