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
#' @details
#' **Teaching connection:** in behavioural technology research,
#' response-time or interaction data logged in milliseconds by some
#' devices and seconds by others creates unit-entry outliers just like
#' this one. A single mislogged value inflates the mean dramatically
#' while leaving the median unaffected -- a key reason to prefer the
#' median (or a trimmed mean) for latency- and duration-type data.
#'
#' @examples
#' summary(reported_daily_screen_time)
#'
#' # How much does the outlier shift the mean vs. the median?
#' mean(reported_daily_screen_time); median(reported_daily_screen_time)
#'
#' # Remove the outlier and compare again.
#' clean <- reported_daily_screen_time[reported_daily_screen_time < 10]
#' mean(clean); median(clean)
"reported_daily_screen_time"
