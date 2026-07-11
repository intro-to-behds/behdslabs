#' Score frequencies across a cognitive test battery
#'
#' For each possible score (0-100), the number of test-takers who achieved
#' that score on each of five tasks in a cognitive test battery. Useful for
#' illustrating and comparing distribution shapes.
#'
#' \itemize{
#'   \item score. Possible score, 0 to 100.
#'   \item attention_task. Number of test-takers scoring this on the attention task.
#'   \item memory_task. Number of test-takers scoring this on the memory task.
#'   \item usability_task. Number of test-takers scoring this on the usability task.
#'   \item reading_task. Number of test-takers scoring this on the reading task.
#'   \item reasoning_task. Number of test-takers scoring this on the reasoning task.
#' }
#'
#' @docType data
#'
#' @usage cognitive_battery_scores
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::nyc_regents_scores} values (Irizarry &
#'   Gill), relabeled.
#'
#' @note These are not real cognitive-testing data. They are the original
#'   \code{dslabs::nyc_regents_scores} values, relabeled. A synthetic or
#'   real, ethically-sourced replacement is planned for a future release
#'   (see \code{BDS_development_plan.md} Phase 2).
#'
#' @examples
#' cognitive_battery_scores |> head()
"cognitive_battery_scores"
