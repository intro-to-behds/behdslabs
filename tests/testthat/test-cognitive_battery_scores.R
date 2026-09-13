test_that("cognitive_battery_scores: score kept (row key), 5 frequency cols scaled", {
  k <- K$cognitive_battery_scores
  expect_equal(cognitive_battery_scores$score, nyc_regents_scores$score)   # EXC: bin key
  expect_equal(cognitive_battery_scores$attention_task, round(k[["attention_task"]] * nyc_regents_scores$integrated_algebra))
  expect_equal(cognitive_battery_scores$memory_task, round(k[["memory_task"]] * nyc_regents_scores$global_history))
  expect_equal(cognitive_battery_scores$usability_task, round(k[["usability_task"]] * nyc_regents_scores$living_environment))
  expect_equal(cognitive_battery_scores$reading_task, round(k[["reading_task"]] * nyc_regents_scores$english))
  expect_equal(cognitive_battery_scores$reasoning_task, round(k[["reasoning_task"]] * nyc_regents_scores$us_history))
  expect_true(length(unique(k)) == 1L)   # all 5 frequency columns share one factor
  expect_equal(anyDuplicated(cognitive_battery_scores$score), 0L)   # regression: no bin collisions
})
