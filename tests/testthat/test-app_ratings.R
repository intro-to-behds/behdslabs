test_that("app_ratings preserves movielens rating fields exactly", {
  expect_equal(app_ratings$app_id, movielens$movieId)
  expect_equal(app_ratings$year, movielens$year)
  expect_equal(app_ratings$user_id, movielens$userId)
  expect_equal(app_ratings$rating, movielens$rating)
  expect_equal(app_ratings$timestamp, movielens$timestamp)
  expect_equal(app_ratings$app_name, paste0("app_", movielens$movieId))
})

test_that("category is a deterministic map of the first source genre", {
  genre_to_category <- c(
    "Action" = "Games", "Adventure" = "Games", "Animation" = "Entertainment",
    "Children" = "Kids", "Comedy" = "Entertainment", "Crime" = "News",
    "Documentary" = "Education", "Drama" = "Entertainment", "Fantasy" = "Games",
    "Film-Noir" = "Entertainment", "Horror" = "Entertainment", "IMAX" = "Entertainment",
    "Musical" = "Music", "Mystery" = "Entertainment", "Romance" = "Lifestyle",
    "Sci-Fi" = "Games", "Thriller" = "Entertainment", "War" = "News",
    "Western" = "Entertainment", "(no genres listed)" = "Uncategorized"
  )
  first_genre <- sub("\\|.*$", "", as.character(movielens$genres))
  expected <- unname(genre_to_category[first_genre])
  expected[is.na(expected)] <- "Uncategorized"
  expect_equal(app_ratings$category, expected)
  expect_false(any(is.na(app_ratings$category)))
})
