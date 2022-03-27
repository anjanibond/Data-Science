# Assignment: ASSIGNMENT 4.2
# Name: Bonda, Anjani
# Date: 2022-01-09


# TEST SCORES EXERICSE

library(ggplot2)
library(patchwork)


# Create testscores variable with scores data
testscores <- read.csv("data/scores.csv", header=TRUE, sep = ",")
testscoresdf <- data.frame(testscores)
testscores

# Views the dataframe formed from the csv file
#View(testscoresdf)

# Summary of the data
summary(testscoresdf)


# Question 1: What are the observational units in this study ?
# The observational units in statistics are the objects on which variables are defined and measurements are recorded.
# There are a total of 38 observational units in this study (Observation length from Summary(testscores) output).

# Question 2: Identify the variables mentioned in the narrative paragraph and determine which are categorical and quantitative?
# There are 3 variables in total out of which 1 of them is a categorical variable and other 2 are quantitative/numerical variables.
# count -> numerical variable
# score -> numerical variable
# section -> categorical (sports or regular)

# Variable to hold subset of data for Regular Section 
regularData <- subset(testscoresdf, testscoresdf$Section == "Regular")
regularData

# Variable to hold subset of data for Sports Section
sportsData <- subset(testscoresdf, testscoresdf$Section == "Sports")
sportsData


# Plot function to plot each Sections scores and the number of students achieving that score.
plot.scores.regular <- ggplot(regularData, aes(x = Score, y = Count)) + geom_point() + geom_smooth(method = "lm", colour = "Blue") + labs(x = "Scores for regular section", y = "No.of students")
plot.scores.regular

plot.scores.sports <- ggplot(sportsData, aes(x = Score, y = Count)) + geom_point() + geom_smooth(method = "lm", colour = "Blue") + labs(x = "Scores for sports section", y = "No.of students")
plot.scores.sports


# Calculate central tendency measures
regularmeanscore <- mean(regularData$Score)
sportsmeanscore <- mean(sportsData$Score)
regularmedianscore <- median(regularData$Score)
sportsmedianscore <- median(sportsData$Score)


# Function to calculate mode
find_mode <- function(x) {
  u <- unique(x)
  tab <- tabulate(match(x, u))
  u[tab == max(tab)]
}

regularmodescore <- find_mode(regularData$Score)
sportsmodescore <- find_mode(sportsData$Score)


sprintf("Mean Score of Regular section: %s", regularmeanscore)
sprintf("Mean Score of Sports section: %s", sportsmeanscore)
sprintf("Median Score of Regular section: %s",  regularmedianscore)
sprintf("Median Score of Sports section: %s", sportsmedianscore)
sprintf("Mode Score(s) of Regular section: %s",  regularmodescore)
sprintf("Mode Score(s) of Sports section: %s", sportsmodescore)

# Question 4:
# Comparing and contrasting the point distributions between the two section, looking at both tendency and consistency: 
# a . Can you say that one section tended to score more points than the other? Justify and explain your answer.
# Answer:
# It seems like Regular section students tended to score more points than the sports. This can be inferred from the respective scatter plots.
# There are more no. of students who scored more than 300 from Regular section compared to Sports. Also, the additional line plotted using geom_smooth() shows
# that the mean from regular section is about 330 compared to 300 from sports section.

# b. Did every student in one section score more points than every student in the other section? If not, explain what a statistical tendency means in this context.
# Answer:
# No. Based on this data and the plots, we cannot say that every student in one section score more than every student in the other section. They don't explain 
# the complete statistical tendency in this context. However, calculating central tendency tells us how the group of data is clustered around the center value of
# distribution. Looking at the mean , median and mode values of both sections, we can incline towards the conclusion that Regular section students scored farely
# better than sports section students.

# c. What could be one additional variable that was not mentioned in the narrative that could be influencing the point distributions between the two sections?
# Answer:
# If the data/context includes another variable like grades, that would help in influencing the point distributions between the two sections.
# Another variable that could explain the difference in distributions is average time spent per student per section. 
# Ideally, the more time spent on a course, the better the student does. This could be useful in explaining the disparity between the sections.



# HOUSING DATA EXERCISE

library(ggplot2)
library(readxl)
library(plyr)

setwd("/Users/anjanibonda/DSC520/dsc520")

# Read housing dataset
housingdata <- read_excel("data/week-6-housing.xlsx")
housingdata

# use apply function on saleprice 
apply(housingdata[c('Sale Price')], 2, mean)


# Use the aggregate function on a variable in your dataset. Change column name to remove space.
# In this case, aggregate is used to alculate mean sale price per zip code
colnames(housingdata)[colnames(housingdata) == "Sale Price"] <- "Sale_Price"
aggregate(Sale_Price ~ zip5, housingdata, mean)

# Use the plyr function on a variable in your dataset
# Calculate new variable -> PricePerSqFt by dividing sale price by square_feet_total_living and bring it back to original DF.
housingdata$PricePerSqFt <- with(housingdata, housingdata$Sale_Price/housingdata$square_feet_total_living)
housingdata$PricePerSqFt
housingdata

options(scipen = 10)
# Check distributions of the data
ggplot(housingdata, aes(Sale_Price)) + geom_histogram(bins = 1000)
# Above distribution based on sale price is left/positively skewed.

# Identify if there are any outliers
# As we can see from the above data distribution, there are some outliers, but nothing out of the box. 
# A ~4-5 million dollar home, which are rare, is quite possible and should not be discounted. 

# Create 2 new variables
# Already created one above - PricePerSqFt. Below is another one for PropertyTax appying 2% on sale price.
housingdata$PropertyTax <- with(housingdata, Sale_Price*0.02)
housingdata$PropertyTax
housingdata

