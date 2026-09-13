test_that("prior_launch_results preserves results_us_election_2012 values exactly", {
  r <- results_us_election_2012
  expect_equal(prior_launch_results$market, r$state)
  expect_equal(prior_launch_results$market_weight, r$electoral_votes)
  expect_equal(prior_launch_results$adopt_new, r$obama)
  expect_equal(prior_launch_results$adopt_current, r$romney)
  expect_equal(prior_launch_results$adopt_alt1, r$johnson)
  expect_equal(prior_launch_results$adopt_alt2, r$stein)
  expect_named(prior_launch_results,
               c("market", "market_weight", "adopt_new", "adopt_current",
                 "adopt_alt1", "adopt_alt2"))
})
