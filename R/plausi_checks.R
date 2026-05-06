#' Session Length Check
#' 
#' This function takes a dataframe as input as well as the minimum number of webpages in your web experiment or study,
#' that a participant should have seen in order to be considered a complete (or plausible) participation.
#' It flags the most extreme 10% of complete participations in the data as very slow or very fast.
#'
#' @param dataframe A dataframe containing WEXTOR data (needs to contain variables `page_trail` for the trail of 
#' webpages in the study and `session_length` for the overall time each participant spent on the study)
#' @param min_pages Numeric. The minimum number of pages a participant must have
#'   visited in the study for their participation to be considered plausible. Defaults to `6`.
#'
#' @returns A dataframe with added variables `sess_length_clean` for only completed session lengths, otherwise NA 
#'          and `check_sess_length` for a flag of the most extreme 10% of time needed to finish participation
#' @export
#' @importFrom stats quantile
#'
#' @examples
#' 
#' data <- read_WEXTOR(path_to_file("BiFiX_data_raw.csv"))
#' new_data <- sess_length_check(data)
#' 
sess_length_check <- function(dataframe, min_pages = 6){
  if(any(grepl(".wx.", names(dataframe)))){
    new <- removepref(dataframe)
  } else {
    new <- dataframe
  }
  
  new$true_trail <- strsplit(new$page_trail, " - ") |>  lengths()
  new$check_page <- ifelse(new$true_trail >= min_pages, "ok", "incomplete")

  new$sess_length_clean <- ifelse(new$check_page == "incomplete", NA, new$session_length)
  new$check_sess_length <- ifelse(new$sess_length_clean < quantile(new$sess_length_clean, 0.05, na.rm = T),
                                     "very fast",
                                     ifelse(new$sess_length_clean > quantile(new$sess_length_clean, 0.95, na.rm = T),
                                            "very slow",
                                            "ok")
                                    )
    
    return(new)
  # }

  # # old version
  # new2 <- dataframe |>
  #   dplyr::mutate(
  #     sess_length_clean = ifelse(check_page == "incomplete", NA, session_length)
  #   )
  # 
  # new2$check_sess_length <- ifelse(between(new2$sess_length_clean, 
  #                                          quantile(new2$sess_length_clean, 0.05, na.rm = T), 
  #                                          quantile(new2$sess_length_clean, 0.95, na.rm = T)),
  #                             "ok", "very slow or fast")
  #
  # return(new2)
}



#' Check for duplicate IP addresses in WEXTOR study data
#'
#' `ip_check()` identifies potential duplicate participations in a dataset
#' by checking for repeated IP addresses. Cases with duplicated IPs are
#' flagged as `"possible duplicate"`, while unique IPs are labeled `"ok"`.
#' Keep in mind that in some cases, duplicate IP addresses should not lead to exclusion,
#' for example when different participants (such as siblings or flatmates) plausibly
#' use the same device.
#'
#' If WEXTOR-style prefixes (i.e. `.wx.`) are detected in the variable names,
#' they are removed prior to performing the check.
#'
#' @param dataframe A data frame containing the study data. Must include a
#'   variable named `ip` representing participants' IP addresses.
#'
#' @returns A data frame with an additional column `check_ip`, indicating
#'   whether each case has a unique IP (`"ok"`) or is a potential duplicate
#'   (`"possible duplicate"`).
#'
#' @details The function uses `duplicated()` to flag repeated IP addresses.
#'   Only subsequent occurrences are marked as duplicates; the first instance
#'   of each IP is treated as valid.
#' @export
#'
#' @examples
#' data <- read_WEXTOR(path_to_file("BiFiX_data_raw.csv"))
#' # The example data does not contain real IPs (data protection), so we will use simulate ones
#' data$ip <- sample(1:1000, nrow(data), replace = TRUE)
#' 
#' new_data <- ip_check(data)
#' 
ip_check <- function(dataframe){

  if(any(grepl(".wx.", names(dataframe)))){
    new3 <- removepref(dataframe)
  } else {
    new3 <- dataframe
  }
  
  new3$check_ip <- ifelse(duplicated(new3$ip), "possible duplicate", "ok")
  return(new3)
}



#' Plausibility check on WEXTOR study data
#'
#' `plausicheck()` performs basic plausibility checks on a study dataset to
#' identify potentially invalid or suspicious participation. The function can
#' check whether participants visited a minimum number of pages, whether the
#' recorded session length appears plausible, and whether IP addresses indicate
#' duplicate participation.
#'
#' If WEXTOR prefixes are detected in the variable names, they are removed before
#' the plausibility checks are applied.
#'
#' @param dataframe A data frame containing the study data (needs to contain variables `page_trail` for the trail of 
#' webpages in the study & `session_length` for the overall time each participant spent on the study (if
#' session length is to be checked) and `ip` for participants' IP addresses (if IP is to be checked)).
#' @param min_pages Numeric. The minimum number of pages a participant must have
#'   visited  in the study for their participation to be considered plausible. Defaults to `6`.
#' @param check_sess_length Logical. Should the session length plausibility check
#'   be performed? Defaults to `TRUE`.
#' @param check_ip Logical. Should the IP address plausibility check be performed?
#'   Defaults to `TRUE`.
#'
#' @returns A data frame with additional plausibility check variables. The final
#'   variable `check_plausibility` indicates whether all selected checks were passed
#'   (`"all ok"`) or whether the case should be excluded (`"exclude"`). Keep in mind
#'   that researchers are advised to make sure that the `"exclude"`-cases were correctly 
#'   identified and are indeed of poorer data quality to avoi unnecessary data loss.
#' @export
#'
#' @examples
#' \dontrun{
#' plausicheck(my_data)
#'
#' plausicheck(
#'   dataframe = my_data,
#'   min_pages = 8,
#'   sess_length_check = TRUE,
#'   ip_check = FALSE
#' )
#' }
#' 
#' data <- read_WEXTOR(path_to_file("BiFiX_data_raw.csv"))
#' # The example data does not contain real IPs (data protection), so we will use simulate ones
#' data$ip <- sample(1:1000, nrow(data), replace = TRUE)
#' 
#' plausi_data <- plausicheck(data) # keeps all defaults i.e. runs all available checks
plausicheck <- function(dataframe,
                        min_pages = 6,
                        check_sess_length = TRUE,
                        check_ip = TRUE){
  # If no Plausicheck is selected, exit and select at least one
  if(!any(c(check_sess_length, check_ip))){
    cat("Please select at least one plausibility check to be performed! 
You can choose `sess_length_check` and `ip_check`.")
  } else{
    if(any(grepl(".wx.", names(dataframe)))){
      plausi <- removepref(dataframe)
    } else {
      plausi <- dataframe
    }
    
    if(is.null(min_pages)){
      cat("Please define the minimum number of pages that a participant of your study should have visited for a plausible participation.")
    } else if(check_sess_length){
      plausi <- sess_length_check(plausi)
    }
    
    if(check_ip){
      plausi <- ip_check(plausi)
    }
    
    # plausi$check_plausibility <- ifelse(
    #   case_when(exists("check_page", where=plausi) & plausi$check_page == "ok" ~ TRUE,
    #             !exists("check_page", where=plausi) ~ TRUE,
    #             exists("check_page", where=plausi) & plausi$check_page != "ok" ~ FALSE) 
    #   &
    #     case_when(exists("check_sess_length", where=plausi) & plausi$check_sess_length == "ok" ~ TRUE,
    #               !exists("check_sess_length", where=plausi) ~ TRUE,
    #               exists("check_sess_length", where=plausi) & plausi$check_sess_length != "ok" ~ FALSE) 
    #   &
    #     case_when(exists("check_ip", where=plausi) & plausi$check_ip == "ok" ~ TRUE,
    #               !exists("check_ip", where=plausi) ~ TRUE,
    #               exists("check_ip", where=plausi) & plausi$check_ip != "ok" ~ FALSE),
    #   # plausi$check_page == "ok" & plausi$check_sess_length == "ok" & plausi$check_ip == "ok",
    #                                     "all ok",
    #                                     "exclude")
    
    plausi$check_plausibility <- ifelse(check_ok(plausi, "check_page") &
                                          check_ok(plausi, "check_sess_length") &
                                          check_ok(plausi, "check_ip"),
                                        "all ok",
                                        "exclude"
                                        )
    
  return(plausi)
  }
}

