#' Sensor feature profiles across activity contexts
#'
#' A high-dimensional multi-class dataset: 189 sensor-window observations,
#' each summarised by 500 opaque numeric features, labelled with one of
#' seven activity contexts. Useful for dimension reduction (PCA), distance
#' calculations, clustering, and multi-class classification when the
#' number of features far exceeds interpretability.
#'
#' \itemize{
#'   \item x. A 189 x 500 numeric matrix of features
#'     (\code{feature_001} .. \code{feature_500}). The individual features
#'     are not meant to be interpreted.
#'   \item y. A factor of length 189 giving the activity context for each
#'     row: \code{walking}, \code{typing}, \code{reading},
#'     \code{meditating}, \code{gaming}, \code{driving}, \code{resting}.
#' }
#'
#' @docType data
#'
#' @usage sensor_activity_features
#'
#' @format An object of class \code{list} with components \code{x} (matrix)
#'   and \code{y} (factor).
#'
#' @keywords datasets
#'
#' @source Original \code{dslabs::tissue_gene_expression} values (Irizarry
#'   & Gill): gene-expression profiles across seven tissue types. The
#'   189 x 500 value matrix is unchanged; only the column names are
#'   replaced (gene symbols -> \code{feature_001} .. \code{feature_500}).
#'   The seven tissue types are relabeled 1:1 to seven activity contexts
#'   (cerebellum -> walking, colon -> typing, endometrium -> reading,
#'   hippocampus -> meditating, kidney -> gaming, liver -> driving,
#'   placenta -> resting).
#'
#' @note These are not real sensor data. They are the original
#'   \code{dslabs::tissue_gene_expression} values (Irizarry & Gill) with
#'   the feature names and class labels relabeled. A synthetic or real,
#'   ethically-sourced replacement is planned for a future release (see
#'   \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** the PCA + clustering workflow used to identify
#' tissue types from expression profiles is the same one used in UX
#' research to discover behavioural user archetypes from
#' clickstream / gesture / eye-tracking features -- each logged feature is
#' one column, each user segment one class. The "500 features, 189 rows"
#' shape also makes this a natural example for why \eqn{p \gg n} needs
#' care.
#'
#' @examples
#' dim(sensor_activity_features$x)
#' table(sensor_activity_features$y)
#'
#' # First two principal components, coloured by activity
#' pc <- prcomp(sensor_activity_features$x)$x[, 1:2]
#' plot(pc, col = as.numeric(sensor_activity_features$y), pch = 16)
"sensor_activity_features"
