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


## Plot 2
## Create a new column of the combined date and time
a=with(data,paste(as.Date(Date,format='%d/%m/%Y'),Time, sep = " "))
data2 <- cbind(as.POSIXct(a),data)
colnames(data2)[1] <- "datetime"

png("plot2.png",  width = 480, height = 480, units = "px")
with(data2,plot(x=datetime, y=Global_active_power,type="l",,xlab=""
	        ylab="Global Active Power (kilowatts)"))
dev.off()
