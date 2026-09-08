test_that("app_outage_engagement_impact preserves pr_death_counts values exactly", {
  expect_equal(app_outage_engagement_impact$date, pr_death_counts$date)
  expect_equal(app_outage_engagement_impact$daily_active_users, pr_death_counts$deaths)
  expect_named(app_outage_engagement_impact, c("date", "daily_active_users"))
})
