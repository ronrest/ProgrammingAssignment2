
getDataInDateRange <- function(datafile, startDate, endDate){
    # ==========================================================================
    #                                                          GET DATA IN RANGE
    # ==========================================================================
    # Gets sub-data from the data file that falls within a specified range of 
    # timestamps. 
    # 
    # Assumes that the data being imported is the "Individual household 
    # electric power consumption Data Set" from the UC Irvine Machine Learning 
    # Repository, stored as a plain text file, with columns delimeted with 
    # semicolons ";" and missing values represented by question marks "?"
    # 
    # This function efficiently imports the desired subset of data by ONLY 
    # reading the relevant lines from the source file, instead of reading the 
    # whole file into memory, and then filtering. It calculates the relevant 
    # lines by first sampling the very first line of data, and calculating how 
    # many minutes must elapse from this initial measurement and the start of 
    # the desired range. It also calculates how many minutes there are in the 
    # desired range. The number of minutes determines the number of rows that 
    # must be skipped and read in the text file.
    # 
    # Args:
    #   datafile:   A string representing the filepath to the data file. 
    #   startDate:  A POSIXlt date-time object. Determines the start of the date 
    #               range we are interested in
    #   endDate:    A POSIXlt date-time object. Determines the end of the date 
    #               range we are interested in
    # 
    # Returns:
    #   A dataframe object with only the rows containing information for the 
    #   range of datetimes specified.
    # ==========================================================================
    
    # --------------------------------------------------------------------------
    #                                                                      Setup
    # --------------------------------------------------------------------------
    # Coerce the columns in the data to the following types. 
    # NOTE: coercing to "date" type for the first column does not work as 
    #       expected using this data file, perhaps because of the date format 
    #       used.  This column will be instead be imported as a string, and a 
    #       new datetime column will be added later that combines the 
    #       information from the date, and the time column.  
    colClasses <- c("character", "character", "numeric", "numeric", "numeric", 
                    "numeric", "numeric", "numeric", "numeric")
    
    # --------------------------------------------------------------------------
    #                                                    Initial File Inspection
    # --------------------------------------------------------------------------
    # Retreive just the 1st row of data, to get the column names, and the 
    # timestamp of the first measurement
    df <- read.csv(dataFile, sep=";", nrows=1)
    df.names <- names(df)
    firstMeasurement <- strptime(with(df, paste(Date, Time)), 
                                 format="%d/%m/%Y %H:%M:%S")
    
    # --------------------------------------------------------------------------
    #                                           Calculate Relevant Lines Numbers
    # --------------------------------------------------------------------------
    # Calculation is based on the number of minutes that have elapsed since the 
    # first measurement
    firstLineOfData = 2     # Line 2, because line 1 in the text file is column 
    # names, not data
    firstLine = as.integer(difftime(startDate, firstMeasurement, 
                                    units = "mins") + firstLineOfData)
    last_line = as.integer(difftime(endDate, startDate, 
                                    units = "mins") + firstLine)
    df.numrows <- last_line + 1 - firstLine
    
    # --------------------------------------------------------------------------
    #                                          Read The Relevant Lines From File
    # --------------------------------------------------------------------------
    message("Reading subset of lines from : ", datafile)
    message("First Line: ", firstLine)
    message("First Line: ", last_line)
    message("Number of rows: ", df.numrows)
    
    df <- read.table(dataFile, sep=";", na.strings="?",
                     col.names=df.names, colClasses=colClasses, 
                     skip=firstLine-1, nrows=df.numrows)
    
    # --------------------------------------------------------------------------
    #                                          Tidy up, and return the dataframe
    # --------------------------------------------------------------------------
    # Create a timestamp column
    df$Timestamp = strptime(with(df, paste(Date, Time)), format="%d/%m/%Y %H:%M:%S")
    return(df)
}
