#' Remove WEXTOR variable name prefixes (automatic)
#'
#' This function strips the old prefix from the server variable names of the dataframe.
#' It identifies such variables that start with ".wx.#." where # stands for any number, or simply ".wx." and then removes
#' these prefixes for more easily legible and usable variable names in your data!
#'
#' @param dataframe A dataframe, usefully containing variables that have the server prefix ".wx.#."
#'
#' @returns  Returns dataframe with those variables renamed that start with the old prefix.
#' @export
#'
#' @examples
#' bli <- tibble::tibble(.wx.1.ar = 1:5, y_ar = 6:10, .wx.z = 11:15)
#' blu <- removepref(bli)
#' names(bli)
#' names(blu)
#' 
removepref <- function(dataframe){
  value <- stripped <- new_names <- NULL
  
  pref_old <- ".wx.\\d+."
  
  # dataframe must be a dataframe
  namedf <- tibble::as_tibble(names(dataframe))  |>
    dplyr::mutate(stripped = ifelse(grepl(pref_old, value),
                                    substr(value, 7, nchar(value)),
                                    value), 
                  new_names = ifelse(startsWith(stripped, ".wx."),
                                     substr(stripped, 5, nchar(stripped)),
                                     stripped)
    )
  
  names(dataframe) <- namedf |> dplyr::pull(new_names)
  return(dataframe)
}
