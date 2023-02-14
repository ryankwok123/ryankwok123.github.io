--Creating views for visualizations on tableau


--# of total missions flown by country (bar) (Sorting by kinetic vs. non-kinetic missions)

--aggregating data from all years
--union to combine total num missions (both kinetic and nonkinetic, non-null) over the years 
with All_missions_flown as (
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
	union 
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
)
select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, count(THOR_DATA_VIET_ID) as num_missions_flown_by_country
from All_missions_flown
where COUNTRYFLYINGMISSION is not null --and MFUNC_DESC_CLASS = 'KINETIC'
group by MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION
order by 1

--create a view for the # of total missions flown by country (bar)
/*
Create View num_missions_flown_by_country as
with All_missions_flown as (
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
	union 
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
	union
	select THOR_DATA_VIET_ID, MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, MFUNC_DESC
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
)
select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, count(THOR_DATA_VIET_ID) as num_missions_flown_by_country
from All_missions_flown
where COUNTRYFLYINGMISSION is not null --and MFUNC_DESC_CLASS = 'KINETIC'
group by MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION
--order by 1
*/

-----------------------------------------------------------------------------------------------------------------

--next visualization 
--Bombings over time (by date), month-year, by country (line) (Sorting by kinetic vs. non-kinetic missions)

--count number of missions (mission ID's) per month where country and date not null
select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
order by 1

--aggregating data from all years
--union to combine (both kinetic and nonkinetic, non-null) 

with num_missions_flown_per_month as(
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
)
select *
from num_missions_flown_per_month
order by COUNTRYFLYINGMISSION


--create a view for the # of total missions flown by month (line)
/*
Create View num_missions_flown_by_month_line as 
with num_missions_flown_per_month as(
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
	union
	select MFUNC_DESC_CLASS, COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM') as year_month, count(THOR_DATA_VIET_ID) as num_missions_flown
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
	where COUNTRYFLYINGMISSION is not null and FORMAT(MSNDATE_Converted, 'yyyy-MM') is not null
	group by COUNTRYFLYINGMISSION, FORMAT(MSNDATE_Converted, 'yyyy-MM'), MFUNC_DESC_CLASS
)
select *
from num_missions_flown_per_month
--order by COUNTRYFLYINGMISSION
*/

-----------------------------------------------------------------------------------------------------------------

--next visualization 
--Operations by day on a map, filter by country (geo)
select MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965] 
where lat_long is not null
order by msndate desc

--aggregating data over all years
--union to combine (both kinetic and nonkinetic, non-null) 

--***VERY IMPORTANT*** A LOT OF THE LATITUDE AND LONGITUDE DATA IS NULL SO MANY MISSIONS WILL NOT BE INCLUDED!!!

--it turns out that there are 1924850 duplicate missions (ie. same date, same location, same mfunc_desc, milservice etc.)
--it's likely that single locations were hit multiple times in succession which explains why there is a unique thor_id
--for missions that share all the same characteristics

--don't want to include all the unique points on the map since it will probably overload tableau
--try finding a way to include the number of times the same location was hit with the row_number function as a workaround

with mission_location_geo as (
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975] 
	where lat_long is not null
), cte as(
--row_number counts duplicates that share the fields in partition by
select *, ROW_NUMBER() over (partition by MFUNC_DESC_CLASS, MSNDATE_Converted, target_lat, target_long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED order by THOR_DATA_VIET_ID) as count_num_hits_same_location_date
from mission_location_geo
where MSNDATE_Converted is not null --two values in 1970 labelled feb 29th which does not exist. Not including these
)
--returning number of times same location/date was hit by getting max of row_number function
select *, Max(count_num_hits_same_location_date) over (partition by MFUNC_DESC_CLASS, MSNDATE_Converted, target_lat, target_long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED) as total_hits_same_location_date 
from cte
where MSNDATE_Converted is not null --two values in 1970 labelled feb 29th which does not exist. Not including these
order by Lat_Long, MSNDATE_Converted



--create a view for operations by day on a map, filtered by country(geo) (Sorting by kinetic vs. non-kinetic missions)
--include number of repeat missions on the same date/location and no duplicates (same location/date)
/*
create view mission_location_geo2 as
with mission_location_geo as (
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975] 
	where lat_long is not null
), count_repeat_missions as(
--row_number counts duplicates that share the fields in partition by
select *, ROW_NUMBER() over (partition by MFUNC_DESC_CLASS, MSNDATE_Converted, target_lat, target_long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED order by THOR_DATA_VIET_ID) as count_num_hits_same_location_date
from mission_location_geo
where MSNDATE_Converted is not null --two values in 1970 labelled feb 29th which does not exist. Not including these
), total_hits_per_repeat_mission as(
--returning number of times same location/date was hit by getting max of row_number function
select MFUNC_DESC_CLASS, MSNDATE_Converted, target_lat, target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, count_num_hits_same_location_date, Max(count_num_hits_same_location_date) over (partition by MFUNC_DESC_CLASS, MSNDATE_Converted, target_lat, target_long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED) as total_hits_same_location_date 
from count_repeat_missions
where MSNDATE_Converted is not null--two values in 1970 labelled feb 29th which does not exist. Not including these
--group by MFUNC_DESC_CLASS, MSNDATE_Converted, target_lat, target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED,count_num_hits_same_location_date
--order by Lat_Long, MSNDATE_Converted
)
select *
from total_hits_per_repeat_mission
where count_num_hits_same_location_date = total_hits_same_location_date
*/


--we back for part 3 boys 
--adding latitude and longitude limits to prevent outliers in nonsensical areas obviously outside indochina
/*
Westernmost limit: Mae Sariang District, Thailand (18.548030, 97.369644)
Northernmost limit: Lung Cu, Vietnam (23.390527, 105.322781)
Easternmost limit: South China Sea (15.344668, 117.196773)
Southernmost limit: South China Sea (6.051594, 107.924745)
*/
--also adding tgtcountry field which might be helpful when the points are too clustered
--mission_location_geo2 had 1615431 rows and the new mission_location_geo3 has 1615312, dropped 119 rows

/*
Create View mission_location_geo3 as
with mission_location_geo as (
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974] 
	where lat_long is not null
	union
	select THOR_DATA_VIET_ID, MFUNC_DESC_CLASS, MSNDATE_Converted, TGTLATDD_DDD_WGS84 as target_lat, TGTLONDDD_DDD_WGS84 as target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975] 
	where lat_long is not null
), 

count_repeat_missions as(
--row_number counts duplicates that share the fields in partition by
select *, ROW_NUMBER() over (partition by MFUNC_DESC_CLASS, MSNDATE_Converted, target_lat, target_long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED order by THOR_DATA_VIET_ID) as count_num_hits_same_location_date
from mission_location_geo
where MSNDATE_Converted is not null --two values in 1970 labelled feb 29th which does not exist. Not including these
), 

total_hits_per_repeat_mission as(
--returning number of times same location/date was hit by getting max of row_number function
select MFUNC_DESC_CLASS, MSNDATE_Converted, target_lat, target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED, TGTCOUNTRY, count_num_hits_same_location_date, Max(count_num_hits_same_location_date) over (partition by MFUNC_DESC_CLASS, MSNDATE_Converted, target_lat, target_long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED) as total_hits_same_location_date 
from count_repeat_missions
where MSNDATE_Converted is not null--two values in 1970 labelled feb 29th which does not exist. Not including these
--group by MFUNC_DESC_CLASS, MSNDATE_Converted, target_lat, target_long, Lat_Long, MFUNC_DESC, COUNTRYFLYINGMISSION, MILSERVICE_FORMATTED,count_num_hits_same_location_date
--order by Lat_Long, MSNDATE_Converted
)
select *
from total_hits_per_repeat_mission
--only selecting rows where row_number = max(row_number) and rows that fall within the latitude and longitude limits
where count_num_hits_same_location_date = total_hits_same_location_date and CONVERT(decimal, target_lat) <= 23.390527 and CONVERT(decimal, target_lat) >= 6.051594 and CONVERT(decimal, target_long) >= 97.369644 and CONVERT(decimal, target_long) <= 117.196773
*/

-----------------------------------------------------------------------------------------------------------------

--next visualization 
--Number of missions flown by branch over the entire war(bubble)

Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED, COUNT(MILSERVICE_FORMATTED) as num_missions_by_branch
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
group by MFUNC_DESC_CLASS, MILSERVICE_FORMATTED

--aggregating data over all years
--union to combine (both kinetic and nonkinetic, non-null) 

with num_missions_flown_by_branch_pie as (
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
)
select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED, CONVERT(FLOAT, COUNT(MILSERVICE_FORMATTED)) as num_missions_by_branch, 
ROUND(CONVERT(FLOAT, COUNT(MILSERVICE_FORMATTED))*100/(SELECT COUNT(*) FROM num_missions_flown_by_branch_pie),4) as percentage_of_all_missions
from num_missions_flown_by_branch_pie
group by MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
order by MILSERVICE_FORMATTED

--create a view for number of missions flown by branch (Sorting by kinetic vs. non-kinetic missions)
/*
Create View num_missions_flown_by_branch_pie as
with num_missions_flown_by_branch_pie as (
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
	union all
	Select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
)
--counted the number of missions by each branch as well as the percentage each branch flew over the duration of the war
--had to convert MILSERVICE_FORMATTED from varchar to float so I could perform the percentage calculation
select MFUNC_DESC_CLASS, MILSERVICE_FORMATTED, CONVERT(FLOAT, COUNT(MILSERVICE_FORMATTED)) as num_missions_by_branch, 
ROUND(CONVERT(FLOAT, COUNT(MILSERVICE_FORMATTED))*100/(SELECT COUNT(*) FROM num_missions_flown_by_branch_pie),4) as percentage_of_all_missions
from num_missions_flown_by_branch_pie
group by MFUNC_DESC_CLASS, MILSERVICE_FORMATTED
--order by MILSERVICE_FORMATTED
*/

-----------------------------------------------------------------------------------------------------------------

--next visualization 
--Aircraft type (tree map) (Sorting by kinetic vs. non-kinetic missions)
--use the PERIOD OF DAY column and list number of missions for each part of the day (ie. Day: 1700, Midday: 145, Night: 78)

--not including aircraft root that is unknown as well as nulls in msn_date and country
select MSNDATE_Converted, COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized, count(PERIODOFDAY_Standardized) over (partition by MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized) as num_day_night_missions_by_aircraft, count(VALID_AIRCRAFT_ROOT) over (partition by VALID_AIRCRAFT_ROOT) as total_num_aircraft_type
from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null


--aggregating data over all years
--union to combine (both kinetic and nonkinetic, non-null) 
with aircraft_type_breakdown_tree as (
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
), cte as (
select *, count(PERIODOFDAY_Standardized) over (partition by COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized) as num_day_night_missions_by_aircraft, count(VALID_AIRCRAFT_ROOT) over (partition by VALID_AIRCRAFT_ROOT) as total_num_aircraft_type_all_missions,
--row number function to count up all the duplicates across the criteria in partition by
ROW_NUMBER() over (partition by COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized order by VALID_AIRCRAFT_ROOT) as row_num_count
from aircraft_type_breakdown_tree 
)
select *
from cte
where row_num_count = 1 --drop all duplicates, only keep first unique row 
order by VALID_AIRCRAFT_ROOT


--create a view for number of missions flown by branch (Sorting by kinetic vs. non-kinetic missions)
/*
create view aircraft_type_breakdown_tree_2 as
with aircraft_type_breakdown_tree as (
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1965]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1966]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1967]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1968]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1969]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1970]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1971]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1972]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1973]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1974]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
	union all
	select COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized
	from [Vietnam_Bombing_Operations].[dbo].[VietNam_1975]
	where VALID_AIRCRAFT_ROOT <> 'NOT CODED' and PERIODOFDAY_Standardized in ('D', 'N') and MSNDATE_Converted is not null and COUNTRYFLYINGMISSION is not null
), cte as (
select *, count(PERIODOFDAY_Standardized) over (partition by COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized) as num_day_night_missions_by_aircraft, count(VALID_AIRCRAFT_ROOT) over (partition by VALID_AIRCRAFT_ROOT) as total_num_aircraft_type_all_missions,
--row number function to count up all the duplicates across the criteria in partition by
ROW_NUMBER() over (partition by COUNTRYFLYINGMISSION, MFUNC_DESC_CLASS, VALID_AIRCRAFT_ROOT, PERIODOFDAY_Standardized order by VALID_AIRCRAFT_ROOT) as row_num_count
from aircraft_type_breakdown_tree 
)
select *
from cte
where row_num_count = 1 --drop all duplicates, only keep first unique row 
--order by VALID_AIRCRAFT_ROOT
*/


--incorporating information from the aircraft glossary (full aircraft name/type and website)
--return all data from both tables regardless of whether or not there is a matching aircraft root
--first look to see where nulls show up
--As expected, there are aircraft roots that exist in the data that are not found in the glossary 
select *
from [Vietnam_Bombing_Operations].[dbo].[aircraft_type_breakdown_tree_2] as aircraft_tree
full outer join [Vietnam_Bombing_Operations].[dbo].[THOR_VIET_AIRCRAFT_GLOSS] as aircraft_gloss
on aircraft_tree.VALID_AIRCRAFT_ROOT = aircraft_gloss.VALIDATED_ROOT



--select for all the columns in aircraft_type_breakdown_tree_2 and left join aircraft name, website link, aircraft type and aircraft nickname
with combine_aircraft_gloss as (
select aircraft_tree.*, isnull(aircraft_gloss.AIRCRAFT_NAME, 'Unavailable') as AIRCRAFT_NAME, isnull(aircraft_gloss.WEBSITE_LINK, 'Unavailable') as WEBSITE_LINK, isnull(aircraft_gloss.AIRCRAFT_TYPE, 'Unavailable') as AIRCRAFT_TYPE, isnull(aircraft_gloss.AIRCRAFT_SHORTNAME, 'Unavailable') as AIRCRAFT_SHORTNAME
, ROW_NUMBER() over (partition by countryflyingmission, mfunc_desc_class, valid_aircraft_root, periodofday_standardized order by valid_aircraft_root) as dupe_check --remove rows that return duplicates as a result of the left join (ie. left table record matches 2 right table records)
from [Vietnam_Bombing_Operations].[dbo].[aircraft_type_breakdown_tree_2] as aircraft_tree
left join [Vietnam_Bombing_Operations].[dbo].[THOR_VIET_AIRCRAFT_GLOSS] as aircraft_gloss
on aircraft_tree.VALID_AIRCRAFT_ROOT = aircraft_gloss.VALIDATED_ROOT
--order by aircraft_gloss.VALID_AIRCRAFT_ROOT
)
select *
from combine_aircraft_gloss
where dupe_check = 1
order by combine_aircraft_gloss.VALID_AIRCRAFT_ROOT



--and lasly, create another view for the updated tree diagram
/*
Create View aircraft_type_breakdown_tree_3 as
with combine_aircraft_gloss as (
select aircraft_tree.*, isnull(aircraft_gloss.AIRCRAFT_NAME, 'Unavailable') as AIRCRAFT_NAME, isnull(aircraft_gloss.WEBSITE_LINK, 'Unavailable') as WEBSITE_LINK, isnull(aircraft_gloss.AIRCRAFT_TYPE, 'Unavailable') as AIRCRAFT_TYPE, isnull(aircraft_gloss.AIRCRAFT_SHORTNAME, 'Unavailable') as AIRCRAFT_SHORTNAME
, ROW_NUMBER() over (partition by countryflyingmission, mfunc_desc_class, valid_aircraft_root, periodofday_standardized order by valid_aircraft_root) as dupe_check --remove rows that return duplicates as a result of the left join (ie. left table record matches 2 right table records)
from [Vietnam_Bombing_Operations].[dbo].[aircraft_type_breakdown_tree_2] as aircraft_tree
left join [Vietnam_Bombing_Operations].[dbo].[THOR_VIET_AIRCRAFT_GLOSS] as aircraft_gloss
on aircraft_tree.VALID_AIRCRAFT_ROOT = aircraft_gloss.VALIDATED_ROOT
--order by aircraft_gloss.VALID_AIRCRAFT_ROOT
)
select *
from combine_aircraft_gloss
where dupe_check = 1
--order by combine_aircraft_gloss.VALID_AIRCRAFT_ROOT
*/
