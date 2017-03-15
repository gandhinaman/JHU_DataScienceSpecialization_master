pollutantmean <- function(directory, pollutant, id = 1:332) {
    ##  directory' is a character vector of length 1 indicating the location of the CSV files 
    ## 'pollutant' is a character vector of length 1 indicating the name of the pollutant for which we will calculate the 
    ##  mean; either " sulfate" or "nitrate" 
    ## 'id' is an integer vector indicating the monitor ID numbers to be used 
    
    ## Return the mean of in the ' id' vector the pollutant across all monitors list (ignoring NA values) 
    
    ##NOTE: Do not round the result! 
    
    old_dir = getwd()
    setwd(directory) 
    
    ## adding leading zeros to ensure that we have file names consistent with the data files
    files_id <- formatC(id, width = 3, format = "d", flag = "0")
    files_list <- paste0(files_id, ".csv")
    
    loaddf <- data.frame(Date=as.Date(character()),
                     sulfate=as.integer(character()), 
                     nitrate=as.integer(character()),
                     ID=character(),
                     stringsAsFactors=FALSE) 
    
    ## open the said files and store data in data frame
    for (i in seq_along(files_list)){
        df <- read.csv(files_list[i], header = TRUE, stringsAsFactors = FALSE, na.strings = c("", "NA", "-", "#N/A"))
        loaddf <- rbind(loaddf, df)
    }
    
    setwd(old_dir)
    if (pollutant == "sulfate") {meanval <- mean(loaddf$sulfate, na.rm = TRUE)
        } else {meanval <- mean(loaddf$nitrate, na.rm = TRUE)}
    
    meanval
    }