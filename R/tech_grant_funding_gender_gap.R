#' Gender gap in tech research grant funding, by domain
#'
#' Applications, awards, and success rates for research grants across nine
#' technology domains (AI/ML, sensor hardware, wearable engineering, HCI,
#' software engineering, digital health, UX research, neurotech, and
#' interdisciplinary human-centric tech), split by applicant gender. Useful
#' for teaching gender-gap-in-funding analysis.
#'
#' \itemize{
#'   \item tech_domain. The technology domain.
#'   \item applications_total, applications_men, applications_women. Number of applications.
#'   \item awards_total, awards_men, awards_women. Number of awards.
#'   \item success_rates_total, success_rates_men, success_rates_women. Percent of applications awarded.
#' }
#'
#' @docType data
#'
#' @usage tech_grant_funding_gender_gap
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::research_funding_rates} values (Irizarry &
#'   Gill; van der Lee & Ellemers, PNAS 2015), relabeled -- only the
#'   \code{discipline} column is remapped to technology-domain names; all
#'   numeric columns are unchanged.
#'
#' @note These are not real grant-funding data. They are the original
#'   \code{dslabs::research_funding_rates} values, relabeled. A synthetic or
#'   real, ethically-sourced replacement is planned for a future release
#'   (see \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** gender disparities in tech hiring and
#' promotion show the same confounding pattern as this funding dataset --
#' aggregate differences can shrink or reverse once you condition on
#' domain/role. The same statistical approach (compare the aggregate gap
#' to the within-domain gaps) is used to audit algorithmic hiring tools
#' for disparate impact across demographic groups.
#'
#' @examples
#' tech_grant_funding_gender_gap
#'
#' # Overall success rate by gender -- does a gap appear in aggregate?
#' library(dplyr)
#' tech_grant_funding_gender_gap |>
#'   summarise(rate_men = sum(awards_men) / sum(applications_men),
#'             rate_women = sum(awards_women) / sum(applications_women))
#'
#' # Now break down by tech domain. Does the within-domain pattern match
#' # the aggregate pattern? (analogous to auditing a hiring tool by role)
#' library(ggplot2)
#' tech_grant_funding_gender_gap |>
#'   ggplot(aes(x = reorder(tech_domain, success_rates_men - success_rates_women),
#'              y = success_rates_men - success_rates_women)) +
#'   geom_col() + coord_flip() +
#'   labs(title = "Gender gap in success rate by tech domain")
"tech_grant_funding_gender_gap"
