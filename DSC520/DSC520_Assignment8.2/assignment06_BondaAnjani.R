# Assignment: ASSIGNMENT 6
# Name: Bonda, Anjani
# Date: 2022-02-12

## Set the working directory to the root of your DSC 520 directory
setwd("/Users/anjanibonda/DSC520/dsc520")

## Load the `data/r4ds/heights.csv` to
heights_df <- read.csv("data/r4ds/heights.csv")
head(heights_df)

## Load the ggplot2 library
library(ggplot2)

## Fit a linear model using the `age` variable as the predictor and `earn` as the outcome
age_lm <-  lm(earn ~ age, data = heights_df)
age_lm

## View the summary of your model using `summary()`
summary(age_lm)

## Creating predictions using `predict()`
age_predict_df <- data.frame(earn = predict(age_lm, heights_df), age=heights_df$age)
head(age_predict_df)

## Plot the predictions against the original data
ggplot(data = heights_df, aes(y = earn, x = age)) +
  geom_point(color='blue') +
  geom_line(color='red',data = age_predict_df, aes(y= earn, x= age))

mean_earn <- mean(heights_df$earn)
mean_earn
## Corrected Sum of Squares Total
sst <- sum((mean_earn - heights_df$earn)^2)
sst
## Corrected Sum of Squares for Model
ssm <- sum((mean_earn - age_predict_df$earn)^2)
ssm
## Residuals
residuals <- heights_df$earn - age_predict_df$earn
head(residuals)
## Sum of Squares for Error
sse <- sum(residuals^2)
sse
## R Squared R^2 = SSM\SST
r_squared <- ssm/sst
r_squared

## Number of observations
n <- nrow(heights_df)
n
## Number of regression parameters
p <- 2
## Corrected Degrees of Freedom for Model (p-1)
dfm <- p-1
dfm
## Degrees of Freedom for Error (n-p)
dfe <- n-p
dfe
## Corrected Degrees of Freedom Total:   DFT = n - 1
dft <- n-1
dft

## Mean of Squares for Model:   MSM = SSM / DFM
msm <- ssm/dfm
msm
## Mean of Squares for Error:   MSE = SSE / DFE
mse <- sse/dfe
mse
## Mean of Squares Total:   MST = SST / DFT
mst <- sst/dft
mst
## F Statistic F = MSM/MSE
f_score <- msm/mse
f_score

R2 <- summary(age_lm)$r.squared
## Adjusted R Squared R2 = 1 - (1 - R2)(n - 1) / (n - p)
adjusted_r_squared <- 1 - (1 - R2)*(n-1) / (n-p)
adjusted_r_squared

## Calculate the p-value from the F distribution
p_value <- pf(f_score, dfm, dft, lower.tail=F)
p_value
