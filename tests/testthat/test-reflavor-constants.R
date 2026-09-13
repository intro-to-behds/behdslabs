test_that("every reflavoring factor is finite and not 1", {
  ks <- unlist(behdslabs:::.reflavor_k, use.names = TRUE)
  expect_true(all(is.finite(ks)))
  expect_false(any(ks == 1),
               info = "a factor of 1 would leave a column identical to its dslabs original")
})

test_that(".reflavor_k covers exactly the expected set of scaled datasets", {
  expect_setequal(
    names(behdslabs:::.reflavor_k),
    c("app_data_breaches", "app_task_completion", "app_engagement_experiment",
      "cognitive_battery_scores", "reported_daily_screen_time",
      "tech_grant_funding_gender_gap", "screen_time_vs_smart_speaker_trend",
      "fitness_app_downloads_by_state", "global_tech_adoption",
      "app_outage_engagement_impact", "product_launch_forecast",
      "ui_redesign_surveys", "cognitive_task_metrics", "tech_adoption_trends",
      "connectivity_deep_history", "screentime_wellbeing_series")
  )
})
