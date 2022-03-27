# Assignment: ASSIGNMENT 5.2
# Name: Bonda, Anjani
# Date: 2022-01-16

library(readxl)
library(dplyr)
library(purrr)
library(stringr)


# Set workding directory to read source datasets.
setwd("/Users/anjanibonda/DSC520/dsc520")

# Read housing dataset
housingdata <- read_excel("data/week-6-housing.xlsx")
housingdata

# groupby (dplyr package) operation on housing dataset
grpby_housing <- housingdata %>% group_by(ctyname)
grpby_housing

# select operation on housing dataset
housingdata %>% select('Sale Price', bath_full_count)

# summarize operation on housing dataset
housingdata %>% summarize(MeanBedroomSize = mean(bedrooms))


# mutate operation on housing dataset
housingdata %>% select(bedrooms, bath_full_count) %>% mutate(totrooms = bedrooms + bath_full_count)

# filter operation on housing dataset
housingdata %>% select('Sale Price', bedrooms, bath_full_count) %>% filter(bedrooms == 3)

# arrange operation on housing dataset
housingdata %>% select('Sale Price', bath_full_count, bedrooms) %>% group_by(bedrooms) %>% arrange(desc(bedrooms))

# purrr functions
# keep function
keep(housingdata$year_built, function(x) x > 2010)
# discard function
discard(housingdata$year_built, function(x) x < 1990)


# cbind and rbind functions on housing dataset
# cbind
myvar1 <- c('Sale Price','year_renovated')
myvar2 <- c('bedrooms')
subset_housingdata1 <- housingdata[myvar1]
subset_housingdata2 <- housingdata[myvar2]
cbind_housingdata <- cbind(subset_housingdata1, subset_housingdata2)
head(cbind_housingdata)

# rbind
subset_housingdata3 <- housingdata[1:4, ]
subset_housingdata4 <- housingdata[5:8, ]
subset_housingdata3
subset_housingdata4
rbind_df <- rbind(subset_housingdata3, subset_housingdata4)
head(rbind_df)

# string split and assign labels
addr_list <- str_split(housingdata$addr_full, " ")
head(addr_list)
# create address dataframe
addr_df <- data.frame(Reduce(rbind, addr_list))
head(addr_df)
# assign labels/column names
names(addr_df) <- c("Addr1", "Addr2", "Addr2", "Addr4")
head(addr_df)

# concatenate results back together to the main dataset or dataframe.
housingdata <- cbind(housingdata, addr_df)
head(housingdata)