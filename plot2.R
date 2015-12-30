# Setting the working directory where data is located. 
setwd("~/R/EDA")

# loading packages
library(data.table)
library(dplyr)
library(tidyr)
library(readr)
#library(lattice)
#library(ggplot2)
#library(lubridate)

# Loading the data into R
x <- read_csv(file = "household_power_consumption.txt", 
              col_types = cols(
                      Date = "c",
                      Time = "c" ,
                      Global_active_power = "d", 
                      Global_reactive_power = "d", 
                      Voltage = "d", 
                      Global_intensity = "d",
                      Sub_metering_1 = "d", 
                      Sub_metering_2 = "d",
                      Sub_metering_3 = "d"
              )
)

# This assignment concerns two dates => Filter rows with these two dates
x <- filter(x, Date %in% c("1/2/2007", "2/2/2007"))

# Create timestamp out of variables Date and Time  
x$timestamp <- paste(x$Date, x$Time)
x <- arrange(x, timestamp)
x$timestamp <- strptime(x$timestamp, format = "%d/%m/%Y %H:%M:%S")

# Create png
png("plot2.png", width = 480, height = 480)

# Create plot2 
plot(x$timestamp, x$Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Close connection png
dev.off()