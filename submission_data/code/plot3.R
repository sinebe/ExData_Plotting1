# set data file location
dataFile = "X:/WD/Documents/Projects/Education/DataScience/DataScience/4_Exploratory_Data_Analysis/exdata-data-household_power_consumption/household_power_consumption.txt"

#set wd to be where you will save you files.Specific to your local enviroment
setwd ("X:/WD/Documents/Projects/Education/DataScience/DataScience/4_Exploratory_Data_Analysis/Assignement_1/ExData_Plotting1/submission_data")


cols =  c("Date", 
          "Time", 
          "Global_active_power", 
          "Global_reactive_power", 
          "Voltage","Global_intensity", 
          "Sub_metering_1",  
          "Sub_metering_2" , 
          "Sub_metering_3")

df = read.csv(dataFile, 
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

png(file='graphs/plot3.png', 
    bg = "transparent", 
    width=480, 
    height=480)

plot(df$Sub_metering_1, 
     type ="l", 
     ylab="Energy sub metering", 
     xlab="", 
     xaxt='n' )

lines( df$Sub_metering_2,
       col ='red')

lines( df$Sub_metering_3, 
       col ='blue')

legend("topright",  
       col= c("black","red", "blue"), 
       lwd = 1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

axis(side=1, 
     labels = uniqueDays,  
     at =daysLocation)

dev.off()


