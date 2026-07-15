SELECT
    store_code,
    store_name,
    address,
    city,
    province,
    postal_code,
    latitude,
    longitude,
    store_size_sqft,
    opening_date,
    store_manager,
    phone,
    is_active,
    region,
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
FROM RETAILIQ_DB.STAGING.STORES_CLEAN