test_that("tech_grant_funding_gender_gap preserves research_funding_rates numeric values exactly", {
  numeric_cols <- c(
    "applications_total", "applications_men", "applications_women",
    "awards_total", "awards_men", "awards_women",
    "success_rates_total", "success_rates_men", "success_rates_women"
  )
  for (col in numeric_cols) {
    expect_equal(tech_grant_funding_gender_gap[[col]], research_funding_rates[[col]])
  }
})

test_that("tech_domain is a 1:1 relabeling of discipline, not a re-derivation", {
  domain_map <- c(
    "Chemical sciences" = "AI/ML Research",
    "Physical sciences" = "Sensor Hardware",
    "Physics" = "Wearable Engineering",
    "Humanities" = "HCI & Digital Humanities",
    "Technical sciences" = "Software Engineering",
    "Interdisciplinary" = "Human-Centric Tech (Interdisciplinary)",
    "Earth/life sciences" = "Digital Health & Biosensing",
    "Social sciences" = "UX & Behavioural Research",
    "Medical sciences" = "Neurotech & Clinical Applications"
  )
  expect_equal(
    tech_grant_funding_gender_gap$tech_domain,
    unname(domain_map[research_funding_rates$discipline])
  )
})
