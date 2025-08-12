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

### Rideable choice
Cyclistic currently offer three types of rideables: Classic bikes, electric bikes and electric scooters. The following provides a breakdown of how these are used by the two user types:

<p align="center">
    <img width="1159" height="462" alt="image" src="https://github.com/user-attachments/assets/93dcbe39-3b00-49a6-9a0f-c14daa50ae52" />
</p>

The chart shows that electric bikes are the most popular rideable for both types of user.

### Breakdown of usage
The following three charts provide an overview of the usage by both user types over annual, weekly and daily periods:

<p align="center">
    <img width="1163" height="465" alt="image" src="https://github.com/user-attachments/assets/b66a5bf6-0799-4053-863f-075eb37b9c1c" />
</p>

The annual usage chart shows that the most popular month for both user types is September. There is also a general trend for higher usage between June and September with a drop off to January being the lowest month for both user types.

<p align="center">
    <img width="1163" height="462" alt="image" src="https://github.com/user-attachments/assets/1d1b135f-7527-430e-9922-4424f0e248df" />
</p>

The weekly usage chart shows a trend for higher usage on Saturday and Sunday for casual riders, whereas member usage is higher between Monday and Friday.

<p align="center">
    <img width="1165" height="463" alt="image" src="https://github.com/user-attachments/assets/a195fda3-948c-47ca-9988-a36e661f8876" />
</p>

The daily chart shows that casual usage increases throughout the day before peaking and falling at 17:00. Member usage shows two peaks, one at 8:00 and the highest at 17:00, usage falls between these points but remains higher than casual riders. 

### Ride duration
The average ride duration is 20 and 11.9 minutes for casual and member users respectively. The following three charts provide an overview of the average ride durtion by both user types by monthly, weekly and daily periods:

<p align="center">
    <img width="1163" height="464" alt="image" src="https://github.com/user-attachments/assets/02620721-6e24-4ec1-a8ae-79b0b5a01c8e" />
</p>

The monthly duration chart shows that casual users consistantly take longer rides than members. Amongst casual users, August has the highest average ride duration of 22.3 minutes and January, at 12 minutes, has the lowest, a range of 10.3 minutes. The average ride duration for members remains relatively consistant throughout the year with July having the highest of 13.1 minutes and January and February having the joint lowest of 9.9 minutes, a range of 3.2 minutes.   

<p align="center">
    <img width="1163" height="464" alt="image" src="https://github.com/user-attachments/assets/f55827da-c788-4aad-b8b0-efecc9637f40" />
</p>

The daily average ride duration chart shows casual riders take longer rides on Saturday and Sunday, 22.7 and 23.1 minutes respectively. Wednesday has the lowest average ride duration amounst casual riders at 17 minutes, a range of 6.1 minutes. The average ride length also peaks on Saturday and Sunday for members, 13.1 and 13.2 minutes respectively. From Monday to Friday, values remain constant, with all values falling between 11.4 and 11.9 minutes, a total range of 1.8 minutes. 

<p align="center">
    <img width="1165" height="466" alt="image" src="https://github.com/user-attachments/assets/21b273f3-a2a2-4e6c-8edc-ba8cd3f0f480" />
</p>

The hourly chart shows casual users are taking the shortest rides between 3 and 8am with 6am (06:00) being the shortest at 13.3 minutes, ride duration increases to the highest of 24.3 minutes at 11am (11:00) before falling steadily. Member ride duration remains steady throughout the day, ranging from 10.7 minutes at 5am (05:00) to 12.8 minutes at 5pm (17:00).  
### Stations

The following maps show the distribution of stations where 10,000 rides or more either started or ended, this is also split by user type:

<p align="center">
    <img width="1159" height="464" alt="image" src="https://github.com/user-attachments/assets/ae5a4c03-f375-4347-bc1f-2431f25be401" />
</p>

The maps showing start stations shows that the main cluster of stations for casual users is around central Chicago, with five further stations stretching to the north as far as the Montrose Beach area. For members, there is also a main cluster around the central Chicago area with stations spreading to the north, however the number of stations is greater than the casual rider map. In addition, there is also a small cluster or stations located in the south, around the university of Chicago campus.  

<p align="center">
    <img width="974" height="462" alt="image" src="https://github.com/user-attachments/assets/ce3dc567-f993-4864-a17e-d5fdaeebc22c" />
</p>

The trend for both end station maps is similar to the start stations with the main cluster for casual users being around central Chicago and further stations stretching to the north. For members, in addition to clusters around the central Chicago, the north, and around the university of Chicago campus, there is an additional station at the Illinois Institute of Technology.  

Appendix 1 - files
[combined_trip_data.sql](https://github.com/philpell/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/blob/main/combined_trip_data.sql)

[processing_trip_data.sql](https://github.com/philpell/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/blob/main/processing_trip_data.sql)

[cleaning_trip_data.sql](https://github.com/philpell/Google_Data_Analytics_Capstone_Cyclistic_Case_Study/blob/main/cleaning_trip_data.sql)
