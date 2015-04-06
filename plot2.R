setwd("C:/Users/Karin-PC/Downloads")
library("data.table", lib.loc="~/R/win-library/3.1")
library("dplyr", lib.loc="~/R/win-library/3.1")
y <- fread("household_power_consumption.txt", sep = ";", header = TRUE)
y <- mutate(y, Date2 = as.Date(Date, format="%d/%m/%Y"))
x <- filter(y, Date2 >= "2007-02-01" & Date2 < "2007-02-03")
#rm(y) # remove original datasource
#Make column numeric 
x <- mutate(x, GlobalActivePower = as.numeric(Global_active_power))
x$DateTime <- as.POSIXct(strptime(paste(x$Date,x$Time), "%d/%m/%Y %H:%M:%S"))
#Plot 2
plot(x$DateTime, x$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
#Copy to png
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()