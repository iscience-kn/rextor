# Check for duplicate IP addresses in WEXTOR study data

`ip_check()` identifies potential duplicate participations in a dataset
by checking for repeated IP addresses. Cases with duplicated IPs are
flagged as `"possible duplicate"`, while unique IPs are labeled `"ok"`.
Keep in mind that in some cases, duplicate IP addresses should not lead
to exclusion, for example when different participants (such as siblings
or flatmates) plausibly use the same device.

## Usage

``` r
ip_check(dataframe)
```

## Arguments

- dataframe:

  A data frame containing the study data. Must include a variable named
  `ip` representing participants' IP addresses.

## Value

A data frame with an additional column `check_ip`, indicating whether
each case has a unique IP (`"ok"`) or is a potential duplicate
(`"possible duplicate"`).

## Details

If WEXTOR-style prefixes (i.e. `.wx.`) are detected in the variable
names, they are removed prior to performing the check.

The function uses
[`duplicated()`](https://rdrr.io/r/base/duplicated.html) to flag
repeated IP addresses. Only subsequent occurrences are marked as
duplicates; the first instance of each IP is treated as valid.

## Examples

``` r
data <- read_WEXTOR(path_to_file("BiFiX_data_raw.csv"))
# The example data does not contain real IPs (data protection), so we will use simulate ones
data$ip <- sample(1:1000, nrow(data), replace = TRUE)

new_data <- ip_check(data)
```
