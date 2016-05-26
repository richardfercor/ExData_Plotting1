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

png(filename = "plot3.png",width = 480,height = 480)


plot(x=powerdata$DateTime,y=powerdata$Sub_metering_1,col="black",type="l",ylab = "Energy sub metering",xlab = "")
lines(x=powerdata$DateTime,y=powerdata$Sub_metering_2,col="red",type="l")
lines(x=powerdata$DateTime,y=powerdata$Sub_metering_3,col="blue",type="l")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lwd = c(2,2,2))

dev.off()
