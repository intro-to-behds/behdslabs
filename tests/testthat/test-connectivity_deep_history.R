test_that("connectivity_deep_history preserves historic_co2 values exactly", {
  expect_equal(connectivity_deep_history$year, historic_co2$year)
  expect_equal(connectivity_deep_history$connectivity_index, historic_co2$co2)
  src_map <- c("Ice Cores" = "reconstructed", "Mauna Loa" = "direct")
  expect_equal(connectivity_deep_history$source, unname(src_map[historic_co2$source]))
  expect_named(connectivity_deep_history, c("year", "connectivity_index", "source"))
})
