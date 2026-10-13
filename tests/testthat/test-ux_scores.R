test_that("ux_scores$ux_score matches the documented linear rescale of heights", {
  rng <- range(heights$height)
  expected <- (heights$height - rng[1]) / (rng[2] - rng[1]) * 100

  expect_equal(ux_scores$ux_score, expected)
  expect_equal(range(ux_scores$ux_score), c(0, 100))
})

test_that("ux_scores$device relabels the sex column of heights", {
  expect_equal(levels(ux_scores$device), c("desktop", "mobile"))
  expect_equal(as.character(ux_scores$device) == "desktop",
               heights$sex == "Male")
})
