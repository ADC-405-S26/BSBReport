
test_that("Pitch_Plot assertions find invalid input types for data and PlayerId",{
  good_data <- data.frame(
    TaggedPitchType = c("Fastball", "Curveball"),
    PitcherId = c(1122334455, 2233445566),
    RelSpeed = c(88.23, 80.35),
    InducedVertBreak = c(15.25, -6.44),
    HorzBreak = c(12.87, -3.45))

  # Data - Strings and Ints
  expect_error(Pitch_Plot("trackman_data"), "Assertion on 'data' failed")
  expect_error(Pitch_Plot(1234567890), "Assertion on 'data' failed")
  # PlayerId - Strings + length issues
  expect_error(Pitch_Plot(good_data, PlayerId = "trackman_data"), "Assertion on 'PlayerId' failed")
  expect_error(Pitch_Plot(good_data, PlayerId = 11223344556), "Assertion on 'PlayerId' failed")
  expect_error(Pitch_Plot(good_data, PlayerId = 112233445), "Assertion on 'PlayerId' failed")})


test_that("Pitch_Plot optional PlayerId parameter filters correctly",{
  good_data <- data.frame(
    TaggedPitchType = c("Fastball", "Curveball", "Fastball"),
    PitcherId = c(1122334455, 2233445566, 1122334455),
    RelSpeed = c(88.23, 80.35, 88.73),
    InducedVertBreak = c(15.25, -6.44, 14.56),
    HorzBreak = c(12.87, -3.45, 11.65))

  # PlayerId = NULL - returns all rows in df
  No_player <- Pitch_Plot(good_data, PlayerId = NULL)
  expect_equal(nrow(No_player$plot$data), 3)
  # PlayerId filtering - returns filtered data with specified ID
  Selected_player <- Pitch_Plot(good_data, PlayerId = 1122334455)
  expect_equal(nrow(Selected_player$plot$data), 2)
  expect_true(all(Selected_player$PitcherId == 1122334455))})


test_that("Pitch_Plot output is correct and formatted",{
  good_data <- data.frame(
    TaggedPitchType = c("Fastball", "Curveball", "Fastball"),
    PitcherId = c(1122334455, 2233445566, 1122334455),
    RelSpeed = c(88.2334, 80.35234, 88.73345),
    InducedVertBreak = c(15.25, -6.44, 14.56),
    HorzBreak = c(12.87, -3.45, 11.65))

  table_and_plot <- Pitch_Plot(good_data)
  just_table <- table_and_plot$table
  just_plot <- table_and_plot$plot

  # table outputs correctly, converting to 2 digit integers
  expect_equal(just_table$Avg_Speed[just_table$TaggedPitchType == "Curveball"], 80.35)
  # plot outputs correctly, labelling axes and ensuring the plot is correct type
  expect_equal(just_plot$labels$x, "Horizontal Break")
  expect_equal(just_plot$labels$y, "Vertical Break")
  expect_equal(just_plot$labels$title, "Bullpen Analysis")
  expect_s3_class(just_plot, "ggplot")})




