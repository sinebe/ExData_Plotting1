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

#Create plot 1

png(file='plot1.png', 
    bg = "transparent", 
    width=480, 
    height=480)

hist(df$Global_active_power, 
     main = "Global Active Power", 
     xlab= "Global Active Power (Kilowatts)", 
     ylab="Frequency", 
     col="red")

dev.off()
