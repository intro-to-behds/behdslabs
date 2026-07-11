#' Self-reported height at fitness-wearable app onboarding
#'
#' Self-reported height, as entered by users during onboarding of a
#' fitness-wearable app (needed for stride-length calibration), along with
#' the timestamp of entry and sex. Reported values are messy free text --
#' some in inches, some in feet-and-inches, some in cm, some clearly wrong
#' or nonsensical -- illustrating why raw user input needs cleaning before
#' analysis.
#'
#' \itemize{
#'   \item onboarding_timestamp. Date and time the value was entered.
#'   \item sex. Male or Female.
#'   \item reported_height_raw. Self-reported height, as free text (uncleaned).
#' }
#'
#' @docType data
#'
#' @usage wearable_onboarding_height
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::reported_heights} values (Irizarry & Gill),
#'   relabeled. The messy string content (unit confusion, jokes, obvious
#'   errors) is preserved unchanged, since it is specific to self-reported
#'   height and is the point of the exercise.
#'
#' @note These are not real wearable-app onboarding records. They are the
#'   original \code{dslabs::reported_heights} values, relabeled. A synthetic
#'   or real, ethically-sourced replacement is planned for a future release
#'   (see \code{BDS_development_plan.md} Phase 2).
#'
#' @examples
#' wearable_onboarding_height |> head()
"wearable_onboarding_height"
