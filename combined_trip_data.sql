-- As good practice, check for existing table before combining the ride data into a new table

DROP TABLE IF EXISTS `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`;

-- Query to combine the 17 tables with data covering the period between August 2024 to July 2025 into a single table.

CREATE TABLE IF NOT EXISTS `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data` AS (
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.aug_2024_1` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.aug_2024_2` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.sept_2024_1` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.sept_2024_2` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.oct_2024_1` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.oct_2024_2` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.nov_2024` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.dec_2024` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.jan_2025` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.feb_2025` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.mar_2025` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.apr_2025` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.may_2025` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.jun_2025_1` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.jun_2025_2` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.jul_2025_1` UNION ALL
  SELECT * FROM `chrome-theater-456309-n2.cyclistic_bike_share.jul_2025_2`
  );

-- checking no of rows

SELECT COUNT(*)
FROM `chrome-theater-456309-n2.cyclistic_bike_share.combined_ride_data`;

-- 5611500 returned, this matched the combined individual files indicating all trip data was successfully combined
