# download file into wd if it doesn't exist, unzip, read in, and filter only needed columns
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("electric.zip")){
  download.file(url, dest = "electric.zip","curl")
  unzip("electric.zip")
}
electric <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?", 
                       colClasses = c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"), nrows= 70000)
electric <- electric[electric$Date %in% c("1/2/2007","2/2/2007"), ]

# get lubridate package for easier manipulation of dates and times
require("lubridate")

# make datetime column in electric
electric$DateTime <- dmy_hms(paste(electric$Date, electric$Time))

# set graphics device and set par() to fit create a 2x2 matrix for 4 plots
png("plot4.png")
par(mfrow = c(2,2))

# first plot - Global Active Power Histogram
with(electric, plot(DateTime, Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)"))

# second plot - DateTime vs. Voltage line plot
with(electric, plot(DateTime, Voltage, type = "l"))

# third plot - DateTime vs. Energy sub metering line plot
with(electric, plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = NA))
with(electric, points(DateTime, Sub_metering_1, type = "l"))
with(electric, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(electric, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))

# fourth plot - DateTime vs. Global Reactive Power line plot
with(electric, plot(DateTime, Global_reactive_power, type = "l"))

# turn off graphics device and complete plotting process
dev.off()
