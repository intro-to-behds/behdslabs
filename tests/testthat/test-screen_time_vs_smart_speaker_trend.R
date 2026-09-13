test_that("screen_time_vs_smart_speaker_trend is divorce_margarine scaled", {
  k <- K$screen_time_vs_smart_speaker_trend
  expect_equal(
    screen_time_vs_smart_speaker_trend$avg_daily_screen_time_hours,
    k[["avg_daily_screen_time_hours"]] * divorce_margarine$divorce_rate_maine
  )
  expect_equal(
    screen_time_vs_smart_speaker_trend$smart_speaker_sales_index,
    k[["smart_speaker_sales_index"]] * divorce_margarine$margarine_consumption_per_capita
  )
  expect_equal(screen_time_vs_smart_speaker_trend$year, divorce_margarine$year)   # EXC
})
