# Add variable name prefix (without substitution)

This function adds the new prefix and changes the dataframe's names to
the new ones.

## Usage

``` r
namepref0(dataframe, pref_new)
```

## Arguments

- dataframe:

  A dataframe

- pref_new:

  New prefix character to add to all variable namess in the dataframe
  have

## Value

Returns dataframe with all variables renamed to start with the new
prefix.

## Examples

``` r
bla <- tibble::tibble(x_ar = 1:5, y_ar = 6:10)
blo <- namepref(bla, "var")
names(bla)
#> [1] "x_ar" "y_ar"
names(blo)
#> [1] "x_ar" "y_ar"
```
