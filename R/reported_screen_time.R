#' Raw, messy self-reported daily screen time
#'
#' A web form asked respondents for their average daily screen time,
#' in minutes, as a single number. As with any free-text field, many
#' respondents ignored the instructions: some used an hours-and-minutes
#' shorthand borrowed from feet-and-inches notation, some wrote a
#' decimal that was really a clock time typed as if it were a fraction
#' (meaning 2 hours 30 minutes, not 2.3 hours), some reported the total
#' in seconds instead of minutes, and a few entries are simply
#' unusable. This is the raw, uncleaned character column -- the case
#' study for teaching string processing and regular expressions.
#'
#' \itemize{
#'   \item time_stamp. Submission timestamp.
#'   \item platform. Self-reported phone platform (iOS or Android); not
#'     used by the string-processing case study, included for realism.
#'   \item screen_time. The raw, messy free-text entry. Most values are
#'     already a plausible number of minutes. Among the rest: an
#'     hours-and-minutes shorthand analogous to feet-and-inches notation
#'     (two hours fifteen minutes written like a feet-inches height, or
#'     as \code{2h15m}); a digit-literal decimal typo for the same thing
#'     (e.g. \code{2.30} meaning 2 hours 30 minutes); a bare number that
#'     is actually seconds (needs dividing by 60); a bare decimal below
#'     1 that is actually hours (needs multiplying by 60); and outright
#'     junk.
#' }
#'
#' @docType data
#'
#' @usage reported_screen_time
#'
#' @format A data frame with 1095 rows and 3 columns.
#'
#' @keywords datasets
#'
#' @source Independently synthesized (see
#'   \code{inst/script/make-reported_screen_time.R}). Modeled on the
#'   messy-format pattern of \code{dslabs::reported_heights} (which has
#'   the same feet-and-inches / decimal-typo / alternate-unit structure,
#'   just for height in inches) -- there is no real dslabs dataset for
#'   this case study, so values are simulated rather than relabeled from
#'   an existing source, in the spirit of \code{dslabs::outlier_example}
#'   (itself simulated for the same reason: no real dataset happened to
#'   illustrate the exact teaching point needed).
#'
#' @note This is not real screen-time data. It is a synthetic dataset
#'   built to reproduce the same category of messy free-text entries as
#'   \code{dslabs::reported_heights}, so the string-processing chapter's
#'   regex lessons carry over with a behavioural-data-science-flavoured
#'   example. See \code{BDS_development_plan.md} Phase 2 for the general
#'   plan on real vs. synthetic datasets.
#'
#' @details
#' **Teaching connection:** free-text numeric fields in survey tools
#' (Qualtrics, Google Forms, REDCap) collect exactly this kind of mess in
#' real behavioural research -- self-reported duration, dosage, or
#' age-of-onset fields routinely mix units and typo'd decimals. Cleaning
#' this column with regex is the same skill needed before any analysis
#' of real self-report duration data.
#'
#' @examples
#' library(dplyr)
#' library(stringr)
#'
#' head(reported_screen_time)
#'
#' # How many entries are not already a plausible number of minutes?
#' problems <- reported_screen_time |>
#'   mutate(minutes = suppressWarnings(as.numeric(screen_time))) |>
#'   filter(is.na(minutes) | minutes < 15 | minutes > 600) |>
#'   pull(screen_time)
#' length(problems)
"reported_screen_time"
