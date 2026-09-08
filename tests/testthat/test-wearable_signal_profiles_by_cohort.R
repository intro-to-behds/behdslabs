test_that("wearable_signal_profiles_by_cohort preserves olive fatty-acid values exactly", {
  w <- wearable_signal_profiles_by_cohort
  expect_equal(w$pct_motion_artifact, olive$palmitic)
  expect_equal(w$pct_saturation, olive$palmitoleic)
  expect_equal(w$pct_baseline_drift, olive$stearic)
  expect_equal(w$pct_clean, olive$oleic)
  expect_equal(w$pct_poor_contact, olive$linoleic)
  expect_equal(w$pct_dropout, olive$linolenic)
  expect_equal(w$pct_powerline_noise, olive$arachidic)
  expect_equal(w$pct_other, olive$eicosenoic)
  expect_equal(nrow(w), nrow(olive))
})

test_that("device_type / device_model are a 1:1 relabeling of region / area", {
  w <- wearable_signal_profiles_by_cohort
  dt_map <- c("Northern Italy" = "smartwatch", "Sardinia" = "chest_strap",
              "Southern Italy" = "smart_ring")
  expect_equal(as.character(w$device_type),
               unname(dt_map[as.character(olive$region)]))
  # nesting preserved: each device_model maps to exactly one area and one device_type
  expect_equal(length(unique(paste(w$device_model, olive$area))),
               length(unique(w$device_model)))
  expect_equal(length(unique(paste(w$device_model, w$device_type))),
               length(unique(w$device_model)))
})
