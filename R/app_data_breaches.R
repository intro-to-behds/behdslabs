#' Reported data-breach incidents by US state
#'
#' Number of reported data-breach/cyber-incident notifications per US state,
#' alongside state population -- often used as an example of why raw counts
#' need to be adjusted for population before comparing across regions.
#'
#' \itemize{
#'   \item state. Name of state.
#'   \item abb. Two letter abbreviation of state name.
#'   \item region. Geographical region of state.
#'   \item population. Population of state.
#'   \item incidents. Number of reported data-breach/cyber-incident notifications.
#' }
#'
#' @docType data
#'
#' @usage app_data_breaches
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source US Census Bureau, uspopulation.org. Incident counts are the
#'   original \code{dslabs::murders$total} values, relabeled.
#'
#' @note These values are not real data-breach/incident data. They are the
#'   original \code{dslabs::murders} values (Irizarry & Gill), relabeled for
#'   narrative fit. A synthetic or real, ethically-sourced replacement is
#'   planned for a future release (see \code{BDS_development_plan.md} Phase 2).
#'
#' @examples
#' app_data_breaches
"app_data_breaches"
