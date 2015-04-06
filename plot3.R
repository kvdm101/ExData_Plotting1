setwd("C:/Users/Karin-PC/Downloads")
library("data.table", lib.loc="~/R/win-library/3.1")
library("dplyr", lib.loc="~/R/win-library/3.1")
y <- fread("household_power_consumption.txt", sep = ";", header = TRUE)
y <- mutate(y, Date2 = as.Date(Date, format="%d/%m/%Y"))
x <- filter(y, Date2 >= "2007-02-01" & Date2 < "2007-02-03")
rm(y) # remove original datasource
#Make column numeric 
x <- mutate(x, GlobalActivePower = as.numeric(Global_active_power))
x <- mutate(x, Sub_metering_1 = as.numeric(Sub_metering_1))
x <- mutate(x, Sub_metering_2 = as.numeric(Sub_metering_2))
x <- mutate(x, Sub_metering_3 = as.numeric(Sub_metering_3))

x$DateTime <- as.POSIXct(strptime(paste(x$Date,x$Time), "%d/%m/%Y %H:%M:%S"))
#Plot 3
par(cex = 0.8) 
par(mar = c(4, 4, 2, 2))
plot(x$DateTime, x$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(x$DateTime, x$Sub_metering_2, col="red")
lines(x$DateTime, x$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1)
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()