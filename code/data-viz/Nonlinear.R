library(latex2exp)
library(grid)
library(ggplot2)
library(gridExtra)
library(lattice)
minX <- 0.02049727 * 1000
maxX <- 0.09737158 * 1000
xAxis = seq(minX, maxX, length.out=101)

coxFun <- function(xx, knots, coefs)
{
     yy = c()
     for (x in xx) {
     firstKnot <- knots[1]
     lastKnot <- knots[length(knots)]
     lastSecondKnot <- knots[length(knots)-1]
     lastTwoDiff <- lastKnot - lastSecondKnot
     normValue <- (lastKnot - firstKnot)^(2.0/3.0)
     newX = c()
     newX <- c(newX, x)
     diffLastSecond = x - lastSecondKnot
     diffLast = x - lastKnot
     for (i in 2:(length(knots)-1))
     {
          xi = 0
          ti = knots[i-1]
          diffX = x - ti
          if (diffX>0) {xi = (diffX/normValue)^3}
          if (diffLastSecond>0)  {xi = xi - (diffLastSecond/normValue)^3 * (lastKnot - ti)/lastTwoDiff } 
          if (diffLast>0) {xi = xi + (diffLast/normValue)^3 * (lastSecondKnot - ti)/lastTwoDiff} 
          newX <- c(newX, xi)
     }
     y = exp(crossprod(newX,coefs)[1][1])
     yy = c(yy, y)
     }
     yy
}

CI <- function(xx, knots, coefs, stds)
{
     yyUp = c()
     yyLow = c()
     for (x in xx) {
     firstKnot <- knots[1]
     lastKnot <- knots[length(knots)]
     lastSecondKnot <- knots[length(knots)-1]
     lastTwoDiff <- lastKnot - lastSecondKnot
     normValue <- (lastKnot - firstKnot)^(2.0/3.0)
     newX = c()
     newX <- c(newX, x)
     diffLastSecond = x - lastSecondKnot
     diffLast = x - lastKnot
     for (i in 2:(length(knots)-1))
     {
          xi = 0
          ti = knots[i-1]
          diffX = x - ti
          if (diffX>0) {xi = (diffX/normValue)^3}
          if (diffLastSecond>0)  {xi = xi - (diffLastSecond/normValue)^3 * (lastKnot - ti)/lastTwoDiff } 
          if (diffLast>0) {xi = xi + (diffLast/normValue)^3 * (lastSecondKnot - ti)/lastTwoDiff} 
          newX <- c(newX, xi)
     }
     yUp = exp(crossprod(newX,(coefs+1.96*stds))[1][1])
     yLow = exp(crossprod(newX,(coefs-1.96*stds))[1][1])
     yyUp = c(yyUp, yUp)
     yyLow = c(yyLow, yLow)
     }
    return(list(yyLow, yyUp))
}


coxBasicFun <- function(xx,  coefs)
{
     yy = c()
     for (x in xx) {
     y = exp(crossprod(x,coefs)[1][1])
     yy = c(yy, y)
     }
     yy
}
CIBasic <- function(xx, coefs, stds)
{
     yyUp = c()
     yyLow = c()
     for (x in xx) {
     yUp = exp(crossprod(x,(coefs+1.96*stds))[1][1])
     yLow = exp(crossprod(x,(coefs-1.96*stds))[1][1])
     yyUp = c(yyUp, yUp)
     yyLow = c(yyLow, yLow)
     }
    return(list(yyLow, yyUp))
}


### NEW ### ### NEW ### ### NEW ### ### NEW ### ### NEW ### ### NEW ### ### NEW ### ### NEW ### ### NEW ### 
### NEW ### ### NEW ### ### NEW ### ### NEW ### ### NEW ### ### NEW ### ### NEW ### ### NEW ### ### NEW ### 

file='all'
comparison1="All-cause"
par(mfrow=c(5,2))
#par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04527869, 0.05554645, 0.06519424) * 1000
coef.3.1 = c(0.6564445, 1.8003170) * 0.001
std.3.1 = c(0.1090865, 0.1209351) * 0.001
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1) 
ci.3.1 =CI(xAxis, knots.3.1, coef.3.1, std.3.1)

# linear 
# coef.0 = c(2.987) * 0.001
# y.0 <- coxBasicFun(xAxis, coef.0)

p1 <- ggplot() +theme_bw() +
theme(axis.line = element_line(color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) +
geom_text(aes(x=60, y=1.45, label=comparison1), color="black") +  
geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
#geom_line(aes(y=y.0, x=xAxis), color=rgb(0, 0, 255, 100, maxColorValue=255), size=1.0) +
scale_y_continuous(breaks=c(1.0,1.25,1.5), limits = c(0.8, 1.5)) + 
scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
labs(y="Risk Ratio")
p1

jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=5.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()


file='cvd'
comparison1="CVD"
par(mfrow=c(3,1))
par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04527869, 0.05554645, 0.06519424) * 1000
coef.3.1 = c(-0.2773925, 3.4059985) * 0.001
std.3.1 = c(0.1699481, 0.1867716) * 0.001
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1)
ci.3.1 =CI(xAxis,knots.3.1,coef.3.1, std.3.1)

# linear 
# coef.0 = c(0.482) * 0.001
# y.0 <- coxBasicFun(xAxis, coef.0)
p1 <- ggplot() +theme_bw() +
theme(axis.line = element_line(color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) +
geom_text(aes(x=60, y=1.45, label=comparison1), color="black") +  
geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
#geom_line(aes(y=y.0, x=xAxis), color=rgb(0, 0, 255, 100, maxColorValue=255), size=1.0) +
scale_y_continuous(breaks=c(1.0,1.25,1.5), limits = c(0.8, 1.5)) + 
scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
labs(y="Risk Ratio")


jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=5.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()




file='ihd'
comparison1="IHD"
par(mfrow=c(3,1))
par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04527869, 0.05554645, 0.06519424) * 1000
coef.3.1 = c(-2.4791605, 5.6875754) * 0.001
std.3.1 = c(0.2304905, 0.2510026) * 0.001
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1)
ci.3.1 =CI(xAxis,knots.3.1,coef.3.1, std.3.1)

# linear 
#coef.0 = c(0.439) * 0.001
#y.0 <- coxBasicFun(xAxis, coef.0)

p1 <- ggplot() +theme_bw() +
theme(axis.line = element_line(color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) +
geom_text(aes(x=60, y=1.45, label=comparison1), color="black") +  
geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
#geom_line(aes(y=y.0, x=xAxis), color=rgb(0, 0, 255, 100, maxColorValue=255), size=1.0) +
scale_y_continuous(breaks=c(1.0,1.25,1.5), limits = c(0.85, 1.5)) +
scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
labs(y="Risk Ratio")

jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=5.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()




file='chf'
comparison1="CHF"
par(mfrow=c(3,1))
par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04527869, 0.05554645, 0.06519424) * 1000
coef.3.1 = c(11.517559,-2.815505) * 0.001
std.3.1 = c(0.724836,0.799579) * 0.001
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1)
ci.3.1 =CI(xAxis,knots.3.1,coef.3.1, std.3.1)

# linear 
#coef.0 = c(-0.467) * 0.001
#y.0 <- coxBasicFun(xAxis, coef.0)

p1 <- ggplot() +theme_bw() +
theme(axis.line = element_line(color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) +
geom_text(aes(x=60, y=2.750, label=comparison1), color="black") +  
geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
#geom_line(aes(y=y.0, x=xAxis), color=rgb(0, 0, 255, 100, maxColorValue=255), size=1.0) +
scale_y_continuous(breaks=c(1.0,1.5,2.0,2.5,3.0), limits = c(0.85, 3)) + 
scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
labs(y="Risk Ratio")

jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=5.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()




file='cbv'
comparison1="CBV"
par(mfrow=c(3,1))
par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04527869, 0.05554645, 0.06519424) * 1000
coef.3.1 = c( 1.440963, 1.156010) * 0.001 
std.3.1 = c(0.398399, 0.438439) * 0.001 
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1) 
ci.3.1 =CI(xAxis, knots.3.1, coef.3.1, std.3.1)

# linear 
# coef.0 = c(2.987) * 0.001
# y.0 <- coxBasicFun(xAxis, coef.0)

p1 <- ggplot() +theme_bw() +
theme(axis.line = element_line(color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) +
geom_text(aes(x=60, y=1.45, label=comparison1), color="black") +  
geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
# geom_line(aes(y=y.0, x=xAxis), color=rgb(0, 0, 255, 100, maxColorValue=255), size=1.0) +
scale_y_continuous(breaks=c(1.0,1.25,1.5), limits = c(0.8, 1.5)) + 
scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
labs(y="Risk Ratio")


jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=5.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()



file='resp'
comparison1="Respiratory"
par(mfrow=c(3,1))
par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04527869, 0.05554645, 0.06519424) * 1000
coef.3.1 = c(2.8373110, 1.1156633) * 0.001
std.3.1 = c(0.3323432, 0.3587962) * 0.001
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1)
ci.3.1 =CI(xAxis,knots.3.1,coef.3.1, std.3.1)

# linear 
# coef.0 = c(0.482) * 0.001
# y.0 <- coxBasicFun(xAxis, coef.0)

p1 <- ggplot() +theme_bw() +
theme(axis.line = element_line(color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) +
geom_text(aes(x=60, y=1.45, label=comparison1), color="black") +  
geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
# geom_line(aes(y=y.0, x=xAxis), color=rgb(0, 0, 255, 100, maxColorValue=255), size=1.0) +
scale_y_continuous(breaks=c(1.0,1.25,1.5), limits = c(0.8, 1.5)) + 
scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
labs(y="Risk Ratio")


jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=5.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()




file='copd'
comparison1="COPD"
par(mfrow=c(3,1))
par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04527869, 0.05554645, 0.06519424) * 1000
coef.3.1 = c(6.8742886, 0.1978131) * 0.001
std.3.1 = c(0.4690620, 0.4953322) * 0.001
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1)
ci.3.1 =CI(xAxis,knots.3.1,coef.3.1, std.3.1)

# linear 
# coef.0 = c(0.439) * 0.001
# y.0 <- coxBasicFun(xAxis, coef.0)

p1 <- ggplot() +theme_bw() +
theme(axis.line = element_line(color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) +
geom_text(aes(x=60, y=2.4, label=comparison1), color="black") +  
geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
scale_y_continuous(breaks=c(1.0,1.5,2.0,2.5,3.0), limits = c(0.8, 3.50)) + 
scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
labs(y="Risk Ratio")


jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=10.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()




file='pneu'
comparison1="Pneumonia"
par(mfrow=c(3,1))
par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04527869, 0.05554645, 0.06519424) * 1000
coef.3.1 = c(-1.699e+00, 2.736e+00) * 0.001
std.3.1 = c(6.050e-01, 6.522e-01) * 0.001
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1)
ci.3.1 =CI(xAxis,knots.3.1,coef.3.1, std.3.1)

# linear 
# coef.0 = c(-0.467) * 0.001
# y.0 <- coxBasicFun(xAxis, coef.0)

p1 <- ggplot() +theme_bw() +
theme(axis.line = element_line(color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) +
geom_text(aes(x=60, y=1.075, label=comparison1), color="black") +  
geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
# geom_line(aes(y=y.0, x=xAxis), color=rgb(0, 0, 255, 100, maxColorValue=255), size=1.0) +
scale_y_continuous(breaks=c(1.0,1.25,1.5), limits = c(0.8, 1.5)) +
scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
labs(y="Risk Ratio")


jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=5.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()





file='canc'
comparison1="Cancer"
par(mfrow=c(3,1))
par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04527869, 0.05554645, 0.06519424) * 1000
coef.3.1 = c( -1.3530458, 1.5679797) * 0.001 
std.3.1 = c(0.2311032, 0.2583471) * 0.001 
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1) 
ci.3.1 =CI(xAxis, knots.3.1, coef.3.1, std.3.1)

# linear 
# coef.0 = c(2.987) * 0.001
# y.0 <- coxBasicFun(xAxis, coef.0)

p1 <- ggplot() +theme_bw() +
theme(axis.line = element_line(color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) +
geom_text(aes(x=60, y=1.45, label=comparison1), color="black") +  
geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
# geom_line(aes(y=y.0, x=xAxis), color=rgb(0, 0, 255, 100, maxColorValue=255), size=1.0) +
scale_y_continuous(breaks=c(1.0,1.25,1.5), limits = c(0.8, 1.5)) +
scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
labs(y="Risk Ratio")


jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=5.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()



file='lungc'
comparison1="Lung Cancer"
par(mfrow=c(3,1))
par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04527869, 0.05554645, 0.06519424) * 1000
coef.3.1 = c(1.4246899, -0.5688185) * 0.001
std.3.1 = c(0.4503034, 0.5005332) * 0.001
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1)
ci.3.1 =CI(xAxis,knots.3.1,coef.3.1, std.3.1)

# linear 
# coef.0 = c(0.482) * 0.001
# y.0 <- coxBasicFun(xAxis, coef.0)

p1 <- ggplot() +theme_bw() +
theme(axis.line = element_line(color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) +
geom_text(aes(x=60, y=1.45, label=comparison1), color="black") +  
geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
# geom_line(aes(y=y.0, x=xAxis), color=rgb(0, 0, 255, 100, maxColorValue=255), size=1.0) +
scale_y_continuous(breaks=c(1.0,1.25,1.5), limits = c(0.8, 1.5)) +
scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
labs(y="Risk Ratio")


jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=5.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()



#----
file='4knots'
comparison1="All Cause"
par(mfrow=c(3,1))
par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04178142, 0.05275275, 0.05832544, 0.06915437) * 1000
coef.3.1 = c(1.2259186, -0.9747108, 13.1850592) * 0.001
std.3.1 = c(0.1545442, 0.4686453,2.2065693) * 0.001
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1)
ci.3.1 =CI(xAxis,knots.3.1,coef.3.1, std.3.1)

# linear 
# coef.0 = c(0.439) * 0.001
# y.0 <- coxBasicFun(xAxis, coef.0)

p1 <- ggplot() +theme_bw() +
theme(axis.line = element_line(color = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) +
geom_text(aes(x=60, y=1.45, label=comparison1), color="black") +  
geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
scale_y_continuous(breaks=seq(1.0,1.3,0.05), limits = c(1.0, 1.3)) + 
scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
labs(y="Risk Ratio")


jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=5.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()



file='5knots'
comparison1="All Cause"
par(mfrow=c(3,1))
par(mar=c(4,4.5,2,1))
knots.3.1 = c(0.04178142, 0.05107735, 0.05554645, 0.05984699, 0.06915437) * 1000
coef.3.1 = c(0.994086, 1.144301, -11.500654,36.841965) * 0.001
std.3.1 = c(0.183805, 0.994863,7.120705,12.421446) * 0.001
y.3.1 = coxFun(xAxis, knots.3.1, coef.3.1)
ci.3.1 =CI(xAxis,knots.3.1,coef.3.1, std.3.1)

# linear 
# coef.0 = c(0.439) * 0.001
# y.0 <- coxBasicFun(xAxis, coef.0)

p1 <- ggplot() +theme_bw() +
    theme(axis.line = element_line(color = "black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank()) +
    geom_text(aes(x=60, y=1.25, label=comparison1), color="black") +  
    geom_line(aes(y=y.3.1, x=xAxis), color="black", size=1.0) + 
    geom_line(aes(y=unlist(ci.3.1[1]), x=xAxis), color="black", linetype=6) + 
    geom_line(aes(y=unlist(ci.3.1[2]), x=xAxis), color="black", linetype=6) + 
    scale_y_continuous(breaks=seq(1.0,1.3,0.05), limits = c(1.0, 1.3)) + 
    scale_x_continuous(breaks=c(20,30,40,50,60,70,80,90,100)) + 
    labs(x=expression(paste('Ozone ', '(', 'ppb',')'))) + 
    labs(y="Risk Ratio")


jpeg(paste(file, ".jpeg", sep = ""), width=8.05, height=5.06, units = 'in', res = 300)
grid.arrange(p1, nrow=1,ncol=1)
dev.off()



