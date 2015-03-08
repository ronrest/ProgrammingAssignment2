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
#                                                                   CREATE PLOT2
################################################################################
png("plot2.png", width=480, heigh=480, units="px")
with(df, plot(Timestamp, Global_active_power, 
              type="l", 
              xlab="", 
              ylab="Global Active Power (kilowatts)"))
dev.off()
