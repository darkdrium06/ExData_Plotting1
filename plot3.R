plot3 <- function(){
  #download and extract file
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, destfile = "./household_power_consumption.zip")
  unzip("household_power_consumption.zip")

  #load first five rows to get the classes of the variables
  top5 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 5)
  classes <- sapply(top5, class)

  #read the entire dataset
  alldata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = classes)

  #convert the date variable to a Date datatype
  alldata$Date <- as.Date(alldata$Date, "%d/%m/%Y")

  #We will only be using data from the dates 2007-02-01 and 2007-02-02
  subsetdata <- alldata[alldata$Date >= "2007-02-01" & alldata$Date <= "2007-02-02",]

  #convert the time field to a datetime
  subsetdata$Time <- as.POSIXct(paste(subsetdata$Date, strftime(strptime(subsetdata$Time, "%T"), "%T")), format = "%Y-%m-%d %T")
  colnames(subsetdata)[2] <- "datetime"
  
  #create the plot and save it
  png(filename = "plot3.png")
  with(subsetdata, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
  with(subsetdata, lines(datetime, Sub_metering_2, col = "red"))
  with(subsetdata, lines(datetime, Sub_metering_3, col = "blue"))
  legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}

