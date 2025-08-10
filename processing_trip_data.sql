-- Check for NULL values in each column
SELECT
  COUNTIF(ride_id IS NULL) AS ride_id_nulls,
  COUNTIF(rideable_type IS NULL) AS rideable_type_nulls,
  COUNTIF(started_at IS NULL) AS started_at_nulls,
  COUNTIF(ended_at IS NULL) AS ended_at_nulls,
  COUNTIF(ride_length IS NULL) AS ride_length_nulls,
  COUNTIF(weekday IS NULL) AS weekday_nulls,
  COUNTIF(start_station_name IS NULL) AS start_station_name_nulls,
  COUNTIF(start_station_id IS NULL) AS start_station_id_nulls,
  COUNTIF(end_station_name IS NULL) AS end_station_name_nulls,
  COUNTIF(end_station_id IS NULL) AS end_station_id_nulls,
  COUNTIF(start_lat IS NULL) AS start_lat_nulls,
  COUNTIF(start_lng IS NULL) AS start_lng_nulls,
  COUNTIF(end_lat IS NULL) AS end_lat_nulls,
  COUNTIF(end_lng IS NULL) AS end_lng_nulls,
  COUNTIF(member_casual IS NULL) AS member_casual_nulls
FROM `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`;
