test_that("screen_time_vs_smart_speaker_trend preserves divorce_margarine values exactly", {
  expect_equal(
    screen_time_vs_smart_speaker_trend$avg_daily_screen_time_hours,
    divorce_margarine$divorce_rate_maine
  )
  expect_equal(
    screen_time_vs_smart_speaker_trend$smart_speaker_sales_index,
    divorce_margarine$margarine_consumption_per_capita
  )
  expect_equal(screen_time_vs_smart_speaker_trend$year, divorce_margarine$year)
})
