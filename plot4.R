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
png("plot4.png", 480,480,"px")

par(mfrow = c(2,2), mar = c(4,4,2,2), oma=c(0,02,0))
with(data, {
  plot(Global_active_power~data$data_datetime, type = "l", xlab = "", ylab = "Global Active Power (killowats)")
  plot(data$Voltage~data$data_datetime, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(Sub_metering_1 ~data$data_datetime, type = "l", xlab = "", ylab = "Energy Sub metering")
  lines(Sub_metering_2, col = "red")
  lines(Sub_metering_3, col = "blue")
  legend("topright", col =c("black", "red", "blue"),  lwd = c(1,1,1) ,c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(data$Global_reactive_power~data$data_datetime, type = "l", xlab = "", ylab = "Global_reactive_power")
})

dev.off()