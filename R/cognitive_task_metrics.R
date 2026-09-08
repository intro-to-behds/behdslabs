#' Cognitive-load and arousal metrics for 96 task sessions
#'
#' Two metrics recorded during 96 short cognitive-task sessions, plus the
#' task performed. A visualization-driven-discovery teaching set: plotting
#' the two continuous metrics against each other reveals distinct clusters
#' of task types, without using the label.
#'
#' \itemize{
#'   \item session. Anonymized session identifier (\code{"S01"}..\code{"S96"}).
#'   \item cognitive_load. Cognitive-load index for the session.
#'   \item arousal_index. Physiological-arousal index (arbitrary units).
#'   \item task_type. The task performed: \code{stroop},
#'     \code{visual_search}, \code{mental_arithmetic}, \code{sorting},
#'     \code{planning}, \code{reading}, \code{free_recall}, or one of
#'     \code{n_back_1}/\code{n_back_2}/\code{n_back_3}.
#' }
#'
#' @docType data
#'
#' @usage cognitive_task_metrics
#'
#' @format An object of class \code{"data.frame"} (96 x 4).
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::stars} values (physical properties of
#'   stars, via Irizarry & Gill). \code{magnitude} and \code{temp} values
#'   are unchanged (\code{magnitude} -> \code{cognitive_load}, \code{temp}
#'   -> \code{arousal_index}); \code{star} -> anonymized \code{session};
#'   the 10 OBAFGKM(+white-dwarf) spectral classes are relabeled 1:1 to 10
#'   task types.
#'
#' @note These are not real cognitive-task data. They are the original
#'   \code{dslabs::stars} values, relabeled for narrative fit. A synthetic
#'   or real, ethically-sourced replacement is planned for a future release
#'   (see \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** the Hertzsprung-Russell diagram (magnitude vs.
#' temperature) famously separates stars into a main sequence, giants, and
#' white dwarfs just by plotting two numbers. The same move -- a 2D scatter
#' of two behavioural metrics -- is how UX researchers surface latent user
#' groups or task-difficulty tiers from usability data before fitting any
#' model.
#'
#' @examples
#' plot(cognitive_task_metrics$arousal_index,
#'      cognitive_task_metrics$cognitive_load,
#'      col = factor(cognitive_task_metrics$task_type), pch = 16)
"cognitive_task_metrics"
