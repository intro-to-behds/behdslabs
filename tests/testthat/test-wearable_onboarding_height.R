test_that("wearable_onboarding_height preserves reported_heights values exactly", {
  expect_equal(wearable_onboarding_height$onboarding_timestamp, reported_heights$time_stamp)
  expect_equal(wearable_onboarding_height$sex, reported_heights$sex)
  expect_equal(wearable_onboarding_height$reported_height_raw, reported_heights$height)
})
