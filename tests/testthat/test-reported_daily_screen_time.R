test_that("reported_daily_screen_time is outlier_example scaled", {
  expect_equal(reported_daily_screen_time,
               K$reported_daily_screen_time[["value"]] * outlier_example)
})
