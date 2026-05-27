# Table Recapping all Relevant Location and Movement Metrics

Table Recapping all Relevant Location and Movement Metrics

## Usage

``` r
Master_Summary(data, PlayerId = NULL)
```

## Arguments

- data:

  Trackman data with standard naming

- PlayerId:

  Optional: Unique integer for identifying specific pitcher / player

## Value

A table with all metrics averaged and color-coded strike percentage
calculations

## Examples

``` r
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
library(ggplot2)
library(knitr)
library(kableExtra)
#> 
#> Attaching package: ‘kableExtra’
#> The following object is masked from ‘package:dplyr’:
#> 
#>     group_rows
#mini sample trackman dataset
demo_trackman_data <- data.frame(
  TaggedPitchType = c("Fastball", "Curveball"),
  PitcherId = c(1122334455, 2233445566),
  RelSpeed = c(88.23, 80.35),
  InducedVertBreak = c(15.25, -6.44),
  HorzBreak = c(12.87, -3.45),
  PlateLocHeight = c(1.73, 2.14),
  PlateLocSide = c(0.84, 0.92))

Master_Summary(demo_trackman_data)
#> <table class="table" style="margin-left: auto; margin-right: auto;">
#>  <thead>
#>   <tr>
#>    <th style="text-align:left;"> Pitch Type </th>
#>    <th style="text-align:right;"> Pitch Count </th>
#>    <th style="text-align:right;"> Velocity (mph) </th>
#>    <th style="text-align:left;"> Strike Percentage </th>
#>    <th style="text-align:right;"> Vertical Break (in) </th>
#>    <th style="text-align:right;"> Horizontal Break (in) </th>
#>    <th style="text-align:right;"> Location Height (ft) </th>
#>    <th style="text-align:right;"> Location Side (ft) </th>
#>   </tr>
#>  </thead>
#> <tbody>
#>   <tr>
#>    <td style="text-align:left;"> Curveball </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 80.35 </td>
#>    <td style="text-align:left;"> <span style=" font-weight: bold;    color: lightgrey !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: rgba(181, 54, 122, 179) !important;">100</span> </td>
#>    <td style="text-align:right;"> -6.44 </td>
#>    <td style="text-align:right;"> -3.45 </td>
#>    <td style="text-align:right;"> 2.14 </td>
#>    <td style="text-align:right;"> 0.92 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Fastball </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 88.23 </td>
#>    <td style="text-align:left;"> <span style=" font-weight: bold;    color: lightgrey !important;border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: rgba(181, 54, 122, 179) !important;">100</span> </td>
#>    <td style="text-align:right;"> 15.25 </td>
#>    <td style="text-align:right;"> 12.87 </td>
#>    <td style="text-align:right;"> 1.73 </td>
#>    <td style="text-align:right;"> 0.84 </td>
#>   </tr>
#> </tbody>
#> </table>
```
