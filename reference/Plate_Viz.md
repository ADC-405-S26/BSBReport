# Pitch Location Plot

Pitch Location Plot

## Usage

``` r
Plate_Viz(data, PlayerId = NULL)
```

## Arguments

- data:

  Trackman data with standard naming

- PlayerId:

  Optional: Unique integer for identifying specific pitcher / player

## Value

a plot displaying pitch location within the strikezone to see command
and location

## Examples

``` r
#mini sample trackman dataset
library(dplyr)
library(ggplot2)
library(knitr)
demo_trackman_data <- data.frame(
  TaggedPitchType = c("Fastball", "Curveball"),
  PitcherId = c(1122334455, 2233445566),
  RelSpeed = c(88.23, 80.35),
  PlateLocHeight = c(1.73, 2.14),
  PlateLocSide = c(0.84, 0.92))

 Plate_Viz(demo_trackman_data)
#> $plot

#> 
#> $table
#> # A tibble: 2 × 5
#>   TaggedPitchType Pitch_Count Avg_Speed Avg_Plate_Height Avg_Plate_Side
#>   <chr>                 <int>     <dbl>            <dbl>          <dbl>
#> 1 Curveball                 1      80.4             2.14           0.92
#> 2 Fastball                  1      88.2             1.73           0.84
#> 
```
