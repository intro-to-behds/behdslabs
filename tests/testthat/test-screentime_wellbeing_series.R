test_that("screentime_wellbeing_series is temp_carbon scaled by one shared factor", {
  k <- K$screentime_wellbeing_series
  expect_equal(screentime_wellbeing_series$year, temp_carbon$year)   # EXC
  expect_equal(screentime_wellbeing_series$wellbeing_anomaly,
               k[["wellbeing_anomaly"]] * temp_carbon$temp_anomaly)
  expect_equal(screentime_wellbeing_series$mood_anomaly,
               k[["mood_anomaly"]] * temp_carbon$land_anomaly)
  expect_equal(screentime_wellbeing_series$sleep_anomaly,
               k[["sleep_anomaly"]] * temp_carbon$ocean_anomaly)
  expect_equal(screentime_wellbeing_series$screen_time_index,
               k[["screen_time_index"]] * temp_carbon$carbon_emissions)
  expect_true(length(unique(k)) == 1L)   # co-plotted anomalies share one factor
})
