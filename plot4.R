setwd("C:/Users/liliz/Desktop/Coursera/Exploratory Data Analysis")

## Because the data file is very big, and only a small fraction of the data is 
## required for analysis,so the code reads the file by only selecting the rows 
## which meet the requirement for efficency. To do so, the first 10 rows of the 
## data are read for quick inspection. From the first 10 rows of data, it is known 
## that the starting date of the data is "2006-12-16 17:24:00", with an one-minute 
## sampling rate. The target dates for the analysis are between 2007-2-1 00:00:00 
## and 2007-2-2 23:59:00, therefore the exact number of minutes, i.e. number of 
## rows, can be calculated.

header <- read.table("household_power_consumption.txt",sep=";",na.strings = "?",
	  header=TRUE, nrows=10)
header

start <- as.POSIXct("2006-12-16 17:24:00")
mid <- as.POSIXct("2007-2-1 00:00:00")
end <- as.POSIXct("2007-2-3 00:00:00")

## The number of minutes is calculated by multiplying date difference 
## with 24 hours and 60 minutes
skiprows <- (mid - start)*24*60
keeprows <- (end - mid)*24*60

## Select only the required rows
data <- read.table("household_power_consumption.txt",sep=";",na.strings = "?",
	nrows=keeprows,header=TRUE,skip=skiprows)
colnames(data) <- colnames(header)


## Plot 4

png("plot4.png",  width = 480, height = 480, units = "px")

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

#1
a=with(data,paste(as.Date(Date,format='%d/%m/%Y'),Time, sep = " "))
data2 <- cbind(as.POSIXct(a),data)
colnames(data2)[1] <- "datetime"
with(data2,plot(x=datetime, y=Global_active_power,type="l",
	   ylab="Global Active Power",xlab=""))

#2
with(data2,plot(x=datetime, y=Voltage,type="l"))

#3
with (data2,{
  plot(x=datetime,y=Sub_metering_1,type="l",col="black",xlab="",ylab="",ylim=c(0,40))
  par(new=TRUE)
  plot(x=datetime,y=Sub_metering_2,type="l",col="red",xlab="",ylab="",ylim=c(0,40))
  par(new=TRUE)
  plot(x=datetime,y=Sub_metering_3,type="l",col="blue",xlab="",ylim=c(0,40),ylab="Energy sub metering")
  legend("topright",colnames(data2)[8:10],col=c(1:3),lty=1)
})


#4
with(data2,plot(x=datetime, y=Global_reactive_power,type="l"))

dev.off()





