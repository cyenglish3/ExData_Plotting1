#This code was developed by:
#Crystal English
#Exploratory Data Analysis - Course Project 1:1
#
#/////////////////////////////////////////////

## Instructions:
## Load the Electric Power Consumption data
## Subset only the time period being plotted: 
## 2007-02-01 and 2007-02-02
## Convert Date and Time variables to Date/time classes
## Missing values are coded as ?
## Create plot and graphic

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

# Now create Plot #1 with specified arguments
# First launch the graphics device
png("plot1.png", width = 480, height = 480)

# Next, create the plot - a histogram
hist(useData$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# Close the graphics device
dev.off()

