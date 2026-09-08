#' Adoption outcome of the previous product launch
#'
#' Post-launch adoption percentages by market for the company's
#' \emph{previous} major launch -- the natural comparison point when
#' forecasting the next one (\code{\link{product_launch_forecast}} /
#' \code{product_launch_results}). Same markets and weighting as the
#' current-launch results.
#'
#' \itemize{
#'   \item market. Market.
#'   \item market_weight. Relative importance/size weight for the market.
#'   \item adopt_new. Adoption percentage for that launch's new version.
#'   \item adopt_current. Adoption percentage for the version it replaced.
#'   \item adopt_alt1, adopt_alt2. Adoption percentages for minor
#'     alternatives.
#' }
#'
#' @docType data
#'
#' @usage prior_launch_results
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::results_us_election_2012} values
#'   (Irizarry & Gill). All numeric values unchanged; \code{state} ->
#'   \code{market}, \code{electoral_votes} -> \code{market_weight}, Obama
#'   -> new, Romney -> current, Johnson/Stein -> alt1/alt2.
#'
#' @note These are not real product-launch data. They are the original
#'   \code{dslabs::results_us_election_2012} values, relabeled. A synthetic
#'   or real, ethically-sourced replacement is planned for a future release
#'   (see \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** anchoring a new forecast on the last launch's
#' outcome is standard practice -- and a standard source of bias when the
#' two situations differ. Used alongside
#' \code{\link{product_launch_forecast}} for anchoring-bias and
#' partial-pooling exercises.
#'
#' @examples
#' prior_launch_results |> head()
"prior_launch_results"
