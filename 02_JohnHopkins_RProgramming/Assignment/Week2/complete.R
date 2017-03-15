complete <- function(directory, id = 1:332) {
    ##  directory' is a character vector of length 1 indicating the location of the CSV files 
    ## 'id' is an integer vector indicating the monitor ID numbers to be used 
    
    ##Return a data frame of the form: 
    ##     id nobs 
    ##      1 117 
    ##      2 1041 
    ## where ' id' is the monitor ID number and ' nobs ' is the number of complete cases 
  
    old_dir = getwd()
    setwd(directory) 
    
    ## adding leading zeros to ensure that we have file names consistent with the data files
    
    files_id <- formatC(id, width = 3, format = "d", flag = "0")
    files_list <- paste0(files_id, ".csv")

    id_len <- length(id)
    complete_data <- rep(0, id_len)
    j <- 1 
    
    for (i in seq_along(files_list)){
        df <- read.csv(files_list[i], header = TRUE, stringsAsFactors = FALSE, na.strings = c("", "NA", "-", "#N/A"))
        complete_data[j] <- sum(complete.cases(df))
        j <- j + 1
    }
    
    result <- data.frame(id = id, nobs = complete_data)
    setwd(old_dir)
    return(result)
    
}