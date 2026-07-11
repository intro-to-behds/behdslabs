#' Screen time vs. smart-speaker sales, a spurious-correlation example
#'
#' Two time series -- average daily screen time and a smart-speaker sales
#' index -- that trend together over a decade despite having no causal
#' relationship. Useful for teaching that correlation is not causation.
#'
#' \itemize{
#'   \item avg_daily_screen_time_hours. Average daily screen time, in hours.
#'   \item smart_speaker_sales_index. Smart-speaker sales index.
#'   \item year. Year.
#' }
#'
#' @docType data
#'
#' @usage screen_time_vs_smart_speaker_trend
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::divorce_margarine} values (Irizarry &
#'   Gill; Tyler Vigen's spurious correlations), relabeled.
#'
#' @note These are not real screen-time or sales data. They are the
#'   original \code{dslabs::divorce_margarine} values, relabeled. A
#'   synthetic or real, ethically-sourced replacement is planned for a
#'   future release (see \code{BDS_development_plan.md} Phase 2).
#'
#' @examples
#' screen_time_vs_smart_speaker_trend
"screen_time_vs_smart_speaker_trend"
