## plot2.R takes data from the household power consumption data and creates a plot of date/time and global active power

## Read data into a table using separator ;, removing ? and replacing with NA and converting all numbers to numeric
## also specifies first line is a header
energy <- read.table("household_power_consumption.txt", 
                     sep = ";", 
                     na.strings = "?",
                     colClasses = 
                     c(
                        Global_active_power = "numeric",
                        Voltage = "numeric",
                        Global_intensity = "numeric",
                        Sub_metering_1 = "numeric",
                        Sub_metering_2 = "numeric"
                     ), 
                     header = TRUE
)

## Convert Date column to Date type
energy$Date <- strptime(energy$Date, "%d/%m/%Y")

## Subset data to only grab Feb 1 and 2 from 2007
Feb_energy <- subset(energy, Date == "2007-02-01" | Date == "2007-02-02")

## Create new date time column
Feb_energy$DateTime <- as.POSIXct(paste0(Feb_energy$Date, Feb_energy$Time), format="%Y-%m-%d %H:%M:%S")

## Set device to png
png(file = "plot2.png")

## Create plot
with(Feb_energy, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

## Close graphics device
dev.off()
