# EXPLORATORY DATA ANALYSIS
# WEEK 1: COURSE PROJECT 1
# RECREATE 4 GRAPHS USING DATA FROM "INDIVIDUAL HOUSEHOLD ELECTRIC POWER CONSUMPTION DATA SET"
# DOWNLOAD AND UNZIP TEXT FILE "household_power_consumption.txt" TO YOUR WORKING DIRECTORY

#/\/\/\/\/\/\/\/\//\/\/\/\/\//\/\/\/\/\/\/\/\//\/\/\/\/\/\/\//\/\/\/\/\/\/\/\/\//\/\/\/\/\/\/\/\
#   0. CALL LIBRARIES REQUIRED
#   YOU MAY NEED TO INSTALL THESE LIBRARIES IF YOU HAVE NOT ALREADY DONE SO
#   REMOVE HASHTAGS ON LINE TO INSTALL PACKAGES
#/\/\/\/\/\/\/\/\//\/\/\/\/\//\/\/\/\/\/\/\/\//\/\/\/\/\/\/\//\/\/\/\/\/\/\/\/\//\/\/\/\/\/\/\/\
#install.packages("ggplot2")
library(ggplot2)

#/\/\/\/\/\/\/\/\//\/\/\/\/\//\/\/\/\/\/\/\/\//\/\/\/\/\/\/\//\/\/\/\/\/\/\/\/\//\/\/\/\/\/\/\/\
#   1. DOWNLOAD, UNZIP DATA TO WORKING DIRECTORY
#/\/\/\/\/\/\/\/\//\/\/\/\/\//\/\/\/\/\/\/\/\//\/\/\/\/\/\/\//\/\/\/\/\/\/\/\/\//\/\/\/\/\/\/\/\
#1.1: SET YOUR WORKING DIRECTORY HERE:
setwd("C:\\Data Science Specialization JHU\\C4_Exploratory_Data_Analysis\\Week1")

#1.2: DOWNLOAD ZIPPED DATA; UNZIP
#DESTINATION OF ZIP FILE SPECIFIED IN INSTRUCTIONS
zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file <- "household_power_consumption.txt"
#CHECK IF ZIP FILE HAS BEEN DOWNLOADED; IF NOT THEN DOWNLOAD
if(!file.exists(zip_file)){
  download.file(zip_url, zip_file, mode = "wb")
  
}

#CHECK IF ZIP FILE HAS BEEN UNZIPPED; IF NOT THEN UNZIP
data_path <- "household_power_consumption.txt"
if(!file.exists(data_path)){
  unzip(zip_file)
}

#/\/\/\/\/\/\/\/\//\/\/\/\/\//\/\/\/\/\/\/\/\//\/\/\/\/\/\/\//\/\/\/\/\/\/\/\/\//\/\/\/\/\/\/\/\
#   2. READ IN DATASET
#      ONLY NEED DATA FROM 2007-02-01 to 2007-02-02 
#      THATS 1st-2nd FEB 2007!
#/\/\/\/\/\/\/\/\//\/\/\/\/\//\/\/\/\/\/\/\/\//\/\/\/\/\/\/\//\/\/\/\/\/\/\/\/\//\/\/\/\/\/\/\/\

dt_electric <- read.table("household_power_consumption.txt", sep = ";", header = T, na.strings = "?", stringsAsFactors = F)
dt_sub_electric <- subset(dt_electric, dt_electric == "1/2/2007" | dt_electric$Date == "2/2/2007") #EXTRACT DATES REQUIRED
dt_sub_electric$Date_Time <- paste(dt_sub_electric$Date, dt_sub_electric$Time) #CREATE NEW DATE_TIME FIELD, USED FROM PLOT 2
dt_sub_electric$Date_Time <- strptime(dt_sub_electric$Date_Time, "%d/%m/%Y %H:%M:%S")
dt_sub_electric$Date <- as.Date(dt_sub_electric$Date, format="%d/%m/%Y")
dt_sub_electric$Time <- strptime(dt_sub_electric$Time, "%H:%M:%S")

#/\/\/\/\/\/\/\/\//\/\/\/\/\//\/\/\/\/\/\/\/\//\/\/\/\/\/\/\//\/\/\/\/\/\/\/\/\//\/\/\/\/\/\/\/\
#   PLOT 4: MULTIPLE PLOTS IN ONE OUTPUT
#/\/\/\/\/\/\/\/\//\/\/\/\/\//\/\/\/\/\/\/\/\//\/\/\/\/\/\/\//\/\/\/\/\/\/\/\/\//\/\/\/\/\/\/\/\
par(mfrow = c(2,2))
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
#Position: Row1 | Col 1
#COPY OF GRAPH FROM PLOT 2: SO STEAL CODE
plot(dt_sub_electric$Date_Time, 
     dt_sub_electric$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power")
#Position: Row1 | Col 2
#VOLTAGE BY DATE_TIME
plot(dt_sub_electric$Date_Time, 
     dt_sub_electric$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")
#Position: Row2 | Col 1
#COPY FROM PLOT 3
plot(dt_sub_electric$Date_Time, 
     dt_sub_electric$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering") #COL OK AS DEFAULT
#ADD SUB METER 2
lines(dt_sub_electric$Date_Time, 
      dt_sub_electric$Sub_metering_2, 
      type = "l", 
      col = "red")
#ADD SUB METER 3
lines(dt_sub_electric$Date_Time, 
      dt_sub_electric$Sub_metering_3, 
      type = "l", 
      col = "blue")
#ADD LEGEND
legend("topright", 
       lty = c(1,1),
       lwd = c(1,1),
       bty = "n",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Position: Row2 | Col 2
#Global Reactive power by datetime
plot(dt_sub_electric$Date_Time, 
     dt_sub_electric$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()