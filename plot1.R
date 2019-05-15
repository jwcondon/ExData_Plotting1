## plot1.R takes data from the household power consumption data and creates a histogram on global active power consumption

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

## Set device to png
png(file = "plot1.png")

## Create histogram
hist(Feb_energy$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

## Close graphics device
dev.off()
