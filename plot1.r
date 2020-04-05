## Set Working Directory

setwd("D:/Coursera Esp/Exploratory Data Analysis/ExData_Plotting1")

## extracting and reading file

if (!file.exists('/exdata_data_household_power_consumption.zip')){
  unzip("exdata_data_household_power_consumption.zip", exdir = getwd())
}

data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = 
                     c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

##Changing data format
data$Date <- as.Date(data$Date,"%d/%m/%Y")

## choosing rage of dates
data <- subset(data, Date >=as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

data <- data[complete.cases(data),]

data_datetime <- paste(data$Date, data$Time)
data_datetime <- setNames(data_datetime,("DateTime"))
data <- cbind(data_datetime, data)
data$data_datetime <- as.POSIXct(data_datetime)

##Ploting hist&saving 
png("plot1.png", 480,480,"px")
hist(data$Global_active_power, col ="red", xlab = "Global Active Power (killowats)", main = "Global Acive Power")
dev.off()
