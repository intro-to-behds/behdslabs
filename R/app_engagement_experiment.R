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
#' @details
#' **Teaching connection:** the two-factor design (UI version x cohort)
#' directly mirrors a UX A/B experiment testing two interface variants
#' across two user groups (e.g. interface version x expertise level). The
#' interaction term is crucial: an interface change that helps one cohort
#' may slow down another. This is the same two-way ANOVA logic used to
#' analyse UI-version x user-group study data.
#'
#' @examples
#' app_engagement_experiment |> head()
#' with(app_engagement_experiment, table(sex, ui_version))
#'
#' # Is the effect of UI version on engagement the same across sexes?
#' # (interaction term = "does the redesign help one group more than the other")
#' fit <- aov(engagement_score ~ ui_version * sex, data = app_engagement_experiment)
#' summary(fit)
#'
#' library(ggplot2)
#' ggplot(app_engagement_experiment, aes(x = ui_version, y = error_rate_pct, fill = sex)) +
#'   geom_violin() + geom_jitter(width = 0.1, alpha = 0.3) +
#'   labs(title = "Interaction plot: UI version x user group")
"app_engagement_experiment"
