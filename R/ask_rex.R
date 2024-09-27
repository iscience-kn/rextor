#' Ask Rex
#'
#' @description
#' This function lets you ask dino Rex for help. 
#' You can try to ask for specific functions and topics or just use the function as-is
#' for some motivational words of encouragement. :)
#' 
#' @param topic What you want to know about; either leave it blank for motivation or specify 'ttest', 'mean'... Input must be in quotes!
#'
#' @return Returns advice and explanations on R; sometimes Rex asks follow-up questions
#' 
#' @export
#'
#' @examples
#' # Get motivation
#' ask_rex()
#' 
#' # Get specific information
#' ask_rex("mean")
#' ask_rex(topic = "ttest")
#' 
ask_rex <- function(topic = "?"){
  
  if(topic %in% c("ttest", "tTest", "t-test")){
    ttype <- readline(prompt = "Please enter the number of the type of t-test you would like to know more about - (1) one-sample t-test,
(2) two-sample (independent) t-test or (3) paired (dependent) t-test.: ")
    
    reply <- switch (ttype,
      "1" = "t.test(x = variable, mu = fixed_mean) or check ?t.test for more help!",
      "2" = "t.test(means ~ group, var.equal = TRUE) or check ?t.test for more help!",
      "3" = "t.test(means ~ group, var.equal = TRUE, paired = TRUE) or check ?t.test for more help!",
      "Maybe ask something else?" # default
    )
    
  }
  else if (topic == "mean") {
    reply <- "mean(x) or if there are missing values in your data try mean(x, na.rm = TRUE)."
  } else if (topic %in% c("NA", "missing", "missings")){
    reply <- "is.na(x) returns TRUE where data is missing and FALSE where there is actual data."
  }
  else {
    reply <- sample(c("No worries, Rex got you!",
                      "Your'e doing great.",
                      "Trust the process!",
                      "Honestly, I don't know either.",
                      "You can ask Rex about 'ttest', 'mean' "), 1)
  }
  cat(reply)
}
