#' Annual screen-time index and wellbeing anomalies
#'
#' A yearly time series pairing a population screen-time index with three
#' wellbeing "anomaly" measures (deviations from a baseline period). Built
#' for the classic observational-time-series question: does the rising
#' driver track the changing outcome, and can you claim it \emph{causes}
#' it?
#'
#' \itemize{
#'   \item year. Year.
#'   \item wellbeing_anomaly. Overall wellbeing anomaly (deviation from
#'     baseline).
#'   \item mood_anomaly. Mood-domain anomaly.
#'   \item sleep_anomaly. Sleep-domain anomaly.
#'   \item screen_time_index. Population screen-time index for the year.
#' }
#'
#' @docType data
#'
#' @usage screentime_wellbeing_series
#'
#' @format An object of class \code{"data.frame"} (268 x 5).
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::temp_carbon} values (Irizarry & Gill).
#'   All numeric values unchanged: \code{temp_anomaly} ->
#'   \code{wellbeing_anomaly}, \code{land_anomaly} -> \code{mood_anomaly},
#'   \code{ocean_anomaly} -> \code{sleep_anomaly}, \code{carbon_emissions}
#'   -> \code{screen_time_index}.
#'
#' @note These are not real wellbeing or screen-time data. They are the
#'   original \code{dslabs::temp_carbon} values, relabeled for narrative
#'   fit. A synthetic or real, ethically-sourced replacement is planned for
#'   a future release (see \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** two rising curves on a shared time axis invite
#' a causal reading -- and this is exactly the shape of the
#' screen-time-vs-wellbeing debate. The dataset is a vehicle for showing
#' why a strong temporal correlation, on its own, does not settle
#' causation (confounding by everything else that trended over the same
#' decades).
#'
#' @examples
#' with(screentime_wellbeing_series,
#'      plot(screen_time_index, wellbeing_anomaly))
"screentime_wellbeing_series"
