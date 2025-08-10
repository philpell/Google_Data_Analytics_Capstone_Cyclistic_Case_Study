-- Create a cleaned version of the combined dataset
CREATE OR REPLACE TABLE `chrome-theater-456309-n2.cyclistic_bike_share.cleaned_ride_data` AS
SELECT *
FROM `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`;

-- Remove rows with missing key fields
DELETE FROM `chrome-theater-456309-n2.cyclistic_bike_share.cleaned_ride_data`
WHERE ride_id IS NULL
   OR started_at IS NULL
   OR ended_at IS NULL
   OR member_casual IS NULL
   OR rideable_type IS NULL
   OR start_lat	IS NULL 
   OR start_lng IS NULL 
   OR end_lat IS NULL 
   OR end_lng IS NULL
;

-- Remove trips with invalid time logic i.e. ended_at earlier than started_at, trips shorter than 1 minute or trips longer than 24 hours
DELETE FROM `chrome-theater-456309-n2.cyclistic_bike_share.cleaned_ride_data`
WHERE ended_at < started_at
   OR TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 1
   OR TIMESTAMP_DIFF(ended_at, started_at, HOUR) > 24;

-- Standardise categorical values, lowercase and trim spaces from 'member_casual' and 'rideable_type'
UPDATE `chrome-theater-456309-n2.cyclistic_bike_share.cleaned_ride_data`
SET member_casual = LOWER(TRIM(member_casual)),
    rideable_type = LOWER(TRIM(rideable_type))
WHERE TRUE;

-- After cleaning, the processing_trip_data script was run on cleaned_ride_data to ensure:
--   - No missing key fields
--   - No invalid times
--   - No invalid coordinates
--   - Consistent categorical values
-- The final cleaned table produced 5523105 data rows
