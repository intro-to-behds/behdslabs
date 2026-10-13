test_that("reaction_times keeps the sex column of heights unchanged", {
  expect_equal(reaction_times$sex, heights$sex)
  expect_equal(as.vector(table(reaction_times$sex)), c(238, 812))
})

test_that("reaction_times$rt_ms has realistic reaction-time properties", {
  rt <- reaction_times$rt_ms
  expect_true(all(rt > 150))                     # a floor
  expect_gt(mean(rt), median(rt))                # right skew
  expect_gt(mean(rt > 400), 0.05)                # a tail of slow participants
  med <- tapply(rt, reaction_times$sex, median)
  expect_lt(med[["Male"]], med[["Female"]])      # men slightly faster
  expect_lt(med[["Female"]] - med[["Male"]], 40) # ...by a small amount
})
