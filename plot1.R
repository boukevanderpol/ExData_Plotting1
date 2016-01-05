# Setting the working directory where data is located. 
setwd("~/R/EDA/project1")

# loading packages
library(data.table)
library(dplyr)
library(tidyr)
library(readr)
#library(lattice)
#library(ggplot2)
library(lubridate)

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

# Convert classes of variables (with lubridate package) 
x$Date <- dmy(x$Date)
x$Time <- hms(x$Time)

# Create png
png("plot1.png", width = 480, height = 480)

# Create plot1 - histogram
hist(x$Global_active_power, 
     col = "red", 
     main = "Golbal Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Close connection png
dev.off()

