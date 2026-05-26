test_that("Plate_Viz assertions find invalid input types for data and PlayerId",{
  good_data <- data.frame(
    TaggedPitchType = c("Fastball", "Curveball"),
    PitcherId = c(1122334455, 2233445566),
    RelSpeed = c(88.23, 80.35),
    PlateLocHeight = c(1.73, 2.14),
    PlateLocSide = c(0.84, 0.92))

  # Data- strings and integers
  expect_error(Plate_Viz("trackman_data"), "Assertion on 'data' failed")
  expect_error(Plate_Viz(1234567890), "Assertion on 'data' failed")

  # PlayerId - Strings and length issues
  expect_error(Plate_Viz(good_data, PlayerId = "trackman_data"), "Assertion on 'PlayerId' failed")
  expect_error(Plate_Viz(good_data, PlayerId = 11223344556), "Assertion on 'PlayerId' failed")
  expect_error(Plate_Viz(good_data, PlayerId = 112233445), "Assertion on 'PlayerId' failed")})

test_that("Plate_Viz optional PlayerId parameter filters correctly",{
  good_data <- data.frame(
    TaggedPitchType = c("Fastball", "Curveball", "Fastball"),
    PitcherId = c(1122334455, 2233445566, 1122334455),
    RelSpeed = c(88.23, 80.35, 88.73),
    PlateLocHeight = c(1.73, 2.14, 1.45),
    PlateLocSide = c(0.84, 0.92, 0.99))

  # PlayerId = NULL - returns all rows in df
  No_player <- Plate_Viz(good_data, PlayerId = NULL)
  expect_equal(nrow(No_player$plot$data), 3)
  # PlayerId filtering - returns filtered data with specified ID
  Selected_player <- Plate_Viz(good_data, PlayerId = 1122334455)
  expect_equal(nrow(Selected_player$plot$data), 2)
  expect_true(all(Selected_player$PitcherId == 1122334455))})


test_that("Plate_Viz output is correct and formatted",{
  good_data <- data.frame(
    TaggedPitchType = c("Fastball", "Curveball", "Fastball"),
    PitcherId = c(1122334455, 2233445566, 1122334455),
    RelSpeed = c(88.2334, 80.35234, 88.73345),
    PlateLocHeight = c(1.73, 2.14, 1.45),
    PlateLocSide = c(0.84, 0.92, 0.99))

  table_and_plot <- Plate_Viz(good_data)
  just_table <- table_and_plot$table
  just_plot <- table_and_plot$plot

  # table outputs correctly, converting to 2 digit integers
  expect_equal(just_table$Avg_Speed[just_table$TaggedPitchType == "Curveball"], 80.35)
  # plot outputs correctly, labelling axes and ensuring the plot is correct type
  expect_equal(just_plot$labels$x, "Feet from Homeplate")
  expect_equal(just_plot$labels$y, "Feet above Homeplate")
  expect_equal(just_plot$labels$title, "Pitch Execution Summary")
  expect_s3_class(just_plot, "ggplot")})

