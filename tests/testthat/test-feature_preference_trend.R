test_that("feature_preference_trend preserves polls_2008 values exactly", {
  expect_equal(feature_preference_trend$days_before_launch, polls_2008$day)
  expect_equal(feature_preference_trend$preference_margin, polls_2008$margin)
})
