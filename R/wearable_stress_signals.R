#' Wearable physiological signals and arousal state
#'
#' A binary classification benchmark: 569 wearable-recording windows, each
#' summarised by 30 physiological-signal features, labelled by the user's
#' arousal state (\code{low} or \code{high}). Ten base signals are each
#' summarised three ways -- window mean (\code{_mean}), within-window
#' variability (\code{_se}), and the extreme end of the window
#' (\code{_peak}) -- for 30 features in total. Useful for teaching feature
#' correlation / PCA, logistic regression vs. flexible classifiers, and the
#' sensitivity/specificity trade-off.
#'
#' \itemize{
#'   \item y. Arousal state: a factor with levels \code{"low"} and
#'     \code{"high"}.
#'   \item x. A 569 x 30 numeric matrix. Ten base signals, each with
#'     \code{_mean}, \code{_se}, and \code{_peak}:
#'     \itemize{
#'       \item heart_rate. Beats per minute.
#'       \item hrv_rmssd. Heart-rate variability (beat-to-beat).
#'       \item breathing_rate. Breaths per minute.
#'       \item motion_intensity. Accelerometer-derived movement magnitude.
#'       \item eda_tonic. Skin-conductance level.
#'       \item eda_phasic. Skin-conductance responses.
#'       \item skin_temp. Peripheral skin temperature.
#'       \item pulse_amplitude. Blood-volume-pulse amplitude.
#'       \item beat_regularity. Regularity of inter-beat intervals.
#'       \item signal_complexity. Nonlinear complexity of the signal.
#'     }
#' }
#'
#' @docType data
#'
#' @usage wearable_stress_signals
#'
#' @format An object of class \code{list} with components \code{x} (a
#'   569 x 30 matrix) and \code{y} (a length-569 factor).
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::brca} values (Breast Cancer Wisconsin
#'   Diagnostic dataset, UCI ML Repository, via Irizarry & Gill). The
#'   569 x 30 value matrix is unchanged; the 10 base nuclear measurements
#'   are relabeled to 10 wearable signals, the \code{mean}/\code{se}/
#'   \code{worst} suffixes become \code{mean}/\code{se}/\code{peak}, and
#'   the \code{B}/\code{M} (benign/malignant) label becomes
#'   \code{low}/\code{high} arousal.
#'
#' @note These are not real physiological data. They are the original
#'   \code{dslabs::brca} values (Irizarry & Gill; UCI), relabeled for
#'   narrative fit. A synthetic or real, ethically-sourced replacement is
#'   planned for a future release (see \code{BDS_development_plan.md}
#'   Phase 2).
#'
#' @details
#' **Teaching connection:** the binary-classification pipeline here --
#' extract many correlated features, pick a model, tune the
#' sensitivity/specificity trade-off -- is identical to building a
#' user-churn predictor or an app-store fake-review detector from
#' behavioural signals. Missing a true churner vs. raising a false alarm
#' is the same cost asymmetry as missing a tumour vs. an unnecessary
#' biopsy.
#'
#' @examples
#' table(wearable_stress_signals$y)
#' dim(wearable_stress_signals$x)
#'
#' # Strongly correlated feature block (as in the source data)
#' round(cor(wearable_stress_signals$x[, c("heart_rate_mean",
#'                                         "breathing_rate_mean",
#'                                         "motion_intensity_mean")]), 2)
"wearable_stress_signals"
