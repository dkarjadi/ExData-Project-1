library("data.table")
library(lubridate)

#Please make sure the data is in the correct directory below
setwd("C:/Users/Lenovo/Documents/my R data/datasciencecoursera/data")

pDate <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

pDate[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

pDate[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

pDate <- pDate[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

hist(pDate[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
