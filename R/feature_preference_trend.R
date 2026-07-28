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
#' @details
#' **Teaching connection:** daily satisfaction or NPS scores during a
#' product launch produce noisy time series with the same structure as
#' opinion-polling margins. A LOESS smooth extracts the underlying
#' preference trend from day-to-day noise -- the same technique used in
#' product analytics dashboards to distinguish genuine engagement shifts
#' from random fluctuation.
#'
#' @examples
#' feature_preference_trend |> head()
#'
#' library(ggplot2)
#' ggplot(feature_preference_trend, aes(x = days_before_launch, y = preference_margin)) +
#'   geom_point(alpha = 0.4) +
#'   geom_smooth(method = "loess", span = 0.3) +
#'   labs(title = "Preference trend over time",
#'        subtitle = "Same method used to smooth daily satisfaction scores during an app launch")
#'
#' # Noise-to-signal ratio: how much does the raw margin vary day to day?
#' sd(feature_preference_trend$preference_margin)
"feature_preference_trend"
