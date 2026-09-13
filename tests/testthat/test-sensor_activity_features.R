test_that("sensor_activity_features$x preserves tissue_gene_expression values exactly", {
  expect_equal(unname(sensor_activity_features$x), unname(tissue_gene_expression$x))
  expect_equal(rownames(sensor_activity_features$x), rownames(tissue_gene_expression$x))
  expect_equal(colnames(sensor_activity_features$x),
               sprintf("feature_%03d", seq_len(ncol(tissue_gene_expression$x))))
})

test_that("y is a 1:1 relabeling of the seven tissue types", {
  activity_map <- c(
    "cerebellum"  = "walking",
    "colon"       = "typing",
    "endometrium" = "reading",
    "hippocampus" = "meditating",
    "kidney"      = "gaming",
    "liver"       = "driving",
    "placenta"    = "resting"
  )
  expect_equal(as.character(sensor_activity_features$y),
               unname(activity_map[as.character(tissue_gene_expression$y)]))
  expect_equal(levels(sensor_activity_features$y), unname(activity_map))
})
