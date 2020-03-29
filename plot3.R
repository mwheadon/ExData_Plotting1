## This script reads the household power consumption corresponding to the dates
## 2007-02-01 and 2007-02-02 and plots the Energy Sub Metering for Thurs and Fri 
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

## Next the Energy Sub Metering is plotted vs. DateTime and the output is saved
## to the file plot3.png.

png(file = "plot3.png", width = 480, height = 480)
with(relevantdata, plot(DateTime, Sub_metering_1, type = "n", xlab = "", 
                        ylab = "Energy sub metering"))
with(relevantdata, points(DateTime, Sub_metering_1, type = "l"))
with(relevantdata, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(relevantdata, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()