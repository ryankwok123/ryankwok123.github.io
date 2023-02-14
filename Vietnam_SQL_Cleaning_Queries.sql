--cleaning data in all tables
--Standardize the dates
/*
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
order by MSNDATE_Converted

--adding new MSNDATE column to the table labelled MSNDATE_Converted
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1965] 
add MSNDATE_Converted date;

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
set MSNDATE_Converted = Convert(date, MSNDATE)


select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
order by MSNDATE_Converted

--repeat msndate conversion for other 1966
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1966] 
add MSNDATE_Converted date;

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
set MSNDATE_Converted = Convert(date, MSNDATE)


select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
order by MSNDATE_Converted

--repeat msndate conversion for other 1967
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1967] 
add MSNDATE_Converted date;

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
set MSNDATE_Converted = Convert(date, MSNDATE)


--leap year
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
order by MSNDATE_Converted

--repeat msndate conversion for other 1968
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1968] 
add MSNDATE_Converted date;

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
set MSNDATE_Converted = Convert(date, MSNDATE)


select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
order by MSNDATE_Converted

--repeat msndate conversion for other 1969
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1969] 
add MSNDATE_Converted date;

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
set MSNDATE_Converted = Convert(date, MSNDATE)


--for some reason, 1970 appears to have 2 rows per date as well as one invalid date FEB 29th (1970 is not a leap year)
--when returning MSNDATE there are exactly 731 rows, 365*2 is 730 so removing the invalid date suggests dates are doubled up
--Turns out dates are formatted differently 
--For example: DISTINCT picks up 19700101 & 1/1/1970 as two different dates, but the conversion fixes this. Days in the year add to 365
select distinct MSNDATE, Try_Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
--where MSNDATE is not null
order by MSNDATE_Converted
/*
with comparing_days_per_month as 
(
select distinct MSNDATE, Try_Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
--order by MSNDATE_Converted
)
--counting the number of days per month to see what's going on
select DAY(EOMONTH(MSNDATE_Converted)), count(MSNDATE_Converted)/2 --divide by 2 since dates are doubled up
from comparing_days_per_month
group by EOMONTH(MSNDATE_Converted)
--order by MSNDATE_Converted
*/

--repeat msndate conversion for other 1970
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1970] 
add MSNDATE_Converted date;

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
set MSNDATE_Converted = Try_Convert(date, MSNDATE) --there is one invalid date (feb 29th) that needs to be removed




--1971 has 367 rows instead of 365 
--discovered the extra entries come from february and march due to different formating in the date
--DISTINCT picks up 2/12/1971 & 19710212 as two different dates, but the conversion fixes this anyways so no biggie
--DISTINCT picks up 3/12/1971 & 19710312 as two different dates, but the conversion fixes this anyways so no biggie
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
order by MSNDATE_Converted
/*
with comparing_days_per_month as 
(
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
--order by MSNDATE_Converted
)
--counting the number of days per month to see what's going on
select DAY(EOMONTH(MSNDATE_Converted)), count(MSNDATE_Converted)
from comparing_days_per_month
group by EOMONTH(MSNDATE_Converted)
--order by MSNDATE_Converted
*/

--repeat msndate conversion for other 1971
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1971] 
add MSNDATE_Converted date;

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
set MSNDATE_Converted = Convert(date, MSNDATE)


--1972 has 367 rows, it's a leap year but what's the extra date? 
--using the comparing days per month query above, we can see that distinct counts Jan 28th twice, problem solved
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
order by MSNDATE_Converted

/*
Another method of checking duplicates using row_number

with check_duplicate as(
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
--order by MSNDATE_Converted
)
select MSNDATE, MSNDATE_Converted, ROW_NUMBER() over (partition by MSNDATE_Converted order by MSNDATE_Converted) as num_dupes
from check_duplicate
order by num_dupes desc*/

/*
with comparing_days_per_month as 
(
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
--order by MSNDATE_Converted
)
--counting the number of days per month to see what's going on
select DAY(EOMONTH(MSNDATE_Converted)), count(MSNDATE_Converted)
from comparing_days_per_month
group by EOMONTH(MSNDATE_Converted)
--order by MSNDATE_Converted
*/

--repeat msndate conversion for other 1972
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1972] 
add MSNDATE_Converted date;

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
set MSNDATE_Converted = Convert(date, MSNDATE)


--1973 has 368 rows
--April 19th, May 4th, July 12th incorrect format
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
order by MSNDATE_Converted
/*
with comparing_days_per_month as 
(
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
--order by MSNDATE_Converted
)
--counting the number of days per month to see what's going on
select DAY(EOMONTH(MSNDATE_Converted)), count(MSNDATE_Converted)
from comparing_days_per_month
group by EOMONTH(MSNDATE_Converted)
--order by MSNDATE_Converted
*/

--repeat msndate conversion for other 1973
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1973] 
add MSNDATE_Converted date;

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
set MSNDATE_Converted = Convert(date, MSNDATE)


--1974 has 366 rows
--February 21st incorrect format
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
order by MSNDATE_Converted
/*
with comparing_days_per_month as 
(
select distinct MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
--order by MSNDATE_Converted
)
--counting the number of days per month to see what's going on
select DAY(EOMONTH(MSNDATE_Converted)), count(MSNDATE_Converted)
from comparing_days_per_month
group by EOMONTH(MSNDATE_Converted)
--order by MSNDATE_Converted
*/

--repeat msndate conversion for other 1974
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1974] 
add MSNDATE_Converted date;

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
set MSNDATE_Converted = Convert(date, MSNDATE)


--why does the data extend past the end of the vietnam war?
--kinetic missions targeting south vietnam stop abruptly after the fall of saigon, 
--mostly nulls and a few missions in cambodia. Might be worthwhile to drop everything after April 30, 1975
select MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted, MFUNC_DESC, MFUNC_DESC_CLASS, TAKEOFFLOCATION, TGTCOUNTRY
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
where MFUNC_DESC_CLASS = 'KINETIC' --AND MSNDATE_Converted <= April 30th, 1975
order by MSNDATE_Converted

--repeat msndate conversion for other 1975
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1975] 
add MSNDATE_Converted date;

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
set MSNDATE_Converted = Convert(date, MSNDATE)
*/
---------------------------------------------------------------------------------------------------------

--replaced nulls in tgtcountry with "Unknown"
--repeated for all years/tables

UPDATE [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
SET TGTCOUNTRY = ISNULL(TGTCOUNTRY, 'Unknown')

select TGTCOUNTRY, count(THOR_DATA_VIET_ID)
FROM [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
group by TGTCOUNTRY


---------------------------------------------------------------------------------------------------------

--number of missions flown by country (bar graph)
Select COUNTRYFLYINGMISSION, count(THOR_DATA_VIET_ID) as num_missions_flown_by_country
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
where COUNTRYFLYINGMISSION is not null
group by COUNTRYFLYINGMISSION

---------------------------------------------------------------------------------------------------------
--number missions flown by branch (pie chart)

with replace_null as (
--query that replaces nulls in MILSERVICE with OTHER
Select MILSERVICE, ISNULL(MILSERVICE, 'OTHER') as MILSERVICE_FORMATTED
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
)
Select MILSERVICE, MILSERVICE_FORMATTED, COUNT(MILSERVICE_FORMATTED) num_missions_by_branch
from replace_null
group by MILSERVICE, MILSERVICE_FORMATTED

--milservice cleaning
/*
Select ISNULL(MILSERVICE, 'OTHER') as MILSERVICE_FORMATTED
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]

--creating new column MILSERVICE_FORMATTED
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1965] 
add MILSERVICE_FORMATTED varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
set MILSERVICE_FORMATTED = ISNULL(MILSERVICE, 'OTHER')

--repeat for 1966
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1966] 
add MILSERVICE_FORMATTED varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
set MILSERVICE_FORMATTED = ISNULL(MILSERVICE, 'OTHER') 

--USAF is inputted as USA, fixing this typo by replacing all instances of USA with USAF
--changing usa to usaf for 1966, 1969, 1970 
update [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
set MILSERVICE_FORMATTED = replace(replace(MILSERVICE_FORMATTED, 'USA', 'USAF'), 'USAFF', 'USAF')


--repeat for 1967
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1967] 
add MILSERVICE_FORMATTED varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
set MILSERVICE_FORMATTED = ISNULL(MILSERVICE, 'OTHER')

--repeat for 1968
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1968] 
add MILSERVICE_FORMATTED varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
set MILSERVICE_FORMATTED = ISNULL(MILSERVICE, 'OTHER')

--repeat for 1969
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1969] 
add MILSERVICE_FORMATTED varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
set MILSERVICE_FORMATTED = ISNULL(MILSERVICE, 'OTHER')

--USAF is inputted as USA, fixing this typo by replacing all instances of USA with USAF
--changing usa to usaf for 1966, 1969, 1970 
update [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
set MILSERVICE_FORMATTED = replace(replace(MILSERVICE_FORMATTED, 'USA', 'USAF'), 'USAFF', 'USAF')


--repeat for 1970
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1970] 
add MILSERVICE_FORMATTED varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
set MILSERVICE_FORMATTED = ISNULL(MILSERVICE, 'OTHER')

--USAF is inputted as USA, fixing this typo by replacing all instances of USA with USAF
--changing usa to usaf for 1966, 1969, 1970 
update [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
set MILSERVICE_FORMATTED = replace(replace(MILSERVICE_FORMATTED, 'USA', 'USAF'), 'USAFF', 'USAF')


--repeat for 1971
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1971] 
add MILSERVICE_FORMATTED varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
set MILSERVICE_FORMATTED = ISNULL(MILSERVICE, 'OTHER')

--repeat for 1972
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1972] 
add MILSERVICE_FORMATTED varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
set MILSERVICE_FORMATTED = ISNULL(MILSERVICE, 'OTHER')

--repeat for 1973
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1973] 
add MILSERVICE_FORMATTED varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
set MILSERVICE_FORMATTED = ISNULL(MILSERVICE, 'OTHER')

--repeat for 1974
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1974] 
add MILSERVICE_FORMATTED varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
set MILSERVICE_FORMATTED = ISNULL(MILSERVICE, 'OTHER')

--repeat for 1975
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1975] 
add MILSERVICE_FORMATTED varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
set MILSERVICE_FORMATTED = ISNULL(MILSERVICE, 'OTHER')
*/
---------------------------------------------------------------------------------------------------------

--experimenting here: determining number of missions flown per day, ordered by standardized date
select MSNDATE, Convert(date, MSNDATE) as MSNDATE_Converted, count(THOR_DATA_VIET_ID) over (partition by(MSNDate))
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
order by MSNDATE_Converted

---------------------------------------------------------------------------------------------------------

--number of missions flown by each type of aircraft (bubble chart)
select AIRCRAFT_ORIGINAL, count(AIRCRAFT_ORIGINAL) as num_missions_flown_by_aircraft
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
group by AIRCRAFT_ORIGINAL 
order by num_missions_flown_by_aircraft desc

--maybe use valid aircraft root instead? Comparing aircraft original with valid aircraft root. 
--Seems like there are no nulls in either column. might just do air crafts that have flown more
--than X number of missions to make life easier, in this case used greater than 1 mission
select AIRCRAFT_ORIGINAL, VALID_AIRCRAFT_ROOT, count(AIRCRAFT_ORIGINAL) as num_missions_flown_by_aircraft, count(VALID_AIRCRAFT_ROOT) as num_missions_flown_by_validaircraft
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
group by AIRCRAFT_ORIGINAL, VALID_AIRCRAFT_ROOT
having count(AIRCRAFT_ORIGINAL) > 1
order by num_missions_flown_by_validaircraft desc

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--looking at the period of day missions took place in (bubble chart description)
--Day: D, Night: N, Evening: E, Morning: M
--need to standardize the missions so that evening missions are night and morning missions are day (1965-1970)
--for the visualization, drop all the other labels other than day and night after the standardization
select PERIODOFDAY, count(PERIODOFDAY) as PERIODOFDAY_Count
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
group by PERIODOFDAY
order by PERIODOFDAY_Count desc

--Standardizing the Morning and Night Values 
--do this for all tables!!!

/*
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--creating new column PERIODOFDAY_Standardized 
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1965] 
add PERIODOFDAY_Standardized varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
set PERIODOFDAY_Standardized = CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END 



--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--repeat new column PERIODOFDAY_Standardized for 1966
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1966] 
add PERIODOFDAY_Standardized varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
set PERIODOFDAY_Standardized = CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END 


--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--repeat new column PERIODOFDAY_Standardized for 1967
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1967] 
add PERIODOFDAY_Standardized varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
set PERIODOFDAY_Standardized = CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END 



--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--repeat new column PERIODOFDAY_Standardized for 1968
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1968] 
add PERIODOFDAY_Standardized varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
set PERIODOFDAY_Standardized = CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END 


--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--repeat new column PERIODOFDAY_Standardized for 1969
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1969] 
add PERIODOFDAY_Standardized varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
set PERIODOFDAY_Standardized = CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END 


--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--repeat new column PERIODOFDAY_Standardized for 1970
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1970] 
add PERIODOFDAY_Standardized varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
set PERIODOFDAY_Standardized = CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END 


--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--repeat new column PERIODOFDAY_Standardized for 1971
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1971] 
add PERIODOFDAY_Standardized varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
set PERIODOFDAY_Standardized = CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END 


--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--repeat new column PERIODOFDAY_Standardized for 1972
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1972] 
add PERIODOFDAY_Standardized varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
set PERIODOFDAY_Standardized = CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END 


--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--repeat new column PERIODOFDAY_Standardized for 1973
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1973] 
add PERIODOFDAY_Standardized varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
set PERIODOFDAY_Standardized = CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END 

--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--repeat new column PERIODOFDAY_Standardized for 1974
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1974] 
add PERIODOFDAY_Standardized varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
set PERIODOFDAY_Standardized = CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END 


--Standardizing the Morning and Night Values 
--do this for all tables!!!
select PERIODOFDAY, 
CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END as PERIODOFDAY_Standardized
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
WHERE PERIODOFDAY IN('M', 'E')
ORDER BY PERIODOFDAY_Standardized

--repeat new column PERIODOFDAY_Standardized for 1975
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1975] 
add PERIODOFDAY_Standardized varchar(50);

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
set PERIODOFDAY_Standardized = CASE
    WHEN PERIODOFDAY = 'M' THEN 'D' 
    WHEN PERIODOFDAY = 'E' THEN 'N'
	ELSE PERIODOFDAY
END 
*/

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--time data is riddled with errors:
	--ambigious midnight (24:00 exists as well as 00:00)
	--several data entry errors, 24:00 should actually be 00:00, 15:70 doesn't exist probably misread 2 as 7
	--nonsensical time values such as 61:41 are prevalent 

--you can still use this time data but with heavy filtering involved 
--(ie, cutting out all nulls and only including valid values for the sake of demonstration)

/*
--calculate average mission duration for each aircraft 
select try_cast(TIMEONTARGET as time), TIMEOFFTARGET
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]


--manipulating by inserting colons so that the values can be converted to datetime
--what should we do with zeros and nulls? 
with format_time as (
select TIMEONTARGET,
CASE
    WHEN len(TIMEONTARGET) = 4 THEN LEFT(timeontarget,2) + ':' + RIGHT(timeontarget,2) --insert colon in the middle
    WHEN len(TIMEONTARGET) = 3 THEN LEFT(timeontarget,1) + ':' + RIGHT(timeontarget,2) --insert colon in the middle
    WHEN len(TIMEONTARGET) = 2 THEN '00:' + TIMEONTARGET --add two zeros then insert colon (assuming minutes) 
	WHEN len(TIMEONTARGET) = 1 THEN '00:0' + TIMEONTARGET --add two zeros then colon then zero again (assuming minutes)
END as TIMEONTARGET_Formatted,

TIMEOFFTARGET,
CASE
    WHEN len(TIMEOFFTARGET) = 4 THEN LEFT(TIMEOFFTARGET,2) + ':' + RIGHT(TIMEOFFTARGET,2) --insert colon in the middle
    WHEN len(TIMEOFFTARGET) = 3 THEN LEFT(TIMEOFFTARGET,1) + ':' + RIGHT(TIMEOFFTARGET,2) --insert colon in the middle
    WHEN len(TIMEOFFTARGET) = 2 THEN '00:' + TIMEOFFTARGET --add two zeros then insert colon (assuming minutes) 
	WHEN len(TIMEOFFTARGET) = 1 THEN '00:0' + TIMEOFFTARGET --add two zeros then colon then zero again (assuming minutes)
END as TIMEOFFTARGET_Formatted
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
--where len(TIMEONTARGET) = 1 and TIMEONTARGET <> 0
), 
--second cte
time_diff as (
select TIMEONTARGET, TIMEONTARGET_Formatted, try_cast(TIMEONTARGET_Formatted as time) as TIMEONTARGET_Converted,
TIMEOFFTARGET, TIMEOFFTARGET_Formatted, try_cast(TIMEOFFTARGET_Formatted as time) as TIMEOFFTARGET_Converted
from format_time
)
--calculate the minute difference between time on and time off, datediff???
select TIMEONTARGET, TIMEONTARGET_Formatted, TIMEONTARGET_Converted, TIMEOFFTARGET, TIMEOFFTARGET_Formatted, TIMEOFFTARGET_Converted, 
datediff(minute, TIMEONTARGET_Converted, TIMEOFFTARGET_Converted) as time_diff_mins
from time_diff
order by time_diff_mins 
--a lot of nulls where there shouldn't be, these are invalid times 
--(ie. 24:00 should actually be 00:00, 15:70 doesn't exist probably misread 2 as 7 *facepalm*)
--getting picked up as values by the LEN() function
--also, negative time diff values need to be fixed
*/

---------------------------------------------------------------------------------------------------------
--Operations by day on a map filter by country (geo)
select TGTLATDD_DDD_WGS84, TGTLONDDD_DDD_WGS84, TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84 as Lat_Long
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
--where TGTLATDD_DDD_WGS84 is not null and TGTLONDDD_DDD_WGS84 is not null


--Adding the new longitude and latitude column to the table
/*
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1965] 
add Lat_Long Varchar(255)

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
set Lat_Long = TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84


--repeat for all 1966
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1966] 
add Lat_Long Varchar(255)

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
set Lat_Long = TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84

--repeat for all 1967
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1967] 
add Lat_Long Varchar(255)

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
set Lat_Long = TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84

--repeat for all 1968
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1968] 
add Lat_Long Varchar(255)

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
set Lat_Long = TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84


--repeat for all 1969
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1969] 
add Lat_Long Varchar(255)

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
set Lat_Long = TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84


--repeat for all 1970
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1970] 
add Lat_Long Varchar(255)

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
set Lat_Long = TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84


--repeat for all 1971
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1971] 
add Lat_Long Varchar(255)

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
set Lat_Long = TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84


--repeat for all 1972
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1972] 
add Lat_Long Varchar(255)

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
set Lat_Long = TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84


--repeat for all 1973
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1973] 
add Lat_Long Varchar(255)

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
set Lat_Long = TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84


--repeat for all 1974 
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1974] 
add Lat_Long Varchar(255)

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
set Lat_Long = TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84

--it appears there are no operations from this year onwards
select Lat_Long 
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974] 
where lat_long is not null


--repeat for all 1975
alter table [Vietnam_Bombing_Operations].[dbo].[VietNam_1975] 
add Lat_Long Varchar(255)

update [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
set Lat_Long = TGTLATDD_DDD_WGS84 + ', ' + TGTLONDDD_DDD_WGS84

--a few last ditch strike missions one day prior to the fall of saigon in the neighboring province of dong nai
select msndate, Lat_Long, MFUNC_DESC_CLASS, MFUNC_DESC
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975] 
where lat_long is not null
order by msndate desc
*/


