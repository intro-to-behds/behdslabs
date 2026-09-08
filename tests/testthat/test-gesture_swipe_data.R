test_that("gesture_swipe_data preserves mnist_27 predictors and structure exactly", {
  expect_equal(gesture_swipe_data$train$x_1, mnist_27$train$x_1)
  expect_equal(gesture_swipe_data$train$x_2, mnist_27$train$x_2)
  expect_equal(gesture_swipe_data$test$x_1, mnist_27$test$x_1)
  expect_equal(gesture_swipe_data$test$x_2, mnist_27$test$x_2)
  expect_equal(gesture_swipe_data$index_train, mnist_27$index_train)
  expect_equal(gesture_swipe_data$index_test, mnist_27$index_test)
  expect_equal(gesture_swipe_data$true_p, mnist_27$true_p)
})

test_that("y is a 1:1 relabeling of the digit classes, not a re-derivation", {
  relabel <- function(y) {
    factor(ifelse(as.character(y) == "2", "swipe_left", "swipe_right"),
           levels = c("swipe_left", "swipe_right"))
  }
  expect_equal(gesture_swipe_data$train$y, relabel(mnist_27$train$y))
  expect_equal(gesture_swipe_data$test$y, relabel(mnist_27$test$y))
})
