#' Generating Pitch Movement Plot and Summary Table
#'
#' @param data Trackman data with standard naming
#'
#' @returns A summary table with session averages and advanced stats like VAA, as well as a pitch movement plot
#' @importFrom dplyr group_by summarise n
#' @importFrom knitr kable
#' @importFrom ggplot2 ggplot aes geom_point geom_hline geom_vline labs theme_classic guides
#' @export
#'
#' @examples
Pitch_Plot <- function(data){
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
  return(move_graph)
}
