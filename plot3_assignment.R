### Unzip and Read data ###
data <- read.table(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), header=T, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))


### Make the date column a Date class ###
data$Date <- as.Date(data$Date, "%d/%m/%Y")


### Subsetting only the data on 01/02/2007 and 02/02/2007 ###
data2 <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))


### Removing the data with missing values by only keeping the complete cases ###
data3 <- data2[complete.cases(data2),]


### Combine date and time ###
Date_and_Time <- paste(data3$Date, data3$Time)


### Format the new Date_and_Time column to the right format ###
Date_and_Time <- as.POSIXct(Date_and_Time)


### Give the column a header ###
Date_and_Time <- setNames(Date_and_Time, "Date_and_Time")


### Add the Date_and_Time column to the dataset ###
data3 <- cbind(Date_and_Time, data3)


### Make the third plot ###
with(data3, {plot(Sub_metering_1~Date_and_Time, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  lines(Sub_metering_2~Date_and_Time, col="Red")
  lines(Sub_metering_3~Date_and_Time, col= "Blue")
  })


### Add legend ###
legend("topright", col=c("black", "red", "blue"), lwd = c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), y.intersp=.8, cex=.8)


### Save the file in the right format ###
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
    