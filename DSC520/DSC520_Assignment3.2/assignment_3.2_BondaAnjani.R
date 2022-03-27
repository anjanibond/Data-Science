# Assignment: ASSIGNMENT 3.2
# Name: Bonda, Anjani
# Date: 2021-12-18

## Load the ggplot2 and qqplotr package
library(ggplot2)
library(qqplotr)
theme_set(theme_minimal())

## Set the working directory to the root of your DSC 520 directory
setwd("/Users/anjanibonda/DSC520/dsc520")

## Load the `data/acs-14-1yr-s0201.csv `to
census_df <- read.csv("data/acs-14-1yr-s0201.csv")

## summary of census_df
summary(census_df)

## print output of str(), nrow(), ncol()
str(census_df)
nrow(census_df)
ncol(census_df)

## Create a histogram of the `HSDegree` variable using `geom_histogram()`
## Use 10 bins
ggplot(census_df, aes(HSDegree)) + geom_histogram(binwidth = 1.1, bins = 10) 

ggplot(census_df, aes(HSDegree)) + geom_histogram(binwidth = 1.1, bins = 20) + ggtitle("HSDegree Histogram Plot") + labs(x = "High School Degree (%)", y = "Count")

#Answer the following questions based on the Histogram produced:
print("Based on what you see in this histogram, is the data distribution unimodal?")
print("Answer : YES. Since the plot has a peak, the distribution is clearly unimodal")

print("Is it approximately symmetrical?")
print("Answer : YES. The distribution is approx. symmetrical")

print("Is it approximately bell-shaped?")
print("Answer : YES. The distribution is approx. bell-shaped")

print("Is it approximately normal?")
print("Answer : NO. The distribution is not normal as it is left skewed")

print("If not normal, is the distribution skewed? If so, in which direction?")
print("Answer : YES. The distribution is left skewed")



## Add a normal curve to the previous plot
ggplot(census_df, aes(HSDegree)) + geom_histogram(binwidth = 1.1, bins = 20) + ggtitle("HSDegree Histogram Plot") + labs(x = "High School Degree (%)", y = "Count") + geom_density(aes(y=1.1*..count..))

print("Explain whether a normal distribution can accurately be used as a model for this data.")
print("Answer : NO. A normal distribution cannot be used as a model for this data")
print(" Since, it is not exactly symmetrical, not exactly bell shaped. Also, mean,median and mode are not same")

## Create a Probability Plot of the HSDegree variable.
qplot(sample = HSDegree, data = census_df, xlab = "Theoretical" , ylab = "HSDegree %")

print("Answer the following questions based on the Probability Plot:")
print("Based on what you see in this probability plot, is the distribution approximately normal? Explain how you know.")
print("Answer : No, Distribution is not normal since the plot is not symmetrical and mean, median and mode are not same.")
print("If not normal, is the distribution skewed? If so, in which direction? Explain how you know.")
print("Answer : Yes the distrinution is left skewed. Data that have an upper bound are often skewed left.")

print("Now that you have looked at this data visually for normality, you will now quantify normality with numbers using the stat.desc() function. Include a screen capture of the results produced.")
print("In several sentences provide an explanation of the result produced for skew, kurtosis, and z-scores. In addition, explain how a change in the sample size may change your explanation?")
print("Answer: A document (pdf) attached separately for this info")

