setwd("../Assignement_1")
fileUrl  = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, desfile = 'assigment_data')

df1 = read.csv("exdata-data-household_power_consumption/household_power_consumption.txt", sep=';' , nrows =10, header = TRUE )

cols =  c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage","Global_intensity", "Sub_metering_1",  "Sub_metering_2" , "Sub_metering_3")
df = read.csv("exdata-data-household_power_consumption/household_power_consumption.txt", sep=';' , nrows =2880, header = TRUE, skip=66637, col.names =cols )

df$Date.Time = paste (df$Date, df$Time, sep= " ")
df$Date.Time = strptime(df$Date.Time, "%d/%m/%Y %H:%M:%S")


#plot 1
png(file='plot_1.png', bg = "transparent", width=480, height=480)
hist(df$Global_active_power, main = "Global Active Power", xlab= "Global Active Power (Kilowatts)", ylab="Frequency", col="red")
dev.off()


#plot 2
df$days =  factor(weekdays(df$Date.Time, abbreviate = TRUE))
uniqueDays = as.character(unique(df$days, orderded=TRUE))
daysLocation = match(uniqueDays, df$days)
png(file='plot_2.png', bg = "transparent", width=480, height=480)
plot(df$Global_active_power, type ="l", ylab="Global Active Power (Kilowatts)", xlab="", axes=FALSE)
axis(side=1, labels = uniqueDays,  at =daysLocation)
axis(side=2, at = seq(0,6, by=2))
box()
dev.off()


#plot 2
df$days =  factor(weekdays(df$Date.Time, abbreviate = TRUE))
uniqueDays = as.character(unique(df$days, orderded=TRUE))
daysLocation = match(uniqueDays, df$days)
png(file='plot_3.png', bg = "transparent", width=480, height=480)
plot(df$Sub_metering_1, type ="l", ylab="Energy Sub metering", xlab="", axes=FALSE )

lines( df$Sub_metering_2 ,col ='red')
lines( df$Sub_metering_3, col ='blue')
legend("topright", pch=2, col= c("black","red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(side=1, labels = uniqueDays,  at =daysLocation)
axis(side=2, at = seq(0,30, by=10))
box()
dev.off()

