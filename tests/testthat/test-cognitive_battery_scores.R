test_that("cognitive_battery_scores preserves nyc_regents_scores values exactly", {
  expect_equal(cognitive_battery_scores$score, nyc_regents_scores$score)
  expect_equal(cognitive_battery_scores$attention_task, nyc_regents_scores$integrated_algebra)
  expect_equal(cognitive_battery_scores$memory_task, nyc_regents_scores$global_history)
  expect_equal(cognitive_battery_scores$usability_task, nyc_regents_scores$living_environment)
  expect_equal(cognitive_battery_scores$reading_task, nyc_regents_scores$english)
  expect_equal(cognitive_battery_scores$reasoning_task, nyc_regents_scores$us_history)
})
