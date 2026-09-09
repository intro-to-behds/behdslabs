#' Long-run adoption-index trends for three technologies
#'
#' An adoption index for each of three technologies at 100 evenly spaced
#' points along a long timeline. A tidy long-format series for practising
#' multi-group trend visualisation over a long horizon.
#'
#' \itemize{
#'   \item year. Position along an abstract long-run timeline.
#'   \item technology. One of \code{smartphones}, \code{social_media},
#'     \code{streaming}.
#'   \item adoption_index. Adoption index for that technology at that time.
#' }
#'
#' @docType data
#'
#' @usage tech_adoption_trends
#'
#' @format An object of class \code{"data.frame"} (300 x 3).
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::greenhouse_gases} values (Irizarry &
#'   Gill). \code{concentration} values are unchanged; the three gases
#'   (CO2, CH4, N2O) are relabeled to three technologies and
#'   \code{concentration} -> \code{adoption_index}.
#'
#' @note These are not real technology-adoption data. They are the
#'   original \code{dslabs::greenhouse_gases} values, relabeled for
#'   narrative fit. A synthetic or real, ethically-sourced replacement is
#'   planned for a future release (see \code{BDS_development_plan.md}
#'   Phase 2).
#'
#' @details
#' **Teaching connection:** long-horizon trend visualisation -- one line
#' per group, a shared time axis -- is exactly the shape of multi-year
#' engagement or digital-divide trend data. The lesson is choosing a scale
#' and a smoother that show the secular trend without over-reading
#' short-run wiggles.
#'
#' @examples
#' library(ggplot2)
#' ggplot(tech_adoption_trends, aes(year, adoption_index, color = technology)) +
#'   geom_line()
"tech_adoption_trends"
