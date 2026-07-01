SELECT
    campaign_id,
    campaign_name,
    MIN(start_date) AS start_date,
    MAX(end_date)   AS end_date,
    ANY_VALUE(province) AS province
FROM RETAILIQ_DB.STAGING.CAMPAIGN_RESULTS_CLEAN
GROUP BY campaign_id, campaign_name
 

 