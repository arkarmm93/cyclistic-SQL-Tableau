# Google Data Analytics Capstone: Cyclistic Case Study

## Introduction

In this case study, I will assume the role of a junior data analyst at Cyclistic, a fictional company. To address critical business inquiries, I will adhere to the structured data analysis process, encompassing the steps of Ask, Prepare, Process, Analyze, Share, and Act.

### Quick links:
- Data Source: [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) [accessed on 2024-03-30]

- SQL Queries:\
[01_Data Combining](https://github.com/arkarmm93/cyclistic-SQL-Tableau/blob/main/01_Data_Combination.sql),\
[02_Data Exploration](https://github.com/arkarmm93/cyclistic-SQL-Tableau/blob/main/02_Data_Exploration.sql),\
[03_Data Cleaning](https://github.com/arkarmm93/cyclistic-SQL-Tableau/blob/main/03_Data_Cleaning.sql),\
[04_Data Analysis](https://github.com/arkarmm93/cyclistic-SQL-Tableau/blob/main/04_Data_Analysis.sql),

- Data Visualizations: [Tableau](https://public.tableau.com/views/CyclisticCaseStudyAnalysis_17122671813330/BikeTypesUsedin2023?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link)

## Background

In 2016, Cyclistic launched a successful bike-share program in Chicago, which has since grown to encompass 5,824 bicycles across 692 stations. The program allows users to unlock bikes from one station and return them to any other station in the network. Cyclistic's marketing strategy has traditionally focused on raising general awareness and targeting broad consumer segments, offering pricing plans including single-ride passes, full-day passes, and annual memberships. Annual members have been identified as significantly more profitable than casual riders by Cyclistic's finance analysts. 

Director of Marketing, Moreno, believes that increasing the number of annual members is crucial for future growth. Rather than targeting entirely new customers, there is a strategic opportunity to convert casual riders into members, as they are already familiar with Cyclistic's program. 

Moreno's objective is to design marketing strategies specifically aimed at converting casual riders into annual members. To achieve this goal, the team aims to understand the differences between annual members and casual riders, why casual riders would consider purchasing a membership, and how digital media could impact their marketing tactics. Analysis of historical bike trip data is underway to identify trends that will inform these strategies.

## Scenario

As a junior data analyst on the marketing analyst team at Cyclistic, a bike-share company in Chicago, I am tasked with understanding the distinct behaviors of casual riders and annual members. The director of marketing emphasizes the importance of increasing annual memberships for the company's future success. Therefore, my team aims to uncover insights into how these two customer segments utilize Cyclistic bikes differently. Armed with this understanding, I will develop a targeted marketing strategy to convert casual riders into annual members. However, our recommendations must gain approval from Cyclistic executives, necessitating robust data insights and polished data visualizations to support our proposals.

## 1. Ask

### Business Task
Develop marketing strategies aimed at converting casual riders into annual members.

### Analysis Questions
Three questions will guide the future marketing program:

1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

Moreno has assigned me the first question to answer: 
> How do annual members and casual riders use Cyclistic bikes differently?

## 2. Prepare

### Data Source
I will use Cyclistic’s historical trip data to analyze and identify trends from Jan 2023 to Dec 2023 which can be downloaded from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html). The data has been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement).

This is public data that can be used to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit from using riders’ personally identifiable information. This means that I won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.

I will utilize Cyclistic’s historical trip data to analyze and uncover trends from January 2023 to December 2023, which can be accessed from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html).This data is provided by Motivate International Inc. under the terms of this [license](https://divvybikes.com/data-license-agreement).

It's important to note that this data is publicly available and allows us to examine how various customer segments utilize Cyclistic bikes. However, privacy regulations prevent us from linking pass purchases to credit card details, thereby limiting our ability to determine whether casual riders reside within Cyclistic's service area or if they've purchased multiple single passes.

### Data Organization
There are 12 files named following the convention YYYYMM-divvy-tripdata. Each file contains data for one month, including details such as ride ID, bike type, start time, end time, start station, end station, start location, end location, and rider membership status. The corresponding column names are as follows: ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, and member_casual.

### Tools
* Data cleaning & processing - SQL on Google Big Query
* Data visualization - [Tableau](https://public.tableau.com/views/CyclisticCaseStudyAnalysis_17122671813330/BikeTypesUsedin2023?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link)

## 3. Process

BigQuery is employed to merge multiple datasets into a single dataset and perform data cleaning.
#### Explanation:
Due to the limitation of Microsoft Excel, which can only handle up to 1,048,576 rows per worksheet, it is necessary to utilize a platform like BigQuery capable of managing large-scale datasets, especially since the Cyclistic dataset exceeds 5.7 million rows.

### Combining the Data
- SQL Query: [Data Combining](https://github.com/arkarmm93/cyclistic-SQL-Tableau/blob/main/01_Data_Combination.sql)
  - 12 csv files are uploaded as tables in the dataset 'cyclistic_bike_share'. Another table named "trip_2023_combined" is created, containing 5,719,877 rows of data for the entire year.

### Data Exploration 
- SQL Query: [Data Exploration](https://github.com/arkarmm93/cyclistic-SQL-Tableau/blob/main/02_Data_Exploration.sql)
  - Before proceeding with data cleaning, I familiarized ourselves with the data to identify any inconsistencies.

#### Observations:

1. The table displayed all column names and their data types. The **ride_id** column serves as our primary key. <br /><br /> 
![](https://github.com/arkarmm93/assets/blob/main/cyclistic-SQL-Tablea-Ref/bike_share_01.PNG?raw=true) <br />

2. I examined the number of **null values** in each column. <br /><br />
![](https://github.com/arkarmm93/assets/blob/main/cyclistic-SQL-Tablea-Ref/bike_share_02.PNG?raw=true) <br />
 Some columns had the same number of missing values, likely due to missing information in the same row, such as station names and IDs, and latitude and longitude for the same ending station.

3. I checked for duplicate rows using the ride_id column and found **none**.

4. All **ride_id** values had a length of **16**, indicating no need for cleaning.

5. The data contained **three** unique types of bikes (**rideable_type**).<br /><br /> 
![](https://github.com/arkarmm93/assets/blob/main/cyclistic-SQL-Tablea-Ref/bike_share_03.PNG?raw=true) <br />

6. Columns **started_at** and **ended_at** provided trip start and end times in YYYY-MM-DD hh:mm:ss UTC format. I proposed creating a new column (**ride_length**) to calculate the total trip duration. Additionally, I noted 6,418 trips longer than a day and 263,293 trips with durations less than a minute or with end times earlier than start times. These anomalies needed removal. Columns **day_of_week** and **month** could be useful for analyzing trips at different times of the year.

7. There were a total of 875,848 rows with both **start_station_name** and **start_station_id** missing, 929,343 rows with both **end_station_name** and **end_station_id missing**, 6,990 rows with both **end_lat** and **end_lng** missing, and 3 rows with zero value in **end_lat** and **end_lng**, all of which required removal.

8.  The **member_casual** column had two unique values: member or casual rider.

9.  Columns **start_station_id** and **end_station_id** were deemed unnecessary for our analysis and were recommended for removal. Longitude and latitude location columns could be used for map visualization but might not be needed for analysis.

### Data Cleaning

- SQL Query: [Data Cleaning](https://github.com/arkarmm93/cyclistic-SQL-Tableau/blob/main/03_Data_Cleaning.sql)

  -  Deleted all rows with missing values
  -  Added three new columns (ride_length, day_of_week, and month)
  -  Excluded trips with durations less than a minute or longer than a day.
-  This process resulted in the removal of a total of 1,551,379 rows.

## 4. Analyze

- SQL Query: [Data Analysis](https://github.com/arkarmm93/cyclistic-SQL-Tableau/blob/main/04_Data_Analysis.sql)
- Data Visualization: [Tableau](https://public.tableau.com/views/CyclisticCaseStudyAnalysis_17122671813330/BikeTypesUsedin2023?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link)

### Data Analysis:
With the data appropriately stored and prepared, I conducted analysis and visualization in Tableau to address the analysis question: 
> How do annual members and casual riders use Cyclistic bikes differently?

1. First, let's compare the types of bikes used by members and casual riders.![](https://github.com/arkarmm93/assets/blob/main/cyclistic-SQL-Tablea-Ref/Bike%20Types%20Used%20in%202023.png?raw=true) 
The data shows that members make up 64.3% of the total users, while casual riders constitute the remaining 35.7%. Among the bike types, the classic bike is the most frequently used, followed by the electric bike. Docked bikes are least popular, mainly used by casual riders.

2.  Next, let's look at the distribution of trips across months, days of the week, and hours of the day.
   ![](https://github.com/arkarmm93/assets/blob/main/cyclistic-SQL-Tablea-Ref/Total%20Trips%20per%20Month_Day_Hour.png?raw=true)
In terms of monthly trips, both casual riders and members show similar behavior, with more trips occurring in spring and summer, and fewer in winter. The gap between casual riders and members is consistent throughout the year.<br /><br />
When comparing trips by day of the week, casual riders tend to take more trips on weekends, while members show a decline in trips over the weekend compared to weekdays.<br /><br />
Regarding trips throughout the day, members have two peaks: one in the early morning from 6 am to 8 am, and another in the evening from 4 pm to 6 pm. In contrast, casual riders consistently increase their trips throughout the day until the evening, then decrease afterwards.<br /><br /> From these observations, we can infer that members likely use bikes for commuting during weekdays, while casual riders use them throughout the day, especially on weekends, for leisure activities. Both groups are most active in summer and spring.

3.  Now, let's compare the ride durations of casual and member riders. ![](https://github.com/arkarmm93/assets/blob/main/cyclistic-SQL-Tablea-Ref/Avg%20Ride%20Duration%20per%20Month_Day_Hour.png?raw=true)
Casual riders tend to cycle longer distances on average compared to members. The length of members' average journeys remains consistent throughout the year, week, and day. However, casual riders travel longer distances, particularly in spring and summer, on weekends, and during midday hours. Between 5 am and 8 am, they tend to take shorter trips. <br /><br />In conclusion, casual riders travel longer distances but less frequently than members, often for recreational purposes. 

4.  To further understand the differences between casual and member riders, let's analyze the starting and ending station locations. ![](https://github.com/arkarmm93/assets/blob/main/cyclistic-SQL-Tablea-Ref/Total%20Trips%20at%20Starting%20Station.png?raw=true) Casual riders often start their trips from stations near recreational spots such as museums, parks, beaches, harbors, and aquariums. In contrast, members typically begin their journeys from stations located near universities, residential areas, restaurants, hospitals, grocery stores, theaters, schools, banks, factories, train stations, parks, and plazas. ![](https://github.com/arkarmm93/assets/blob/main/cyclistic-SQL-Tablea-Ref/Total%20Trips%20at%20Ending%20Station.png?raw=true)
A similar pattern is observed in the ending station locations. Casual riders tend to conclude their journeys near parks, museums, and other leisure destinations, while members prefer ending their trips close to universities, residential areas, and commercial zones. This distinction indicates that casual riders use bikes for recreational purposes, while members primarily use them for daily commuting.

## 5. Share
### Summary of Findings

|                    | Casual                                                                                                                                              | Member                                                                                                                                |
|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| **Preference**    | Casual riders like riding bikes all day, especially on weekends in summer and spring, for fun.         | Members prefer riding bikes on weekdays during commuting hours (8 am / 5 pm) in summer and spring.                                    |
| **Travel Habits** | Casual riders travel about twice as far as members, but they ride less often.                                                               | Members ride more often but for shorter periods (about half the time compared to casual riders).                      |
| **Start & End Points** | Casual riders usually start and finish their rides near parks, museums, beaches, and other fun places. | Members typically start and finish their rides near universities, homes, and business areas.                |

## 6. Act

Once the variations between casual and member riders have been recognized, it's essential to formulate marketing strategies aimed at converting casual riders into members.

### Recommandations
Here are some recommendations:

1.  Conduct marketing campaigns during spring and summer at tourist/recreational spots frequented by casual riders.
2.  Since casual riders are most active on weekends and during the summer and spring, consider offering seasonal or weekend-only memberships to attract them.
3.  Given that casual riders tend to use their bikes for longer durations compared to members, consider offering discounts for longer rides. This approach can incentivize casual riders and encourage members to extend their ride durations.
