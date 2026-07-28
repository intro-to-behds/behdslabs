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
#' @details
#' **Teaching connection:** app analytics dashboards routinely surface
#' high correlations between unrelated metrics that share a seasonal or
#' long-run time trend -- e.g. daily app opens correlating with ambient
#' temperature or a competing platform's usage. A near-perfect but
#' obviously non-causal correlation like this one is a memorable anchor
#' for teaching analysts to detrend before interpreting engagement
#' metrics.
#'
#' @examples
#' screen_time_vs_smart_speaker_trend
#'
#' # A strong correlation -- but obviously non-causal.
#' with(screen_time_vs_smart_speaker_trend,
#'      cor(smart_speaker_sales_index, avg_daily_screen_time_hours))
#'
#' # Detrend both variables against year and check whether the correlation
#' # survives -- the standard pre-processing step before trusting an
#' # engagement-metric correlation.
#' fit_screen <- lm(avg_daily_screen_time_hours ~ year,
#'                   data = screen_time_vs_smart_speaker_trend)
#' fit_speaker <- lm(smart_speaker_sales_index ~ year,
#'                    data = screen_time_vs_smart_speaker_trend)
#' cor(resid(fit_screen), resid(fit_speaker))
"screen_time_vs_smart_speaker_trend"
