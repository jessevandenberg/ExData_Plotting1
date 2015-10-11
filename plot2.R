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

## Make plot 2 - Time vs Global Active Power 
## Open graphics device
png(file = "plot2.png")
## Make plot
with(conSubset, plot(Time, Global_active_power,
                     ylab = "Global Active Power (kilowatts)",
                     type = "l"))
## Close graphics device
dev.off()