USE Cyclistic;

-- Before analysing the data, it needs to be cleaned. I looked through a few on Numbers since I am a Mac user.
-- Then I found out it is too big to conduct the cleaning on Numbers.
-- So I need to import the downloaded data into the database. For that, I created an empty table with the same coloum names.

CREATE TABLE IF NOT EXISTS Cyclistic.20jul_data(
	ride_id VARCHAR(16) NOT NULL,
    rideable_type VARCHAR(20),
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    start_station_name VARCHAR(100),
    start_station_id INT,
    end_station_name VARCHAR(100),
    end_station_id INT,
    start_lat FLOAT,
    start_lng FLOAT,
    end_lat FLOAT,
    end_lng FLOAT,
    member_casual VARCHAR(10)
);

SELECT 
    *
FROM
    20jul_data;

-- Next, I need to create the tables for the rest of csvs
CREATE TABLE 20aug_data LIKE 20jul_data;
CREATE TABLE 20sep_data LIKE 20jul_data;
CREATE TABLE 20oct_data LIKE 20jul_data;
CREATE TABLE 20nov_data LIKE 20jul_data;
CREATE TABLE 20dec_data LIKE 20jul_data;
CREATE TABLE 21jan_data LIKE 20jul_data;
CREATE TABLE 21feb_data LIKE 20jul_data;
CREATE TABLE 21mar_data LIKE 20jul_data;
CREATE TABLE 21apr_data LIKE 20jul_data;
CREATE TABLE 21may_data LIKE 20jul_data;
CREATE TABLE 21jun_data LIKE 20jul_data;

-- Now try to import csv files into the table with Workbench tool
-- But it turned out to be extremely slow, so used Load Data Infile syntax to import (file sizes are 9 - 154MB)

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202007-divvy-tripdata.csv'
INTO TABLE 20jul_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

SELECT * FROM 20jul_data
WHERE ride_id IS NULL;

SELECT COUNT(ride_id) FROM 20jul_data;

-- It looks everything imported correctly, so conduct the same for the rest

LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202008-divvy-tripdata.csv'
INTO TABLE 20aug_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
    
LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202009-divvy-tripdata.csv'
INTO TABLE 20sep_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202010-divvy-tripdata.csv'
INTO TABLE 20oct_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202011-divvy-tripdata.csv'
INTO TABLE 20nov_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202012-divvy-tripdata.csv'
INTO TABLE 20dec_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
    
LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202101-divvy-tripdata.csv'
INTO TABLE 21jan_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202102-divvy-tripdata.csv'
INTO TABLE 21feb_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202103-divvy-tripdata.csv'
INTO TABLE 21mar_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202104-divvy-tripdata.csv'
INTO TABLE 21apr_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
    
LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202105-divvy-tripdata.csv'
INTO TABLE 21may_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA LOCAL
INFILE '/Users/gakthebeginner/Desktop/Projects:study/GDAC /Case Study /202106-divvy-tripdata.csv'
INTO TABLE 21jun_data 
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

select * from 21jun_data;

/* 
Now all the data has been imported.
it is time for merging all the table into one.
*/

CREATE VIEW all_data AS
	SELECT * FROM 20jul_data
UNION ALL
	SELECT * FROM 20aug_data
UNION ALL
	SELECT * FROM 20sep_data
UNION ALL
	SELECT * FROM 20oct_data
UNION ALL
	SELECT * FROM 20nov_data
UNION ALL
	SELECT * FROM 20dec_data
UNION ALL
	SELECT * FROM 21jan_data
UNION ALL
	SELECT * FROM 21feb_data
UNION ALL
	SELECT * FROM 21mar_data
UNION ALL
	SELECT * FROM 21apr_data
UNION ALL
	SELECT * FROM 21may_data
UNION ALL
	SELECT * FROM 21jun_data;

/*
after exported the file and checked the data, it seems that there are 4 types of data on "member_casual" which is supposed to be 2.
so, update the data accordingly.
*/

update 20aug_data set member_casual = "Member" where member_casual LIKE "m%";
update 20aug_data set member_casual = "Casual" where member_casual LIKE "c%";

update 20dec_data set member_casual = "Member" where member_casual LIKE "m%";
update 20dec_data set member_casual = "Casual" where member_casual LIKE "c%";

update 20jul_data set member_casual = "Member" where member_casual LIKE "m%";
update 20jul_data set member_casual = "Casual" where member_casual LIKE "c%";

update 20nov_data set member_casual = "Member" where member_casual LIKE "m%";
update 20nov_data set member_casual = "Casual" where member_casual LIKE "c%";

update 20oct_data set member_casual = "Member" where member_casual LIKE "m%";
update 20oct_data set member_casual = "Casual" where member_casual LIKE "c%";

update 20sep_data set member_casual = "Member" where member_casual LIKE "m%";
update 20sep_data set member_casual = "Casual" where member_casual LIKE "c%";

update 21apr_data set member_casual = "Member" where member_casual LIKE "m%";
update 21apr_data set member_casual = "Casual" where member_casual LIKE "c%";

update 21feb_data set member_casual = "Member" where member_casual LIKE "m%";
update 21feb_data set member_casual = "Casual" where member_casual LIKE "c%";

update 21jan_data set member_casual = "Member" where member_casual LIKE "m%";
update 21jan_data set member_casual = "Casual" where member_casual LIKE "c%";

update 21jun_data set member_casual = "Member" where member_casual LIKE "m%";
update 21jun_data set member_casual = "Casual" where member_casual LIKE "c%";

update 21mar_data set member_casual = "Member" where member_casual LIKE "m%";
update 21mar_data set member_casual = "Casual" where member_casual LIKE "c%";

update 21may_data set member_casual = "Member" where member_casual LIKE "m%";
update 21may_data set member_casual = "Casual" where member_casual LIKE "c%";

-- Just to make sure that there is no more problem on the member_casual, execute the below and see how many..
select count(*) from all_data where member_casual NOT IN('Member', 'Casual');
-- the result was 0

-- Now it is time for more of data checking

SELECT COUNT(*) FROM all_data
WHERE started_at IS NULL OR ended_at IS NULL;
-- Result is 0

SELECT COUNT(*) FROM all_data
WHERE start_lat IS NULL OR start_lng IS NULL OR end_lat IS NULL OR end_lng IS NULL;
-- Result is 0

SELECT COUNT(*) FROM all_data
WHERE member_casual IS NULL;
-- Result is 0

SELECT COUNT(*) FROM all_data
WHERE start_station_id IS NULL;
-- Found that start_station_name, start_station_id, end_station_name, end_station_id have NULL values.
-- However, these are not used for my analysis so it is not really big thing. So, create a new dataset without these

CREATE VIEW clean_data_1 AS (
	SELECT ride_id, rideable_type, started_at, ended_at, member_casual
    FROM all_data
);

SELECT SUM(ended_at - started_at) AS timediff, member_casual FROM clean_data_1 where started_at BETWEEN '2020-12-01' AND '2020-12-31' group by member_casual;
-- Then, I realised that there are some inccorect or system error data in it. So, execute the below to create another view without these

CREATE VIEW clean_data_2 AS
    (SELECT 
        ride_id, rideable_type, started_at, ended_at, member_casual
    FROM
        all_data
    WHERE
        ride_id NOT IN (SELECT 
                ride_id
            FROM
                clean_data_1
            WHERE
                0 > ended_at - started_at));


-- Also, I need to add a few columns for analysis such as ride_length(ended_at - started_at), day_of_week
-- create all the required data into one table by member type
WITH member_type AS (
	SELECT membercasual AS Member
    FROM clean_data_1),

	day_of_week AS (
    SELECT ride_id, started_at,
		CASE DATE_FORMAT(started_at, '%w')
            WHEN 0 THEN 'Sun'
			WHEN 1 THEN 'Mon' 
			WHEN 2 THEN 'Tue' 
			WHEN 3 THEN 'Wed' 
            WHEN 4 THEN 'Thu' 
            WHEN 5 THEN 'Fri' 
			WHEN 6 THEN 'Sat' 
            ELSE 'x' 
		END AS d_of_week
	FROM clean_data),

	m_final_data AS (
    SELECT cd.ride_id,
		cd.started_at,
        ended_at,
        dw.d_of_week,
        rl.m_ride,
        rl.m_time_diff,
        start_lat,
        start_lng,
        end_lat,
        end_lng,
        member_casual
	FROM clean_data cd
    JOIN ride_length rl ON cd.ride_id = rl.ride_id
    JOIN day_of_week dw ON cd.ride_id = dw.ride_id)
SELECT * FROM m_final_data
WHERE member_casual = 'member';

-- Then, I realied that this can be done on Tableau, so instead of executing it on here, I did the same on Tableau.
-- Now for analysis and data vidualisation, use Tableau
