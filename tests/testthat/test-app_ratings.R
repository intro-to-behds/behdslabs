test_that("app_ratings preserves movielens rows; rating is scaled by .reflavor_k", {
  expect_equal(app_ratings$app_id, movielens$movieId)
  expect_equal(app_ratings$year, movielens$year)
  expect_equal(app_ratings$user_id, movielens$userId)
  expect_equal(app_ratings$timestamp, movielens$timestamp)
  k <- behdslabs:::.reflavor_k$app_ratings[["rating"]]
  expect_equal(app_ratings$rating, k * movielens$rating)
  expect_true(all(app_ratings$rating != movielens$rating))
})

test_that("app_name is a unique, non-missing label per app", {
  items <- unique(app_ratings[, c("app_id", "app_name")])
  expect_false(anyNA(items$app_name))
  expect_equal(anyDuplicated(items$app_id), 0)
  expect_equal(anyDuplicated(items$app_name), 0)
  expect_false(any(grepl("^app_[0-9]+$", items$app_name)))
})

test_that("hand-curated names used in the book are in place", {
  items <- unique(app_ratings[, c("app_id", "app_name", "category")])
  curated <- c("260" = "Space saga game IV", "1196" = "Space saga game V",
               "1210" = "Space saga game VI", "858" = "Vesuvio mafia game",
               "1221" = "Vesuvio mafia game II", "3252" = "Vesuvio tango game",
               "1213" = "Mob family crime game",
               "539" = "Long-distance dating app",
               "2424" = "Pen-pal dating app")
  got <- items$app_name[match(as.integer(names(curated)), items$app_id)]
  expect_equal(got, unname(curated))
  expect_equal(items$category[items$app_id == 539], "Lifestyle")
})

test_that("generated names and categories follow the first/last genre rule", {
  genre_noun <- c(
    "Action" = "action game", "Adventure" = "adventure game",
    "Animation" = "cartoon app", "Children" = "kids app",
    "Comedy" = "comedy video app", "Crime" = "crime game",
    "Documentary" = "documentary app", "Drama" = "drama series app",
    "Fantasy" = "fantasy RPG", "Film-Noir" = "noir detective game",
    "Horror" = "horror game", "Musical" = "music app",
    "Mystery" = "puzzle game", "Romance" = "dating app",
    "Sci-Fi" = "sci-fi game", "Thriller" = "thriller game",
    "War" = "war news app", "Western" = "western game"
  )
  genre_to_category <- c(
    "Action" = "Games", "Adventure" = "Games", "Animation" = "Kids",
    "Children" = "Kids", "Comedy" = "Entertainment", "Crime" = "Games",
    "Documentary" = "Education", "Drama" = "Entertainment", "Fantasy" = "Games",
    "Film-Noir" = "Games", "Horror" = "Games", "Musical" = "Music",
    "Mystery" = "Games", "Romance" = "Lifestyle", "Sci-Fi" = "Games",
    "Thriller" = "Games", "War" = "News", "Western" = "Games"
  )
  items <- unique(data.frame(app_id = app_ratings$app_id,
                             app_name = app_ratings$app_name,
                             category = app_ratings$category,
                             genres = as.character(movielens$genres)))
  generated <- endsWith(items$app_name, paste0(" ", items$app_id))
  expect_gt(sum(generated), 8900)
  items <- items[generated, ]
  genres <- lapply(strsplit(items$genres, "|", fixed = TRUE),
                   setdiff, c("IMAX", "(no genres listed)"))
  first <- vapply(genres, function(g) if (length(g)) g[1] else NA_character_, "")
  noun <- ifelse(is.na(first), "uncategorized app", genre_noun[first])
  label <- tolower(sub(" [0-9]+$", "", items$app_name))
  expect_true(all(endsWith(label, tolower(unname(noun)))))
  expected <- ifelse(is.na(first), "Uncategorized", genre_to_category[first])
  expect_equal(items$category, unname(expected))
  expect_false(anyNA(app_ratings$category))
})
