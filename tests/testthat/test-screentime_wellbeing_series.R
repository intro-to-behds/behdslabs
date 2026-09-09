test_that("screentime_wellbeing_series preserves temp_carbon values exactly", {
  expect_equal(screentime_wellbeing_series$year, temp_carbon$year)
  expect_equal(screentime_wellbeing_series$wellbeing_anomaly, temp_carbon$temp_anomaly)
  expect_equal(screentime_wellbeing_series$mood_anomaly, temp_carbon$land_anomaly)
  expect_equal(screentime_wellbeing_series$sleep_anomaly, temp_carbon$ocean_anomaly)
  expect_equal(screentime_wellbeing_series$screen_time_index, temp_carbon$carbon_emissions)
})
