## This script reads the household power consumption corresponding to the dates
## 2007-02-01 and 2007-02-02 and plots the Global Active Power for Thurs and Fri 
## as a png.

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

## This section of code combines data from the Date and Time columns and 
## computes a new column with data of class date-time.

relevantdata <- relevantdata %>%
    mutate(DateTime = ymd_hms(paste(relevantdata$Date, relevantdata$Time, 
                                    sep = " ")))

## Next the Global Active Power is plotted vs. DateTime and the output is saved
## to the file plot2.png.

png(file = "plot2.png", width = 480, height = 480)
with(relevantdata, plot(DateTime, Global_active_power, type = "l", xlab = "", 
                        ylab = "Global Active Power (kilowatts)"))
dev.off()