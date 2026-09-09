#' A deep-time connectivity index
#'
#' A single connectivity index reconstructed over an extremely long
#' timeline (hundreds of thousands of years), from two kinds of evidence:
#' direct measurement in the recent past, and indirect reconstruction
#' before that. Useful for practising how to frame, scale, and annotate
#' data that spans wildly different time resolutions.
#'
#' \itemize{
#'   \item year. Year (can be strongly negative -- deep past).
#'   \item connectivity_index. The connectivity index at that time.
#'   \item source. How the value was obtained: \code{"direct"} (recent
#'     direct measurement) or \code{"reconstructed"} (indirect estimate).
#' }
#'
#' @docType data
#'
#' @usage connectivity_deep_history
#'
#' @format A tibble (694 x 3).
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::historic_co2} values (Irizarry & Gill).
#'   \code{year} and \code{co2} values are unchanged (\code{co2} ->
#'   \code{connectivity_index}); \code{source} "Mauna Loa"/"Ice Cores" ->
#'   "direct"/"reconstructed".
#'
#' @note These are not real connectivity data. They are the original
#'   \code{dslabs::historic_co2} values, relabeled for narrative fit. A
#'   synthetic or real, ethically-sourced replacement is planned for a
#'   future release (see \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** presenting technology-change data that reaches
#' from a few years ago back to a scale where human intuition breaks down
#' is a real framing problem -- the recent, high-resolution, directly
#' measured part and the deep, sparse, reconstructed part need different
#' visual treatment and carry different uncertainty.
#'
#' @examples
#' library(ggplot2)
#' # Recent, directly measured window only
#' ggplot(subset(connectivity_deep_history, source == "direct"),
#'        aes(year, connectivity_index)) +
#'   geom_line()
"connectivity_deep_history"
