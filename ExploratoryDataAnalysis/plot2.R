# Plot 2

# get raw data 
raw_data<- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?")
raw_data$Date <- as.Date(raw_data$Date, format="%d/%m/%Y")

# filter by date
selected_data <- subset(raw_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# convert to date object
datetime <- paste(selected_data$Date, selected_data$Time)
selected_data$Datetime <- as.POSIXlt(datetime)

# draw chart
plot(selected_data$Datetime,selected_data$Global_active_power, type="l",
   xlab="", ylab="Global Active Power (kilowatts)" )
   
# write to png file
dev.copy(png, file="plot2.png",height=480, width=480)
dev.off()
