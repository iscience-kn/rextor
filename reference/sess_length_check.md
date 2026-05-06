# Session Length Check

This function takes a dataframe as input as well as the minimum number
of webpages in your web experiment or study, that a participant should
have seen in order to be considered a complete (or plausible)
participation. It flags the most extreme 10% of complete participations
in the data as very slow or very fast.

## Usage

``` r
sess_length_check(dataframe, min_pages = 6)
```

## Arguments

- dataframe:

  A dataframe containing WEXTOR data (needs to contain variables
  `page_trail` for the trail of webpages in the study and
  `session_length` for the overall time each participant spent on the
  study)

- min_pages:

  Numeric. The minimum number of pages a participant must have visited
  in the study for their participation to be considered plausible.
  Defaults to `6`.

## Value

A dataframe with added variables `sess_length_clean` for only completed
session lengths, otherwise NA and `check_sess_length` for a flag of the
most extreme 10% of time needed to finish participation

## Examples

``` r

data <- read_WEXTOR(path_to_file("BiFiX_data_raw.csv"))
new_data <- sess_length_check(data)
```
