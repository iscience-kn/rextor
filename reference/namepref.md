# Add variable name prefix (with substitution)

This function strips the old prefix from the variable names of the
dataframe. It then adds the new prefix where the old one was and changes
the dataframe's names to the new ones.

## Usage

``` r
namepref(dataframe, pref_old, pref_new)
```

## Arguments

- dataframe:

  A dataframe

- pref_old:

  Old prefix character that some or all variables in the dataframe have

- pref_new:

  New prefix character to replace the old one

## Value

Returns dataframe with those variables renamed that start with the old
prefix.

## Examples

``` r
bla <- tibble::tibble(x_ar = 1:5, y_ar = 6:10)
blo <- namepref(bla, "x_", "z_")
names(bla)
#> [1] "x_ar" "y_ar"
names(blo)
#> [1] "z_ar" "y_ar"
```
