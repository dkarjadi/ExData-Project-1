library("data.table")
library(lubridate)

#Please make sure the data is in the correct directory below
setwd("C:/Users/Lenovo/Documents/my R data/datasciencecoursera/data")

#Reads data from file and subsets data into var pDate
pDate <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

pDate[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

pDate[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

pDate <- pDate[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(pDate[, dateTime], pDate[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

plot(pDate[, dateTime],pDate[, Voltage], type="l", xlab="datetime", ylab="Voltage")

plot(pDate[, dateTime], pDate[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(pDate[, dateTime], pDate[, Sub_metering_2], col="red")
lines(pDate[, dateTime], pDate[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

plot(pDate[, dateTime], pDate[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()