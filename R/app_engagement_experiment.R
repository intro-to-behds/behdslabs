#' App-engagement A/B experiment
#'
#' A two-factor experiment comparing a standard vs. redesigned app UI across
#' user cohorts, measuring engagement, consistency, and error rate. Useful
#' for teaching factorial experimental design (UI version x cohort).
#'
#' \itemize{
#'   \item engagement_score. Overall engagement score.
#'   \item consistency_index. Session-to-session consistency index.
#'   \item error_rate_pct. Percent of sessions containing a user error.
#'   \item sex. F or M (demographic covariate).
#'   \item ui_version. standard or redesigned.
#'   \item cohort. User cohort identifier.
#'   \item test_batch. Which of two testing batches the observation belongs to.
#' }
#'
#' @docType data
#'
#' @usage app_engagement_experiment
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::mice_weights} values (data provided by
#'   Karen Svenson, Jackson Laboratories), relabeled.
#'
#' @note These are not real app-usage or engagement data. They are the
#'   original \code{dslabs::mice_weights} values, relabeled. A synthetic or
#'   real, ethically-sourced replacement is planned for a future release
#'   (see \code{BDS_development_plan.md} Phase 2).
#'
#' @examples
#' app_engagement_experiment |> head()
#' with(app_engagement_experiment, table(sex, ui_version))
"app_engagement_experiment"
