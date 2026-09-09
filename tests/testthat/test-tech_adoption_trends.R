test_that("tech_adoption_trends is greenhouse_gases scaled", {
  expect_equal(tech_adoption_trends$year, greenhouse_gases$year)   # EXC
  expect_equal(tech_adoption_trends$adoption_index,
               K$tech_adoption_trends[["adoption_index"]] * greenhouse_gases$concentration)
  tech_map <- c("CO2" = "smartphones", "CH4" = "social_media", "N2O" = "streaming")
  expect_equal(tech_adoption_trends$technology, unname(tech_map[greenhouse_gases$gas]))
})
