#' Table Recapping all Relevant Location and Movement Metrics
#'
#' @param data Trackman data with standard naming
#' @param PlayerId Optional: Unique integer for identifying specific pitcher / player
#'
#' @returns A table with all metrics averaged and color-coded strike percentage calculations
#' @importFrom dplyr group_by n summarise arrange
#' @importFrom knitr kable
#' @importFrom kableExtra cell_spec spec_color kable_styling
#' @export
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' library(knitr)
#' library(kableExtra)
#' #mini sample trackman dataset
#' demo_trackman_data <- data.frame(
#'   TaggedPitchType = c("Fastball", "Curveball"),
#'   PitcherId = c(1122334455, 2233445566),
#'   RelSpeed = c(88.23, 80.35),
#'   InducedVertBreak = c(15.25, -6.44),
#'   HorzBreak = c(12.87, -3.45),
#'   PlateLocHeight = c(1.73, 2.14),
#'   PlateLocSide = c(0.84, 0.92))
#'  Master_Summary(demo_trackman_data)
Master_Summary <- function(data, PlayerId = NULL){
  checkmate::assert_data_frame(data, min.rows = 2, min.cols = 7,
                               col.names = "named")
  checkmate::assert_names(colnames(data), must.include =
                            c("TaggedPitchType", "PitcherId", "RelSpeed", "InducedVertBreak", "HorzBreak", "PlateLocHeight", "PlateLocSide"))

  if(!is.null(PlayerId)) {data <- dplyr::filter(data, .data$PitcherId == PlayerId)}

  data$Strike_or_not <- ifelse(data$PlateLocSide >= -.95 & data$PlateLocSide <= 0.95 &
                          data$PlateLocHeight >= 1.6 & data$PlateLocHeight <= 3.5, 1, 0)

  grouped_data <- dplyr::group_by(data, .data$TaggedPitchType)

  Master <- dplyr::summarise(grouped_data,
                             Pitch_Count = dplyr::n(),
                             Avg_Speed = mean(.data$RelSpeed, na.rm = TRUE),
                             Strike_Percentage = round(mean(.data$Strike_or_not, na.rm = TRUE) * 100, 1),
                             Avg_Vertical_Break = mean(.data$InducedVertBreak, na.rm = TRUE),
                             Avg_Horizontal_Break = mean(.data$HorzBreak, na.rm = TRUE),
                             Avg_Plate_Height = mean(.data$PlateLocHeight, na.rm = TRUE),
                             Avg_Plate_Side = mean(.data$PlateLocSide, na.rm = TRUE))

  Strike_table <- dplyr::arrange(Master, dplyr::desc(.data$Strike_Percentage))
  Strike_table$Strike_Percentage <- kableExtra::cell_spec(
    Strike_table$Strike_Percentage, format = "html", bold = TRUE, color = "lightgrey",
    background = kableExtra::spec_color(Strike_table$Strike_Percentage, alpha = 0.7, direction = 1, option = "A"))

  originial_table <- knitr::kable(Strike_table, format = "html",escape = FALSE, digits = 2)
  final_table <- kableExtra::kable_styling(originial_table)
  print(final_table)

  return(invisible(Master))}
