# Assignment: Week 8,9 Exercise - Housing Data
# Name: Bonda, Anjani
# Date: 2022 - 02- 12


library(readxl)
library(dplyr)
library(purrr)
library(QuantPsyc)
library(car)
library(tidyverse)
library(ggplot2)
library(lmtest)


# Set workding directory to read source datasets.
setwd("/Users/anjanibonda/DSC520/dsc520")

# Read housing dataset
housingdata <- read_excel("data/week-6-housing.xlsx")
housingdata

str(housingdata)
glimpse(housingdata)

# Check for nulls in all rows
apply(housingdata, 2, function(i) any(is.na(i)))

# Looking at the data, there is missing data for sale_warning and ctyname

# I. Explain any transformations or modifications you made to the dataset 
colnames(housingdata)[1] <- "Sale_Date"
colnames(housingdata)[2] <- "Sale_Price"

# I have Changed the column names of Sale Date and Sale Price to avoid any possible issues.

# II. Create two variables;
#    one that will contain the variables Sale Price and Square Foot of Lot (same variables used from previous assignment on simple regression)
#    and one that will contain Sale Price and several additional predictors of your choice.
#    Explain the basis for your additional predictor selections.
housingdata_lm1 <- lm(formula = Sale_Price ~ sq_ft_lot, data = housingdata)
housingdata_lm2 <- lm(formula = Sale_Price ~ zip5 + bedrooms + year_built, data = housingdata)

# I have inlcuded other predictors like zip5, bedroomms and year built as those are often key factors in home price predictions.

# III. Execute a summary() function on two variables defined in the previous step to compare the model results. 
#    What are the R2 and Adjusted R2 statistics? Explain what these results tell you about the overall model.
#    Did the inclusion of the additional predictors help explain any large variations found in Sale Price?
summary(housingdata_lm1)
summary(housingdata_lm2)

# R2 for housingdata_lm1: 0.01  adjusted: 0.01
# R2 for housingdata_lm2: 0.11 adjusted: 0.11
# RSquared is a statistical measure of fit for the model.
# These low RSquared values mean that the model is not a great fit.
# The multiple regression seems OK, but not ideal.

# IV. Considering the parameters of the multiple regression model you have created,
#     What are the standardized betas for each parameter and what do the values indicate?
library(lm.beta)

coef_lmbeta <- lm.beta(housingdata_lm2)
coef_lmbeta

# zip5 (standardized β = 0.04458759) - This value indicates that as zip code increase by
# 1 standard deviation, sales price increase by 0.04458759 standard deviation.
# bedrooms (standardized β = 0.22417183) -This value indicates that as bedrooms
# increase by 1 standard deviation, sales price increase by 0.22417183 standard deviation.
# year_built(standardized β = 0.23537926) - This value indicates that as year_# built
# increase by 1 standard deviation, sales price increase by 0.23537926 standard deviation.


# V. Calculate the confidence intervals for the parameters in your model and
#     explain what the results indicate.
confint(housingdata_lm2)

# In this model, the predictor (year_built) have very tight confidence intervals,
# indicating that the estimates for the current model are likely
# to be representative of the true population.
# The confidence interval for (zip5 and bedrooms) is wider but still does not cross zero,
# indicating that the parameter for this variable is less representative, but still significant.

# VI. Assess the improvement of the new model compared to your original model (simple regression model) ----
#     by testing whether this change is significant by performing an analysis of variance.
anova(housingdata_lm1,housingdata_lm2)

# The p value is very small value indeed,
# we can say that housingdata_lm2 significantly improved
# the fit of the model to the data compared to housingdata_lm1

# VII. Perform casewise diagnostics to identify outliers and/or influential cases,
#     storing each function's output in a dataframe assigned to a unique variable name.
housingdata$residuals<-resid(housingdata_lm2)
housingdata$standardized.residuals<- rstandard(housingdata_lm2)
housingdata$studentized.residuals<-rstudent(housingdata_lm2)
housingdata$cooks.distance<-cooks.distance(housingdata_lm2)
housingdata$dfbeta<-dfbeta(housingdata_lm2)
housingdata$dffit<-dffits(housingdata_lm2)
housingdata$leverage<-hatvalues(housingdata_lm2)
housingdata$covariance.ratios<-covratio(housingdata_lm2)

housingdata

# VIII. Calculate the standardized residuals using the appropriate command,
#     specifying those that are +-2, storing the results of large residuals in a variable you create.
housingdata$large.residual <- housingdata$standardized.residuals > 2 | housingdata$standardized.residuals < -2
head(housingdata$large.residual)

# IX. Use the appropriate function to show the sum of large residuals.
sum(housingdata$large.residual)

# X. Which specific variables have large residuals (only cases that evaluate as TRUE)?
housingdata[housingdata$large.residual,c("Sale_Price", "zip5", "bedrooms", "year_built","standardized.residuals")]

# XI. Investigate further by calculating the
#    leverage,
#    cooks distance,
#    and covariance ratios.
# Comment on all cases that are problematics.
housingdata[housingdata$large.residual , c("cooks.distance", "leverage", "covariance.ratios")]

# None of the values has a Cook’s distance greater than 1 ,
# The leverage values also seem miniscule.


# XII. Perform the necessary calculations to assess the assumption of independence
#    and state if the condition is met or not.
durbinWatsonTest(housingdata_lm2)

# The test statistic is 0.7442029 and the corresponding p-value is 0. 
# Since this p-value is less than 0.05, we can reject the null hypothesis and 
# conclude that the residuals in this regression model are autocorrelated. 
# Value less than 1 suggests that the assumption might not been met.

# XIII. Perform the necessary calculations to assess the assumption of no multicollinearity
#    and state if the condition is met or not.
vif(housingdata_lm2)
#tolerance statistics
1/vif(housingdata_lm2)
mean(vif(housingdata_lm2))

# VIF values are all below 10 and the tolerance statistics above 0.2. 
# Also, the mean VIF is ~ 1.
# Based on these results we can conclude that there is no collinearity in data.

# XIV. Visually check the assumptions related to the residuals using the plot() and hist() functions.
#     Summarize what each graph is informing you of and if any anomalies are present.
housingdata$fitted <- housingdata_lm2$fitted.values

histogram<-ggplot(housingdata, aes(studentized.residuals)) + 
  geom_histogram(aes(y = ..density..), colour = "blue", fill = "white") + 
  labs(x = "StudentizedResidual", y = "Density")
histogram

histogram + stat_function(fun = dnorm, args = list(mean = mean(housingdata$studentized.residuals, na.rm = TRUE), 
  sd = sd(housingdata$studentized.residuals,na.rm = TRUE)), colour= "red", size = 1)

qplot(sample = housingdata$studentized.residuals, stat="qq") + labs(x ="Theoretical Values", y = "Observed Values")

# The distribution is roughly normal.
# To summarize, the model appears to be accurate for the sample and can be generalized to the population.

# XV. Overall, is this regression model unbiased?
#    If an unbiased regression model, what does this tell us about the sample vs. the entire population model?

# Based on vif score/values calculated above, since the values are not close to 5, the predictors doesn't have 
# any significant multi collinearity.
# Mean vif is also just above 1 but no where near 5.
# Hence, Model does not appear to be biased.