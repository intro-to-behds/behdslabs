test_that("gesture_swipe_data_3class preserves mnist_127 predictors exactly", {
  expect_equal(gesture_swipe_data_3class$train$x_1, mnist_127$train$x_1)
  expect_equal(gesture_swipe_data_3class$train$x_2, mnist_127$train$x_2)
  expect_equal(gesture_swipe_data_3class$test$x_1, mnist_127$test$x_1)
  expect_equal(gesture_swipe_data_3class$test$x_2, mnist_127$test$x_2)
})

test_that("y is a 1:1 relabeling of the three digit classes", {
  relabel <- function(y) {
    m <- c("1" = "tap", "2" = "swipe", "7" = "pinch")
    factor(unname(m[as.character(y)]), levels = c("tap", "swipe", "pinch"))
  }
  expect_equal(gesture_swipe_data_3class$train$y, relabel(mnist_127$train$y))
  expect_equal(gesture_swipe_data_3class$test$y, relabel(mnist_127$test$y))
})
