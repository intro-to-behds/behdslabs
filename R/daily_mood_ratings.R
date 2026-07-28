#' Daily mood ratings on a 7-point scale, with missing data
#'
#' A vector of daily mood ratings on a 1-7 Likert scale, including missing
#' values (participants who did not respond on a given day). Useful for
#' teaching how to handle missing data.
#'
#' @docType data
#'
#' @usage daily_mood_ratings
#'
#' @format An integer vector, with \code{NA}s for missing responses.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::na_example} values (Irizarry & Gill),
#'   relabeled -- no rescaling needed, as the original 1-7 integer range
#'   already reads naturally as a Likert scale.
#'
#' @note These are not real mood-rating data. They are the original
#'   \code{dslabs::na_example} values, relabeled. A synthetic or real,
#'   ethically-sourced replacement is planned for a future release (see
#'   \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** in daily-diary and ecological momentary
#' assessment studies, participants skip days, abandon the study
#' mid-way, or fail attention checks. Whether the missingness is random
#' (MCAR), conditional on something you observed (MAR -- e.g. participants
#' who had a bad day skip the check-in), or systematic and unobserved
#' (MNAR -- the lowest-mood participants simply stop responding) changes
#' how safe it is to compute an aggregate mood score at all.
#'
#' @examples
#' table(daily_mood_ratings, useNA = "always")
#'
#' # What proportion of days are missing?
#' mean(is.na(daily_mood_ratings))
#'
#' # How much does excluding missing values change the mean? Critical when
#' # scoring a mood/wellbeing index with incomplete daily responses.
#' mean(daily_mood_ratings, na.rm = TRUE)
#' # What would the mean be if missing days were disproportionately from
#' # low-mood participants (MNAR)? Discuss the implications.
"daily_mood_ratings"
