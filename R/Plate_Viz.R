#' Pitch Location Plot
#'
#' @param data Trackman data with standard naming
#' @param PlayerId Optional: Unique integer for identifying specific pitcher / player
#'
#' @returns a plot displaying pitch location within the strikezone to see command and location
#' @export
#' @importFrom dplyr group_by summarise n
#' @importFrom knitr kable
#' @importFrom ggplot2 ggplot aes geom_point labs guides geom_path theme_classic coord_equal
#'
#'
#' @examples
#' #mini sample trackman dataset
#' library(dplyr)
#' library(ggplot2)
#' library(knitr)
#' demo_trackman_data <- data.frame(
#'   TaggedPitchType = c("Fastball", "Curveball"),
#'   PitcherId = c(1122334455, 2233445566),
#'   RelSpeed = c(88.23, 80.35),
#'   PlateLocHeight = c(1.73, 2.14),
#'   PlateLocSide = c(0.84, 0.92))
#'
#'  Plate_Viz(demo_trackman_data)
Plate_Viz <- function(data, PlayerId = NULL){

  checkmate::assert_data_frame(data, min.rows = 2, min.cols = 5,col.names = "named")
  checkmate::assert_names(colnames(data), must.include =
                            c("TaggedPitchType", "PitcherId", "RelSpeed", "PlateLocHeight", "PlateLocSide"))

  if(!is.null(PlayerId)) {data <- dplyr::filter(data, .data$PitcherId == PlayerId)}

  grouped_data <- dplyr::group_by(data, .data$TaggedPitchType)

  Pitch_Execution_Table <- dplyr::summarise(grouped_data,
                                            Pitch_Count = dplyr::n(),
                                            Avg_Speed = mean(.data$RelSpeed, na.rm = TRUE),
                                            Avg_Plate_Height = mean(.data$PlateLocHeight, na.rm = TRUE),
                                            Avg_Plate_Side = mean(.data$PlateLocSide, na.rm = TRUE))

  print(knitr::kable(Pitch_Execution_Table, digits = 2, "simple"))


  x <- c(-.95,.95,.95,-.95,-.95)
  z <- c(1.6,1.6,3.5,3.5,1.6)
  sz <- data.frame(x,z)

  Plate_graph <- ggplot2::ggplot(data) +
    ggplot2::geom_path(data = sz, ggplot2::aes(x=.data$x, y=.data$z)) +
    ggplot2::coord_equal(xlim = c(-2.5, 2.5), ylim = c(0, 5)) +
    ggplot2::geom_point(data = data, ggplot2::aes(x = .data$PlateLocSide, y = .data$PlateLocHeight, color = .data$TaggedPitchType, )) +
    ggplot2::labs(title = "Pitch Execution Summary",
                  color = "Pitch Type",
                  x ="Feet from Homeplate",
                  y = "Feet above Homeplate") +
    ggplot2::guides(shape = "none") +
    ggplot2::theme_classic()

  return(Plate_graph)}
