# Definition of the scale_color_ipea function
#' Title
#'
#' @param pal 
#' @param direction 
#' @param aesthetic 
#' @param ... 
#'
#' @import ggplot2
#' @return
#' @export
#'
#' @examples
scale_color_cus <- function(pal =  "cute",
                            direction = 1,
                            aesthetic = "color",
                            # ,
                            # decimal.mark = ".",
                            # barheight = NULL, barwidth = NULL,
                            # title.hjust = NULL, label.hjust = NULL,
                            ...) {
  
  structure(list(pal = pal, direction = direction,
                 aesthetic = aesthetic,
                 # decimal.mark = decimal.mark, barheight = barheight, barwidth = barwidth,
                 # title.hjust = title.hjust, label.hjust = label.hjust,
                 ...), class = "scale_cus_color")
}

#' @export
#' @method ggplot_add scale_cus_color
# Definition of the ggplot_add.scale_ipea_color method
ggplot_add.scale_cus_color <- function(object, plot, object_name, ...){
  
  # Set arguments
  args <- object
  pal <- args$pal
  direction <- args$direction
  aesthetic <- args$aesthetic
  # decimal.mark <- args$decimal.mark
  # barheight <- args$barheight
  # barwidth <- args$barwidth
  # title.hjust <- args$title.hjust
  # label.hjust <- args$label.hjust
  
  # Set palette to 'ipea1' if it is not provided, otherwise use the provided value
  # palette <-  ifelse(missing(palette),'Blue',palette)
  
  # Define rextor custom color scales
  paletteses <- list(
    arby = c("#FF6347", "#FFD700", "#3CB371", "#4682B4", "#4B0082"), 
    cute = c("#BF7389", "#F2D0A9", "#F1E3D3", "#99C1B9", "#E87478")
  )
  
  # Reverse palette for direction = -1
  if(direction == 1){
    chosen_pal <- paletteses[[pal]]
  } else if (direction == -1){
    chosen_pal <- rev(paletteses[[pal]])
  } else {
    stop("Direction must be either 1 or -1 to reverse the palette.")
  }
  
  
  # if (decimal.mark == ",") {
  #   # Use comma as decimal mark and dot as thousand separator for labels (Brazilian Portuguese)
  #   labels = scales::label_comma(decimal.mark = ",", big.mark = ".")
  # } else if (decimal.mark == "."){
  #   # Use dot as decimal mark and comma as thousand separator for labels (default)
  #   labels = scales::label_comma(decimal.mark = ".", big.mark = ",")
  # } else {
  #   stop("Decimal.mark argument must be '.' or ','.")
  # }
  # 
  # # Set default arguments
  # label.hjust = ifelse(is.null(label.hjust),0.5,label.hjust)
  # title.hjust = ifelse(is.null(title.hjust),0.5,title.hjust)
  # 
  # if(is.null(barheight)){
  #   barheight = NULL
  # } else{
  #   barheight = unit(barheight, units = "mm")
  # }
  # 
  # if(is.null(barwidth)){
  #   barwidth = NULL
  # } else{
  #   barwidth = unit(barwidth, units = "mm")
  # }
  
  
  
  # Find the first layer with the defined 'color' aesthetic
  # If ggplot includes aesthetics within geom_* this will recognize the class of the argument based on what is inside it
  for (i in seq_along(plot$layers)) {
    if (aesthetic %in% names(plot$layers[[i]]$mapping)) {
      if(aesthetic == "color"){
        color_var <- plot$layers[[i]]$mapping$colour
      } else {
        color_var <- plot$layers[[i]]$mapping$fill
      }
      
      # plot$layers[[i]]$mapping$colour
      var_evaluated <- rlang::eval_tidy(color_var, plot$layers[[i]]$data)
      break
    } else {
      color_var <- NULL
    }
  }
  
  
  # If 'color_var' was not found in any layer, check in the base ggplot call
  if (is.null(color_var)) {
    # Depending on the selected aesthetic, color var is defined as color/
    if(aesthetic == "color"){
      color_var <- plot$mapping$colour
    } else {
      color_var <-  plot$mapping$fill
    }
    
    var_evaluated <- rlang::eval_tidy(color_var, plot$data)
  }

  # If 'color_var' is not yet found, returns error
  if (is.null(color_var)) {
    stop(paste0("No '", aesthetic, "' color defined, please define '", aesthetic,  "' in your plot aesthetics."))
    # return(plot) # could also just return the plot naked...?
  }
  
  # Evaluates whether the variable is numeric and continuous
  # Discrete:
  if(!is.numeric(var_evaluated) | unique(var_evaluated) |> length() < 10){
    
    return(plot + 
             do.call("discrete_scale",
                     c(list(aesthetics = aesthetic, 
                            palette = function(n) {
                              return(chosen_pal[1:n])
                            } 
                            #      ),
                            # args))
                     )))
    )
    

  } else {
    
    # Define continuous scale
    return(plot + 
             do.call("continuous_scale", 
                     c(list(aesthetics = aesthetic,
                            palette = scales::gradient_n_pal(chosen_pal))
                       # , 
                       # args, 
                       # guide = "colourbar"
                     ))
    )
    
  }
  
  
}