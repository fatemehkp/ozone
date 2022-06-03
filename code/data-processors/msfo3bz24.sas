/* Created by Fatemeh K (01-02-2021)															*/
/* Create an aggregate data by the Site															*/
/* Dataset aggregated number of enrolleess and deaths by site, year, month, age, sex and race   */
/* Focus on 2000 (Jan) to 2008 data                                              				*/

libname prcs '/scratch/fatemehkp/projects/Ozone/data/processed';
libname raw '/scratch/fatemehkp/projects/Ozone/data/raw';
libname cms '/scratch/fatemehkp/projects/CMS/data/processed';

proc sql;
	create table raw.enrollee_ozone_bz24 as
	select *
	from cms.enrollee65_ndi_0008_clean a 
	inner join prcs.ozone_site_zip_bz24 b
	on a.zip_code=b.zip_code and a.year=b.year
	where sex ne 'U';
quit;

data enrollee_ozone; 
	set raw.enrollee_ozone_bz24;
	if race='W' then race='W';
		else race='NW';
	if enrollee_age ge 90 then enrollee_age = 90;
run;

/****************************************************************************/
/* Compute MASTER file                                                      */
/****************************************************************************/
proc sql;
*Count the number of enrollees of age a, sex s and race r by site s at the beginning of the month t ;
	create table master_enrollee_bysite as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_enrollee
	from enrollee_ozone
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of all-cause death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite1 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_allcuz
	from enrollee_ozone
	where allcuz=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of non-accidental death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite2 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_nacc
	from enrollee_ozone
	where nacc=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of accidental death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite3 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_acc
	from enrollee_ozone
	where acc=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of CVD death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite4 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_cvd
	from enrollee_ozone
	where cvd=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of IHD death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite5 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_ihd
	from enrollee_ozone
	where ihd=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of CHF death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite6 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_chf
	from enrollee_ozone
	where chf=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of CBV death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite7 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_cbv
	from enrollee_ozone
	where cbv=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Respiratory death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite8 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_resp
	from enrollee_ozone
	where resp=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of COPD death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite9 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_copd
	from enrollee_ozone
	where copd=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Pneumonia death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite10 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_pneu
	from enrollee_ozone
	where pneu=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of URI death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite11 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_uri
	from enrollee_ozone
	where uri=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of ARDS death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite12 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_ards
	from enrollee_ozone
	where ards=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Cancer death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite13 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_canc
	from enrollee_ozone
	where canc=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Lung Cancer death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite14 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_lungc
	from enrollee_ozone
	where lungc=1
	group by site_id, year, month, enrollee_age, sex, race;
	
*Count the number of Sepsis death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite15 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_seps
	from enrollee_ozone
	where seps=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Vascular Dementia death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite16 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_VaD
	from enrollee_ozone
	where VaD=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Alzheimer death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite17 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_AD
	from enrollee_ozone
	where AD=1
	group by site_id, year, month, enrollee_age, sex, race;
	
*Count the number of Neurodegenerative Disease death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite18 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_NeD
	from enrollee_ozone
	where NeD=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Unspecified Dementia death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite19 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_UsD
	from enrollee_ozone
	where UsD=1
	group by site_id, year, month, enrollee_age, sex, race;
	
*Count the number of Diabete typeI death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite20 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_diabt1
	from enrollee_ozone
	where diabt1=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Diabete typeII death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite21 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_diabt2
	from enrollee_ozone
	where diabt2=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Diabete death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite22 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_diab
	from enrollee_ozone
	where diabt1=1 or diabt2=1
	group by site_id, year, month, enrollee_age, sex, race;

*Count the number of Renal disease death among enrollees of age a, sex s and race r by site s during month t ;
/* ICD CODE */
	create table master_death_bysite23 as
	select site_id, year, month, enrollee_age, sex, race, count(distinct BENE_ID) as no_death_kidn
	from enrollee_ozone
	where kidn=1
	group by site_id, year, month, enrollee_age, sex, race;

quit;

data master_cuz;
	merge master_enrollee_bysite master_death_bysite1 master_death_bysite2 master_death_bysite3
								 master_death_bysite4 master_death_bysite5 master_death_bysite6
								 master_death_bysite7 master_death_bysite8 master_death_bysite9
								 master_death_bysite10 master_death_bysite11 master_death_bysite12
								 master_death_bysite13 master_death_bysite14 master_death_bysite15
								 master_death_bysite16 master_death_bysite17 master_death_bysite18
								 master_death_bysite19 master_death_bysite20 master_death_bysite21
								 master_death_bysite22 master_death_bysite23;
	by site_id year month enrollee_age sex race;
run;

proc datasets nolist;
	delete master_enrollee_bysite master_death_bysite1 master_death_bysite2 master_death_bysite3
								  master_death_bysite4 master_death_bysite5 master_death_bysite6
								  master_death_bysite7 master_death_bysite8 master_death_bysite9
								  master_death_bysite10 master_death_bysite11 master_death_bysite12
								  master_death_bysite13 master_death_bysite14 master_death_bysite15
								  master_death_bysite16 master_death_bysite17 master_death_bysite18
								  master_death_bysite19 master_death_bysite20 master_death_bysite21
								  master_death_bysite22 master_death_bysite23;
run;

/*change . to 0*/
data prcs.master_ndi_ozone_bz24; set master_cuz;
	array change _numeric_;
		do over change;
			if change <0 then change=0;
		end;
run;

proc export	data=prcs.master_ndi_ozone_bz24
	outfile='/scratch/fatemehkp/projects/Ozone/data/processed/master_ndi_ozone_bz24.csv'
	dbms=csv
	replace;
run;


