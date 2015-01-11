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

df = df[1:nrow(df)-1,] # deleted the last row b/c it goes into the next day. Row needed for labeling

# Create plot 2

png(file='plot2.png', 
    bg = "transparent", 
    width=480, 
    height=480)

plot(df$Global_active_power, 
     type ="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="", 
     xaxt='n')

axis(side=1, 
     labels = uniqueDays,  
     at =daysLocation)


dev.off()