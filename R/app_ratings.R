#' App ratings by user, app, and category
#'
#' Individual star ratings left by users for apps, with the app's store
#' category and release year and the rating timestamp. A behavioural-log
#' dataset for building and evaluating recommender systems (latent-factor
#' models, user/item effects, regularization).
#'
#' \itemize{
#'   \item app_id. Unique integer ID for the app.
#'   \item app_name. Anonymized app name (\code{app_<app_id>}).
#'   \item year. Year the app was released.
#'   \item category. The app's primary store category (a single value
#'     derived from the source data's first genre; see source).
#'   \item user_id. Unique integer ID for the user.
#'   \item rating. Star rating between 0 and 5.
#'   \item timestamp. Time the rating was given (seconds since epoch).
#' }
#'
#' @docType data
#'
#' @usage app_ratings
#'
#' @format An object of class \code{"data.frame"}.
#'
#' @keywords datasets
#'
#' @references
#' F. Maxwell Harper and Joseph A. Konstan. 2015. The MovieLens Datasets:
#' History and Context. ACM Transactions on Interactive Intelligent
#' Systems (TiiS) 5, 4, Article 19. \doi{10.1145/2827872}
#'
#' @source Original \code{dslabs::movielens} values (MovieLens Latest
#'   Small). \code{userId}, \code{rating}, \code{timestamp} and \code{year}
#'   are unchanged; \code{movieId} -> \code{app_id}; \code{title} ->
#'   \code{app_name} (a deterministic anonymized label); the multi-genre
#'   \code{genres} string is collapsed to a single \code{category} by
#'   mapping its first genre token through a fixed genre -> store-category
#'   table.
#'
#' @note These are not real app-rating data. They are the original
#'   \code{dslabs::movielens} (MovieLens) values, relabeled. A synthetic or
#'   real, ethically-sourced replacement is planned for a future release
#'   (see \code{BDS_development_plan.md} Phase 2).
#'
#' @details
#' **Teaching connection:** ratings are behavioural logs of preference --
#' the same structure as in-app ratings, thumbs up/down, or implicit
#' signals (play time, skip rate). The user-effect term in a latent-factor
#' model is the same individual response-style bias controlled for in UX
#' Likert surveys (some users rate everything high, some low).
#'
#' @examples
#' head(app_ratings)
#' table(app_ratings$category)
"app_ratings"
