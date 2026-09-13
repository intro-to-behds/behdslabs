test_that("tech_grant_funding_gender_gap: counts scaled by one shared factor, rates kept", {
  count_cols <- c(
    "applications_total", "applications_men", "applications_women",
    "awards_total", "awards_men", "awards_women"
  )
  k <- K$tech_grant_funding_gender_gap[["counts"]]
  for (col in count_cols) {
    expect_equal(tech_grant_funding_gender_gap[[col]], round(k * research_funding_rates[[col]]))
  }
  for (col in c("success_rates_total", "success_rates_men", "success_rates_women")) {
    expect_equal(tech_grant_funding_gender_gap[[col]], research_funding_rates[[col]])   # EXC
  }
  # the shared factor keeps total = men + women
  expect_equal(tech_grant_funding_gender_gap$applications_total,
               tech_grant_funding_gender_gap$applications_men +
                 tech_grant_funding_gender_gap$applications_women)
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
