test_that("simulate_sdt returns the documented shape", {
  d <- simulate_sdt(n = 10, seed = 1)
  expect_s3_class(d, "data.frame")
  expect_equal(nrow(d), 10)
  expect_named(d, c("participant", "hits", "misses", "false_alarms",
                    "correct_rejections", "prop_correct", "d_prime", "criterion"))
})

test_that("the four trial counts add up to n_trials", {
  d <- simulate_sdt(n = 20, n_trials = 120, signal_prob = 0.4, seed = 2)
  expect_true(all(d$hits + d$misses + d$false_alarms + d$correct_rejections == 120))
  # signal and noise trials are split as requested
  expect_true(all(d$hits + d$misses == 48))
  expect_true(all(d$false_alarms + d$correct_rejections == 72))
})

test_that("prop_correct is consistent with the counts", {
  d <- simulate_sdt(n = 15, n_trials = 100, seed = 3)
  expect_equal(d$prop_correct, (d$hits + d$correct_rejections) / 100)
  expect_true(all(d$prop_correct >= 0 & d$prop_correct <= 1))
})

test_that("seeds make results reproducible", {
  expect_equal(simulate_sdt(n = 10, seed = 7), simulate_sdt(n = 10, seed = 7))
  expect_false(isTRUE(all.equal(simulate_sdt(n = 10, seed = 7),
                                simulate_sdt(n = 10, seed = 8))))
})

test_that("d_prime and criterion accept one value or one per participant", {
  same <- simulate_sdt(n = 4, d_prime = 1.2, criterion = 0.3, seed = 4)
  expect_true(all(same$d_prime == 1.2))
  expect_true(all(same$criterion == 0.3))

  varied <- simulate_sdt(n = 3, d_prime = c(0.5, 1.5, 2.5),
                         criterion = c(-1, 0, 1), seed = 4)
  expect_equal(varied$d_prime, c(0.5, 1.5, 2.5))
  expect_equal(varied$criterion, c(-1, 0, 1))
})

test_that("d' is recoverable from the counts", {
  d <- simulate_sdt(n = 200, n_trials = 2000, d_prime = 1.5, criterion = 0.2, seed = 5)
  hit_rate <- d$hits / (d$hits + d$misses)
  fa_rate <- d$false_alarms / (d$false_alarms + d$correct_rejections)
  recovered <- stats::qnorm(hit_rate) - stats::qnorm(fa_rate)
  expect_equal(mean(recovered), 1.5, tolerance = 0.05)
})

test_that("higher sensitivity means better performance at a fixed criterion", {
  d <- simulate_sdt(n = 400, n_trials = 400, d_prime = c(0.5, 2.5),
                    criterion = 0, seed = 6)
  low <- d$prop_correct[d$d_prime == 0.5]
  high <- d$prop_correct[d$d_prime == 2.5]
  expect_gt(mean(high), mean(low))
})

test_that("criterion shifts the willingness to answer yes, not the ability", {
  d <- simulate_sdt(n = 400, n_trials = 400, d_prime = 1.5,
                    criterion = c(-1, 1), seed = 7)
  liberal <- d$criterion == -1
  # a liberal criterion buys more hits at the cost of more false alarms
  expect_gt(mean(d$hits[liberal]), mean(d$hits[!liberal]))
  expect_gt(mean(d$false_alarms[liberal]), mean(d$false_alarms[!liberal]))
})

test_that("equal prop_correct can hide unequal sensitivity", {
  # The teaching case: a strongly biased criterion drags a good detector down
  # to the score a much worse one achieves at its best possible criterion.
  d <- simulate_sdt(n = 2, n_trials = 4000, d_prime = c(0.8, 2.0),
                    criterion = c(0.4, -0.475), seed = 8)
  expect_lt(abs(diff(d$prop_correct)), 0.03)
  expect_gt(diff(d$d_prime), 1)
})

test_that("invalid arguments are rejected", {
  expect_error(simulate_sdt(n_trials = 0), "n_trials")
  expect_error(simulate_sdt(signal_prob = 0), "signal_prob")
  expect_error(simulate_sdt(signal_prob = 1), "signal_prob")
})
