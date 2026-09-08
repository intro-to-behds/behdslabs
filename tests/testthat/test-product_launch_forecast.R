test_that("product_launch_forecast preserves polls_us_election_2016 values exactly", {
  p <- polls_us_election_2016
  expect_equal(product_launch_forecast$market, p$state)
  expect_equal(product_launch_forecast$startdate, p$startdate)
  expect_equal(product_launch_forecast$enddate, p$enddate)
  expect_equal(product_launch_forecast$panel_grade, p$grade)
  expect_equal(product_launch_forecast$samplesize, p$samplesize)
  expect_equal(product_launch_forecast$respondents, p$population)
  expect_equal(product_launch_forecast$raw_pref_new, p$rawpoll_clinton)
  expect_equal(product_launch_forecast$raw_pref_current, p$rawpoll_trump)
  expect_equal(product_launch_forecast$raw_pref_switch, p$rawpoll_johnson)
  expect_equal(product_launch_forecast$raw_pref_other, p$rawpoll_mcmullin)
  expect_equal(product_launch_forecast$adj_pref_new, p$adjpoll_clinton)
  expect_equal(product_launch_forecast$adj_pref_current, p$adjpoll_trump)
  expect_equal(product_launch_forecast$adj_pref_switch, p$adjpoll_johnson)
  expect_equal(product_launch_forecast$adj_pref_other, p$adjpoll_mcmullin)
})

test_that("panel is an anonymized 1:1 relabeling of pollster", {
  expected <- sprintf("Panel %03d", as.integer(factor(polls_us_election_2016$pollster)))
  expect_equal(product_launch_forecast$panel, expected)
  # same panel <-> same original pollster
  key <- paste(product_launch_forecast$panel, polls_us_election_2016$pollster)
  expect_equal(length(unique(product_launch_forecast$panel)),
               length(unique(key)))
})

test_that("product_launch_results preserves results_us_election_2016 values exactly", {
  r <- results_us_election_2016
  expect_equal(product_launch_results$market, r$state)
  expect_equal(product_launch_results$market_weight, r$electoral_votes)
  expect_equal(product_launch_results$adopt_new, r$clinton)
  expect_equal(product_launch_results$adopt_current, r$trump)
  expect_equal(product_launch_results$adopt_alt1, r$johnson)
  expect_equal(product_launch_results$adopt_alt2, r$stein)
  expect_equal(product_launch_results$adopt_alt3, r$mcmullin)
  expect_equal(product_launch_results$adopt_other, r$others)
})
