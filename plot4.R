# Read the unzipped txt file in the working directory
fileName <- "household_power_consumption.txt"
rawData <- read.table(fileName, header = TRUE, sep = ";", na.strings = "?", colClasses = c(rep("character", 2), rep("numeric", 7)))

# Make a copy of the raw data
allData <- rawData

# Create a new column called DateTime by combining the Date and Time columns 
allData$DateTime <- paste(allData$Date, allData$Time, sep = " ")

# Covert DateTime column to POSIXlt class
allData$DateTime <- strptime(allData$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Covert Date columne to Date class
allData$Date <- as.Date(allData$Date, format = "%d/%m/%Y")

# Subset the dataset for the 2-day period in which we are interested
newData <- allData[which(allData$Date == "2007-02-01" | allData$Date == "2007-02-02"), ]

#Plot 4
locale <- Sys.getlocale('LC_TIME')
Sys.setlocale('LC_TIME', 'C')
png("plot4.png")
par(mfrow = c(2,2))

#Plot Top-Left
with(newData, plot(DateTime, Global_active_power, type = "l", xlab ="", ylab = "Global Active Power (kilowatts)"))

#Plot Top-Right
with(newData, plot(DateTime, Voltage, type = "l", xlab ="datetime"))

#Plot Bottom-Left
with(newData, plot(DateTime, Sub_metering_1, type = "l", xlab ="", ylab = "Energy sub metering"))
with(newData, lines(DateTime, Sub_metering_2, col = "red"))
with(newData, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Plot Bottom-Right
with(newData, plot(DateTime, Global_reactive_power, type = "l", xlab ="datetime"))

dev.off()
Sys.setlocale('LC_TIME', locale)