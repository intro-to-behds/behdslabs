test_that("app_task_completion preserves admissions values exactly", {
  expect_equal(app_task_completion$task, admissions$major)
  expect_equal(app_task_completion$completion_rate, admissions$admitted)
  expect_equal(app_task_completion$n_attempts, admissions$applicants)
  expect_equal(
    app_task_completion$device,
    ifelse(admissions$gender == "men", "mobile", "desktop")
  )
})
