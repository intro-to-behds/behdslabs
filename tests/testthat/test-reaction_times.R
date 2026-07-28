test_that("reaction_times$rt_ms matches the documented linear rescale of heights", {
  rng <- range(heights$height)
  expected_rt_ms <- 200 + (heights$height - rng[1]) / (rng[2] - rng[1]) * 300

  expect_equal(reaction_times$sex, heights$sex)
  expect_equal(reaction_times$rt_ms, expected_rt_ms)
  expect_true(all(reaction_times$rt_ms >= 200 & reaction_times$rt_ms <= 500))
})
