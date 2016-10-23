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

# set graphics device, create "Global Active Power" line plot over two day period, close graphics device
png("plot2.png")
with(electric, plot(DateTime, Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)"))
dev.off()
