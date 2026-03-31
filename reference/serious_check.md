# Filter data frame by seriousness check

Filter your data frame by your item for the "seriousness check". If the
data comes from WEXTOR with no previous changes to the automatically
created variable, you will be able to accept all defaults in this
function and simply input the data frame.

## Usage

``` r
serious_check(dataframe, varname = "seriousness", keep = "participate")
```

## Arguments

- dataframe:

  Data which contains a variable for the seriousness check.

- varname:

  Variable for the seriousness check. Defaults to `"seriousness"`.

- keep:

  Values from the variable to keep. Defaults to `"participate"`

## Value

Filtered data

## Examples

``` r
# See vignette walkthrough
```
