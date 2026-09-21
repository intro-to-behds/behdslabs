test_that("simulate_likert returns the documented shape", {
  d <- simulate_likert(n = 50, n_items = 4, seed = 1)
  expect_s3_class(d, "data.frame")
  expect_equal(nrow(d), 50)
  expect_named(d, c("respondent", paste0("item_", 1:4), "total", "true_score"))
})

test_that("a group column appears only when groups are requested", {
  expect_false("group" %in% names(simulate_likert(n = 20, seed = 1)))

  d <- simulate_likert(n = 20, group = c("standard", "redesigned"), seed = 1)
  expect_true("group" %in% names(d))
  expect_setequal(levels(d$group), c("standard", "redesigned"))

  # a full-length vector is used as given
  g <- rep(c("a", "b"), each = 10)
  expect_equal(as.character(simulate_likert(n = 20, group = g, seed = 1)$group), g)
})

test_that("responses stay inside the response scale", {
  d <- simulate_likert(n = 200, n_items = 5, n_levels = 7, error_sd = 3, seed = 2)
  items <- as.matrix(d[, grep("^item_", names(d))])
  expect_true(all(items >= 1 & items <= 7))
  expect_true(all(items == round(items)))
  expect_equal(d$total, unname(rowSums(items)))
})

test_that("seeds make results reproducible", {
  expect_equal(simulate_likert(n = 30, seed = 99), simulate_likert(n = 30, seed = 99))
  expect_false(isTRUE(all.equal(simulate_likert(n = 30, seed = 1),
                                simulate_likert(n = 30, seed = 2))))
})

test_that("supplying true_score reproduces it exactly (the retest case)", {
  t1 <- simulate_likert(n = 40, seed = 3)
  t2 <- simulate_likert(n = 40, true_score = t1$true_score, seed = 4)

  expect_equal(t2$true_score, t1$true_score)
  # same people, same construct, different measurement occasion
  expect_false(isTRUE(all.equal(t1$total, t2$total)))
})

test_that("error_sd drives reliability", {
  alpha <- function(d) {
    items <- as.matrix(d[, grep("^item_", names(d))])
    k <- ncol(items)
    k / (k - 1) * (1 - sum(apply(items, 2, stats::var)) / stats::var(rowSums(items)))
  }
  precise <- simulate_likert(n = 400, error_sd = 0.5, seed = 5)
  noisy <- simulate_likert(n = 400, error_sd = 3, seed = 5)

  expect_gt(alpha(precise), alpha(noisy))
  # and a noisier scale tracks the true score less closely
  expect_gt(cor(precise$total, precise$true_score),
            cor(noisy$total, noisy$true_score))
})

test_that("equal_spacing changes the response process, not the latent scores", {
  ordinal <- simulate_likert(n = 300, seed = 6)
  interval <- simulate_likert(n = 300, equal_spacing = TRUE, seed = 6)

  expect_equal(ordinal$true_score, interval$true_score)
  expect_false(isTRUE(all.equal(ordinal$total, interval$total)))
})

test_that("default thresholds are asymmetric and equal_spacing ones are not", {
  asym <- behdslabs:::.likert_thresholds(5)
  even <- behdslabs:::.likert_thresholds(5, equal_spacing = TRUE)

  expect_length(asym, 4)
  expect_length(even, 4)
  expect_equal(diff(even), rev(diff(even)))          # symmetric
  expect_lt(mean(asym), mean(even))                   # shifted toward a ceiling
})

test_that("group_sd lets groups differ in spread as well as location", {
  d <- simulate_likert(n = 600, group = c("a", "b"),
                       group_effect = 0, group_sd = c(1, 3), seed = 8)
  spread <- tapply(d$true_score, d$group, stats::sd)
  expect_gt(spread[["b"]], spread[["a"]])
})

test_that("invalid arguments are rejected", {
  expect_error(simulate_likert(n_items = 1), "n_items")
  expect_error(simulate_likert(n_levels = 1), "n_levels")
  expect_error(simulate_likert(error_sd = -1), "error_sd")
  expect_error(simulate_likert(n = 10, true_score = 1:5), "true_score")
  expect_error(simulate_likert(n = 10, n_levels = 5, thresholds = c(0, 1)), "thresholds")
})
