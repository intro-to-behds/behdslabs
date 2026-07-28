#' Probability of app churn within one year, by age and sex
#'
#' The estimated probability that a user discontinues use of a wellness/
#' wearable app within one year, by age and sex. Useful for teaching
#' expected-value calculations.
#'
#' \itemize{
#'   \item age. Age in years.
#'   \item sex. Male or Female.
#'   \item churn_prob. Probability of churning within one year.
#' }
#'
#' @docType data
#'
#' @usage app_churn_prob
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::death_prob} values (Irizarry & Gill;
#'   Social Security Administration actuarial life tables), relabeled.
#'
#' @note These are not real churn-probability data. They are the original
#'   \code{dslabs::death_prob} values, relabeled. A synthetic or real,
#'   ethically-sourced replacement is planned for a future release (see
#'   \code{BDS_development_plan.md} Phase 2).
#'
#' @examples
#' app_churn_prob |> head()
"app_churn_prob"
