test_that("reported_screen_time has the expected structure", {
  expect_s3_class(reported_screen_time, "data.frame")
  expect_equal(nrow(reported_screen_time), 1095)
  expect_equal(names(reported_screen_time),
               c("time_stamp", "platform", "screen_time"))
  expect_type(reported_screen_time$screen_time, "character")
  expect_true(all(reported_screen_time$platform %in% c("iOS", "Android")))
})

test_that("reported_screen_time contains the messy formats the case study needs", {
  x <- reported_screen_time$screen_time
  # some values already parse as plausible minutes
  clean <- suppressWarnings(as.numeric(x))
  expect_true(sum(!is.na(clean) & clean >= 15 & clean <= 600) > 500)
  # some values use a feet'inches-style hours'minutes" shorthand
  expect_true(any(grepl("^[0-9]'\\d", x)))
  # some values use a digit-literal H.MM/H,MM typo
  expect_true(any(grepl("^[0-9][.,]\\d", x)))
  # some values are implausibly large bare numbers (seconds, not minutes)
  expect_true(sum(!is.na(clean) & clean > 600) > 50)
  # some values are implausibly small decimals (hours, not minutes)
  expect_true(any(!is.na(clean) & clean > 0 & clean < 1))
})
