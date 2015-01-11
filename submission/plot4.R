setwd("X:/WD/Documents/Projects/Education/DataScience/DataScience/4_Exploratory_Data_Analysis/")
setwd("Assignement_1")


cols =  c("Date", 
          "Time", 
          "Global_active_power", 
          "Global_reactive_power", 
          "Voltage","Global_intensity", 
          "Sub_metering_1",  
          "Sub_metering_2" , 
          "Sub_metering_3")

df = read.csv("exdata-data-household_power_consumption/household_power_consumption.txt", 
              sep=';', 
              nrows =2880, 
              header = TRUE, 
              skip=66637, 
              col.names=cols)

df$Date.Time = paste(df$Date, df$Time, sep= " ")

df$Date.Time = strptime(df$Date.Time, "%d/%m/%Y %H:%M:%S")

df$days =  factor(weekdays(df$Date.Time, abbreviate = TRUE))

uniqueDays = as.character(unique(df$days, orderded=TRUE))

daysLocation = match(uniqueDays, df$days)

df = df[1:nrow(df)-1,] # deleted the last row b/c it goes into the next day. Row was imported for labeling


#plot3 


png(file='plot4.png', bg = "transparent", width=480, height=480)

par(mfcol = c(2,2))

#from plot 2

plot(df$Global_active_power, 
     type ="l", 
     ylab="Global Active Power (Kilowatts)", 
     xlab="", 
     xaxt='n')

axis(side=1, 
     labels = uniqueDays,  
     at =daysLocation)


# another plot: 2nd

plot(df$Sub_metering_1, 
     type ="l", 
     ylab="Energy Sub metering", 
     xlab="", 
     xaxt='n')

lines(df$Sub_metering_2, 
      col ='red')

lines(df$Sub_metering_3, 
      col ='blue')

legend("topright",  
       col= c("black","red", "blue"), 
       lwd = 1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

axis(side=1, 
     labels = uniqueDays,  
     at = daysLocation)


#3rd Plot

plot(df$Voltage, 
     xlab="datetime", 
     ylab="Voltage", 
     type='l', 
     xaxt='n')

axis(side=1, 
     labels = uniqueDays,  
     at = daysLocation)

#4th Plot

plot(df$Global_reactive_power, 
     xlab="datetime", 
     ylab="Global_reactive_power", 
     type='l', 
     xaxt='n', 
     yaxt='n')

axis(side=2,
     at=seq(0,0.5, by=0.1), 
     labels=seq(0,0.5, by= 0.1))

axis(side=1, 
     labels = uniqueDays,  
     at = daysLocation)

dev.off()
