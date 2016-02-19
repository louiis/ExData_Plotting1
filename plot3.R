
library(dplyr)
library(lubridate)

setwd(dir = "Developer/R/Coursera John Hopkins/4. Exploratory analysis/Week 1 assignment/")

if (!dir.exists("./data")) {dir.create("data")}

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "./data/household_power_consumption.zip",
              method = "curl")

unzip("./data/household_power_consumption.zip", exdir = "./data")

# Read data into dataframe
dfdata <- read.csv(file = "data/household_power_consumption.txt", 
                   sep = ";", stringsAsFactors = FALSE,
                   na.strings = "?" )

str(dfdata)

# Size of data frame in Mb
format(object.size(dfdata), units = "Mb")

# Select the data for the first two days of February 2007
powerdf <- filter(dfdata, Date == "1/2/2007" | Date == "2/2/2007")
str(powerdf)

powerdf$fulldate <- dmy_hms(paste(powerdf$Date,powerdf$Time))
str(powerdf)


# plot 3: energy submetering (1,2,3) vs time
png("Plot3.png")
with(powerdf, plot(fulldate,Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering"))
lines(powerdf$fulldate, powerdf$Sub_metering_2, type = "l", col = "red")
lines(powerdf$fulldate, powerdf$Sub_metering_3, type = "l", col = "blue")

legend(x = "topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1),
       col = c(1,2,4))
dev.off()


