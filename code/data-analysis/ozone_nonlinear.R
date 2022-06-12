library(survival)
library(rms)
library(pspline)

data <- read.delim('~/Downloads/o3cms_asr2008_ses.csv', sep=',')
names(data)

#find the knots for 3.
quantile(data$o3maxh, c(0.1, 0.5, 0.9))
# 10%        50%        90% 
# 0.04527869 0.05554645 0.06519424 

# non-linear (3knots for Yall + strata on age, sex and race)
knots_3 <- rcspline.eval(data$o3maxh, knots=c(0.04527869, 0.05554645, 0.06519424), inclx=TRUE,norm=2)
all_model <- glm(Yall~knots_3+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(all_model)
#Coefficients:
#Estimate Std. Error  z value Pr(>|z|)    
#(Intercept)                                  -6.4013537  0.0084062 -761.505  < 2e-16 ***
#  knots_3x                                      0.6564445  0.1090865    6.018 1.77e-09 ***
#  knots_3                                       1.8003170  0.1209351   14.887  < 2e-16 ***
#  pmj_1ymvavg                                   0.0059250  0.0001845   32.118  < 2e-16 ***
#  ses                                          -0.1823831  0.0027921  -65.321  < 2e-16 ***
#

cvd_model <- glm(Ycvd~knots_3+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(cvd_model)
#Coefficients:
#  Estimate Std. Error  z value Pr(>|z|)    
#(Intercept)                                  -7.7236543  0.0135416 -570.366  < 2e-16 ***
#  knots_3x                                     -0.2773925  0.1699481   -1.632  0.10263    
#  knots_3                                       3.4059985  0.1867716   18.236  < 2e-16 ***
#  pmj_1ymvavg                                   0.0178567  0.0002840   62.886  < 2e-16 ***
#  ses                                          -0.1454949  0.0044029  -33.045  < 2e-16 ***

ihd_model <- glm(Yihd~knots_3+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(ihd_model)
#Coefficients:
#  Estimate Std. Error  z value Pr(>|z|)    
#(Intercept)                                  -8.9346864  0.0194098 -460.319  < 2e-16 ***
#  knots_3x                                     -2.4791605  0.2304905  -10.756  < 2e-16 ***
#  knots_3                                       5.6875754  0.2510026   22.659  < 2e-16 ***
#  pmj_1ymvavg                                   0.0364933  0.0003811   95.764  < 2e-16 ***
#  ses                                          -0.1796589  0.0060747  -29.575  < 2e-16 ***


chf_model <- glm(Ychf~knots_3+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(chf_model)
#Coefficients:
#  Estimate Std. Error  z value Pr(>|z|)    
#(Intercept)                                  -10.323437   0.056732 -181.970  < 2e-16 ***
#  knots_3x                                      11.517559   0.724836   15.890  < 2e-16 ***
#  knots_3                                       -2.815505   0.799579   -3.521  0.00043 ***
#  pmj_1ymvavg                                   -0.019650   0.001181  -16.637  < 2e-16 ***
#  ses                                           -0.216788   0.016551  -13.099  < 2e-16 ***


cbv_model <- glm(Ycbv~knots_3+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(cbv_model)
#Coefficients:
#  Estimate Std. Error  z value Pr(>|z|)    
#(Intercept)                                  -9.380009   0.031420 -298.537  < 2e-16 ***
#  knots_3x                                      1.440963   0.398399    3.617 0.000298 ***
#  knots_3                                       1.156010   0.438439    2.637 0.008373 ** 
#  pmj_1ymvavg                                   0.004436   0.000671    6.611 3.83e-11 ***
#  ses                                           0.093428   0.010390    8.992  < 2e-16 ***

resp_model <- glm(Yresp~knots_3+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(resp_model)
#Coefficients:
#  Estimate Std. Error  z value Pr(>|z|)    
#(Intercept)                                  -9.2619089  0.0278284 -332.822  < 2e-16 ***
#  knots_3x                                      2.8373110  0.3323432    8.537  < 2e-16 ***
#  knots_3                                       1.1156633  0.3587962    3.109 0.001874 ** 
#  pmj_1ymvavg                                   0.0044375  0.0005446    8.148 3.70e-16 ***
#  ses                                          -0.2351066  0.0084009  -27.986  < 2e-16 ***

copd_model <- glm(Ycopd~knots_3+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(copd_model)
#Coefficients:
#  Estimate Std. Error  z value Pr(>|z|)    
#(Intercept)                                  -9.8184751  0.0394229 -249.055  < 2e-16 ***
#  knots_3x                                      6.8742886  0.4690620   14.655  < 2e-16 ***
#  knots_3                                       0.1978131  0.4953322    0.399 0.689632    
#  pmj_1ymvavg                                  -0.0067728  0.0007582   -8.933  < 2e-16 ***
#  ses                                          -0.4888904  0.0116883  -41.827  < 2e-16 ***

pneu_model <- glm(Ypneu~knots_3+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(pneu_model)
#Coefficients:
#  Estimate Std. Error  z value Pr(>|z|)    
#(Intercept)                                  -1.144e+01  5.465e-02 -209.380  < 2e-16 ***
#  knots_3x                                     -1.699e+00  6.050e-01   -2.808 0.004986 ** 
#  knots_3                                       2.736e+00  6.522e-01    4.196 2.72e-05 ***
#  pmj_1ymvavg                                   3.687e-02  9.669e-04   38.133  < 2e-16 ***
#  ses                                           8.959e-02  1.597e-02    5.610 2.02e-08 ***

canc_model <- glm(Ycanc~knots_3+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(canc_model)
#Coefficients:
#  Estimate Std. Error  z value Pr(>|z|)    
#$(Intercept)                                  -7.4849405  0.0172470 -433.986  < 2e-16 ***
#  knots_3x                                     -1.3530458  0.2311032   -5.855 4.78e-09 ***
#  knots_3                                       1.5679797  0.2583471    6.069 1.28e-09 ***
#  pmj_1ymvavg                                   0.0038950  0.0003929    9.915  < 2e-16 ***
#  ses                                          -0.1324066  0.0059310  -22.324  < 2e-16 ***

lungc_model <- glm(Ylungc~knots_3+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(lungc_model)
#Coefficients:
#  Estimate Std. Error  z value Pr(>|z|)    
#(Intercept)                                  -8.7503108  0.0333500 -262.378  < 2e-16 ***
#  knots_3x                                   1.4246899  0.4503034    3.164 0.001557 ** 
#  knots_3                                    -0.5688185  0.5005332   -1.136 0.255779    
# pmj_1ymvavg                                   0.0003187  0.0007593    0.420 0.674629    
# ses                                          -0.2912921  0.0113308  -25.708  < 2e-16 ***


# #knots=4
quantile(data$o3maxh, c(0.05, 0.35, 0.65, 0.95))
#        5%        35%        65%        95% 
# 0.04178142 0.05275275 0.05832544 0.06915437 
knots_4 <- rcspline.eval(data$o3maxh, knots=c(0.04178142, 0.05275275, 0.05832544, 0.06915437), inclx=TRUE,norm=2)
all_knots4 <- glm(Yall~knots_4+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(all_knots4)
#Coefficients:
#  Estimate Std. Error  z value Pr(>|z|)    
#(Intercept)                                  -6.4267328  0.0096514 -665.889  < 2e-16 ***
#  knots_4x                                      1.2259186  0.1545442    7.932 2.15e-15 ***
#  knots_4                                      -0.9747108  0.4686453   -2.080 0.037539 *  
#  knots_4                                      13.1850592  2.2065693    5.975 2.30e-09 ***
#  pmj_1ymvavg                                   0.0059094  0.0001845   32.021  < 2e-16 ***
#  ses                                          -0.1798486  0.0028133  -63.929  < 2e-16 ***

quantile(data$o3maxh, c(0.05, 0.275,0.5,0.725,0.95))
#     5%      27.5%        50%      72.5%        95% 
# 0.04178142 0.05107735 0.05554645 0.05984699 0.06915437
knots_5 <- rcspline.eval(data$o3maxh, knots=c(0.04178142, 0.05107735, 0.05554645, 0.05984699, 0.06915437), inclx=TRUE,norm=2)
all_knots5 <- glm(Yall~knots_5+pmj_1ymvavg+ses+state+strata(age,sex,race),offset=(log(N)), data=data, family=poisson())
summary(all_knots5)
#Coefficients:
#  Estimate Std. Error  z value Pr(>|z|)    
#(Intercept)                                   -6.418739   0.010313 -622.381  < 2e-16 ***
#  knots_5x                                       0.994086   0.183805    5.408 6.36e-08 ***
#  knots_5                                        1.144301   0.994863    1.150 0.250058    
#  knots_5                                      -11.500654   7.120705   -1.615 0.106289    
#  knots_5                                       36.841965  12.421446    2.966 0.003017 ** 
#  pmj_1ymvavg                                    0.005946   0.000185   32.140  < 2e-16 ***
#  ses                                           -0.179415   0.002815  -63.733  < 2e-16 ***
