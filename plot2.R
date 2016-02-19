
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


# plot 2: xyplot of global active power vs. time
powerdf$weekday <- wday(powerdf$fulldate, label = TRUE)
str(powerdf)

png("Plot2.png")
plot(powerdf$fulldate, powerdf$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global active power (kilowatts)")
dev.off()

