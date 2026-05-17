# Plausibility check on WEXTOR study data

`plausicheck()` performs basic plausibility checks on a study dataset to
identify potentially invalid or suspicious participation. The function
can check whether participants visited a minimum number of pages,
whether the recorded session length appears plausible, and whether IP
addresses indicate duplicate participation.

## Usage

``` r
plausicheck(dataframe, min_pages, check_sess_length = TRUE, check_ip = TRUE)
```

## Arguments

- dataframe:

  A data frame containing the study data (needs to contain variables
  `page_trail` for the trail of webpages in the study & `session_length`
  for the overall time each participant spent on the study (if session
  length is to be checked) and `ip` for participants' IP addresses (if
  IP is to be checked)).

- min_pages:

  Numeric. The minimum number of pages a participant must have visited
  in the study for their participation to be considered plausible.

- check_sess_length:

  Logical. Should the session length plausibility check be performed?
  Defaults to `TRUE`.

- check_ip:

  Logical. Should the IP address plausibility check be performed?
  Defaults to `TRUE`.

## Value

A data frame with additional plausibility check variables. The final
variable `check_plausibility` indicates whether all selected checks were
passed (`"all ok"`) or whether the case should be excluded
(`"exclude"`). Keep in mind that researchers are advised to make sure
that the `"exclude"`-cases were correctly identified and are indeed of
poorer data quality to avoi unnecessary data loss.

## Details

If WEXTOR prefixes are detected in the variable names, they are removed
before the plausibility checks are applied.

## Examples

``` r

data <- read_WEXTOR(path_to_file("BiFiX_data_raw.csv"))
# The example data does not contain real IPs (data protection), so we will use simulate ones
data$ip <- sample(1:1000, nrow(data), replace = TRUE)

plausi_data <- plausicheck(dataframe = data,
  min_pages = 6,
  check_sess_length = TRUE,
  check_ip = TRUE)
```
