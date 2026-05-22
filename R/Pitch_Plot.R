#' Generating Pitch Movement Plot and Summary Table
#'
#' @param data Trackman data with standard naming
#'
#' @returns A summary table with session averages and advanced stats like VAA, as well as a pitch movement plot
#' @importFrom dplyr group_by summarise n
#' @importFrom knitr kable
#' @importFrom ggplot2 ggplot aes geom_point geom_hline geom_vline labs theme_classic
#' @export
#'
#' @examples
mvmnt_plot <- function(data){
 Pitch_Analysis_Table <- data %>%
   dplyr::group_by(TaggedPitchType) %>%
   dpylr::summarise(Pitch_Count = dpylr::n(),
                    Avg_Speed = avg(RelSpeed, na.rm = TRUE),
                    Avg_V_Break = avg(InducedVertBreak, na.rm = TRUE),
                    Avg_H_Break = avg(HorzBreak, na.rm = TRUE),
                    Avg_VAA = avg(VertApprAngle, na.rm = TRUE))

  print(knitr::kable(Pitch_Analysis_Table, digits = 2, "simple"))

  move_graph <- ggplot2::ggplot(
    data, ggplot2::aes(x = HorzBreak, y = InducedVertBreak, color = TaggedPitchType)) +
    ggplot2::geom_point(aes(shape = factor(TaggedPitchType)), alpha = 0.7, size = 1.5) +
    ggplot2::geom_hline(yintercept = 0, alpha = 0.8, color = "darkblue") +
    ggplot2::geomvline(xintercept  = 0, alpha = 0.8, color = "darkblue") +
    ggplot2::labs(title = "Bullpen Analysis",
                 x = "Horizontal Break",
                 y = "Vertical Break") +
    ggplot2::theme_classic()
  return(move_graph)
}
