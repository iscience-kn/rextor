# Read WEXTOR Data

With this function, you can easily read in your WEXTOR generated data.
By default, it will be exported as a "CSV" file, which stands for
"comma-separated values". R has many available options of reading in
this type of data, which can make it hard to navigate which one to use -
especially for beginners.

## Usage

``` r
read_WEXTOR(filepath, keep_validation = TRUE)
```

## Arguments

- filepath:

  Location of the WEXTOR CSV file on your computer.

- keep_validation:

  Should the validation variable from WEXTOR be kept? TRUE by default.

## Value

The WEXTOR data as an R data object.

## Details

In the `read_WEXTOR()` function, you just need to provide the
`filepath`, i.e. the location of the CSV data file that you downloaded
from WEXTOR. If you want, you can already decided whether to keep the
first column containing a so-called validation variable, but you don't
have to. With no other input, rextor will keep the variable for you. You
can explicitly set `keep_validation` to FALSE if you like your data neat
and do not need this extra measure. The usage is explained in the
examples down below using the open source BiFiX data with psychological
Big Five personality traits.

This function prepares the WEXTOR data so that it is readable by both R
and you as a human. It will give you your original data and also make
the start and end time of each participation easier to read and work
with later (by default, WEXTOR will return these values as date and time
separately, cluttering your dataset).

## Examples

``` r
data<-read_WEXTOR("https://raw.githubusercontent.com/iscience-kn/rextor/refs/heads/main/data/BiFiX_data_raw.csv")

# If you don't need the validation variable, try
data_noval<-read_WEXTOR("https://raw.githubusercontent.com/iscience-kn/rextor/refs/heads/main/data/BiFiX_data_raw.csv",
                          keep_validation = FALSE)
```
