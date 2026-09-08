#' Daily active users around a major app-outage event
#'
#' A daily time series of active-user counts spanning a period that
#' includes a disruptive event (a prolonged outage / forced update).
#' Useful for interrupted-time-series analysis: fitting an expected
#' baseline from the pre-event data and estimating the "excess" (observed
#' minus expected) engagement loss afterwards.
#'
#' \itemize{
#'   \item date. Date of the observation.
#'   \item daily_active_users. Number of active users on that date.
#' }
#'
#' @docType data
#'
#' @usage app_outage_engagement_impact
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::pr_death_counts} values (Irizarry &
#'   Gill): daily death counts in Puerto Rico around Hurricane Maria
#'   (2017). Counts are unchanged; \code{deaths} -> \code{daily_active_users}
#'   and the event is reframed as an app outage.
#'
#' @note These are not real app-usage data. They are the original
#'   \code{dslabs::pr_death_counts} values (Irizarry & Gill), relabeled. A
#'   synthetic or real, ethically-sourced replacement is planned for a
#'   future release (see \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** excess-mortality estimation (observed minus
#' expected deaths) is the same interrupted-time-series method used to
#' measure the engagement impact of a major outage or a controversial
#' redesign -- including the same difficulty of choosing a defensible
#' pre-event baseline (seasonality, trend, day-of-week effects).
#'
#' @examples
#' with(app_outage_engagement_impact, plot(date, daily_active_users, type = "l"))
"app_outage_engagement_impact"
