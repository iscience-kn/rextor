# Check whether a plausibility condition is satisfied

Returns a logical vector indicating whether a given check column equals
`"ok"`. If the column does not exist in the data, all cases are treated
as passing.

## Usage

``` r
check_ok(data, col)
```

## Arguments

- data:

  A data frame containing plausibility check variables.

- col:

  A character string specifying the column name to check.

## Value

A logical vector of length `nrow(data)`.

## Details

Used inside the
[`plausicheck()`](https://iscience-kn.github.io/rextor/reference/plausicheck.md)
function.

## Examples

``` r
if (FALSE) { # \dontrun{
check_ok(my_data, "check_ip")
} # }
```
