# Get file path to example data file

This function makes the example data from the BiFiX study (submitted for
publication in BRM) easy to access.

## Usage

``` r
path_to_file(path = NULL)
```

## Source

This function is adapted from `palmerpenguins` (which is adapted from
`readxl::readxl_example()`).

## Arguments

- path:

  Name of file in quotes with extension; `"BiFiX_data_raw.csv"` will
  work. If `NULL`, the example file will be listed.

## Value

Gives the path to the example file included in the package. Meant for
use in
[`read_WEXTOR()`](https://iscience-kn.github.io/rextor/reference/read_WEXTOR.md).

## Examples

``` r
path_to_file()
#> [1] "BiFiX_data_raw.csv"
path_to_file("BiFiX_data_raw.csv")
#> [1] "/home/runner/work/_temp/Library/rextor/extdata/BiFiX_data_raw.csv"
head(read.csv(path_to_file("BiFiX_data_raw.csv")))
#>                                                                                                                                           X.validation_var..wx.1.id..wx.3.experimental_condition..wx.4.start_time..wx.5.start_date..wx.6.end_time..wx.7.end_date..wx.8.session_length..wx.page_trail..wx.pages_visited..wx.user_agent.age.big_A10.big_A19.big_A24.big_A38.big_Ar11.big_Ar30.big_Ar37 ...
#> 1 NA;28759;NA;11:21:22;03/14/24;11:21:22;03/14/24;0;start.html;1;Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA
#> 2 NA;34173;NA;16:39:18;03/20/24;16:39:18;03/20/24;0;start.html;1;Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;fb;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA
#> 3 NA;76476;NA;17:09:59;03/20/24;17:09:59;03/20/24;0;start.html;1;Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;fb;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA
#> 4  NA;68763;NA;17:09:59;03/20/24;17:09:59;03/20/24;0;start.html;1;Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;x;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA
#> 5 NA;99946;NA;17:09:59;03/20/24;17:09:59;03/20/24;0;start.html;1;Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;ig;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA
#> 6                                NA;80979;NA;18:00:24;03/20/24;18:00:24;03/20/24;0;start.html;1;Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123.0;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;fb;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA;NA
```
