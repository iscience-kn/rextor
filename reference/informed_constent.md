# Informed Consent Filter

One of the best practices in data collection is including and informed
consent question. With this function you can automatically filter out
rows where participants did not explicitly consent to their data being
used.

## Usage

``` r
informed_constent(dataframe, varname = "informedconsent")
```

## Arguments

- dataframe:

  A dataframe of data collected with WEXTOR

- varname:

  character. Variable name of informed consent variable. Defaults to
  "informedconsent".

## Value

Returns data with cases filtered out that did not check the informed
constent box
