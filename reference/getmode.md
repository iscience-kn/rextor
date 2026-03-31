# Get the mode of a vector or variable

The mode is the number that appears the most often in a vector or
variable. This measure is especially important for nominal variables
since the mean or median cannot meaningfully be reported.

## Usage

``` r
getmode(v)
```

## Arguments

- v:

  a vector of variable in dataframe

## Value

Returns the mode of v, i.e., the value occurring most often

## Examples

``` r
vec <- c("A", "A", "B")
getmode(vec)
#> [1] "A"
```
