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
Two new columns were added to each of csv files using Excel, a ride_length column calculated using ended_at-started_at, and a weekday column calculated using the weekday function.	

Due to the number of records in each file, a decision was made to process the data using SQL, rather than continuing to use Excel. Therefore, the data covering the period between August 2024 to July 2025, were uploaded into BigQuery, Google's serverless data warehouse. Due to an upload limit of 100 mb, some files were split, based on date, to meet this requirement.

The first stage was to create a Cyclistic bike-share dataset folder within BigQuery, this will be used to hold the csv files. Tables were then created using the  
