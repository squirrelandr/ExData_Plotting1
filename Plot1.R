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

hist(epc2007$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
