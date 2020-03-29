## This script reads the household power consumption corresponding to the dates
## 2007-02-01 and 2007-02-02 and plots a histogram of the data as a png.

library(dplyr)
library(readr)
library(lubridate)

## This section of code reads in the household power data, then subsets that 
## data to return the relevant data corresponding to the first two days of 
## February 2007. After subsetting the data, the irrelevant data is removed from 
## RAM. 

all_data <- read_delim("./household_power_consumption.txt", 
                       delim = ";", col_names = TRUE)
all_data$Date <- dmy(all_data$Date)

date1 <- ymd("2007-02-01")
date2 <- ymd("2007-02-02")

relevantdata <- all_data %>%
    filter(Date == date1 | Date == date2)

rm(all_data)

## Next the relevant historgram for Global Active Power is generated and output 
## to the file plot1.png.

png(file = "plot1.png", width = 480, height = 480)
hist(relevantdata$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()