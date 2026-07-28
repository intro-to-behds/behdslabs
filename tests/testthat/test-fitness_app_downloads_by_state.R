test_that("fitness_app_downloads_by_state preserves us_contagious_diseases values exactly", {
  expect_equal(fitness_app_downloads_by_state$state, us_contagious_diseases$state)
  expect_equal(fitness_app_downloads_by_state$year, us_contagious_diseases$year)
  expect_equal(fitness_app_downloads_by_state$weeks_tracked, us_contagious_diseases$weeks_reporting)
  expect_equal(fitness_app_downloads_by_state$downloads, us_contagious_diseases$count)
  expect_equal(fitness_app_downloads_by_state$population, us_contagious_diseases$population)
})

test_that("app_category is a 1:1 relabeling of disease, not a re-derivation", {
  app_category_map <- c(
    "Hepatitis A" = "Macro/Nutrition Logging",
    "Measles" = "Guided Meditation",
    "Mumps" = "Sleep Tracking",
    "Pertussis" = "Yoga & Stretching",
    "Polio" = "Heart-Rate Monitoring",
    "Rubella" = "Running Coach",
    "Smallpox" = "Step Tracking"
  )
  expect_equal(
    fitness_app_downloads_by_state$app_category,
    unname(app_category_map[as.character(us_contagious_diseases$disease)])
  )
})
