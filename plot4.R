################################################################################
#                                                                          SETUP
################################################################################
dataFile <- "household_power_consumption.txt"

# The range of datetimes that we are interested in looking at
startDate <- strptime("2007-02-01 0:0:0", format="%Y-%m-%d %H:%M:%S")
endDate <- strptime("2007-02-02 23:59:0", format="%Y-%m-%d %H:%M:%S")


################################################################################
#                                                                    IMPORT DATA
################################################################################
source("getData.R")
df <- getDataInDateRange(dataFile, startDate, endDate)


################################################################################
#                                                                   CREATE PLOT4
################################################################################
png("plot4.png", width=480, heigh=480, units="px")
par(mfcol=c(2,2))
with(df, {
    plot(Timestamp, Global_active_power, 
         type="l", 
         xlab="", 
         ylab="Global Active Power")
    
    plot(Timestamp, Sub_metering_1, 
         col="black", 
         type="l", 
         xlab="", 
         ylab="Energy sub metering")
    
    points(Timestamp, Sub_metering_2, 
           col="red", 
           type="l")
    
    points(Timestamp, Sub_metering_3, 
           col="blue", 
           type="l")
    
    legend("topright", 
           pch=NA, 
           lty=1, 
           col=c("black", "red", "blue"), 
           bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(Timestamp, Voltage, 
         type="l", 
         xlab="datetime", 
         ylab="Voltage")
    
    plot(Timestamp, Global_reactive_power, 
         type="l", 
         xlab="datetime", 
         ylab="Global_reactive_power")
})
dev.off()

