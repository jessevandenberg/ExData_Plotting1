## Loading libraries
library(dplyr)

## Reading the file
consumption <- tbl_df(read.table("Data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?", "")))

## Fixing the date and time variable
consumption$Date <- as.Date(consumption$Date, format = "%d/%m/%Y")
consumption$TempTime <- paste(consumption$Date, consumption$Time)
consumption$Time <- strptime(consumption$TempTime, format = "%Y-%m-%d %H:%M:%S")
consumption$TempTime <- NULL

## Subset dates 2007-02-01 and 2007-02-02
conSubset <- consumption[which(consumption$Date == "2007-02-01" | consumption$Date == "2007-02-02"), ]

## Make plot 3
## Open graphics device
png(file = "plot3.png")
## Make plot
with(conSubset, plot(x = Time, 
                     y = Sub_metering_1,
                     ylab = "Energy sub metering",
                     type = "l"))
## Add the other points
with(conSubset, points(Time, Sub_metering_2, col = "red", type = "l"))
with(conSubset, points(Time, Sub_metering_3, col = "blue", type = "l"))

## Make the legend
legend("topright", 
       pch = 2, 
       col = c("black", "red", "blue"), 
       legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"))
## Close graphics device
dev.off()