# Remove WEXTOR variable name prefixes (automatic)

This function strips the old prefix from the server variable names of
the dataframe. It identifies such variables that start with ".wx.#."
where \# stands for any number, or simply ".wx." and then removes these
prefixes for more easily legible and usable variable names in your data!

## Usage

``` r
removepref(dataframe)
```

## Arguments

- dataframe:

  A dataframe, usefully containing variables that have the server prefix
  ".wx.#."

## Value

Returns dataframe with those variables renamed that start with the old
prefix.

## Examples

``` r
bli <- tibble::tibble(.wx.1.ar = 1:5, y_ar = 6:10, .wx.z = 11:15)
blu <- removepref(bli)
names(bli)
#> [1] ".wx.1.ar" "y_ar"     ".wx.z"   
names(blu)
#> [1] "ar"   "y_ar" "z"   
```
