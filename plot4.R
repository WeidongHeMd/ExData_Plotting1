# plot4.R
# Generate the four figs in one plot
# 

# load segement of the data file containing measurements 
# on 2007-02-01 and 2007-02-02

library(lubridate)
library(stringr)

initial <- read.table("datafile.txt", sep=";", na.strings="?", 
                      header = TRUE, stringsAsFactors=FALSE, 
                      nrows=10)
classes <- sapply(initial, class)

feb2007 <- read.table("datafile.txt", sep=";", na.strings="?", 
                      header = TRUE, stringsAsFactors=FALSE, 
                      nrows=20000, skip = 50000, 
                      col.names = names(initial),colClasses = classes)

# extract the measurements on 2007-02-01 and 2007-02-02
feb2007$Date <- dmy(feb2007$Date)
plotdata <- subset(feb2007,feb2007$Date==as.Date("2007-02-01")|
                       feb2007$Date==as.Date("2007-02-02"))

# create date time from the first two columns
date_time <- as.character(plotdata$Date) %>% paste(plotdata$Time) %>% ymd_hms()


## plot 4 plots

png(filename = "plot4.png")
par(mfrow=c(2,2))

# Global active power
plot(date_time, plotdata$Global_active_power, 
     type="l", 
     xlab="", 
     ylab = "Global Active Power (kilowatts)")

# Voltage
plot(date_time, plotdata$Voltage, 
     type="l", 
     xlab="datetime", 
     ylab = "Voltage")

# Energy submeterings
plot(date_time, plotdata$Sub_metering_1, 
     xlab = "", 
     ylab = "Energy sub meterings", 
     yaxp=c(0,30,3), 
     type="n")
lines(date_time, plotdata$Sub_metering_1)
lines(date_time, plotdata$Sub_metering_2, col="red")
lines(date_time, plotdata$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1,1), 
       col=c("black", "red", "blue"), 
       legend = c("Sub_metering1", "Sub_metering2","Sub_metering3"))

# Global reactive power
plot(date_time, plotdata$Global_reactive_power, 
     type="l", 
     xlab="datetime")

dev.off()