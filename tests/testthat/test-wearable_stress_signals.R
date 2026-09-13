test_that("wearable_stress_signals$x preserves brca$x values exactly", {
  expect_equal(unname(wearable_stress_signals$x), unname(brca$x))
  expect_equal(dim(wearable_stress_signals$x), c(569L, 30L))
})

test_that("column names are a 1:1 relabeling of the brca feature names", {
  signal_map <- c(
    radius = "heart_rate", texture = "hrv_rmssd", perimeter = "breathing_rate",
    area = "motion_intensity", smoothness = "eda_tonic", compactness = "eda_phasic",
    concavity = "skin_temp", concave_pts = "pulse_amplitude",
    symmetry = "beat_regularity", fractal_dim = "signal_complexity"
  )
  suffix_map <- c(mean = "mean", se = "se", worst = "peak")
  old <- colnames(brca$x)
  base <- sub("_(mean|se|worst)$", "", old)
  suf  <- sub("^.*_(mean|se|worst)$", "\\1", old)
  expected <- paste0(unname(signal_map[base]), "_", unname(suffix_map[suf]))
  expect_equal(colnames(wearable_stress_signals$x), expected)
})

test_that("y is a 1:1 relabeling of the benign/malignant label", {
  expect_equal(as.character(wearable_stress_signals$y),
               ifelse(as.character(brca$y) == "M", "high", "low"))
  expect_equal(levels(wearable_stress_signals$y), c("low", "high"))
})
