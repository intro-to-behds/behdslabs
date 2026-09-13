#' Touchscreen gesture classification example (three classes)
#'
#' A three-class extension of \code{\link{gesture_swipe_data}}: three
#' touchscreen gesture types (\code{tap}, \code{swipe}, \code{pinch}),
#' each described by the same two predictors. Split into training and test
#' sets. Useful for moving from binary to multi-class classification.
#'
#' \itemize{
#'   \item train. A data frame with the training data: label \code{y}
#'     (\code{tap}/\code{swipe}/\code{pinch}) and predictors \code{x_1},
#'     \code{x_2}.
#'   \item test. A data frame with the test data, same columns.
#' }
#'
#' @seealso [gesture_swipe_data], [read_mnist()]
#'
#' @docType data
#'
#' @usage gesture_swipe_data_3class
#'
#' @format An object of class \code{list}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::mnist_127} values (a 1/2/7 handwritten
#'   digit subset with two dark-pixel-quadrant predictors). The three
#'   digit classes are relabeled 1:1 to three gesture types
#'   (\code{1} -> \code{tap}, \code{2} -> \code{swipe},
#'   \code{7} -> \code{pinch}); the predictors are unchanged.
#'
#' @note These are not real touchscreen-gesture data. They are the
#'   original \code{dslabs::mnist_127} values (Irizarry & Gill) with the
#'   class labels relabeled. A synthetic or real, ethically-sourced
#'   replacement is planned for a future release (see
#'   \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** extending binary to three-class classification
#' mirrors recognising three gesture types, three usability-severity
#' levels, or three user states (engaged / distracted / frustrated) from
#' interaction or physiological signals.
#'
#' @examples
#' with(gesture_swipe_data_3class$train, plot(x_1, x_2, col = as.numeric(y)))
"gesture_swipe_data_3class"
