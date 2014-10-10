# Plot 1

# get raw data 
raw_data<- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?")
raw_data$Date <- as.Date(raw_data$Date, format="%d/%m/%Y")

# filter by date
selected_data <- subset(raw_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))


# draw chart
hist(selected_data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
     
     
# write to png file
dev.copy(png, file="plot1.png",height=480, width=480)
dev.off()