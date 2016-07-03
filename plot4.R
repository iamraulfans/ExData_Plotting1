library(httr)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")
housedata <- read.table("household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";", as.is = TRUE)
data <- subset(housedata, Date == "1/2/2007" | Date == "2/2/2007")
data$Time <- paste(data$Date, data$Time, sep = ".")
data$Date <- as.Date(data$Date, format='%d/%m/%Y')
data$Time <- strptime(data$Time, format = '%d/%m/%Y.%H:%M:%S')

par(mfrow = c(2,2), mar = c(7,5,1,1))

with(data, plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

with(data, plot(Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

with(data, plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Engergy sub metering"))
lines(data$Time, data$Sub_metering_2, col = "red")
lines(data$Time, data$Sub_metering_3, col = "blue")
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(data, plot(Time, Global_reactive_power, type = "l", xlab = "datetime"))

dev.copy(png, file = "plot4.png")
dev.off()