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
#' @examples
#' table(daily_mood_ratings, useNA = "always")
"daily_mood_ratings"
