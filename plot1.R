library("data.table")

# Download source data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = paste(getwd(),"data.zip", sep="/"))
unzip("data.zip")

#Reads the text file
hpcTable <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Change Date Column to Date Type
hpcTable[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Include only records between 2007-02-01 and 2007-02-02
hpcTable <- hpcTable[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

#draw plot
hist(hpcTable[,Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()