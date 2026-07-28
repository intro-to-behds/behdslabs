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
#' @details
#' **Teaching connection:** computing population-adjusted rates and
#' comparing regional patterns is the same operation used to analyse
#' regional variation in smartphone theft reports, cyberbullying
#' incidents per user, or privacy-complaint rates across states. The
#' workflow here (rate per capita, compare by region) is a template for
#' any geographically stratified behavioural-technology dataset.
#'
#' @examples
#' app_data_breaches
#'
#' # Rate per 100,000 population -- the same formula used for incident
#' # rates per 100,000 installs or cybercrime reports per 100,000 users.
#' library(dplyr)
#' app_data_breaches |>
#'   mutate(rate = incidents / population * 1e5) |>
#'   group_by(region) |>
#'   summarise(mean_rate = mean(rate)) |>
#'   arrange(desc(mean_rate))
#'
#' # Does raw count mislead about regional risk, as it can when comparing
#' # large vs. small user bases in app analytics?
#' with(app_data_breaches, cor(population, incidents))
"app_data_breaches"
