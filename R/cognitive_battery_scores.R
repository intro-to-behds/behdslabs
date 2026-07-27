#' Score frequencies across a cognitive test battery
#'
#' For each possible score (0-100), the number of test-takers who achieved
#' that score on each of five tasks in a cognitive test battery. Useful for
#' illustrating and comparing distribution shapes.
#'
#' \itemize{
#'   \item score. Possible score, 0 to 100.
#'   \item attention_task. Number of test-takers scoring this on the attention task.
#'   \item memory_task. Number of test-takers scoring this on the memory task.
#'   \item usability_task. Number of test-takers scoring this on the usability task.
#'   \item reading_task. Number of test-takers scoring this on the reading task.
#'   \item reasoning_task. Number of test-takers scoring this on the reasoning task.
#' }
#'
#' @docType data
#'
#' @usage cognitive_battery_scores
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::nyc_regents_scores} values (Irizarry &
#'   Gill), relabeled.
#'
#' @note These are not real cognitive-testing data. They are the original
#'   \code{dslabs::nyc_regents_scores} values, relabeled. A synthetic or
#'   real, ethically-sourced replacement is planned for a future release
#'   (see \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** the source data (NY Regents exam scores) is
#' known for a spike right at the historical passing threshold, a
#' response-clustering artifact from grader behaviour near a
#' pass/fail cutoff. A cognitive battery has no equivalent hard cutoff,
#' so don't over-read a "passing score" into this data -- but the general
#' phenomenon (respondents' scores clustering near a benchmark value) is
#' exactly what shows up as anchoring on validated-scale thresholds (e.g.
#' SUS = 68, or a Likert midpoint) in usability research, and the same
#' histogram-based detection method applies.
#'
#' @examples
#' cognitive_battery_scores |> head()
#'
#' # Visualise all five task distributions side by side.
#' library(tidyr); library(ggplot2)
#' pivot_longer(cognitive_battery_scores, -score, names_to = "task", values_to = "freq") |>
#'   ggplot(aes(x = score, y = freq)) + geom_col() + facet_wrap(~task) +
#'   labs(title = "Score distribution by task")
#'
#' # Generic check for clustering near any benchmark value `b` (e.g. the
#' # ratio of frequency at b to the average of the few scores just below
#' # it) -- the same check used to detect anchoring at a usability-scale
#' # threshold such as SUS = 68. Note: `score` has a trailing NA row, so
#' # guard the equality check with !is.na() before subsetting.
#' b <- 65
#' cognitive_battery_scores |>
#'   dplyr::summarise(across(-score, ~ .[!is.na(score) & score == b] /
#'                              mean(.[score %in% (b - 3):(b - 1)], na.rm = TRUE),
#'                           .names = "{.col}_spike"))
"cognitive_battery_scores"
