#' Coloring Scale for Data Visualization
#' 
#' This scale is very versatile and powerful. It offers several color palettes to choose from and automatically recognizes whether to use
#' a discrete or continuous scale depending on the data type of the mapping object.
#' It can also be used for both `color` and `fill` aesthetics by defining `aesthetic` accordingly directly inside the function!
#'
#' @param pal Color palette. Use either numbers from 1 to X or one of the names: `'arby'`, `'cute'`...
#' @param direction Direction of the color palette. Keep blank or use 1 for the default direction or use -1 to reverse the colors.
#' @param aesthetic Which aesthetic to use the scale on; either `color` or `fill`, defaults to `color`.
#' @param ... Other common scale parameters.
#'
#' @import ggplot2
#' @return `ggplot` plot object
#' 
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Species, Petal.Width, color = Petal.Width)) + 
#' geom_jitter() + 
#' theme_wob() + 
#' scale_rextor()
#' 
#' data <- data.frame(Time = rep(c("Time 1", "Time 2", "Time 3", "Time 4", "Time 5", "Time 6", "Time 7", "Time 8"), each = 2),
#' cont = 1:16,
#' Value = c(8, 5, 10, 3, 8, 5, 10, 3,  8, 5, 10, 3,  8, 5, 10, 3))
#' 
#' ggplot(data, aes(x = Time, y = Value, color = Time, fill = Time)) +
#'   geom_boxplot(alpha = 0.95) +
#'     theme_wob() +
#'     scale_rextor(pal = "neon") +
#'     scale_rextor(pal = "neon", aesthetic = "fill")
#'     
#' ggplot(data, aes(x = cont, y = Value, color = cont, fill = cont)) +
#'   geom_jitter(alpha = 0.8, size = 8) +
#'   theme_minimal() +
#'   scale_rextor(pal = "wextor") +
#'   scale_rextor(pal = "wextor", aesthetic = "fill")
#' 
scale_rextor <- function(pal =  "cute",
                            direction = 1,
                            aesthetic = "color",
                            ...) {
  
  structure(list(pal = pal, direction = direction,
                 aesthetic = aesthetic,
                 ...), class = "dino_scale")
}

#' @export
#' @method ggplot_add dino_scale
# Definition of the ggplot_add.dino_scale method
ggplot_add.dino_scale <- function(object, plot, object_name, ...){
  
  # Set arguments
  args <- object
  pal <- args$pal
  direction <- args$direction
  aesthetic <- ifelse(args$aesthetic == "fill", "fill", "colour")

  # Define rextor custom color scales
  paletteses <- list(
    arby = c("#FC4A2B", "#FE9116", "#FFD700", "#3CB371", "#4682B4", "#5F3BA5", "#4B0082"), 
    cute = c("#BF7389", "#F2D0A9", "#D79B86", "#99C1B9", "#E87478"),
    wextor = c("#326699", "#53D8FB", "#66C3FF", "#254CA7", "#B79FAD", "#B3424F", "#901137", "#7F0000"), 
    dualtone = c("#870058",  "#E65F5C", "#c8d6af", "#104547","#c97f54", "#ed1c24"),
    colorful = c("#750400", "#f7ad00", "#58015e", "#0006b8", "#00d9ce", "#16ab31", "#eb6eb7", "#d16c00"), 
    protanomaly = c("#6E2c4d", "#cd8b5c", "#ccae88", "#cad1b3", "#193346", "#c66123"), 
    forest = c("#6C464F", "#475B52", "#226F54", "#87C38F","#656839", "#F4F0BB", "#9C8D6D", "#43291F"), 
    hadestown = c("#d26c01", "#cfa362", "#991400", "#fd3122", "#C1B397", "#654F3C", "#85604D", "#dbc191"), 
    neon = c("#FFBB00", "#98CE00", "#16E0BD", "#0006b8", "#8B08A0",  "#D11150", "#F72C25", "#FF7100")
  )
  
  # Reverse palette for direction = -1
  if(direction == 1){
    chosen_pal <- paletteses[[pal]]
  } else if (direction == -1){
    chosen_pal <- rev(paletteses[[pal]])
  } else {
    stop("Direction must be either 1 or -1 to reverse the palette.")
  }
  
  # Find the first layer with the defined 'color' aesthetic
  # If ggplot includes aesthetics within geom_* this will recognize the class of the argument based on what is inside it
  for (i in seq_along(plot$layers)) {
    if (aesthetic %in% names(plot$layers[[i]]$mapping)) {
      if(aesthetic %in% "colour"){
        color_var <- plot$layers[[i]]$mapping$colour
      } else {
        color_var <- plot$layers[[i]]$mapping$fill
      }
      
      # var_evaluated <- rlang::eval_tidy(color_var, plot$layers[[i]]$data)
      var_evaluated <- rlang::eval_tidy(color_var, plot$data)
      break
    } else {
      color_var <- NULL
    }
  }
  
  
  # If 'color_var' was not found in any layer, check in the base ggplot call
  if (is.null(color_var)) {
    # Depending on the selected aesthetic, color var is defined as color/
    if(aesthetic == "colour"){
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
    
    scale <- discrete_scale(
      aesthetics = object$aesthetic,
      palette = function(n) chosen_pal[1:n],
      ...
    )
    

  } else {
    
    # Define continuous scale
    scale <- ggplot2::continuous_scale(
      aesthetics = aesthetic,
      palette = scales::gradient_n_pal(chosen_pal),
      ...
    )

  }
  
  newplot <- plot + scale
  return(newplot)
  
  
}
