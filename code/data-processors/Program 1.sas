/*****************************/
/* Total enrolees with brfs data */
proc import datafile='/scratch/fatemehkp/projects/Ozone/data/processed/ozone-brfss-count.csv'
	out=raw.brfss
	dbms=csv
	replace;
run;

proc sql;
	select count(distinct bene_id) as num_enrollee
	from raw.enrollee_ozone a
	inner join raw.brfss b
	on a.year = b.year and a.month = b.month and a.site_id = b.site_id;
quit; 
	
	
/*****************************/
/* ozone sites with ndi data */
proc import datafile='/scratch/fatemehkp/projects/Ozone/data/processed/ozone-site-ndi.csv'
	out=raw.ozone_site
	dbms=csv
	replace;
run;

data raw.ozone_site;
	set raw.ozone_site;
	Site_ID = Site.ID;
	Location = Location.Setting;
	Region = Region.IV;
run;

/*****************************/
/* Total enrollee by urbanicity */
proc sql;
	title 'Total enrollee by Location Setting';
	select Location, count(distinct bene_id) as num_enrollee
	from raw.enrollee_ozone_start a
	inner join raw.ozone_site b
	on a.site_id = b.site_id
	group by Location
	order by Location;
quit; 


/*****************************/
/* Total enrollee by region */
proc sql;
	title 'Total enrollee by Region';
	select Region, count(distinct bene_id) as num_enrollee
	from raw.enrollee_ozone_start a
	inner join raw.ozone_site b
	on a.site_id = b.site_id
	group by Region
	order by Region;
quit; 