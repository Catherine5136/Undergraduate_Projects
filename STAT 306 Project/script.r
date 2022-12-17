# Here we filter the entire data set into just the variables we care about
data <- X14100042
unitdata <- data[data$SCALAR_FACTOR=="units",]
unitdata <- unitdata[unitdata$Sex=="Males" | unitdata$Sex=="Females",]
unitdata <- unitdata[unitdata$`Age group`=="15 to 24 years" | unitdata$`Age group`=="25 to 54 years"  | unitdata$`Age group`=="55 to 64 years" | unitdata$`Age group`=="65 years and over",]
unitdata <- unitdata[unitdata$Job=="All jobs",]
unitdata <- unitdata[unitdata$`Type of work`=="Full-time employment",]
unitdata <- unitdata[unitdata$`Hours worked`=="Average actual hours (all workers)",]
unitdata <- unitdata[unitdata$GEO!="Canada",]
unitdata <- subset(unitdata, select = -c(`DGUID`, `Hours worked`,`Job`,`Type of work`,`UOM`,`UOM_ID`,`SCALAR_ID`,`SCALAR_FACTOR`,`VECTOR`,`COORDINATE`,`STATUS`,`SYMBOL`,`TERMINATED`,`DECIMALS`))
unitdata <- unitdata[-c(1:42240), ]

# Here we make the categorical variables factors and examine their levels
unitdata$Sex <- as.factor(unitdata$Sex)
levels(unitdata$Sex)
unitdata$`Age group` <- as.factor(unitdata$`Age group`)
levels(unitdata$`Age group`)
unitdata$GEO <- as.factor(unitdata$GEO)
levels(unitdata$GEO)
summary(unitdata)



# Here we look at boxplots for each categorical variable vs. response
boxplot(VALUE~Sex,data=unitdata,xlab="Sex",ylab="Average Hours Worked")
boxplot(VALUE~`Age group`,data=unitdata,xlab="Age group ",ylab="Average Hours Worked",par(mar=c(8,4,4,4)),las=1)
boxplot(VALUE~GEO,data=unitdata,xlab="",ylab="Average Hours Worked",par(mar=c(14,4,1,4)),las=3)

# Our goal is to find a predictive relationship with average working hours and the explanatory variables
# we will find out if working hours is influenced mainly from gender, age, or province.

# full model with all pairwise interactions, plus residual and QQ plots
mod <- lm(VALUE~Sex +`Age group`+ GEO  + +Sex*`Age group`+Sex*GEO+ `Age group`*GEO   ,data=unitdata)
summary(mod)

plot(mod$fitted.values, mod$residuals,xlab="predicted",ylab="residual",main="Residual plot (MAIN)")

qqnorm(mod$residuals,main = "Normal Q-Q Plot (MAIN)")

#  log transformed response model with interactions, plus residual and QQ plots
modlog <-  lm(I(log(VALUE))~Sex +`Age group`+ GEO  + +Sex*`Age group`+Sex*GEO+ `Age group`*GEO   ,data=unitdata)
summary(modlog)
plot(modlog$fitted.values, modlog$residuals,xlab="predicted",ylab="residual",main="Residual plot (LOG)")
qqnorm(modlog$residuals,main = "Normal Q-Q Plot (LOG)")

#  square root transformed response model with interactions, plus residual and QQ plots
modroot <- lm(I(sqrt(VALUE))~Sex +`Age group`+ GEO  + +Sex*`Age group`+Sex*GEO+ `Age group`*GEO,data=unitdata)
summary(modroot)
plot(modroot$fitted.values, modroot$residuals,xlab="predicted",ylab="residual",main="Residual plot (SQRT)")
qqnorm(modroot$residuals,main = "Normal Q-Q Plot (SQRT)")





