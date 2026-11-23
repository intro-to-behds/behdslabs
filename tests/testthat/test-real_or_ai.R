test_that("real_or_ai has the documented structure", {
  expect_equal(nrow(real_or_ai), 600)
  expect_equal(names(real_or_ai),
               c("id", "ai_familiarity", "image_type", "time_pressure", "correct"))
  expect_equal(levels(real_or_ai$image_type), c("photo", "illustration"))
  expect_equal(levels(real_or_ai$time_pressure), c("no", "yes"))
  expect_true(all(real_or_ai$correct %in% c(0, 1)))
  expect_true(all(real_or_ai$ai_familiarity %in% 0:10))
  expect_equal(as.vector(table(real_or_ai$image_type)), c(300, 300))
  expect_equal(as.vector(table(real_or_ai$time_pressure)), c(300, 300))
})

test_that("real_or_ai has the intended effects", {
  acc <- with(real_or_ai, tapply(correct, time_pressure, mean))
  expect_gt(mean(real_or_ai$correct), 0.5)      # above chance
  expect_lt(acc[["yes"]], acc[["no"]])          # time pressure hurts
  fit <- glm(correct ~ ai_familiarity, family = binomial, data = real_or_ai)
  expect_gt(coef(fit)[["ai_familiarity"]], 0)   # familiarity helps
})
