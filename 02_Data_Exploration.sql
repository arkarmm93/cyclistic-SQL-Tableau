-- Data Exploration

-- checking the data types of all columns

SELECT column_name, data_type
FROM cyclistic_bike_share.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'trip_2023_combined' ;


-- Check Total records of combined file
SELECT *
FROM cyclistic_bike_share.trip_2023_combined;
-- Total of 5719877 records

-- Check the number of null values in each column
SELECT 
  COUNT(*) - COUNT(ride_id) ride_id,
  COUNT(*) - COUNT(rideable_type) rideable_type,
  COUNT(*) - COUNT(started_at) started_at,
  COUNT(*) - COUNT(ended_at) ended_at,
  COUNT(*) - COUNT(start_station_name) start_station_name,
  COUNT(*) - COUNT(start_station_id) start_station_id,
  COUNT(*) - COUNT(end_station_name) end_station_name,
  COUNT(*) - COUNT(end_station_id) end_station_id,
  COUNT(*) - COUNT(start_lat) start_lat,
  COUNT(*) - COUNT(start_lng) start_lng,
  COUNT(*) - COUNT(end_lat) end_lat,
  COUNT(*) - COUNT(end_lng) end_lng,
  COUNT(*) - COUNT(member_casual) member_casual
FROM cyclistic_bike_share.trip_2023_combined;

-- Investigate data quality column by column

-- 1) rider_id: No Duplicates & Ensure consistent length of rider IDs 
-- checking for duplicate rows
SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM cyclistic_bike_share.trip_2023_combined;

-- Ensure consistent length of rider IDs
SELECT LENGTH(ride_id) AS rider_id_length
FROM cyclistic_bike_share.trip_2023_combined
GROUP BY rider_id_length;
-- All ride_ids consist of 16 characters.

-- 2) rideable_type: Identify bike types
SELECT DISTINCT rideable_type
FROM cyclistic_bike_share.trip_2023_combined
-- Three bike types observed: classic, electric, and docked.

-- 3) started_at, ended_at: Analyze ride duration. Identify rides that are extremely short or unusually long
SELECT ride_id, started_at, ended_at
FROM cyclistic_bike_share.trip_2023_combined
WHERE 
    TIMESTAMP_DIFF(ended_at, started_at, MINUTE) <= 1 OR -- less than a minute
    TIMESTAMP_DIFF(ended_at, started_at, MINUTE) >= 1440; -- more than a day
-- less than a minute = 263293 records
-- more than a minute =   6418 records 
-- total              = 269711 records
-- Also checks for cases where the end time is before the start time.
-- Timestamp format: YYYY-MM-DD hh:mm:ss UTC.

-- 4) Name & ID of start_station and end_station
SELECT DISTINCT start_station_name, COUNT(*) AS count_start_station
FROM cyclistic_bike_share.trip_2023_combined
GROUP BY start_station_name;
-- Total distinct start_station_names observed, including null values.

SELECT DISTINCT end_station_name, COUNT(*) AS count_end_station
FROM cyclistic_bike_share.trip_2023_combined
GROUP BY end_station_name;
-- Total distinct end_station_names observed, including null values.

SELECT DISTINCT start_station_id, end_station_id
FROM cyclistic_bike_share.trip_2023_combined
WHERE start_station_id IS NOT NULL OR end_station_id IS NOT NULL;
-- Null values observed in station IDs. 
-- 172490 records
-- Inconsistent string lengths in station IDs ignored as they're not critical.

-- 5) Latitude & Longitude of start and end
SELECT * 
FROM cyclistic_bike_share.trip_2023_combined
WHERE
    start_lat IS NULL OR
    start_lng IS NULL OR
    end_lat IS NULL OR
    end_lng IS NULL OR
    end_lat = 0 OR
    end_lng = 0 NULL;
-- Total null values observed in latitude and longitude.
-- 6993 records (Null - 6990, zero - 3) records

-- 6) member_casual: Membership types
SELECT member_casual, COUNT(*) AS count_membership
FROM cyclistic_bike_share.trip_2023_combined
GROUP BY member_casual;
-- Two membership types observed: member and casual.
-- Total membership count matches total rows.
-- member = 3660698 records
-- casual = 2059179 records
-- total  = 5719877 records