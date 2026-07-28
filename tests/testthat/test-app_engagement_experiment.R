test_that("app_engagement_experiment preserves mice_weights values exactly", {
  expect_equal(app_engagement_experiment$engagement_score, mice_weights$body_weight)
  expect_equal(app_engagement_experiment$consistency_index, mice_weights$bone_density)
  expect_equal(app_engagement_experiment$error_rate_pct, mice_weights$percent_fat)
  expect_equal(app_engagement_experiment$sex, mice_weights$sex)
  expect_equal(app_engagement_experiment$cohort, mice_weights$gen)
  expect_equal(app_engagement_experiment$test_batch, mice_weights$litter)
  expect_equal(
    as.character(app_engagement_experiment$ui_version),
    ifelse(mice_weights$diet == "chow", "standard", "redesigned")
  )
})
