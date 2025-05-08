#' Informed Consent Filter
#' 
#' 
#' One of the best practices in data collection is including and informed consent question.
#' With this function you can automatically filter out rows where participants did not explicitly consent to their data being used.
#'
#' @param dataframe A dataframe of data collected with WEXTOR
#' @param varname character. Variable name of informed consent variable. Defaults to "informedconsent".
#'
#' @returns Returns data with cases filtered out that did not check the informed constent box
#' @export
#'
informed_constent <- function(dataframe, varname = "informedconsent"){
  
  new <- dataframe[dataframe[varname] == "checked", ] |> na.omit()
  new
}