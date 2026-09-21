#' Simulate a signal detection task
#'
#' Generates trial counts for a yes/no detection task under the standard
#' equal-variance signal detection model. On each trial the participant
#' receives some evidence -- drawn from a distribution centred at \eqn{d'} when
#' a signal is present, and at 0 when it is not -- and answers "yes" whenever
#' that evidence exceeds their decision criterion.
#'
#' The reason this matters for a measurement course is that the two parameters
#' are separable, and the obvious summary is not. Proportion correct mixes
#' \emph{sensitivity} (\eqn{d'}, how well the person can tell signal from
#' noise -- the construct) with \emph{response bias} (the criterion, how
#' willing they are to say "yes" -- not the construct). Two participants can
#' score identically and differ substantially in ability. Pass vectors to
#' \code{d_prime} and \code{criterion} to construct exactly that case.
#'
#' Note that this is a \emph{simulator}, not one of the package's relabeled
#' datasets: it is not derived from a \code{dslabs} original, so the
#' reflavoring rules documented in \code{REFLAVORING_PLAN.md} do not apply.
#'
#' @param n Number of participants.
#' @param n_trials Number of trials per participant.
#' @param signal_prob Proportion of trials on which a signal is present.
#' @param d_prime Sensitivity, in standard deviation units. Either one value
#'   (shared by all participants) or one value per participant.
#' @param criterion Response bias, in standard deviation units. Zero is
#'   unbiased; positive values make the participant more conservative (less
#'   likely to answer "yes"), negative values more liberal.
#'   Either one value or one per participant.
#' @param seed Optional integer passed to \code{set.seed()} for
#'   reproducibility.
#'
#' @return A data frame with one row per participant and the columns:
#'   \code{participant}, \code{hits}, \code{misses}, \code{false_alarms},
#'   \code{correct_rejections}, \code{prop_correct}, and the generating values
#'   \code{d_prime} and \code{criterion}.
#'
#' @seealso \code{\link{simulate_likert}}
#'
#' @examples
#' # Two participants with very different sensitivity, whose response bias
#' # leaves them with the same proportion correct: the first is doing as well
#' # as their d' allows, the second is answering "yes" far too readily.
#' sdt <- simulate_sdt(n = 2, n_trials = 2000,
#'                     d_prime = c(0.8, 2.0),
#'                     criterion = c(0.4, -0.475),
#'                     seed = 2026)
#' sdt
#'
#' # Recovering d' from the counts: the difference between the hit rate and
#' # the false-alarm rate, on the z scale.
#' hit_rate <- sdt$hits / (sdt$hits + sdt$misses)
#' fa_rate <- sdt$false_alarms / (sdt$false_alarms + sdt$correct_rejections)
#' qnorm(hit_rate) - qnorm(fa_rate)
#'
#' @export
simulate_sdt <- function(n = 40,
                         n_trials = 100,
                         signal_prob = 0.5,
                         d_prime = 1.5,
                         criterion = 0,
                         seed = NULL){
  .simulate_sdt(n = n, n_trials = n_trials, signal_prob = signal_prob,
                d_prime = d_prime, criterion = criterion, seed = seed)
}
