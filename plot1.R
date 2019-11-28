# plot1.R
# Generate the first plot:
# Global Active Power (kilowatts) 

# load segement of the data file containing measurements 
# on 2007-02-01 and 2007-02-02

library(lubridate)

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
date_time <- as.character(plotdata$Date) %>% paste(plotdata$Time) %>%ymd_hms()

## plot 1: Global Active Power (kilowatts) 
png(filename = "plot1.png")
hist(plotdata$Global_active_power, 
     col="red", 
     xlab = "Global Active Power (killowats)", 
     main = "Global Active Power")
dev.off()
