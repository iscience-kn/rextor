#' Filter data frame by seriousness check
#'
#' Filter your data frame by your item for the "seriousness check". 
#' If the data comes from WEXTOR with no previous changes to the automatically created variable,
#' you will be able to accept all defaults in this function and simply input the data frame.
#'
#' @param dataframe Data which contains a variable for the seriousness check.
#' @param varname Variable for the seriousness check. Defaults to `"seriousness"`.
#' @param keep Values from the variable to keep. Defaults to `"participate"`
#'
#' @return Filtered data
#' @export
#'
#' @examples
#' # See vignette walkthrough
#' 
serious_check <- function(dataframe, varname = "seriousness", keep = "participate"){
  new <- subset(dataframe, eval(parse(text = varname)) == keep)
  return(new)
}