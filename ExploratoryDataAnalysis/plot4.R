setwd("C:\\Users\\kevinzhang\\Documents\\exdata")
raw_data<- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?")
raw_data$Date <- as.Date(raw_data$Date, format="%d/%m/%Y")

selected_data <- subset(raw_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

datetime <- paste(selected_data$Date, selected_data$Time)
selected_data$Datetime <- as.POSIXlt(datetime)

png(file="plot4.png",height=480, width=480)
par(mfrow=c(2,2))

with(selected_data, {
  plot(Datetime,Global_active_power, type="l", 
     xlab="",ylab="Global Active Power" )
  plot(Datetime,Voltage, type="l",
       xlab="datetime",ylab="Voltage")
  plot(Datetime,Sub_metering_1,type="l",
       xlab="",ylab="Energy sub metering")
  lines(Datetime,Sub_metering_2,col='Red')
  lines(Datetime,Sub_metering_3,col='Blue')
  legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1,bty="n",cex=0.6)
  plot(Datetime,Global_reactive_power, type="l", 
       xlab="datetime",ylab="Global_Rective_Power")
})
#dev.copy(png, file="plot4.png",height=480, width=480)
dev.off()

