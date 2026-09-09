test_that("connectivity_deep_history is historic_co2 scaled", {
  expect_equal(connectivity_deep_history$year, historic_co2$year)   # EXC
  expect_equal(connectivity_deep_history$connectivity_index,
               K$connectivity_deep_history[["connectivity_index"]] * historic_co2$co2)
  src_map <- c("Ice Cores" = "reconstructed", "Mauna Loa" = "direct")
  expect_equal(connectivity_deep_history$source, unname(src_map[historic_co2$source]))
  expect_named(connectivity_deep_history, c("year", "connectivity_index", "source"))
})
