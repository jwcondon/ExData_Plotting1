## plot3.R takes data from the household power consumption data and creates a plot of date/time and energy sub metering

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
png(file = "plot3.png")

## Create plot
with(Feb_energy, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))

## Add additional lines
points(DateTime, Feb_energy$Sub_metering_2, type = "l", col = "red")
points(DateTime, Feb_energy$Sub_metering_3, type = "l", col = "blue")

## Add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

## Close graphics device
dev.off()
