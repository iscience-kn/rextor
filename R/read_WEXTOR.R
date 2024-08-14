#' Read WEXTOR Data
#' 
#' With this function, you can easily read in your WEXTOR generated data.
#' By default, it will be exported as a "CSV" file, which stands for "comma-separated values". 
#' R has many available options of reading in this type of data, which can make it hard to navigate which one to use - especially for beginners.
#' 
#' In the [read_WEXTOR()] function, you just need to provide the `filepath`, i.e. the location of the CSV data file 
#' that you downloaded from WEXTOR. 
#' If you want, you can already decided whether to keep the first column containing a so-called validation variable, but you don't have to.
#' With no other input, rextor will keep the variable for you. 
#' You can explicitly set `keep_validation` to FALSE if you like your data neat and do not need this extra measure.
#' The usage is explained in the examples down below using the open source BiFiX data with psychological Big Five personality traits.
#' 
#' This function prepares the WEXTOR data so that it is readable by both R and you as a human.
#' It will give you your original data and also make the start and end time of each participation easier to read and work with later 
#' (by default, WEXTOR will return these values as date and time separately, cluttering your dataset).
#'
#' @param filepath Location of the WEXTOR CSV file on your computer.
#' @param keep_validation Should the validation variable from WEXTOR be kept? TRUE by default.
#' 
#' @import dplyr
#' @import readr
#'
#' @return The WEXTOR data as an R data object.
#' @export
#'
#' @examples
#' 
#' data <- read_WEXTOR(""https://github.com/iscience-kn/BiFiX/raw/main/data/BiFiX_data.csv")
#' 
#' # If you don't need the validation variable, try
#' data_noval <- read_WEXTOR("https://github.com/iscience-kn/BiFiX/raw/main/data/BiFiX_data.csv",
#'                           keep_validation = FALSE)
#' 
read_WEXTOR <- function(filepath, 
                        keep_validation = TRUE){
  # library(readr)
  
  col_type_val <- if (keep_validation == TRUE) {
    col_logical()
  } else {
    col_skip()
  }
  
  # Resolve global variable issue
  .wx.4.start_time <- .wx.5.start_date <- .wx.6.end_time <- .wx.7.end_date <- NULL
  
  raw <- readr::read_delim(filepath, # filepath
                    delim = ";", trim_ws = TRUE,
                    col_types = cols(`$validation_var` = col_type_val,
                                     .wx.5.start_date = col_date(format = "%m/%d/%y"),
                                     .wx.7.end_date = col_date(format = "%m/%d/%y") # Dates should be brought into the right format
                                     )
                    ) |> 
    suppressMessages() # suppresses the "New names..." message which is not necessary
 
  
  prepped_data <- raw[, 1:(dim(raw)[2]-1)] |>  # skips the last col because it's empty
    dplyr::mutate(start_time = as.POSIXct(paste(.wx.5.start_date, .wx.4.start_time), format = "%Y-%m-%d %H:%M:%S"),
           end_time = as.POSIXct(paste(.wx.7.end_date, .wx.6.end_time), format = "%Y-%m-%d %H:%M:%S")) |>  # format date + time
    dplyr::select(-.wx.4.start_time, -.wx.5.start_date, -.wx.6.end_time, -.wx.7.end_date)
  
  return(prepped_data)
}
