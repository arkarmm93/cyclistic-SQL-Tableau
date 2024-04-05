-- Data Cleaning

-- Drop the table if it exists to ensure a fresh start
DROP TABLE IF EXISTS cyclistic_bike_share.trip_2023_combined_cleaned;

-- Create a new table to store cleaned data
CREATE TABLE IF NOT EXISTS cyclistic_bike_share.trip_2023_combined_cleaned AS (
  SELECT 
    a.ride_id, rideable_type, started_at, ended_at, ride_length,
    -- Convert day of the week to abbreviated form (e.g., MON, TUES)
    CASE EXTRACT(DAYOFWEEK FROM started_at) 
      WHEN 1 THEN 'SUN'
      WHEN 2 THEN 'MON'
      WHEN 3 THEN 'TUES'
      WHEN 4 THEN 'WED'
      WHEN 5 THEN 'THURS'
      WHEN 6 THEN 'FRI'
      WHEN 7 THEN 'SAT'    
    END AS day_of_week,
    -- Convert month to abbreviated form (e.g., JAN, FEB)
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS month,
    start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
  FROM cyclistic_bike_share.trip_2023_combined AS a
  -- Join to calculate ride length in minutes
  JOIN (
    SELECT ride_id, TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length -- in minutes
    FROM cyclistic_bike_share.trip_2023_combined
  ) AS b 
  ON a.ride_id = b.ride_id
  -- Filter out rows with missing values and abnormal ride lengths
  WHERE 
    start_station_name IS NOT NULL AND
    start_station_id IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_station_id IS NOT NULL AND
    start_lat IS NOT NULL AND
    start_lng IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    end_lat <> 0 AND
    end_lng <> 0 AND
    ride_length > 1 AND ride_length < 1440
);

-- Set ride_id as primary key for the table
ALTER TABLE cyclistic_bike_share.trip_2023_combined_cleaned
ADD PRIMARY KEY(ride_id) NOT ENFORCED;

-- Count the number of rows in the cleaned dataset
SELECT COUNT(ride_id) AS no_of_rows       
FROM cyclistic_bike_share.trip_2023_combined_cleaned;
-- 4168498 Records