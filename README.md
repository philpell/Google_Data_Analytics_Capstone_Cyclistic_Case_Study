# Google Data Analytics Capstone Case Study: Cyclistic 
This case study forms the final part of the [Google Data Analytics Professional Certificate](https://www.coursera.org/professional-certificates/google-data-analytics). 

## Aims and Objectives
This report aims to provide evidence-based insights which will help Cyclistic's marketing team in understanding *"How do annual members and casual riders use Cyclistic bikes differently?"*

The key objectives of this report are to provide:
1. A clear statement of the business task
2. A description of all data sources used
3. Documentation of any cleaning or manipulation of data
4. A summary of the analysis undertaken
5. Provide supporting visualizations and key findings
6. Provide top three recommendations based on the analysis

## Background
Since 2016, Cyclistic's bike-sharing programme has grown to a fleet of 5,824 geotracked bicycles which can be borrowed and returned to any of Chicago's network of 692 stations. Cyclistic's Unique Selling Point is their range of bikes aimed at people with disabilities and riders who can’t use a standard two-wheeled bike, approximately 8% of riders. Whilst, the majority of users use the bikes for leisure, about 30% use them to commute to work each day. 

Enabled by their flexible pricing plans which offer: single-ride passes, full-day passes, and annual memberships, Cyclistic’s current marketing strategy relies on building general awareness and appealing to broad consumer segments. Customers who purchase single-ride or full-day passes are referred to as casual riders, and those on annual memberships are Cyclistic members. Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Whilst the pricing flexibility helps Cyclistic attract more customers, there is a belief within Cyclistic that maximising the number of annual members will be key to future growth. 

Rather than creating a marketing campaign that targets all-new customers, Cyclistic’s director of marketing, Lily Moreno, believes there is a solid opportunity to convert casual riders into members, as they are already aware of the Cyclistic programme and have chosen Cyclistic for their mobility needs. To design marketing strategies aimed at converting casual riders into annual members, the marketing team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics.

The subsquent sections will follow the steps of the data analysis process: Ask, Prepare, Process, Analyze, Share, and Act.

## Ask
This section outlines the problem to be solved, the business task, and how the resulting insights can drive decisions.

The study seeks to answer the question: *"How do annual members and casual riders use Cyclistic bikes differently?"* Understanding these differences will help the Cyclistic marketing team develop strategies to convert casual riders into annual members.

The business task is therefore to analyse usage patterns between the two groups and use these insights to shape marketing initiatives that increase membership and drive company growth.

## Prepare
This section provides details of how the data will be sourced, stored, organised, and assessed for credibility.

### Sourcing
The data was sourced from the [divvy_trip](https://divvy-tripdata.s3.amazonaws.com/index.html) repositry, which has been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement). Whilst this is public data, data-privacy issues prohibit the use of riders’ personally identifiable information, such as credit card numbers.

### Storage
Twelve data files, covering the period between August 2024 to July 2025, were downloaded in csv format from the link above before being stored on my personal Google Drive account, which provides data encryption and robust access control.

### Organisation
For each trip taken, the files contained columns for the unique ride_ID, the bike type, the start and end times, the start and end stations with their latitude and longitude, and the customer type i.e. annual member or casual rider.

### Credibility
The data source is Divvy (Chicago’s bike-share system, run by Lyft under CDOT oversight) which publishes the data directly via its site, making it a first-hand, official data source. Whilst the data spans a broad historical range, dating back to around 2013, the data for this study covers the past twelve months, ensuring currency. Furthermore, the clear Divvy Data License Agreement governing data use ensures transparency.   

### Bias
As the data is a record of each trip taken with exclusions, there does not appear to be any bias in the data.

### Problems
A review of the data, using Microsoft Excel, shows that there are a number of blank entries (NULL values) under the start and end station columns plus the latitude and longitude columns, further review will be required before a decision is made regarding how to process these records. 

## Process
In accordance with the requirements of the course, two new columns were added to each CSV file in Excel:

    - ride_length, calculated as ended_at - started_at
    - weekday, calculated using Excel’s WEEKDAY function.

HOwever, due to the large number of records in each file, SQL was chosen for further processing instead of Excel. The data covering August 2024 to July 2025 was uploaded into BigQuery, Google’s serverless data warehouse. Because BigQuery’s web UI upload limit is 100 MB per file, some CSV files were split by date before uploading, resulting in 17 files in total.

A Cyclistic bike-share dataset was created in BigQuery to hold the uploaded files. Tables were created with schemas automatically detected. These tables were then combined into one table and checked using the SQL script combined_trip_data.sql (see Appendix 1). During the merge process, BigQuery returned an error because the ride_length column in the nov_2024 table was inferred as STRING instead of TIME, unlike all other tables. Upon review, trips on 3 November in nov_2024 had ended_at values earlier than their started_at values, producing negative durations. BigQuery classified the column as STRING because of these invalid values. I assumed this was due to transposed start and end times and corrected the affected rows by exchanging the two values. After this fix, the SQL script executed successfully without errors to produce a combined table contained 5,611,500 rows, matching the sum of the individual files.

Data validation checks were then performed, including row counts per source file, null value counts for all columns, and identification of invalid entries such as negative or excessively long trip durations, start and end times in the wrong order, and out-of-range GPS coordinates using the SQL script processing_trip_data.sql (see Appendix 1). The cleaning process used the SQL script cleaning_trip_data.sql (see Appendix 1) to remove rows with missing essential fields (ride_id, started_at, ended_at, member_casual, rideable_type, end_lat, end_long), filtered trips outside valid time and coordinate ranges, and standardised categorical values to lowercase with trimmed spaces. The final cleaned dataset contained 5,523,105 rows, therefore 88,395 rows were removed during the cleaning process. 

## Analysis
The cleaned_ride_data table was downloaded from BigQuery in csv format and then uploaded into Tableau Public for analysis, with the aim of answering the question: *"How do annual members and casual riders use Cyclistic bikes differently?"*

The following are visualisation taken from Tableau that show the key metrics for the August 2024 to July 2025 period:

### Casual riders to Cyclistic member breakdown:

<p align="center">
  <img width="690" height="454" alt="image" src="https://github.com/user-attachments/assets/88154112-e2cd-4b00-94b1-7b915618ba83" />
</p>

Throughout the 12 month period, members account for almost two thirds (63.63%) of all cycle trips, highlighting the importance of this market. 

## Appendix 1 - files
[combined_trip_data.sql](https://github.com/philpell/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/blob/main/combined_trip_data.sql)

[processing_trip_data.sql](https://github.com/philpell/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/blob/main/processing_trip_data.sql)

[cleaning_trip_data.sql](https://github.com/philpell/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/blob/main/cleaning_trip_data.sql)
