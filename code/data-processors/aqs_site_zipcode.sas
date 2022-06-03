libname raw '/scratch/fatemehkp/projects/Ozone/data/raw';
libname prcs '/scratch/fatemehkp/projects/Ozone/data/processed';
libname air '/scratch/fatemehkp/projects/Zipcode PM NO2/data/processed';


/****************************************************************************************/
/* Site-Zipcode cross-walk for ozone to cms */
/* BZ = 6 */
proc import datafile="/scratch/fatemehkp/projects/Ozone/data/processed/ozone-site-zip-bz6.csv"
        out=ozone_bz6
        dbms=csv
        replace;
     getnames=yes;
run;

* change names to be consistent with CMS data;
data prcs.ozone_site_zip_bz6; retain Site_ID;
	set ozone_bz6;
	Site_ID = Site.ID;
	ZIP_CODE = Zip.Code;
	keep Site_ID ZIP_CODE Year psuedo;
run;

/* BZ = 12 */
proc import datafile="/scratch/fatemehkp/projects/Ozone/data/processed/ozone-site-zip-bz12.csv"
        out=ozone_bz12
        dbms=csv
        replace;
     getnames=yes;
run;

* change names to be consistent with CMS data;
data prcs.ozone_site_zip_bz12; retain Site_ID;
	set ozone_bz12;
	Site_ID = Site.ID;
	ZIP_CODE = Zip.Code;
	keep Site_ID ZIP_CODE Year psuedo;
run;

/* BZ = 24 */
proc import datafile="/scratch/fatemehkp/projects/Ozone/data/processed/ozone-site-zip-bz24.csv"
        out=ozone_bz24
        dbms=csv
        replace;
     getnames=yes;
run;

* change names to be consistent with CMS data;
data prcs.ozone_site_zip_bz24; retain Site_ID;
	set ozone_bz24;
	Site_ID = Site.ID;
	ZIP_CODE = Zip.Code;
	keep Site_ID ZIP_CODE Year psuedo;
run;



/****************************************************************************************/
/* Ozone sites with ndi data */
proc import datafile="/scratch/fatemehkp/projects/Ozone/data/processed/ozone-site-ndi.csv"
        out=ozone_sites
        dbms=csv
        replace;
     getnames=yes;
run;

* change names to be consistent with CMS data;
data prcs.ozone_site_ndi; retain Site_ID;
	rename 'Site.ID'n = Site_ID
			'Location.Setting'n = LocSet
			'Region.IV'n = Region
			'Land.Use'n = Landuse;
	set ozone_sites;
	drop 'State.Code'n 'County.Code'n;
run;


/****************************************************************************************/
/* aqs sites with brfss data */
proc import datafile="/scratch/fatemehkp/projects/Ozone/data/processed/brfss-site.csv"
        out=brfss_sites
        dbms=csv
        replace;
     getnames=yes;
run;

* change names to be consistent with CMS data;
data prcs.brfss_sites; retain Site_ID;
	rename 'Site.ID'n = Site_ID;
	set brfss_sites;
run;


/****************************************************************************************/
/* Adding PM and NO2 data to ozone data */

/*** bz = 6 ***/
proc import datafile="/scratch/fatemehkp/projects/Ozone/data/processed/ozone-site-all-zip-bz6.csv"
        out=site_zip_6
        dbms=csv
        replace;
     getnames=yes;
run;

data site_zip_6(keep = Site_ID Year Zip_Code O3maxh O3avgh O3max8h); 
	rename 'Site.ID'n = Site_ID
			'Zip.Code'n = Zip_Code 
			'O3.maxh'n = O3maxh
			'O3.avgh'n = O3avgh
			'O3.max8h'n = O3max8h;
	set site_zip_6;;
run;

*pm;
proc sql;
	create table site_zip_6_pm as
	select Site_ID, a.year, b.month,
			avg(PM_1yr) as PM_1yr
	from site_zip_6 a
	inner join air.pm_zipcd b
		on a.zip_code = b.zip_code and a.year = b.year
	group by site_id, a.year, b.month
	order by site_id, a.year, b.month;
quit;


proc export data=site_zip_6_pm
	outfile='/scratch/fatemehkp/projects/Ozone/data/processed/pm_ozone_bz6.csv'
	dbms=csv
	replace;
run;

*no2;
proc sql;
	create table site_zip_6_no2 as
	select Site_ID, a.year, b.month,
			avg(no2_1yr) as NO2_1yr
	from site_zip_6 a
	inner join air.no2_zipcd b
		on a.zip_code = b.zip_code and a.year = b.year
	group by site_id, a.year, b.month
	order by site_id, a.year, b.month;
quit;


proc export data=site_zip_6_no2
	outfile='/scratch/fatemehkp/projects/Ozone/data/processed/no2_ozone_bz6.csv'
	dbms=csv
	replace;
run;


/*** bz = 12 ***/
proc import datafile="/scratch/fatemehkp/projects/Ozone/data/processed/ozone-site-all-zip-bz12.csv"
        out=site_zip_12
        dbms=csv
        replace;
     getnames=yes;
run;

data site_zip_12(keep = Site_ID Year Zip_Code O3maxh O3avgh O3max8h); 
	rename 'Site.ID'n = Site_ID
			'Zip.Code'n = Zip_Code 
			'O3.maxh'n = O3maxh
			'O3.avgh'n = O3avgh
			'O3.max8h'n = O3max8h;
	set site_zip_12;
run;

*pm;
proc sql;
	create table site_zip_12_pm as
	select Site_ID, a.year, b.month,
			avg(PM_1yr) as PM_1yr
	from site_zip_12 a
	inner join air.pm_zipcd b
		on a.zip_code = b.zip_code and a.year = b.year
	group by site_id, a.year, b.month
	order by site_id, a.year, b.month;
quit;


proc export data=site_zip_12_pm
	outfile='/scratch/fatemehkp/projects/Ozone/data/processed/pm_ozone_bz12.csv'
	dbms=csv
	replace;
run;

*no2;
proc sql;
	create table site_zip_12_no2 as
	select Site_ID, a.year, b.month,
			avg(no2_1yr) as NO2_1yr
	from site_zip_12 a
	inner join air.no2_zipcd b
		on a.zip_code = b.zip_code and a.year = b.year
	group by site_id, a.year, b.month
	order by site_id, a.year, b.month;
quit;


proc export data=site_zip_12_no2
	outfile='/scratch/fatemehkp/projects/Ozone/data/processed/no2_ozone_bz12.csv'
	dbms=csv
	replace;
run;


/*** bz = 24 ***/
proc import datafile="/scratch/fatemehkp/projects/Ozone/data/processed/ozone-site-all-zip-bz24.csv"
        out=site_zip_24
        dbms=csv
        replace;
     getnames=yes;
run;

data site_zip_24(keep = Site_ID Year Zip_Code O3maxh O3avgh O3max8h); 
	rename 'Site.ID'n = Site_ID
			'Zip.Code'n = Zip_Code 
			'O3.maxh'n = O3maxh
			'O3.avgh'n = O3avgh
			'O3.max8h'n = O3max8h;
	set site_zip_24;
run;

*pm;
proc sql;
	create table site_zip_24_a as
	select Site_ID, a.year, b.month,
			avg(PM_1yr) as PM_1yr
	from site_zip_24 a
	inner join air.pm_zipcd b
		on a.zip_code = b.zip_code and a.year = b.year
	group by site_id, a.year, b.month
	order by site_id, a.year, b.month;
quit;


proc export data=site_zip_24_a
	outfile='/scratch/fatemehkp/projects/Ozone/data/processed/pm_ozone_bz24.csv'
	dbms=csv
	replace;
run;


*no2;
proc sql;
	create table site_zip_24_no2 as
	select Site_ID, a.year, b.month,
			avg(no2_1yr) as NO2_1yr
	from site_zip_24 a
	inner join air.no2_zipcd b
		on a.zip_code = b.zip_code and a.year = b.year
	group by site_id, a.year, b.month
	order by site_id, a.year, b.month;
quit;


proc export data=site_zip_24_no2
	outfile='/scratch/fatemehkp/projects/Ozone/data/processed/no2_ozone_bz24.csv'
	dbms=csv
	replace;
run;


