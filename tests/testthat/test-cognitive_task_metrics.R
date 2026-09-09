test_that("cognitive_task_metrics is stars magnitude/temp scaled", {
  k <- K$cognitive_task_metrics
  expect_equal(cognitive_task_metrics$cognitive_load, k[["cognitive_load"]] * stars$magnitude)
  expect_equal(cognitive_task_metrics$arousal_index, k[["arousal_index"]] * stars$temp)
  expect_equal(nrow(cognitive_task_metrics), nrow(stars))
})

test_that("session is an anonymized per-row id", {
  expect_equal(cognitive_task_metrics$session,
               sprintf("S%02d", seq_len(nrow(stars))))
})

test_that("task_type is a 1:1 relabeling of spectral class", {
  map <- c("O" = "stroop", "B" = "visual_search", "A" = "mental_arithmetic",
           "F" = "sorting", "G" = "planning", "K" = "reading", "M" = "free_recall",
           "DA" = "n_back_1", "DB" = "n_back_2", "DF" = "n_back_3")
  expect_equal(cognitive_task_metrics$task_type,
               unname(map[as.character(stars$type)]))
  expect_false(any(is.na(cognitive_task_metrics$task_type)))
})
