#Name file downloaded
name <- "exdata_data_household_power_consumption.zip"

#Load dplyr
library(lubridate)
library(tidyr)

# Check if file already exists
if (!file.exists(name)){
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(URL, name, method="curl")
} 

# Check if folder exists
if (!file.exists("household_power_consumption.txt")) { 
  unzip(name) 
}

# Reading dataset files 
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
data[,3:9]<- apply(data[,3:9],2,as.numeric)
data<- unite(data, DateTime, c(1:2), sep=" ", remove = TRUE)
data$DateTime<- dmy_hms(data$DateTime)
data2007 <- subset(data, year(DateTime)==2007 & month(DateTime)==2 & day(DateTime) %in% c(1,2))
with(data2007, hist(Global_active_power, 
                    col="red", 
                    xlab = "Global Active Power (kilowatts)", 
                    main="Global Active Power"))
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()