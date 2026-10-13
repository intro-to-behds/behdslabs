#' UX questionnaire scores by device
#'
#' Overall scores (0--100) on a user-experience questionnaire, for 1,050
#' users of an app, with the device they used it on. The distribution is
#' approximately normal, which makes the dataset a convenient first example
#' of distributions, the normal approximation, and quantile-quantile plots.
#'
#' \itemize{
#'   \item device. desktop or mobile.
#'   \item ux_score. Overall UX questionnaire score, from 0 to 100.
#' }
#'
#' @docType data
#'
#' @usage ux_scores
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Linear rescale of \code{dslabs::heights$height} (inches) to the
#'   0--100 range via \code{ux_score = (height - min) / (max - min) * 100};
#'   \code{device} is \code{"desktop"} where \code{sex} is \code{"Male"} and
#'   \code{"mobile"} where it is \code{"Female"}.
#'
#' @note These are not real UX data. The values are the real self-reported
#'   heights of \code{dslabs::heights} (Irizarry & Gill), linearly rescaled:
#'   the shape of the distributions and the difference between the two
#'   groups are those of the original data, while the UX questionnaire and
#'   device framing are fictional.
#'
#' @examples
#' ux_scores |> head()
#' with(ux_scores, tapply(ux_score, device, mean))
"ux_scores"
