# Theme White on Black

This theme option is built to be used with a `ggplot2` plot. It offers
several options for a dark theme, i.e. dark background with light
writing.

## Usage

``` r
theme_wob(max_font_size = 14, contrast = "high")
```

## Arguments

- max_font_size:

  Maximum font size, used for the plot title (other font sizes are
  automatically adjusted accordingly).

- contrast:

  Character to indicate the choice of color palette depending on the
  desired contrast. Defaults to `"high"`. Should be one of
  `"max", "high", "medium", "low", "pink" or "rex"`.

## Value

Plot theme.

## Examples

``` r
# Load the data
data<-read_WEXTOR("https://raw.githubusercontent.com/iscience-kn/rextor/refs/heads/main/data/BiFiX_data_raw.csv")

# Create any plot
library(ggplot2)
ggplot(data, aes(age, color = gender, fill = gender)) + 
  geom_density(alpha = .5) + 
  theme_wob(contrast = "rex")
#> Warning: Removed 272 rows containing non-finite outside the scale range
#> (`stat_density()`).

```
