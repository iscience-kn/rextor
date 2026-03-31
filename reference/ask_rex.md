# Ask Rex

This function lets you ask dino Rex for help. You can try to ask for
specific functions and topics or just use the function as-is for some
motivational words of encouragement. :)

## Usage

``` r
ask_rex(topic = "?")
```

## Arguments

- topic:

  What you want to know about; either leave it blank for motivation or
  specify 'ttest', 'mean'... Input must be in quotes!

## Value

Returns advice and explanations on R; sometimes Rex asks follow-up
questions

## Examples

``` r
# Get motivation
ask_rex()
#> You can ask Rex about 'ttest', 'mean' 

# Get specific information
ask_rex("mean")
#> mean(x) or if there are missing values in your data try mean(x, na.rm = TRUE).
ask_rex(topic = "ttest")
#> Please enter the number of the type of t-test you would like to know more about - (1) one-sample t-test,
#> (2) two-sample (independent) t-test or (3) paired (dependent) t-test.: 
#> Maybe ask something else?
```
