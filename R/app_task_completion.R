#' Task completion rates by device type
#'
#' Completion rates for six in-app tasks, split by device (mobile vs.
#' desktop) -- a classic example of Simpson's paradox: the aggregate
#' completion rate can favor one device while every individual task favors
#' the other.
#'
#' \itemize{
#'   \item task. The in-app task (A-F).
#'   \item device. mobile or desktop.
#'   \item completion_rate. Percent of attempts completed.
#'   \item n_attempts. Total number of attempts.
#' }
#'
#' @docType data
#'
#' @usage app_task_completion
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::admissions} values (Irizarry & Gill;
#'   originally PJ Bickel, EA Hammel, and JW O'Connell, Science 1975),
#'   relabeled.
#'
#' @note These are not real app-usage data. They are the original
#'   \code{dslabs::admissions} values, relabeled. A synthetic or real,
#'   ethically-sourced replacement is planned for a future release (see
#'   \code{BDS_development_plan.md} Phase 2).
#'
#' @examples
#' app_task_completion
"app_task_completion"
