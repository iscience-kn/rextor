

page_check <- function(dataframe, min_pages = 6){

  new <- dataframe |> 
    dplyr::rowwise() |>
    dplyr::mutate(true_trail = list(strsplit(page_trail, " - ") |>  unlist()  |>  unique())[[1]]  |>  length(), # this gives the true page trail
                  check_page = ifelse(true_trail >= min_pages, "ok", "incomplete")
                  )  
    
  new
    # dplyr::mutate(page_check = ifelse(pages_visited >= min_pages, "ok", "incomplete")
    # )
}


# IDEA: amybe create all seperate functionms and then have one big one calling all of them so you can do it seperately or in one go
# probably all of them should create their own plausifilter variables and then have one big plausi var at the end
# 

sess_length_check <- function(dataframe){
  
  new2 <- dataframe |>
    dplyr::mutate(
      sess_length_clean = ifelse(check_page == "incomplete", NA, session_length)
    )
  
  new2$check_sess_length <- ifelse(between(new2$sess_length_clean, quantile(new2$sess_length_clean, 0.05, na.rm = T), quantile(new2$sess_length_clean, 0.95, na.rm = T)),
                              "ok", "very slow or fast")
  
  new2
}



ip_check <- function(dataframe){
  
  new3 <- new2
  new3$check_ip <- ifelse(duplicated(new3$ip), "possible duplicate", "ok")
  new3
}

similarity_check <- function(dataframe){
  matrix <- dataframe
  matrix <- new3 |> dplyr::select(dplyr::starts_with("big_")) |> as.matrix()

}

# 
# matrix2 <- matrix
# matrix2$sd <- apply(matrix2, 1, sd, na.rm = TRUE)
# 
# library(Matrix)
# 
# data_sparse <- as(t(matrix), "sparseMatrix") |> as.matrix()
# cor_matrix <- cor(data_sparse, use = "pairwise.complete.obs")
# 
# ?adist
