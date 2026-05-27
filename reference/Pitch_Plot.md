# Generating Pitch Movement Plot and Summary Table

Generating Pitch Movement Plot and Summary Table

## Usage

``` r
Pitch_Plot(data, PlayerId = NULL)
```

## Arguments

- data:

  Trackman data with standard naming

- PlayerId:

  Optional: Unique integer for identifying specific pitcher / player

## Value

A summary table with session averages and advanced stats like VAA, as
well as a pitch movement plot

## Examples

``` r
library(dplyr)
library(ggplot2)
library(knitr)
#mini sample trackman dataset
demo_trackman_data <- data.frame(
  TaggedPitchType = c("Fastball", "Curveball"),
  PitcherId = c(1122334455, 2233445566),
  RelSpeed = c(88.23, 80.35),
  InducedVertBreak = c(15.25, -6.44),
  HorzBreak = c(12.87, -3.45))

 Pitch_Plot(demo_trackman_data)
#> $plot

#> 
#> $table
#> # A tibble: 2 × 5
#>   TaggedPitchType Pitch_Count Avg_Speed Avg_Vertical_Break Avg_Horizontal_Break
#>   <chr>                 <int>     <dbl>              <dbl>                <dbl>
#> 1 Curveball                 1      80.4              -6.44                -3.45
#> 2 Fastball                  1      88.2              15.2                 12.9 
#> 
```
