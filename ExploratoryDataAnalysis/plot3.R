# Plot 3

# get raw data 
raw_data<- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?")
raw_data$Date <- as.Date(raw_data$Date, format="%d/%m/%Y")

# filter by date
selected_data <- subset(raw_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# convert to date object
datetime <- paste(selected_data$Date, selected_data$Time)
selected_data$Datetime <- as.POSIXlt(datetime)

# write to png file
png(file="plot3.png",height=480, width=480)

# draw chart
with(selected_data, {
  plot(Datetime,Sub_metering_1,type="l",
       xlab="",ylab="Energy sub metering")
  lines(Datetime,Sub_metering_2,col='Red')
  lines(Datetime,Sub_metering_3,col='Blue')
})

legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1)
#dev.copy(png, file="plot3.png",height=480, width=480)
dev.off()
