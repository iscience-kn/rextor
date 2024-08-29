#' Theme White on Black
#' 
#' This theme option is built to be used with a `ggplot2` plot.
#' It offers several options for a dark theme, i.e. dark background with light writing.
#'
#' @param max_font_size Maximum font size, used for the plot title (other font sizes are automatically
#'  adjusted accordingly).
#' @param contrast Character to indicate the choice of color palette depending on the desired contrast. 
#' Defaults to `"high"`. Should be one of `"max", "high", "medium", "low", "pink" or "rex"`.
#'
#' @import ggplot2
#'
#' @return Plot theme.
#' @export
#'
#' @examples
#' # Load the data
#' data <- read_WEXTOR("https://github.com/iscience-kn/BiFiX/raw/main/data/BiFiX_data.csv")
#' 
#' # Create any plot
#' library(ggplot2)
#' ggplot(data, aes(age, color = gender, fill = gender)) + 
#'   geom_density(alpha = .5) + 
#'   theme_wob(contrast = "rex")
#' 
theme_wob <- function(max_font_size = 14,
                      contrast = "high"){
  library(ggplot2)
  
  dark <- switch(contrast,
                 "max" = "black",
                 "high" = "black",
                 "medium" = "#312D2A",
                 "low" = "#272D2D",
                 "pink" = "#210B2C",
                 "rex" = "#004000"
  )
  
  light <- switch(contrast,
                  "max" = "white",
                  "high" = "#FFF9E3",
                  "medium" = "#FAF3DD",
                  "low" = "#A1A6B4",
                  "pink" = "#FFCFCA",
                  "rex" = "#EAF2E3"
  )
  
  themewob <- theme(
    plot.background =  element_rect(fill = dark, color = dark),
    panel.background =  element_rect(fill = dark, color = dark),
    
    panel.grid = element_line(color = light),
    
    axis.text = element_text(color = light, size = max_font_size-4),
    axis.title = element_text(color = light, size = max_font_size-3),
    axis.line = element_line(color = light), 
    
    legend.background = element_rect(fill = dark),
    legend.text = element_text(color = light, size = max_font_size-4), 
    legend.title = element_text(color = light),
    
    plot.title = element_text(color = light, size = max_font_size),
    plot.subtitle = element_text(color = light, size = max_font_size-2),
    plot.caption = element_text(color = light, size = max_font_size-5)
    
  )
  
  return(themewob)
}
