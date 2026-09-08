#' Wearable signal-quality profiles by device cohort
#'
#' For each of 572 wearable recordings, the share of the recording falling
#' into eight signal-quality categories (they sum to about 100%), together
#' with the device it came from. A compositional-data / multivariate
#' classification benchmark: the eight proportions form a "profile" that
#' differs systematically by device type and model.
#'
#' \itemize{
#'   \item device_type. Device category: \code{smartwatch},
#'     \code{chest_strap}, or \code{smart_ring}.
#'   \item device_model. Specific device model (nested within
#'     \code{device_type}; 9 models).
#'   \item pct_clean. Percent of the recording with clean signal.
#'   \item pct_motion_artifact. Percent corrupted by movement.
#'   \item pct_poor_contact. Percent with poor skin/sensor contact.
#'   \item pct_baseline_drift. Percent with baseline wander.
#'   \item pct_saturation. Percent with a saturated (clipped) signal.
#'   \item pct_powerline_noise. Percent with mains-frequency interference.
#'   \item pct_dropout. Percent with dropped samples.
#'   \item pct_other. Percent in any other artifact category.
#' }
#'
#' @docType data
#'
#' @usage wearable_signal_profiles_by_cohort
#'
#' @format An object of class \code{"data.frame"} (572 x 10).
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::olive} values (Forina et al., Italian
#'   olive-oil fatty-acid composition, via Irizarry & Gill). All eight
#'   percentage columns are unchanged; the 8 fatty acids are relabeled 1:1
#'   to 8 signal-quality categories (\code{oleic} -> \code{pct_clean},
#'   etc.), \code{region} -> \code{device_type}, \code{area} ->
#'   \code{device_model}.
#'
#' @note These are not real signal-quality data. They are the original
#'   \code{dslabs::olive} values, relabeled for narrative fit. A synthetic
#'   or real, ethically-sourced replacement is planned for a future release
#'   (see \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** classifying a device (or a user segment) from a
#' vector of proportions is the same multivariate problem as classifying
#' user types from a multi-item UX-questionnaire profile. The compositional
#' constraint (the parts sum to a constant) is the same one you hit with
#' time-use budgets or budget-share data, and it matters for how you
#' visualise and model the features.
#'
#' @examples
#' table(wearable_signal_profiles_by_cohort$device_type)
#'
#' # Mean profile by device type
#' library(dplyr)
#' wearable_signal_profiles_by_cohort |>
#'   group_by(device_type) |>
#'   summarise(across(starts_with("pct_"), mean))
"wearable_signal_profiles_by_cohort"
