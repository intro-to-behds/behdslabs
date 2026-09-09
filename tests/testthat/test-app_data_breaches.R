test_that("app_data_breaches matches murders (population kept, incidents scaled)", {
  expect_equal(app_data_breaches$state, murders$state)
  expect_equal(app_data_breaches$abb, murders$abb)
  expect_equal(app_data_breaches$region, murders$region)
  expect_equal(app_data_breaches$population, murders$population)   # EXC
  expect_equal(app_data_breaches$incidents,
               round(K$app_data_breaches[["incidents"]] * murders$total))
})
