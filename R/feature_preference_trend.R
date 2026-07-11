#' Trend in user preference for a new app feature before launch
#'
#' Daily survey-based net preference margin for a new UI/feature versus the
#' old one, in the run-up to a product launch. Useful for teaching
#' time-series trend estimation.
#'
#' \itemize{
#'   \item days_before_launch. Days before launch (negative = before launch).
#'   \item preference_margin. Net preference for the new feature over the old one.
#' }
#'
#' @docType data
#'
#' @usage feature_preference_trend
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::polls_2008} values (Irizarry & Gill),
#'   relabeled.
#'
#' @note These are not real product-preference data. They are the original
#'   \code{dslabs::polls_2008} values, relabeled. A synthetic or real,
#'   ethically-sourced replacement is planned for a future release (see
#'   \code{BDS_development_plan.md} Phase 2).
#'
#' @examples
#' feature_preference_trend |> head()
"feature_preference_trend"
