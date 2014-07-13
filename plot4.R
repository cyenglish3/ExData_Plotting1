#This code was developed by:
#Crystal English
#Exploratory Data Analysis - Course Project 1:4
#
#/////////////////////////////////////////////

## Instructions:
## Load the Electric Power Consumption data
## Subset only the time period being plotted: 
## 2007-02-01 and 2007-02-02
## Convert Date and Time variables to Date/time classes
## Missing values are coded as ?
## Create plot and graphic with 4 co-plots

## ////////////////////////////////////////////

# Set the working directory
setwd("P:/CE_Documents/Education/Coursera/RDataFiles")

# Create file directory
if (!file.exists("energy")) {
        dir.create("energy")
}

# Load data already extracted from the zip file
useData <- read.table("energy/household_power_consumption.txt", sep = ";", header = TRUE,
                         na.strings = "?", colClasses = c("character","character","numeric",
                                                          "numeric","numeric","numeric",
                                                          "numeric","numeric","numeric"))

# Format data to something more usable
useData$DateTime <- paste(useData$Date, useData$Time)
useData$DateTime <- strptime(useData$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Subset only the data needed for the analysis
useData <- useData[useData$DateTime >= as.POSIXlt("2007-02-01 00:00:00") & 
                           useData$DateTime <= as.POSIXlt("2007-02-02 23:59:59"),]

# Now create Plot #4 with specified arguments
# First launch the graphics device
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))  # creates a two by two or 4-up graphic

# Next, create the subplots. All four will be on the same window
# Plot 4.1
plot(useData$DateTime, useData$Global_active_power, xlab = "", 
     ylab = "Global Active Power", type = "l")

# Plot 4.2
plot(useData$DateTime, useData$Voltage, xlab = "datetime", 
     ylab = "Voltage", type = "l")

# Plot 4.3
plot(useData$DateTime, useData$Sub_metering_1, xlab = "", 
     ylab = "Energy sub metering", type = "l")
lines(useData$DateTime, useData$Sub_metering_2, col = "red")
lines(useData$DateTime, useData$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))

# Plot 4.4
plot(useData$DateTime, useData$Global_reactive_power, xlab = "datetime", 
     ylab = "Global_reactive_power", type = "l")

# Close the graphics device
dev.off()
