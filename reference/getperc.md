# Get percentage of a value

Get percentage of a value

## Usage

``` r
getperc(data, var, val)
```

## Arguments

- data:

  A dataframe

- var:

  A variable in the dataframe, written as a character in quotes, e.g.
  "var"

- val:

  A value of variable var of which to get the percentage, also in quotes

## Value

Returns the percentage of value val in relation to all values of var

## Examples

``` r
 getperc(data.frame(a = c("duck", "duck", "goose")),
  "a", 
  "duck")
#> [1] 66.67
 
 # Also works when val is indexed (alphabetically)
 getperc(data.frame(a = c("duck", "duck", "goose")),
  "a", 
  2)
#> [1] 33.33
```
