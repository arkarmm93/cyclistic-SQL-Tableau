-- Data Analysis

-- Analyzing bike types used by riders
SELECT 
    member_casual, 
    rideable_type, 
    COUNT(*) AS total_trips
FROM 
    cyclistic_bike_share.trip_2023_combined_cleaned
GROUP BY 
    member_casual, 
    rideable_type
ORDER BY 
    member_casual, 
    total_trips;

-- Counting the number of trips per month
SELECT 
    month, 
    member_casual, 
    COUNT(ride_id) AS total_trips
FROM 
    cyclistic_bike_share.trip_2023_combined_cleaned
GROUP BY 
    month, 
    member_casual
ORDER BY 
    member_casual;

-- Counting the number of trips per day of the week
SELECT 
    day_of_week, 
    member_casual, 
    COUNT(ride_id) AS total_trips
FROM 
    cyclistic_bike_share.trip_2023_combined_cleaned
GROUP BY 
    day_of_week, 
    member_casual
ORDER BY 
    member_casual;

-- Counting the number of trips per hour
SELECT 
    EXTRACT(HOUR FROM started_at) AS hour_of_day, 
    member_casual, 
    COUNT(ride_id) AS total_trips
FROM 
    cyclistic_bike_share.trip_2023_combined_cleaned
GROUP BY 
    hour_of_day, 
    member_casual
ORDER BY 
    member_casual;

-- Calculating average ride length per month
SELECT 
    month, 
    member_casual, 
    AVG(ride_length) AS avg_ride_duration
FROM 
    cyclistic_bike_share.trip_2023_combined_cleaned
GROUP BY 
    month, 
    member_casual;

-- Calculating average ride length per day of the week
SELECT 
    day_of_week, 
    member_casual, 
    AVG(ride_length) AS avg_ride_duration
FROM 
    cyclistic_bike_share.trip_2023_combined_cleaned
GROUP BY 
    day_of_week, 
    member_casual;

-- Calculating average ride length per hour
SELECT 
    EXTRACT(HOUR FROM started_at) AS hour_of_day, 
    member_casual, 
    AVG(ride_length) AS avg_ride_duration
FROM 
    cyclistic_bike_share.trip_2023_combined_cleaned
GROUP BY 
    hour_of_day, 
    member_casual;

-- Identifying starting station locations
SELECT 
    start_station_name, 
    member_casual,
    AVG(start_lat) AS start_lat, 
    AVG(start_lng) AS start_lng,
    COUNT(ride_id) AS total_trips
FROM 
    cyclistic_bike_share.trip_2023_combined_cleaned
GROUP BY 
    start_station_name, 
    member_casual;

-- Identifying ending station locations
SELECT 
    end_station_name, 
    member_casual,
    AVG(end_lat) AS end_lat, 
    AVG(end_lng) AS end_lng,
    COUNT(ride_id) AS total_trips
FROM 
    cyclistic_bike_share.trip_2023_combined_cleaned
GROUP BY 
    end_station_name, 
    member_casual;