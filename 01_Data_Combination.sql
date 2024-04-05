-- Check table is already existing

DROP TABLE IF EXISTS cyclistic_bike_share.trip_2023_combined;

-- Create a new table for 2023 using 12 month data sets (Jan-Dec)

CREATE TABLE cyclistic_bike_share.trip_2023_combined AS (
  SELECT * FROM cyclistic_bike_share.trip_2023_01
  UNION ALL
  SELECT * FROM cyclistic_bike_share.trip_2023_02
  UNION ALL
  SELECT * FROM cyclistic_bike_share.trip_2023_03
  UNION ALL
  SELECT * FROM cyclistic_bike_share.trip_2023_04
  UNION ALL
  SELECT * FROM cyclistic_bike_share.trip_2023_05
  UNION ALL
  SELECT * FROM cyclistic_bike_share.trip_2023_06
  UNION ALL
  SELECT * FROM cyclistic_bike_share.trip_2023_07
  UNION ALL
  SELECT * FROM cyclistic_bike_share.trip_2023_08
  UNION ALL
  SELECT * FROM cyclistic_bike_share.trip_2023_09
  UNION ALL
  SELECT * FROM cyclistic_bike_share.trip_2023_10
  UNION ALL
  SELECT * FROM cyclistic_bike_share.trip_2023_11
  UNION ALL
  SELECT * FROM cyclistic_bike_share.trip_2023_12
);

-- checking no of rows which are 5719877

SELECT COUNT(*)
FROM cyclistic_bike_share.trip_2023_combined;