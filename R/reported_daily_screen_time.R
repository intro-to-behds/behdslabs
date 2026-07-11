#' Self-reported daily screen time, with an outlier
#'
#' A vector of self-reported daily screen-time hours, mostly clustered
#' around 5-7 hours, with one obvious outlier caused by a unit-entry error
#' (e.g. minutes entered where hours were expected). Useful for teaching
#' outlier detection.
#'
#' @docType data
#'
#' @usage reported_daily_screen_time
#'
#' @format A numeric vector.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::outlier_example} values (Irizarry & Gill),
#'   relabeled -- no rescaling needed, as the original values already sit in
#'   a plausible daily-hours range.
#'
#' @note These are not real screen-time data. They are the original
#'   \code{dslabs::outlier_example} values, relabeled. A synthetic or real,
#'   ethically-sourced replacement is planned for a future release (see
#'   \code{BDS_development_plan.md} Phase 2).
#'
#' @examples
#' summary(reported_daily_screen_time)
"reported_daily_screen_time"
