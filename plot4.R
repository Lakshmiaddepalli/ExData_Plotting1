
fulldata <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
fulldata$Date <- as.Date(fulldata$Date, format="%d/%m/%Y")

data <- subset(fulldata,(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(fulldata)

datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)


par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(data, {
plot(Global_active_power~Datetime, xlab="",ylab="Global Active Power",type = "l", col = 'black')
plot(Voltage~Datetime,xlab="datetime", ylab="Voltage", type="l",col = 'black' )
plot(Sub_metering_1~Datetime,xlab="",ylab="Energy sub metering",type="l",col ='black')
lines(Sub_metering_2~Datetime,col='Red')
lines(Sub_metering_3~Datetime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(Global_reactive_power~Datetime,xlab="datetime",ylab="Global Rective Power", type="l")
})


## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
