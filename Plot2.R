## download file if not exist
if (!file.exists("powerconsumption.zip")){
  uri<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(uri,destfile = "powerconsumption.zip")
}
## unzip file
unzip("powerconsumption.zip")

## load data frame from working directory

powerdata<-read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?")

## create DateTime field from time and date
powerdata$DateTime <-paste(powerdata$Date," ",powerdata$Time)
powerdata$DateTime <- as.POSIXlt(powerdata$DateTime,format="%d/%m/%Y %H:%M:%S")


## filter data to only 2007-02-01 and 2007-02-02
from <- as.POSIXlt("2007-02-01 00:00:00",format="%Y-%m-%d %H:%M:%S")
to <- as.POSIXlt("2007-02-03 00:00:00",format="%Y-%m-%d %H:%M:%S")

powerdata<-powerdata[powerdata$DateTime>=from & powerdata$DateTime<to,]

##create the graph to a png

png(filename = "plot2.png",width = 480,height = 480)

plot(x=powerdata$DateTime,y=powerdata$Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",xlab = "")

dev.off()
