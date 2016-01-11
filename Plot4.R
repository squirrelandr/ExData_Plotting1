setwd("~/R/Coursera/Exploratory Data Analysis")

# read the first 5 rows to determine column classes
epc5row <- read.csv("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, nrows = 5, sep = ";")
classes <- sapply(epc5row, class)
colheader <- colnames(epc5row)

# the 2007-02-01 data are starting from rows 66638 for 2880 rows (use Notepad's View->Status Bar and Find function to figure that out)
epc2007 <- read.csv("household_power_consumption.txt", header = FALSE, stringsAsFactors = FALSE, skip = 66637, nrows = 2880, sep = ";", na.strings = "?", colClasses = classes)
colnames(epc2007) <- colheader

# convert the Date column to date format
epc2007$Date <- as.Date(epc2007$Date, "%d/%m/%Y")
#epc2007$Time <- as.(epc2007$Time, "%H:%M:%S")

# combine the date and time in a new column for the table
datetime <- paste(epc2007$Date, epc2007$Time, sep = " ")
epc2007$DateTime <- as.POSIXct(datetime)

# perform plotting with with() function to allow multiple lines inside the same plot
par(mfrow = c(2,2), mar = c(4,4,2,1), oma=c(1,1,2,0))
with(epc2007, {
  
  # plot1
  plot(Global_active_power~DateTime, type = "l", ylab = "Global Active Power", xlab = "")

  # plot2
  plot(Voltage~DateTime, type = "l")

  # plot3
  plot(Sub_metering_1~DateTime, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
  lines(Sub_metering_2~DateTime, type = "l", col = "red")
  lines(Sub_metering_3~DateTime, type = "l", col = "blue")
  legend("topright", pch = ".", col = c("black", "red", "blue"), lty = 1, lwd = 1, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  # plot4
  plot(Global_reactive_power~DateTime, type = "l")

})


dev.copy(png, file = "Plot4.png", height = 960, width = 960)
dev.off()
