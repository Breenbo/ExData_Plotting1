# working data.table for big datas and with dplyr for data.frame
library(data.table)
library(dplyr)
library(lubridate)
# reading sample of datas (fread much faster)

datas <- fread("household_power_consumption.txt", sep=";", na.string="?", stringsAsFactors=FALSE, header=TRUE, colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

datas <- as.data.frame(datas)

# selecting datas for 01/02/2007 and 02/02/2007
selDatas <- filter(datas, Date == "1/2/2007" | Date == "2/2/2007")

# creating a date column
selDatas <- mutate(selDatas, Dates = paste(Date,Time))
selDatas <- mutate(selDatas, dates = dmy_hms(Dates))
selDatas <- select(selDatas, dates, Global_active_power:Sub_metering_3)

# ploting the plot for Energy Sub_metering
png("plot3.png")
with(selDatas, plot(dates, Sub_metering_1, col="black", type="l", ylab="Global Active Power (kilowatts)", xlab=""))
with(selDatas, points(dates, Sub_metering_2, col="red", type="l"))
with(selDatas, points(dates, Sub_metering_3, col="blue", type="l"))
legend("topright", pch="_", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
