test_that("app_churn_prob preserves death_prob values exactly", {
  expect_equal(app_churn_prob$age, death_prob$age)
  expect_equal(app_churn_prob$sex, death_prob$sex)
  expect_equal(app_churn_prob$churn_prob, death_prob$prob)
})
