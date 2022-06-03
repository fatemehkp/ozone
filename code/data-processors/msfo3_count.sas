/* Created by Fatemeh K (01-17-2021)																*/
/* Counting numbers per group */

libname raw '/scratch/fatemehkp/projects/Ozone/data/raw';
libname prcs '/scratch/fatemehkp/projects/Ozone/data/processed';

proc sql;
	create table raw.enrollee_ozone as
	select *
	from raw.enrollee_ozone a 
	inner join prcs.ozone_site_ndi b
	on a.site_id=b.site_id;
quit;

data raw.enrollee_ozone_dead;
	set  raw.enrollee_ozone;
	where allcuz = 1 or nacc =1 or acc =1 or cvd = 1 or ihd =1 or chf =1 or cbv =1 or 
	resp =1 or copd =1 or pneu =1 or uri =1 or ards =1 or canc =1 or lungc = 1 or seps =1 or
	VaD =1 or AD =1 or NeD = 1 or UsD =1 or diabt1 = 1 or diabt2 =1 or kidn=1;
run;

/*****************************/
/* Total enrollee */
proc sql;
	title 'Total enrollee in the US';
	select count(distinct bene_id) as num_enrollee
	from raw.enrollee_ozone;
quit; 

/*****************************/
/* Total zipcode */
proc sql;
	title 'Total zipcode in the study';
	select count(distinct zip_code) as num_zipcode
	from raw.enrollee_ozone;
quit; 


* BZ = 12 mile;
/*****************************/
/* Total enrollee */
proc sql;
	title 'Total enrollee in the US';
	select count(distinct bene_id) as num_enrollee
	from raw.enrollee_ozone_bz12;
quit; 


/*****************************/
/* Total zipcode */
proc sql;
	title 'Total zipcode in the study';
	select count(distinct zip_code) as num_zipcode
	from raw.enrollee_ozone_bz12;
quit; 


* BZ = 24 mile;
/*****************************/
/* Total enrollee */
proc sql;
	title 'Total enrollee in the US';
	select count(distinct bene_id) as num_enrollee
	from raw.enrollee_ozone_bz24;
quit; 

/*****************************/
/* Total zipcode */
proc sql;
	title 'Total zipcode in the study';
	select count(distinct zip_code) as num_zipcode
	from raw.enrollee_ozone_bz24;
quit; 


/*****************************/
/* Cause-Specific Mortality */
proc sql;
	title 'Total casue-specific death in the study';
	create table ozone_death as
	select sum(allcuz) as allcause,
			sum(cvd) as allcvd,
			sum(ihd) as allihd,
			sum(chf) as allchf,
			sum(cbv) as allcbv,
			sum(resp) as allresp,
			sum(copd) as allcopd,
			sum(pneu) as allpneu,
			sum(uri) as alluri,
			sum(ards) as allards,
			sum(canc) as allcanc,
			sum(lungc) as alllungc,
			sum(seps) as allsepsis,
			sum(VaD) as allVaD,
			sum(AD) as allAD,
			sum(NeD) as allNeD,
			sum(UsD) as allUsD,
			sum(diabt1) as alldiabt1,
			sum(diabt2) as alldiabt2,
			sum(kidn) as allkidn
	from raw.enrollee_ozone;
quit;

proc export	data=ozone_death
	outfile='/scratch/fatemehkp/projects/Ozone/output/ozone_death.csv'
	dbms=csv
	replace;
run;


*Some people might changed their sex/race identity in between;
proc sort data=raw.enrollee_ozone out=master0;
	by bene_id year month; 
run;
	
proc sort data=master0 nodupkey out=raw.enrollee_ozone_start;
	by bene_id; run;


/*****************************/
/* Total enrollee at each age group at time of enrollment */
proc sql;
title 'Frequency of Age at time of enrollement';
Create table enrollee_age as
select enrollee_age, count(bene_id) as age_freq
from raw.enrollee_ozone_start
group by enrollee_age
order by enrollee_age;
quit;

proc export	data=enrollee_age
	outfile='/scratch/fatemehkp/projects/Ozone/output/ozone_enrollee_age.csv'
	dbms=csv
	replace;
run;


/*****************************/
/* Total enrollee at each sex group at time of enrollment */
proc sql;
title 'Frequency of Sex at time of enrollement';
Create table enrollee_sex as
select sex, count(bene_id) as sex_freq
from raw.enrollee_ozone_start
group by sex
order by sex;
quit;

proc export	data=enrollee_sex
	outfile='/scratch/fatemehkp/projects/Ozone/output/ozone_enrollee_sex.csv'
	dbms=csv
	replace;
run;


/*****************************/
/* Total enrollee at each race group at time of enrollment */
proc sql;
title 'Frequency of Race at time of enrollement';
Create table enrollee_race as
select race, count(bene_id) as race_freq
from raw.enrollee_ozone_start
group by race
order by race;
quit;

proc export	data=enrollee_race
	outfile='/scratch/fatemehkp/projects/Ozone/output/ozone_enrollee_race.csv'
	dbms=csv
	replace;
run;


/*****************************/
/* Total enrollee at each urbanicity group at time of enrollment */
proc sql;
title 'Frequency of urbanicity at time of enrollement';
Create table enrollee_LocSet as
select LocSet, count(bene_id) as locset_freq
from raw.enrollee_ozone_start
group by LocSet
order by LocSet;
quit;

proc export	data=enrollee_LocSet
	outfile='/scratch/fatemehkp/projects/Ozone/output/ozone_enrollee_locationset.csv'
	dbms=csv
	replace;
run;



/*****************************/
/* Total enrollee at each region at time of enrollment */
proc sql;
title 'Frequency of region at time of enrollement';
Create table enrollee_LocSet as
select region, count(bene_id) as region_freq
from raw.enrollee_ozone_start
group by region
order by region;
quit;

proc export	data=enrollee_region
	outfile='/scratch/fatemehkp/projects/Ozone/output/ozone_enrollee_region.csv'
	dbms=csv
	replace;
run;



/** brfss data **/
proc sql;
	create table enrollee_ozone_brfss as
	select *
	from raw.enrollee_ozone a 
	inner join prcs.brfss_site b
	on a.site_id=b.site_id and a.year=b.year and a.month=b.month;
quit;


/*****************************/
/* Total enrollee  with brfss data*/
proc sql;
	title 'Total enrollee in the US with brfss data';
	select count(distinct bene_id) as num_enrollee
	from enrollee_ozone_brfss;
quit; 

/*****************************/
/* Total zipcode */
proc sql;
	title 'Total zipcode in the study with brfss data';
	select count(distinct zip_code) as num_zipcode
	from enrollee_ozone_brfss;
quit; 
