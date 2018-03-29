library("data.table")

# Download source data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = paste(getwd(),"data.zip", sep="/"))
unzip("data.zip")

#Reads the text file
hpcTable <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Add a new column with the combined Date and Time values
hpcTable[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Include only records between 2007-02-01 and 2007-02-02
hpcTable <- hpcTable[(dateTime >= "2007-02-01 00:00:00") & (dateTime <= "2007-02-02 23:59:59")]

png("plot2.png", width=480, height=480)

#draw plot
plot(x = hpcTable[, dateTime], y = hpcTable[, Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()