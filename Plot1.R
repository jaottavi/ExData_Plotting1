# download file into wd, unzip, read in, and filter only needed columns
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("electric.zip")){
  download.file(url, dest = "electric.zip","curl")
  unzip("electric.zip")
}
electric <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?", 
  colClasses = c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"), nrows= 70000)
electric <- electric[electric$Date %in% c("1/2/2007","2/2/2007"), ]

# set graphics device, create "Global Active Power" histogram, make necessary label changes
png("plot1.png")
with(electric, hist(Global_active_power, col = "red", breaks = 12, main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()
