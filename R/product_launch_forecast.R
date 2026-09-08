#' Pre-launch feature-preference surveys and the post-launch outcome
#'
#' Before rolling out a redesigned version of an app, a company commissions
#' many research panels to survey users across markets: do they prefer the
#' \strong{new} version, the \strong{current} version, or would they
#' \strong{switch} to a competitor? \code{product_launch_forecast} holds
#' the individual survey results; \code{product_launch_results} (documented
#' here too) holds the actual post-launch adoption in each market. Together
#' they support the whole forecasting workflow -- aggregating noisy
#' surveys, weighting by panel quality, and checking the forecast against
#' what actually happened.
#'
#' \code{product_launch_forecast} columns:
#' \itemize{
#'   \item market. Market in which the survey was run (\code{"U.S."} is a
#'     national survey).
#'   \item startdate. Survey start date.
#'   \item enddate. Survey end date.
#'   \item panel. Anonymized research-panel identifier (\code{"Panel 001"}
#'     ..\code{"Panel 196"}); the same panel keeps the same id across
#'     surveys.
#'   \item panel_grade. Reliability grade for the panel (\code{A+}..\code{D};
#'     \code{NA} if ungraded).
#'   \item samplesize. Number of respondents.
#'   \item respondents. Respondent screen used (\code{lv}, \code{rv},
#'     \code{a}, \code{v}).
#'   \item raw_pref_new, raw_pref_current, raw_pref_switch, raw_pref_other.
#'     Raw percentage of respondents preferring the new version, the
#'     current version, switching to a competitor, or "other".
#'   \item adj_pref_new, adj_pref_current, adj_pref_switch, adj_pref_other.
#'     House-effect-adjusted versions of the same four percentages.
#' }
#'
#' \code{product_launch_results} columns:
#' \itemize{
#'   \item market. Market.
#'   \item market_weight. Relative importance/size weight for the market.
#'   \item adopt_new, adopt_current, adopt_alt1, adopt_alt2, adopt_alt3,
#'     adopt_other. Actual post-launch adoption percentages.
#' }
#'
#' @docType data
#'
#' @aliases product_launch_results
#'
#' @usage product_launch_forecast
#'
#' @format Two objects of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::polls_us_election_2016} and
#'   \code{dslabs::results_us_election_2016} values (Irizarry & Gill;
#'   FiveThirtyEight / Ballotpedia). Structures and all numeric values are
#'   unchanged. \code{state} -> \code{market}; \code{pollster} ->
#'   anonymized \code{panel}; \code{grade} -> \code{panel_grade};
#'   \code{electoral_votes} -> \code{market_weight}; the 2016 candidates
#'   map to the three preference options: Clinton -> new, Trump ->
#'   current, Johnson -> switch, McMullin/others -> other/alt.
#'
#' @note These are not real product-survey data. They are the original
#'   \code{dslabs} 2016 US-election polling and results values, relabeled
#'   for narrative fit. A synthetic or real, ethically-sourced replacement
#'   is planned for a future release (see \code{BDS_development_plan.md}
#'   Phase 2).
#'
#' @details
#' **Teaching connection:** aggregating many noisy pre-launch preference
#' surveys to forecast an outcome is methodologically identical to
#' aggregating opinion polls. The pitfalls transfer directly -- panel
#' house effects, herding, non-response bias, overconfident intervals --
#' and so does the payoff: comparing the forecast to
#' \code{product_launch_results} (and to the previous launch's
#' \code{\link{prior_launch_results}}) is how you learn whether your
#' aggregation method is actually calibrated.
#'
#' @examples
#' library(dplyr)
#'
#' # Late national surveys: average preference for the new version
#' product_launch_forecast |>
#'   filter(market == "U.S." & enddate >= as.Date("2016-10-25")) |>
#'   summarise(mean_new = mean(raw_pref_new),
#'             mean_current = mean(raw_pref_current))
#'
#' # Forecast vs. actual, by market
#' product_launch_forecast |>
#'   filter(market != "U.S.") |>
#'   group_by(market) |>
#'   summarise(fc_new = mean(adj_pref_new, na.rm = TRUE)) |>
#'   inner_join(product_launch_results, by = "market") |>
#'   mutate(error = adopt_new - fc_new)
"product_launch_forecast"
