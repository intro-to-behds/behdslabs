test_that("tech_adoption_trends preserves greenhouse_gases values exactly", {
  expect_equal(tech_adoption_trends$year, greenhouse_gases$year)
  expect_equal(tech_adoption_trends$adoption_index, greenhouse_gases$concentration)
  tech_map <- c("CO2" = "smartphones", "CH4" = "social_media", "N2O" = "streaming")
  expect_equal(tech_adoption_trends$technology, unname(tech_map[greenhouse_gases$gas]))
})
