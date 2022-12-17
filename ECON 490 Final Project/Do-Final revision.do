capture log close
log using "Econometric File",text replace
*start log file
*Tianrun Mao #74184029 Yuan Ma #49022585 Catherine Cai #52204310 Wataru 15925928 Econometric
clear all
*changing directory
*cd "C:\Users\KL\OneDrive\桌面\ECON490\Econometric"
cd "/Users/czh/Documents/ECON 490/Econometric file"


clear

wbopendata, language(en - English) country() topics() indicator(TM.TAX.MRCH.SM.AR.ZS;TT.PRI.MRCH.XD.WD;BM.KLT.DINV.CD.WD;NE.TRD.GNFS.ZS;NY.GNS.ICTR.ZS;NY.GDP.PETR.RT.ZS) clear long
rename tm_tax_mrch_sm_ar_zs tariff
rename tt_pri_mrch_xd_wd tot
rename bm_klt_dinv_cd_wd fdiout
rename ne_trd_gnfs_zs tropen
rename ny_gns_ictr_zs saving
rename ny_gdp_petr_rt_zs oilprofit
rename countryname country

replace country = "Lao People's DR" if country == "Lao PDR"
replace country = "Viet Nam" if country == "Vietnam"
replace country = "Gambia" if country == "Gambia, The"
replace country = "Iran (Islamic Republic of)" if country == "Iran, Islamic Rep"
replace country = "Slovakia" if country == "Slovak Republic"
replace country = "Bolivia (Plurinational State of)" if country == "Bolivia"
replace country = "Republic of Moldova" if country == "Moldova"
replace country = "Kyrgyzstan" if country == "Kyrgyz Republic"
replace country = "St. Vincent and the Grenadines" if country == "St Vincent and the Grenadines"
replace country = "Republic of Korea" if country == "Korea, Rep"
replace country = "Congo" if country == "Congo, Rep"
replace country = "D.R. of the Congo" if country == "Congo, Dem Rep"
replace country = "Côte d'Ivoire" if country == "Cote d'Ivoire"
replace country = "China, Macao SAR" if country == "Macao SAR, China"
replace country = "Venezuela (Bolivarian Republic of)" if country == "Venezuela, RB"
replace country = "Egypt" if country == "Egypt, Arab Rep"
replace country = "Yemen" if country == "Yemen, Rep"
replace country = "Bahamas" if country == "Bahamas, The"
replace country = "Saint Lucia" if country == "St Lucia"
replace country = "U.R. of Tanzania: Mainland" if country == "Tanzania"
replace country = "Curaçao" if country == "Curacao"
replace country = "China, Hong Kong SAR" if country == "Hong Kong SAR, China"
save wbdata, replace

clear
use "pwt100.dta"

merge 1:1 country year using wbdata
keep if _merge == 3
keep countrycode country cgdpe year tropen pop hc fdiout tot tariff saving csh_x oilprofit
encode country, generate(code)
xtset code year, yearly
gen gdp=(cgdpe/pop)
gen lngdp=ln(gdp)
label variable lngdp "Natural log of GDP per capita"
gen grpop = ln(pop)-ln(L1.pop)
label variable grpop "year-on-year growth rate of the population"
gen lnhc = ln(hc)
label variable lnhc "Natural log of index of human capital"
gen lntropen=ln(tropen)
gen lnsaving=ln(abs(saving))
replace lnsaving = -lnsaving if saving < 0
gen lntot=ln(tot)
gen lntariff=ln(tariff)
gen lnfdiout=ln(abs(fdiout))
replace lnfdiout = -lnfdiout if fdiout < 0

save final, replace

* Citations: 
* Feenstra, Robert C., Robert Inklaar and Marcel P. Timmer (2015), 
* "The Next Generation of the Penn World Table" American Economic Review, 
* 105(10), 3150-3182, available for download at www.ggdc.net/pwt.

* The World Bank, World Development Indicators (2022). Tariff rate, applied, 
* simple mean, all products (%) [Data file]. 
* Retrieved from https://data.worldbank.org/indicator/TM.TAX.MRCH.SM.AR.ZS

* The World Bank, World Development Indicators (2022). Net barter terms of 
* trade index (2000 = 100) [Data file]. 
* Retrieved from http://data.worldbank.org/indicator/TT.PRI.MRCH.XD.WD

* The World Bank, World Development Indicators (2022). Foreign direct 
* investment, net outflows (BoP, current US$) [Data file]. 
* Retrieved from https://data.worldbank.org/indicator/BM.KLT.DINV.CD.WD

* The World Bank, World Development Indicators (2022). Trade (% of GDP)
* [Data file]. Retrieved from http://data.worldbank.org/indicator/NE.TRD.GNFS.ZS

* The World Bank, World Development Indicators (2022). Gross savings (% of GDP)
* [Data file]. Retrieved from http://data.worldbank.org/indicator/NY.GNS.ICTR.ZS

* The World Bank, World Development Indicators (2022). Oil rents (% of GDP) 
* [Data file]. Retrieved from http://data.worldbank.org/indicator/NY.GDP.PETR.RT.ZS




*Comment for our data:
* Since there are different naming convensions, I renamed all of them and
* merge it afterward, the matched obersvation improved from 9360
* to 10680.
* Since FDI net outflow will encounter negative value, we taking the absolute
* value of the FDI outflow and taking natural log of it, later on we change
* the sign of the lnfdiout if the original FDI net outflow is negative.
* Same thing done to saving.
* Regarding for the concern of ln(0)=1, the STATA will ignore the variables
* if the tariff is zero, therefore it will be a ignored value.



*2 reports for all variables for one year 
sum cgdpe pop gdp grpop tot saving hc csh_x tariff fdiout tropen if year==2017

*1. Variable TOT
*check non linearity
quietly reg lngdp lntot lnsaving grpop lnhc L1.lngdp i.year, cluster(code)
acprplot lntot, lowess lsopts(bwidth(1))
graph export nonlinear1.png, replace
*The graph indicate there is non linearity
gen lntot2=lntot^2
reg lngdp lntot lntot2 lnsaving grpop lnhc L1.lngdp i.year, cluster(code)
*We see the coefficietns on lntot2 is siginifcant, indicate a good fit of our model

*fe
xtreg lngdp lntot lntot2 lnsaving grpop lnhc L1.lngdp, fe

*test for year fix effect
quietly xtreg lngdp lntot lntot2 lnsaving grpop lnhc L1.lngdp i.year, fe
testparm i.year
**The score is 10.35 where we reject the null hypothesis that coefficietns 
*on dummies for year is equal to 0. Therefore we need to include
*year fixed effect

*test Heteroskedasticity
quietly xtreg lngdp lntot lntot2 lnsaving grpop lnhc L1.lngdp i.year, fe
xttest3
*The result is 48270 and we reject the null hypothesis that this model
*is homoskedasticity, therefore the residuals are heteroskedastic.

quietly xtreg lngdp lntot lntot2 lnsaving grpop lnhc L1.lngdp i.year, fe
predict r, rstudent
quietly xtreg lngdp lntot lntot2 lnsaving grpop lnhc L1.lngdp i.year if oilprofit>=0.1, fe
predict r1, rstudent
sort r
list r country year tot if abs(r)>3 & r!=.
sort r1
list r1 country year tot if abs(r1)>3 & r1!=.
* The obersvation with r score greater then 3 is considered outlier and will
* be ignored, the full list please see the list above.
* For oil producing country, the outlier are siginifcant ar r1>=3, 10% of the obs
* are outlier with r1 greater equal to 3, those will be excluded
*test serial correlation
xtserial lngdp lntot lntot2 lnsaving grpop lnhc

*The test score is 658.9, and we reject the null hypothesis that there
*is no serial correlation. And there is serial correlation presented in
*this model

*test for collinearity
collin lntot lnsaving grpop lnhc
*Since all the VIF is less then 10, we faile to reject the null hypothesis
*then there is no evidence of multicollineary in this model


quietly xtpcse lngdp lntot lntot2 lnsaving grpop lnhc L1.lngdp i.year, het corr(ar1)

*3Variable TOT graph
twoway (scatter lngdp lntot) (lfit lngdp lntot), title("Natural log of GDP per capita as a function of Natural log of TOT")
graph export scatterlntot.png, replace
twoway (scatter gdp tot) (lfit gdp tot), title("GDP per capita as a function of TOT")
graph export scattertot.png, replace
*5 all variables included
xtpcse lngdp lntot lntot2 lnsaving grpop lnhc L1.lngdp i.year if abs(r)<=3, het corr(ar1) 
*predict quadratic graph 
predict yhat, xb
twoway (scatter yhat lntot) (qfit yhat lntot)
graph export totqfit.png, replace
*6
quietly eststo:xtpcse lngdp lntot i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lntot lntot2 i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lntot lntot2 lnsaving grpop i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lntot lntot2 lnsaving grpop lnhc i.year if abs(r)<=3, het corr(ar1)
eststo:xtpcse lngdp lntot lntot2 lnsaving grpop lnhc L1.lngdp i.year if abs(r)<=3, het corr(ar1)
esttab est1 est2 est3 est4 est5 using TOT.csv, star(* .10 ** .05 *** .01) se stats(N r2) indicate("Year Dummies =*.year") replace

eststo:xtpcse lngdp lntot lntot2 lnsaving grpop lnhc L1.lngdp i.year if abs(r1)<=3&oilprofit>=0.1, het corr(ar1)
esttab est5 est6 using TOToil.csv, star(* .10 ** .05 *** .01) se stats(N r2) indicate("Year Dummies =*.year") replace


use final, clear
*2. Variable Tariff
*check non linearity
quietly reg lngdp lntariff lnsaving grpop lnhc L1.lngdp i.year, cluster(code)
acprplot lntariff, lowess lsopts(bwidth(1))
graph export nonlinear2.png, replace
*The graph indicate there is no issue with non linearity

*fe
quietly xtreg lngdp lntariff lnsaving grpop lnhc L1.lngdp, fe

*test for year fix effect
quietly xtreg lngdp lntariff lnsaving grpop lnhc L1.lngdp i.year, fe
testparm i.year
**The score is 14.74 where we reject the null hypothesis that coefficietns 
*on dummies for year is equal to 0. Therefore we need to include
*year fixed effect

*test homoskedasticity
quietly xtreg lngdp lntariff lnsaving grpop lnhc L1.lngdp, fe
xttest3
*The result is 620000 and we reject the null hypothesis that this model
*is homoskedasticity, therefore the residuals are heteroskedastic.

* Outliers
quietly xtreg lngdp lntariff lnsaving grpop lnhc L1.lngdp i.year, fe
predict r, rstudent
quietly xtreg lngdp lntariff lnsaving grpop lnhc L1.lngdp i.year if oilprofit>=0.1, fe
predict r1, rstudent
sort r
list r country tariff year if abs(r)>3 & r!=.
sort r1
list r1 country tariff year if abs(r1)>3 & r!=.
* The obersvation with r score greater then 3 is considered outlier and will
* be ignored, the full list please see the list above.
* For oil producing country, the outlier are siginifcant ar r1>=3, 10% of the obs
* are outlier with r1 greater equal to 3, those will be excluded

*test serial correlation
xtserial lngdp lntariff lnsaving grpop lnhc

*The test score is 438, and we reject the null hypothesis that there
*is no serial correlation. And there is serial correlation presented in
*this model

*test for collinearity
collin lntariff lnsaving grpop lnhc
*Since all the VIF is less then 10, we faile to reject the null hypothesis
*then there is no evidence of multicollineary in this model

*3Variable TOT graph
twoway (scatter lngdp lntariff) (lfit lngdp lntariff), title("Natural log of GDP per capita as a function of tariff")
graph export scatterlntariff.png, replace
twoway (scatter gdp tariff) (lfit gdp tariff), title("GDP per capita as a function of tariff")
graph export scattertariff.png, replace
*5 all variables included
xtpcse lngdp lntariff lnsaving grpop lnhc L1.lngdp i.year if abs(r)<=3, het corr(ar1)
*predict quadratic graph 
predict yhat, xb
twoway (scatter yhat lntot) (qfit yhat lntot)
graph export totqfit.png, replace
*6
eststo clear
quietly eststo:xtpcse lngdp lntariff i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lntariff lnsaving i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lntariff lnsaving grpop i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lntariff lnsaving grpop lnhc i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lntariff lnsaving grpop lnhc L1.lngdp i.year if abs(r)<=3, het corr(ar1)
esttab est1 est2 est3 est4 est5 using Tariff.csv, star(* .10 ** .05 *** .01) se stats(N r2) indicate("Year Dummies =*.year") replace

quietly eststo:xtpcse lngdp lntariff lnsaving grpop lnhc L1.lngdp i.year  if abs(r1)<=3&oilprofit>=0.1, het corr(ar1)
esttab est5 est6 using Tariffoil.csv, star(* .10 ** .05 *** .01) se stats(N r2) indicate("Year Dummies =*.year") replace

use final, clear

*3. Variable FDI outflow
*check non linearity
quietly reg lngdp lnfdiout lnsaving grpop lnhc L1.lngdp i.year, cluster(code)
acprplot lnfdiout, lowess lsopts(bwidth(1))
graph export nonlinear3.png, replace
*The graph indicate there is no issue with non linearity

*fe
quietly xtreg lngdp lnfdiout lnsaving grpop lnhc L1.lngdp, fe

*test for year fix effect
quietly xtreg lngdp lnfdiout lnsaving grpop lnhc L1.lngdp i.year, fe
testparm i.year
**The score is 10.07 where we reject the null hypothesis that coefficietns 
*on dummies for year is equal to 0. Therefore we need to include
*year fixed effect

*test homoskedasticity
quietly xtreg lngdp lnfdiout lnsaving grpop lnhc L1.lngdp, fe
xttest3
*The result is 80423 and we reject the null hypothesis that this model
*is homoskedasticity, therefore the residuals are heteroskedastic.

quietly xtreg lngdp lnfdiout lnsaving grpop lnhc L1.lngdp i.year, fe
predict r, rstudent
quietly xtreg lngdp lnfdiout lnsaving grpop lnhc L1.lngdp i.year if oilprofit>=0.1, fe
predict r1, rstudent
sort r
list r country fdiout year if abs(r)>3 & r!=.
sort r1
list r1 country fdiout year if abs(r1)>3 & r1!=.
* The obersvation with r score greater then 3 is considered outlier and will
* be ignored, the full list please see the list above.
* For oil producing country, the outlier are siginifcant ar r1>=3, 2% of the obs
* are outlier with r1 greater equal to 3, those will be excluded

*test serial correlation
xtserial lngdp lnfdiout lnsaving grpop lnhc

*The test score is 820, and we reject the null hypothesis that there
*is no serial correlation. And there is serial correlation presented in
*this model

*test for collinearity
collin lnfdiout lnsaving grpop lnhc
*Since all the VIF is less then 10, we faile to reject the null hypothesis
*then there is no evidence of multicollineary in this model

*3Variable TOT graph
twoway (scatter lngdp lnfdiout) (lfit lngdp lnfdiout), title("Natural log of GDP per capita as a function of FDIoutflow")
graph export scatterlnfdi.png, replace
twoway (scatter gdp fdiout) (lfit gdp fdiout), title("GDP per capita as a function of FDIoutflow")
graph export scatterfdi.png, replace
*5 all variables included
xtpcse lngdp lnfdiout lnsaving grpop lnhc L1.lngdp i.year if abs(r)<=3, het corr(ar1)


*6
eststo clear
quietly eststo:xtpcse lngdp lnfdiout i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lnfdiout lnsaving  i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lnfdiout lnsaving grpop i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lnfdiout lnsaving grpop lnhc i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lnfdiout lnsaving grpop lnhc L1.lngdp i.year if abs(r)<=3, het corr(ar1)
esttab est1 est2 est3 est4 est5 using FDIoutflow.csv, star(* .10 ** .05 *** .01) se stats(N r2) indicate("Year Dummies =*.year") replace

quietly eststo:xtpcse lngdp lnfdiout lnsaving grpop lnhc L1.lngdp i.year if abs(r1)<=3&oilprofit>=0.1, het corr(ar1)
esttab est5 est6 using FDIoutflowoil.csv, star(* .10 ** .05 *** .01) se stats(N r2) indicate("Year Dummies =*.year") replace


use final, clear

*4. Variable trade openness
*check non linearity
quietly reg lngdp lntropen lnsaving grpop lnhc L1.lngdp i.year, cluster(code)
acprplot lntropen, lowess lsopts(bwidth(1))
graph export nonlinear4.png, replace
*The graph indicate there is no issue with non linearity

*fe
xtreg lngdp lntropen lnsaving grpop lnhc L1.lngdp, fe

*test for year fix effect
quietly xtreg lngdp lntropen lnsaving grpop lnhc L1.lngdp i.year, fe
testparm i.year
**The score is 8 where we reject the null hypothesis that coefficietns 
*on dummies for year is equal to 0. Therefore we need to include
*year fixed effect

*test homoskedasticity
quietly xtreg lngdp lntropen lnsaving grpop lnhc L1.lngdp, fe
xttest3
*The result is 27266 and we reject the null hypothesis that this model
*is homoskedasticity, therefore the residuals are heteroskedastic.

quietly xtreg lngdp lntropen lnsaving grpop lnhc L1.lngdp i.year, fe
predict r, rstudent
quietly xtreg lngdp lntropen lnsaving grpop lnhc L1.lngdp i.year if oilprofit>=0.1, fe
predict r1, rstudent
sort r
list r country tropen year if abs(r)>3 & r!=.
sort r1
list r1 country tropen year if abs(r1)>3 & r1!=.
* The obersvation with r score greater then 3 is considered outlier and will
* be ignored, the full list please see the list above.
* For oil producing country, the outlier are siginifcant ar r1>=3, 2% of the obs
* are outlier with r greater equal to 3, those will be excluded

*test serial correlation
xtserial lngdp lntropen lnsaving grpop lnhc

*The test score is 853, and we reject the null hypothesis that there
*is no serial correlation. And there is serial correlation presented in
*this model

*test for collinearity
collin lntropen lnsaving grpop lnhc
*Since all the VIF is less then 10, we faile to reject the null hypothesis
*then there is no evidence of multicollineary in this model

*3Variable TOT graph
twoway (scatter lngdp lntropen) (lfit lngdp lntropen), title("Natural log of GDP per capita as a function of trade openness")
graph export scatterlntropen.png, replace
twoway (scatter gdp tropen) (lfit gdp tropen), title("GDP per capita as a function of trade openness")
graph export scattertropen.png, replace
*5 all variables included
xtpcse lngdp lntropen lnsaving grpop lnhc L1.lngdp i.year if abs(r)<=3, het corr(ar1)

*6
eststo clear
quietly eststo:xtpcse lngdp lntropen i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lntropen lnsaving  i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lntropen lnsaving grpop i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lntropen lnsaving grpop lnhc i.year if abs(r)<=3, het corr(ar1)
quietly eststo:xtpcse lngdp lntropen lnsaving grpop lnhc L1.lngdp i.year if abs(r)<=3, het corr(ar1)
esttab est1 est2 est3 est4 est5 using tropen.csv, star(* .10 ** .05 *** .01) se stats(N r2) indicate("Year Dummies =*.year") replace

quietly eststo:xtpcse lngdp lntropen lnsaving grpop lnhc L1.lngdp i.year  if abs(r1)<=3&oilprofit>=0.1, het corr(ar1)
esttab est5 est6 using tropenoil.csv, star(* .10 ** .05 *** .01) se stats(N r2) indicate("Year Dummies =*.year") replace

*5. Variable all 4
use final, clear

gen lntot2=lntot^2

*fe
xtreg lngdp lntot lntot2 lntariff lnfdiout lntropen lnsaving grpop lnhc L1.lngdp, fe

*test for year fix effect
quietly xtreg lngdp lntot lntot2 lntariff lnfdiout lntropen lnsaving grpop lnhc L1.lngdp i.year, fe
testparm i.year
**The score is 13.69 where we reject the null hypothesis that coefficietns 
*on dummies for year is equal to 0. Therefore we need to include
*year fixed effect

*test homoskedasticity
quietly xtreg lngdp lntot lntot2 lntariff lnfdiout lntropen lnsaving grpop lnhc L1.lngdp, fe
xttest3
*The result is 140000 and we reject the null hypothesis that this model
*is homoskedasticity, therefore the residuals are heteroskedastic.

*Outliers
quietly xtreg lngdp lntot lntot2 lntariff lnfdiout lntropen lnsaving grpop lnhc L1.lngdp i.year, fe
predict r, rstudent
quietly xtreg lngdp lntot lntot2 lntariff lnfdiout lntropen lnsaving grpop lnhc L1.lngdp i.year if oilprofit>=0.1, fe
predict r1, rstudent
sort r
list r country year tot tariff fdiout tropen if abs(r)>4 & r!=.
sort r1
list r1 country year tot tariff fdiout tropen if abs(r1)>4 & r1!=.
* The obersvation with r score greater then 4 is considered outlier since there
* are many variables need to be considered so will tend to vary more and will
* be ignored, the full list please see the list above.
* For oil producing country, the outlier are siginifcant ar r1>=4, 13% of the obs
* are outlier with r1 greater equal to 4, those will be excluded

*test serial correlation
xtserial lngdp lntot lntariff lnfdiout lntropen lnsaving grpop lnhc

*The test score is 731, and we reject the null hypothesis that there
*is no serial correlation. And there is serial correlation presented in
*this model

*test for collinearity
collin lntot lntariff lnfdiout lntropen lnsaving grpop lnhc
*Since all the VIF is less then 10 except the squred lntot, we failed to reject
*the null hypothesis then there is no evidence of multicollineary in this model

*5 all variables included
xtpcse lngdp lntot lntot2 lntariff lnfdiout lntropen lnsaving grpop lnhc L1.lngdp i.year if abs(r)<=4, het corr(ar1)

eststo clear
quietly eststo:xtpcse lngdp lntot i.year if abs(r)<=4, het corr(ar1)
quietly eststo:xtpcse lngdp lntot lntot2 i.year if abs(r)<=4, het corr(ar1)
quietly eststo:xtpcse lngdp lntot lntot2 lntariff i.year if abs(r)<=4, het corr(ar1)
quietly eststo:xtpcse lngdp lntot lntot2 lntariff lnfdiout i.year if abs(r)<=4, het corr(ar1)
quietly eststo:xtpcse lngdp lntot lntot2 lntariff lnfdiout lntropen i.year if abs(r)<=4, het corr(ar1)
quietly eststo:xtpcse lngdp lntot lntot2 lntariff lnfdiout lntropen lnsaving i.year if abs(r)<=4, het corr(ar1)
quietly eststo:xtpcse lngdp lntot lntot2 lntariff lnfdiout lntropen lnsaving grpop i.year if abs(r)<=4, het corr(ar1)
quietly eststo:xtpcse lngdp lntot lntot2 lntariff lnfdiout lntropen lnsaving grpop lnhc i.year if abs(r)<=4, het corr(ar1)
quietly eststo:xtpcse lngdp lntot lntot2 lntariff lnfdiout lntropen lnsaving grpop lnhc L1.lngdp i.year if abs(r)<=4, het corr(ar1)
esttab est1 est2 est3 est4 est5 est6 est7 est8 est9 using all.csv, star(* .10 ** .05 *** .01) se stats(N r2) indicate("Year Dummies =*.year") replace

quietly eststo:xtpcse lngdp lntot lntot2 lntariff lnfdiout lntropen lnsaving grpop lnhc L1.lngdp i.year  if abs(r1)<=4&oilprofit>=0.1, het corr(ar1)
esttab est9 est10 using alloil.csv, star(* .10 ** .05 *** .01) se stats(N r2) indicate("Year Dummies =*.year") replace

*8
twoway (histogram tot if gdp > 40000,  title("Distribution of Term of Trade for Rich VS Poor Country") color(blue) lcolor(black))(histogram tot if gdp < 15000, color(red) lcolor(black)),legend(order(1 "Rich" 2 "Poor"))
graph export tot.png, replace

twoway (histogram tariff if gdp > 40000,  title("Distribution of tariff for Rich VS Poor Country") color(blue) lcolor(black))(histogram tariff if gdp < 15000, color(red) lcolor(black)),legend(order(1 "Rich" 2 "Poor"))
graph export tariff.png, replace

twoway (histogram fdiout if gdp > 40000,  title("Distribution of FDI outflowfor for Rich VS Poor Country") color(blue) lcolor(black))(histogram fdiout if gdp < 15000, color(red) lcolor(black)),legend(order(1 "Rich" 2 "Poor"))
graph export fdiout.png, replace

twoway (histogram tropen if gdp > 40000,  title("Distribution of Trade Openness for Rich VS Poor Country") color(blue) lcolor(black))(histogram tropen if gdp < 15000, color(red) lcolor(black)),legend(order(1 "Rich" 2 "Poor"))
graph export tropen.png, replace

*subset

twoway (histogram tot if oilprofit>=0.1,  title("Distribution of Term of Trade for Oil Producing Country VS All Country") color(blue) lcolor(black))(histogram tot, color(red) lcolor(black)),legend(order(1 "Oil" 2 "All"))
graph export totoil.png, replace

twoway (histogram tariff if oilprofit>=0.1,  title("Distribution of tariff for Oil Producing Country VS All Country") color(blue) lcolor(black))(histogram tariff, color(red) lcolor(black)),legend(order(1 "Oil" 2 "All"))
graph export tariffoil.png, replace

twoway (histogram fdiout if oilprofit>=0.1,  title("Distribution of FDI outflowfor for Oil Producing Country VS All Country") color(blue) lcolor(black))(histogram fdiout, color(red) lcolor(black)),legend(order(1 "Oil" 2 "All"))
graph export fdioutoil.png, replace

twoway (histogram tropen if oilprofit>=0.1,  title("Distribution of Trade Openness for Oil Producing Country VS All Country") color(blue) lcolor(black))(histogram tropen, color(red) lcolor(black)),legend(order(1 "Oil" 2 "All"))
graph export tropenoil.png, replace

*close log file
log close
