#' Generating Pitch Movement Plot and Summary Table
#'
#' @param data Trackman data with standard naming
#' @param PlayerId Optional: Unique integer for identifying specific pitcher / player
#'
#' @returns A summary table with session averages and advanced stats like VAA, as well as a pitch movement plot
#' @importFrom dplyr group_by summarise n
#' @importFrom knitr kable
#' @importFrom ggplot2 ggplot aes geom_point geom_hline geom_vline labs theme_classic guides
#' @export
#'
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' library(knitr)
#' #mini sample trackman dataset
#' demo_trackman_data <- data.frame(
#'   TaggedPitchType = c("Fastball", "Curveball"),
#'   PitcherId = c(1122334455, 2233445566),
#'   RelSpeed = c(88.23, 80.35),
#'   InducedVertBreak = c(15.25, -6.44),
#'   HorzBreak = c(12.87, -3.45))
#'
#'  Pitch_Plot(demo_trackman_data)
Pitch_Plot <- function(data, PlayerId = NULL){
  checkmate::assert_data_frame(data, min.rows = 2, min.cols = 5, col.names = "named")

  checkmate::assert_names(colnames(data), must.include =
                            c("TaggedPitchType", "PitcherId", "RelSpeed", "InducedVertBreak", "HorzBreak"))

  if(!is.null(PlayerId)) {data <- dplyr::filter(data, .data$PitcherId == PlayerId)}

  grouped_data <- dplyr::group_by(data, .data$TaggedPitchType)

  Pitch_Analysis_Table <- dplyr::summarise(grouped_data,
                    Pitch_Count = dplyr::n(),
                    Avg_Speed = mean(.data$RelSpeed, na.rm = TRUE),
                    Avg_Vertical_Break = mean(.data$InducedVertBreak, na.rm = TRUE),
                    Avg_Horizontal_Break = mean(.data$HorzBreak, na.rm = TRUE))

  print(knitr::kable(Pitch_Analysis_Table, digits = 2, "simple"))

  move_graph <- ggplot2::ggplot(
    data, ggplot2::aes(x = .data$HorzBreak, y = .data$InducedVertBreak, color = .data$TaggedPitchType)) +
    ggplot2::geom_point(ggplot2::aes(shape = factor(.data$TaggedPitchType)), alpha = 0.7, size = 1.5) +
    ggplot2::geom_hline(yintercept = 0, alpha = 0.8, color = "darkblue") +
    ggplot2::geom_vline(xintercept  = 0, alpha = 0.8, color = "darkblue") +
    ggplot2::labs(title = "Bullpen Analysis",
                 x = "Horizontal Break",
                 y = "Vertical Break",
                 color = "Pitch Type") +
    ggplot2::guides(shape = "none") +
    ggplot2::theme_classic()

  return(move_graph)}
