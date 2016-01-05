# Setting the working directory where data is located. 
setwd("~/R/EDA/project1")

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

x <- gather(x, Sub_metering, count, -c(Date, 
                                       Time, 
                                       Global_active_power, 
                                       Global_reactive_power, 
                                       Voltage, 
                                       Global_intensity))

x$Sub_metering <- as.character(x$Sub_metering)

# Create timestamp out of variables Date and Time  
x$timestamp <- paste(x$Date, x$Time)
x <- arrange(x, timestamp)
x$timestamp <- strptime(x$timestamp, format = "%d/%m/%Y %H:%M:%S")

# Create png
png("plot4.png", width = 480, height = 480)

# Set parameter to get 4 plots: 2 x 2
par(mfrow = c(2,2))

# Create plot4-1
plot(x$timestamp, x$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
     )

# Create plot4-2
plot(x$timestamp, x$Voltage, 
     type = "l", 
     xlab = "datetime",
     ylab = "Voltage"
     )

# Create plot4-3
with(x, plot(timestamp, count, type = "n", xlab = "", ylab = "Energy sub metering"))
with(subset(x, Sub_metering == "Sub_metering_1"), points(timestamp, count, type = "l", col = "black"))
with(subset(x, Sub_metering == "Sub_metering_2"), points(timestamp, count, type = "l", col = "red"))
with(subset(x, Sub_metering == "Sub_metering_3"), points(timestamp, count, type = "l", col = "blue"))
legend("topright", pch = "-", bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Create plot4-4
plot(x$timestamp, x$Global_reactive_power, 
     type = "l", 
     xlab = "datetime",
     ylab = "Global_reactive_power"
     )

# Close connection png
dev.off()