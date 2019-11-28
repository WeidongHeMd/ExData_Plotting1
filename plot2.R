# plot2.R
# Generate the second plot:
# Global Active Power vs time 

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

# Generated the 2nd plot: Global Active Power vs. date_time
png(filename = "plot2.png")
plot(date_time, plotdata$Global_active_power, 
     type="l", 
     xlab="", 
     ylab = "Global Active Power (kilowatts)", 
     main="Global Active Power")

dev.off()
