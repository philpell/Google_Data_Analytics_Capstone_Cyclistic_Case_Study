-- Check for duplicates within the ride_id column, this should produce no data
SELECT 
  ride_id, 
  COUNT(*) AS dup_count
FROM `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`
GROUP BY ride_id
HAVING COUNT(*) > 1
ORDER BY dup_count DESC;

-- NULL value count (and % of total) for each key column. High null percentages may indicate missing data problems.
SELECT
  COUNT(*) AS total_rows,
  COUNTIF(ride_id IS NULL) AS ride_id_nulls,
  ROUND(COUNTIF(ride_id IS NULL) / COUNT(*) * 100, 2) AS ride_id_nulls_pct,
  COUNTIF(rideable_type IS NULL) AS rideable_type_nulls,
  ROUND(COUNTIF(rideable_type IS NULL) / COUNT(*) * 100, 2) AS rideable_type_nulls_pct,
  COUNTIF(started_at IS NULL) AS started_at_nulls,
  ROUND(COUNTIF(started_at IS NULL) / COUNT(*) * 100, 2) AS started_at_nulls_pct,
  COUNTIF(ended_at IS NULL) AS ended_at_nulls,
  ROUND(COUNTIF(ended_at IS NULL) / COUNT(*) * 100, 2) AS ended_at_nulls_pct,
  COUNTIF(start_station_name IS NULL) AS start_station_name_nulls,
  COUNTIF(end_station_name IS NULL) AS end_station_name_nulls,
  COUNTIF(start_lat IS NULL) AS start_lat_nulls,
  COUNTIF(start_lng IS NULL) AS start_lng_nulls,
  COUNTIF(end_lat IS NULL) AS end_lat_nulls,
  COUNTIF(end_lng IS NULL) AS end_lng_nulls,
  COUNTIF(member_casual IS NULL) AS member_casual_nulls
FROM `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`;

-- Check for:
-- - Trips ending before starting (negative duration)
-- - Very short trips (< 1 minute)
-- - Very long trips (> 24 hours)
SELECT
  COUNTIF(ended_at < started_at) AS negative_duration_rows,
  COUNTIF(TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 1) AS very_short_trips,
  COUNTIF(TIMESTAMP_DIFF(ended_at, started_at, HOUR) > 24) AS very_long_trips
FROM `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`;

-- Check to ensure only expected categorical values are present i.e. membership type should be 'member' or 'casual'.
-- Also, rideable type should be 'electric_bike', 'classic_bike', or 'docked_bike'.
SELECT
  COUNTIF(member_casual NOT IN ('member', 'casual')) AS invalid_membership_type,
  COUNTIF(rideable_type NOT IN ('electric_bike', 'classic_bike', 'docked_bike')) AS invalid_ride_type
FROM `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`;

-- Check for latitude values between -90 and 90, and longitude between -180 and 180, values outside these ranges indicate invalid GPS data.
SELECT
  COUNTIF(start_lat < -90 OR start_lat > 90) AS invalid_start_lat,
  COUNTIF(start_lng < -180 OR start_lng > 180) AS invalid_start_lng,
  COUNTIF(end_lat < -90 OR end_lat > 90) AS invalid_end_lat,
  COUNTIF(end_lng < -180 OR end_lng > 180) AS invalid_end_lng
FROM `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`;

