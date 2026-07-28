test_that("app_data_breaches preserves murders values exactly", {
  expect_equal(app_data_breaches$state, murders$state)
  expect_equal(app_data_breaches$abb, murders$abb)
  expect_equal(app_data_breaches$region, murders$region)
  expect_equal(app_data_breaches$population, murders$population)
  expect_equal(app_data_breaches$incidents, murders$total)
})
