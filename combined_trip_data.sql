-- Delete the combined table if it already exists
DROP TABLE IF EXISTS `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`;

-- Create a new combined table using wildcard tables, this merges all monthly tables from Aug 2024 to Jul 2025 and keeps track of which table each row came from.
CREATE OR REPLACE TABLE `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data` AS
SELECT 
    -- I have explicitly listed columns to ensure schema consistency
    ride_id, 
    rideable_type, 
    started_at, 
    ended_at,
    ride_length,	
    weekday, 
    start_station_name, 
    start_station_id, 
    end_station_name, 
    end_station_id, 
    start_lat, 
    start_lng, 
    end_lat, 
    end_lng, 
    member_casual,

    -- Add column to track original table (may be required for debugging)
    _TABLE_SUFFIX AS source_file
FROM 
    `chrome-theater-456309-n2.cyclistic_bike_share.*`
WHERE 
    -- A list of all tables to be included using the BigQuery-specific wildcard tables feature _TABLE_SUFFIX
    _TABLE_SUFFIX IN (
        'aug_2024_1', 'aug_2024_2',
        'sept_2024_1', 'sept_2024_2',
        'oct_2024_1', 'oct_2024_2',
        'nov_2024', 
        'dec_2024', 
        'jan_2025', 
        'feb_2025', 
        'mar_2025', 
        'apr_2025', 
        'may_2025', 
        'jun_2025_1', 'jun_2025_2', 
        'jul_2025_1', 'jul_2025_2'
    );

-- A summary of row counts for each original monthly file, plus a grand total.
-- May be useful for confirming all files contributed the expected number of rows.
SELECT source_file, COUNT(*) AS no_of_rows
FROM `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`
GROUP BY source_file

UNION ALL

SELECT 'TOTAL', COUNT(*) AS no_of_rows
FROM `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`
ORDER BY source_file;
