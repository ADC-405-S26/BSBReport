test_that("Master_Summary assertions find invalid input types for data and PlayerId",{
  good_data <- data.frame(
    TaggedPitchType = c("Fastball", "Curveball"),
    PitcherId = c(1122334455, 2233445566),
    RelSpeed = c(88.23, 80.35),
    InducedVertBreak = c(15.25, -6.44),
    HorzBreak = c(12.87, -3.45),
    PlateLocHeight = c(1.73, 2.14),
    PlateLocSide = c(0.84, 0.92))
  # Data - strings and integer values
  expect_error(Master_Summary("trackman_data"), "Assertion on 'data' failed")
  expect_error(Master_Summary(1234567890), "Assertion on 'data' failed")
  # PlayerId - strings and length issues
  expect_error(Master_Summary(good_data, PlayerId = "trackman_data"), "Assertion on 'PlayerId' failed")
  expect_error(Master_Summary(good_data, PlayerId = 11223344556), "Assertion on 'PlayerId' failed")
  expect_error(Master_Summary(good_data, PlayerId = 112233445), "Assertion on 'PlayerId' failed")})

test_that("Master_Summary optional PlayerId parameter filters correctly",{
  good_data <- data.frame(
    TaggedPitchType = c("Fastball", "Curveball", "Fastball"),
    PitcherId = c(1122334455, 2233445566, 1122334455),
    RelSpeed = c(88.23, 80.35, 88.73),
    InducedVertBreak = c(15.25, -6.44, 14.56),
    HorzBreak = c(12.87, -3.45, 11.65),
    PlateLocHeight = c(1.63, 2.14, 1.31),
    PlateLocSide = c(0.84, 0.97, 0.99))

  # PlayerId = NULL - returns all rows in df
  No_player <- Master_Summary(good_data, PlayerId = NULL)
  expect_equal(sum(No_player$Pitch_Count), 3)
  # PlayerId filtering - reduces rows to contain specified ID's data
  Selected_player <- Master_Summary(good_data, PlayerId = 1122334455)
  expect_equal(sum(Selected_player$Pitch_Count), 2)})

test_that("Master_Summary Strike calulation output verification",{
  good_data <- data.frame(TaggedPitchType = c("Fastball", "Curveball", "Fastball"),
                          PitcherId = c(1122334455, 2233445566, 1122334455),
                          RelSpeed = c(88.23, 80.35, 88.73),
                          InducedVertBreak = c(15.25, -6.44, 14.56),
                          HorzBreak = c(12.87, -3.45, 11.65),
                          PlateLocHeight = c(1.63, 2.14, 1.31),
                          PlateLocSide = c(0.84, 0.97, 0.99))
  # mock data has 2 fastballs within strike zone (-1.5 to 3.5 height, -0.95 to 0.95 width) for a 50% strike percentage
  two_fb_strikes <- Master_Summary(good_data)
  expect_equal(two_fb_strikes$Strike_Percentage[two_fb_strikes$TaggedPitchType == "Fastball"], 50)
})
