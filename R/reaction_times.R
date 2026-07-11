#' Simple reaction times by sex
#'
#' Simulated simple-reaction-time measurements (in milliseconds), split by
#' sex -- commonly used to illustrate distributions and group comparisons.
#'
#' \itemize{
#'   \item sex. Male or Female.
#'   \item rt_ms. Reaction time in milliseconds.
#' }
#'
#' @docType data
#'
#' @usage reaction_times
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Linear rescale of \code{dslabs::heights$height} (inches) to a
#'   200-500ms range via \code{rt_ms = 200 + (height - min) / (max - min) * 300}.
#'
#' @note These values are not real reaction-time data. They are the original
#'   \code{dslabs::heights} values (Irizarry & Gill), linearly rescaled for
#'   narrative fit -- the shape of the distribution and the sex comparison
#'   are unchanged from the original heights data. A synthetic or real,
#'   ethically-sourced replacement is planned for a future release (see
#'   \code{BDS_development_plan.md} Phase 2).
#'
#' @examples
#' reaction_times |> head()
#' with(reaction_times, tapply(rt_ms, sex, mean))
"reaction_times"
