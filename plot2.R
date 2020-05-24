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

png("plot2.png", width=480, height=480)

plot(x = pDate[, dateTime]
     , y = pDate[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()