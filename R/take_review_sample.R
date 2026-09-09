#' Simulate drawing a sample of reviews from a large pool
#'
#' Draws a random sample (with replacement) of \code{Positive}/
#' \code{Negative} reviews from a pool whose true positive rate is not
#' shown, and plots it, so students can try to estimate that rate and see
#' how the estimate varies from sample to sample.
#'
#' This is a review-sampling reframing of \code{\link{take_poll}} (the
#' blue/red bead simulator): each "sample" is one usability study with
#' \code{n} participants, and repeated studies yield different satisfaction
#' estimates -- motivating why confidence intervals matter before
#' reporting a benchmark.
#'
#' @param n Sample size.
#' @param ... Additional arguments, e.g. \code{positive_prob} (the true
#'   positive rate, default 0.529), \code{return_values = TRUE} to return
#'   the sampled labels, or \code{plot = FALSE} to suppress the plot.
#'
#' @return Invisibly \code{NULL}, or (with \code{return_values = TRUE}) a
#'   character vector of \code{"Positive"}/\code{"Negative"}.
#'
#' @seealso [take_poll()]
#'
#' @examples
#' take_review_sample(25)
#'
#' @export
take_review_sample <- function(n, ...){
  .take_review_sample(n, ...)
}
