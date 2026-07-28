test_that("global_tech_adoption preserves unchanged gapminder columns exactly", {
  expect_equal(global_tech_adoption$country, gapminder$country)
  expect_equal(global_tech_adoption$year, gapminder$year)
  expect_equal(global_tech_adoption$continent, gapminder$continent)
  expect_equal(global_tech_adoption$region, gapminder$region)
  expect_equal(global_tech_adoption$gdp, gapminder$gdp)
  expect_equal(global_tech_adoption$active_user_base, gapminder$population)
  expect_equal(global_tech_adoption$avg_price_per_app_usd, gapminder$fertility)
  expect_equal(global_tech_adoption$app_uninstall_rate_per_1000, gapminder$infant_mortality)
})

test_that("avg_daily_screen_time_hours matches the documented linear rescale of life_expectancy", {
  rng <- range(gapminder$life_expectancy, na.rm = TRUE)
  expected <- 1 + (gapminder$life_expectancy - rng[1]) / (rng[2] - rng[1]) * 9
  expect_equal(global_tech_adoption$avg_daily_screen_time_hours, expected)
})
