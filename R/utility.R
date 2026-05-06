#' Get the mode of a vector or variable
#'
#' The mode is the number that appears the most often in a vector or variable.
#' This measure is especially important for nominal variables since the mean 
#' or median cannot meaningfully be reported.
#'
#' @param v a vector of variable in dataframe
#'
#' @return Returns the mode of v, i.e., the value occurring most often
#' @export
#'
#' @examples
#' 
#' vec <- c("A", "A", "B")
#' getmode(vec)
#' 
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

#' Get percentage of a value
#'
#' @param data A dataframe 
#' @param var A variable in the dataframe, written as a character in quotes, e.g. "var"
#' @param val A value of variable var of which to get the percentage, also in quotes
#'
#' @return Returns the percentage of value val in relation to all values of var
#' @export
#'
#' @examples
#'  getperc(data.frame(a = c("duck", "duck", "goose")),
#'   "a", 
#'   "duck")
#'  
#'  # Also works when val is indexed (alphabetically)
#'  getperc(data.frame(a = c("duck", "duck", "goose")),
#'   "a", 
#'   2)
#' 
getperc <- function(data, var, val){
  # data must be a dataframe, var must be a variable in this data fram. GOTCHA: var must be written in "" , e.g. "var".
  # Val must be a value in var
  
  n_data <- dim(data)[1]
  
  round(((table(data[var])/n_data)[[val]])*100, 2) # %>% round(2)
}

#' Get file path to `BiFiX_data_raw.csv` file
#'
#' This function makes the example data from the BiFiX study (submitted for publication in BRM) easy to access.
#'
#' @param path Name of file in quotes with extension;
#' `"BiFiX_data_raw.csv"` will work.
#' If `NULL`, the example file will be listed.
#' @export
#' @examples
#' path_to_file()
#' path_to_file("BiFiX_data_raw.csv")
#' head(read.csv(path_to_file("BiFiX_data_raw.csv")))
#' @source This function is adapted from `palmerpenguins` (which is adapted from `readxl::readxl_example()`).
path_to_file <- function(path = NULL) {
  if (is.null(path)) {
    dir(system.file("extdata", package = "rextor"))
  } else {
    system.file("extdata", path, package = "rextor", mustWork = TRUE)
  }
}


#' Check whether a plausibility condition is satisfied
#'
#' Returns a logical vector indicating whether a given check column equals `"ok"`.
#' If the column does not exist in the data, all cases are treated as passing.
#' 
#' Used inside the `plausicheck()` function.
#'
#' @param data A data frame containing plausibility check variables.
#' @param col A character string specifying the column name to check.
#'
#' @returns A logical vector of length `nrow(data)`.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' check_ok(my_data, "check_ip")

#' }
check_ok <- function(data, col) {
  if (col %in% names(data)) {
    data[[col]] == "ok"
  } else {
    rep(TRUE, nrow(data))
  }
}
