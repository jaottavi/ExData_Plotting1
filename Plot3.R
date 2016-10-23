# download file into wd, unzip, read in, and filter only needed columns
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

# set graphics device, create "Energy sub metering" line plot over 2-day period, close graphics device
png("plot3.png")
with(electric, plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = NA))
with(electric, points(DateTime, Sub_metering_1, type = "l"))
with(electric, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(electric, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))
dev.off()
