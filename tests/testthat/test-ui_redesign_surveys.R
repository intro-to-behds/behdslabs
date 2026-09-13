test_that("ui_redesign_surveys: n_participants scaled, poll columns kept", {
  b <- brexit_polls
  expect_equal(ui_redesign_surveys$startdate, b$startdate)
  expect_equal(ui_redesign_surveys$enddate, b$enddate)
  expect_equal(ui_redesign_surveys$n_participants,
               round(K$ui_redesign_surveys[["n_participants"]] * b$samplesize))
  expect_equal(ui_redesign_surveys$prefer_new, b$remain)
  expect_equal(ui_redesign_surveys$prefer_current, b$leave)
  expect_equal(ui_redesign_surveys$undecided, b$undecided)
  expect_equal(ui_redesign_surveys$margin, b$spread)
  expect_equal(nrow(ui_redesign_surveys), nrow(b))
})

test_that("method is a 1:1 relabeling of poll_type", {
  expect_equal(as.character(ui_redesign_surveys$method),
               ifelse(brexit_polls$poll_type == "Online", "remote", "lab"))
  expect_equal(levels(ui_redesign_surveys$method), c("remote", "lab"))
})

test_that("panel is an anonymized 1:1 relabeling of pollster", {
  expect_equal(ui_redesign_surveys$panel,
               sprintf("Panel %02d", as.integer(factor(brexit_polls$pollster))))
  key <- paste(ui_redesign_surveys$panel, brexit_polls$pollster)
  expect_equal(length(unique(ui_redesign_surveys$panel)), length(unique(key)))
})
