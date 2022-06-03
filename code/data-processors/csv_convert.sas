/* Java cannot read csv files created by R */
/* Read and Write by SAS */

/* pmc */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc.csv'
	out= ndi_pmc
	dbms= csv;
run;

proc export data=ndi_pmc
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc.csv'
	dbms=csv
	replace;
run;

/* fac */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac.csv'
	out= ndi_fac
	dbms= csv;
run;

proc export data=ndi_fac
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac.csv'
	dbms=csv
	replace;
run;

/* fac ex ec */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-ex-ec.csv'
	out= ndi_fac_ex
	dbms= csv;
run;

proc export data=ndi_fac_ex
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-ex-ec.csv'
	dbms=csv
	replace;
run;


/* carbon */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-carbon.csv'
	out= ndi_carbon
	dbms= csv;
run;

proc export data=ndi_carbon
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-carbon.csv'
	dbms=csv
	replace;
run;


/* carbon tot*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-carbon-tot.csv'
	out= ndi_carbon_tot
	dbms= csv;
run;

proc export data=ndi_carbon_tot
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-carbon-tot.csv'
	dbms=csv
	replace;
run;


/* carbon tor*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-carbon-tor.csv'
	out= ndi_carbon_tor
	dbms= csv;
run;

proc export data=ndi_carbon_tor
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-carbon-tor.csv'
	dbms=csv
	replace;
run;

/* pmc residual*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-residual.csv'
	out= ndi_pmc_resid
	dbms= csv;
run;

proc export data=ndi_pmc_resid
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-residual.csv'
	dbms=csv
	replace;
run;

/* fac residual */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-ex-ec-residual.csv'
	out= ndi_fac_resid
	dbms= csv;
run;

proc export data=ndi_fac_resid
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-residual.csv'
	dbms=csv
	replace;
run;


/* pmc residual west*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-res-west.csv'
	out= ndi_pmc_resid_w
	dbms= csv;
run;

proc export data=ndi_pmc_resid_w
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-res-west.csv'
	dbms=csv
	replace;
run;

/* pmc residual midwest*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-res-midwest.csv'
	out= ndi_pmc_resid_mw
	dbms= csv;
run;

proc export data=ndi_pmc_resid_mw
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-res-midwest.csv'
	dbms=csv
	replace;
run;

/* pmc residual south*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-res-south.csv'
	out= ndi_pmc_resid_s
	dbms= csv;
run;

proc export data=ndi_pmc_resid_s
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-res-south.csv'
	dbms=csv
	replace;
run;

/* pmc residual northeast*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-res-northeast.csv'
	out= ndi_pmc_resid_ne
	dbms= csv;
run;

proc export data=ndi_pmc_resid_ne
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-res-northeast.csv'
	dbms=csv
	replace;
run;


/* pmc Age LE 75*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-ageLE75.csv'
	out= ndi_pmc_l75
	dbms= csv;
run;

proc export data=ndi_pmc_l75
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-ageLE75.csv'
	dbms=csv
	replace;
run;


/* pmc Age M 75*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-ageM75.csv'
	out= ndi_pmc_m75
	dbms= csv;
run;

proc export data=ndi_pmc_m75
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-ageM75.csv'
	dbms=csv
	replace;
run;


/* pmc Sex Female*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-sexF.csv'
	out= ndi_pmc_f
	dbms= csv;
run;

proc export data=ndi_pmc_f
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-sexF.csv'
	dbms=csv
	replace;
run;


/* pmc Sex Male*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-sexM.csv'
	out= ndi_pmc_male
	dbms= csv;	
run;

proc export data=ndi_pmc_male
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-sexM.csv'
	dbms=csv
	replace;
run;


/* pmc race A*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceA.csv'
	out= ndi_pmc_A
	dbms= csv;
run;

proc export data=ndi_pmc_A
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceA.csv'
	dbms=csv
	replace;
run;

/* pmc race B*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceB.csv'
	out= ndi_pmc_B
	dbms= csv;
run;

proc export data=ndi_pmc_B
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceB.csv'
	dbms=csv
	replace;
run;

/* pmc race H*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceH.csv'
	out= ndi_pmc_His
	dbms= csv;
run;

proc export data=ndi_pmc_His
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceH.csv'
	dbms=csv
	replace;
run;

/* pmc race W*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceW.csv'
	out= ndi_pmc_Wi
	dbms= csv;
run;

proc export data=ndi_pmc_Wi
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-raceW.csv'
	dbms=csv
	replace;
run;


/* pmc urban*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban.csv'
	out= ndi_pmc_u
	dbms= csv;
run;

proc export data=ndi_pmc_u
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban.csv'
	dbms=csv
	replace;
run;

/* pmc rural*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-rural.csv'
	out= ndi_pmc_r
	dbms= csv;
run;

proc export data=ndi_pmc_r
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-rural.csv'
	dbms=csv
	replace;
run;

/* pmc urban ses L*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban-sesL.csv'
	out= ndi_pmc_Lo
	dbms= csv;
run;

proc export data=ndi_pmc_Lo
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban-sesL.csv'
	dbms=csv
	replace;
run;

/* pmc urban ses M*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban-sesM.csv'
	out= ndi_pmc_Me
	dbms= csv;
run;

proc export data=ndi_pmc_Me
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban-sesM.csv'
	dbms=csv
	replace;
run;

/* pmc urban ses H*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban-sesH.csv'
	out= ndi_pmc_Hi
	dbms= csv;
run;

proc export data=ndi_pmc_Hi
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-urban-sesH.csv'
	dbms=csv
	replace;
run;

/* pmc West*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-west.csv'
	out= ndi_pmc_west
	dbms= csv;
run;

proc export data=ndi_pmc_west
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-west.csv'
	dbms=csv
	replace;
run;


/* pmc Midwest*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-midwest.csv'
	out= ndi_pmc_mw
	dbms= csv;
run;

proc export data=ndi_pmc_mw
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-midwest.csv'
	dbms=csv
	replace;
run;


/* pmc South*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-south.csv'
	out= ndi_pmc_sou
	dbms= csv;
run;

proc export data=ndi_pmc_sou
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-south.csv'
	dbms=csv
	replace;
run;


/* pmc Northeast*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-northeast.csv'
	out= ndi_pmc_ne
	dbms= csv;
run;

proc export data=ndi_pmc_ne
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-northeast.csv'
	dbms=csv
	replace;
run;


/* pmc BRFSS*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-brfss.csv'
	out= ndi_pmc_brfs
	dbms= csv;	
run;

proc export data=ndi_pmc_brfs
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-brfss.csv'
	dbms=csv
	replace;
run;

/* pmc - 5r */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-5yr.csv'
	out= ndi_pmc_5yr
	dbms= csv;
run;

proc export data=ndi_pmc_5yr
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-5yr.csv'
	dbms=csv
	replace;
run;

/* pmc - 4r */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-4yr-5yr.csv'
	out= ndi_pmc_4yr
	dbms= csv;
run;

proc export data=ndi_pmc_4yr
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-4yr-5yr.csv'
	dbms=csv
	replace;
run;

/* pmc - 3r */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-3yr-5yr.csv'
	out= ndi_pmc_3yr
	dbms= csv;
run;

proc export data=ndi_pmc_3yr
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-3yr-5yr.csv'
	dbms=csv
	replace;
run;

/* pmc - 2r */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-2yr-5yr.csv'
	out= ndi_pmc_2yr
	dbms= csv;
run;

proc export data=ndi_pmc_2yr
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-2yr-5yr.csv'
	dbms=csv
	replace;
run;

/* pmc - 1r */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-1yr-5yr.csv'
	out= ndi_pmc_1yr
	dbms= csv;
run;

proc export data=ndi_pmc_1yr
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-1yr-5yr.csv'
	dbms=csv
	replace;
run;

/* pmc - bz6 */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-bz6.csv'
	out= ndi_pmc_bz6
	dbms= csv;
run;

proc export data=ndi_pmc_bz6
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-bz6.csv'
	dbms=csv
	replace;
run;

/* pmc - bz12 */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-bz12.csv'
	out= ndi_pmc_bz12
	dbms= csv;
run;

proc export data=ndi_pmc_bz12
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-bz12.csv'
	dbms=csv
	replace;
run;

/* pmc - bz24 */
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-bz24.csv'
	out= ndi_pmc_bz24
	dbms= csv;
run;

proc export data=ndi_pmc_bz24
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-pmc-bz24.csv'
	dbms=csv
	replace;
run;




/* fac Age LE 75*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-ageLE75.csv'
	out= ndi_fac_l75
	dbms= csv;
run;

proc export data=ndi_fac_l75
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-ageLE75.csv'
	dbms=csv
	replace;
run;


/* fac Age M 75*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-ageM75.csv'
	out= ndi_fac_m75
	dbms= csv;
run;

proc export data=ndi_fac_m75
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-ageM75.csv'
	dbms=csv
	replace;
run;


/* fac Sex Female*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-sexF.csv'
	out= ndi_fac_fe
	dbms= csv;
run;

proc export data=ndi_fac_fe
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-sexF.csv'
	dbms=csv
	replace;
run;


/* fac Sex Male*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-sexM.csv'
	out= ndi_fac_male
	dbms= csv;	
run;

proc export data=ndi_fac_male
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-sexM.csv'
	dbms=csv
	replace;
run;



/* fac race A*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-raceA.csv'
	out= ndi_fac_A
	dbms= csv;
run;

proc export data=ndi_fac_A
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-raceA.csv'
	dbms=csv
	replace;
run;

/* fac race B*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-raceB.csv'
	out= ndi_fac_B
	dbms= csv;
run;

proc export data=ndi_fac_B
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-raceB.csv'
	dbms=csv
	replace;
run;

/* fac race H*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-raceH.csv'
	out= ndi_fac_His
	dbms= csv;
run;

proc export data=ndi_fac_His
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-raceH.csv'
	dbms=csv
	replace;
run;

/* fac race W*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-raceW.csv'
	out= ndi_fac_Wi
	dbms= csv;
run;

proc export data=ndi_fac_Wi
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-raceW.csv'
	dbms=csv
	replace;
run;

/* fac urban*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-urban.csv'
	out= ndi_fac_urb
	dbms= csv;
run;

proc export data=ndi_fac_urb
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-urban.csv'
	dbms=csv
	replace;
run;

/* fac rural*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-rural.csv'
	out= ndi_fac_rur
	dbms= csv;
run;

proc export data=ndi_fac_rur
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-rural.csv'
	dbms=csv
	replace;
run;

/* fac west*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-west.csv'
	out= ndi_fac_west
	dbms= csv;
run;

proc export data=ndi_fac_west
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-west.csv'
	dbms=csv
	replace;
run;

/* fac midwest*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-midwest.csv'
	out= ndi_fac_midwest
	dbms= csv;
run;

proc export data=ndi_fac_midwest
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-midwest.csv'
	dbms=csv
	replace;
run;

/* fac south*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-south.csv'
	out= ndi_fac_south
	dbms= csv;
run;

proc export data=ndi_fac_south
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-south.csv'
	dbms=csv
	replace;
run;

/* fac northeast*/
proc import datafile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-northeast.csv'
	out= ndi_fac_northeast
	dbms= csv;
run;

proc export data=ndi_fac_northeast
	outfile='/scratch/fatemehkp/projects/PM Components/data/analysis/ndi-fac-northeast.csv'
	dbms=csv
	replace;
run;