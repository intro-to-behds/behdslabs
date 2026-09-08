# Tier-1 reflavoring: rename/rescale existing dslabs datasets into
# Behavioural Data Science / digital-technology / wearable / neurophysiological
# themed examples for teaching. NUMERIC VALUES are preserved exactly, or
# linearly rescaled where noted -- these are NOT real behavioural, usage, or
# physiological data. See each dataset's @note in R/ for the full disclaimer,
# and BDS_development_plan.md (Phase 2) for the planned synthetic-data
# replacement.
#
# This script is the single source of truth for the transforms. The
# correspondence tests in tests/testthat/ re-derive the same values from the
# constants below to guard against drift.

library(usethis)

# --- 1. murders -> app_data_breaches -----------------------------------
load("data/murders.rda")
app_data_breaches <- data.frame(
  state = murders$state,
  abb = murders$abb,
  region = murders$region,
  population = murders$population,
  incidents = murders$total
)
usethis::use_data(app_data_breaches, overwrite = TRUE)

# --- 2. heights -> reaction_times ---------------------------------------
load("data/heights.rda")
.rt_from_height <- function(height) {
  rng <- range(heights$height)
  200 + (height - rng[1]) / (rng[2] - rng[1]) * 300
}
reaction_times <- data.frame(
  sex = heights$sex,
  rt_ms = .rt_from_height(heights$height)
)
usethis::use_data(reaction_times, overwrite = TRUE)

# --- 3. reported_heights -> wearable_onboarding_height -------------------
# Kept as a HEIGHT self-report (not screen time): the messy free-text entries
# (feet'inches, cm, decimals, jokes like ">9000") are specific to height and
# don't translate to other units. Reframed as a fitness-wearable app asking
# users to self-report height at onboarding (for stride-length calibration).
load("data/reported_heights.rda")
wearable_onboarding_height <- data.frame(
  onboarding_timestamp = reported_heights$time_stamp,
  sex = reported_heights$sex,
  reported_height_raw = reported_heights$height
)
usethis::use_data(wearable_onboarding_height, overwrite = TRUE)

# --- 4. admissions -> app_task_completion --------------------------------
load("data/admissions.rda")
app_task_completion <- data.frame(
  task = admissions$major,
  device = ifelse(admissions$gender == "men", "mobile", "desktop"),
  completion_rate = admissions$admitted,
  n_attempts = admissions$applicants
)
usethis::use_data(app_task_completion, overwrite = TRUE)

# --- 5. mice_weights -> app_engagement_experiment ------------------------
load("data/mice_weigths.rda")
app_engagement_experiment <- data.frame(
  engagement_score = mice_weights$body_weight,
  consistency_index = mice_weights$bone_density,
  error_rate_pct = mice_weights$percent_fat,
  sex = mice_weights$sex,
  ui_version = factor(ifelse(mice_weights$diet == "chow", "standard", "redesigned")),
  cohort = mice_weights$gen,
  test_batch = mice_weights$litter
)
usethis::use_data(app_engagement_experiment, overwrite = TRUE)

# --- 6. nyc_regents_scores -> cognitive_battery_scores -------------------
load("data/nyc_regents_scores.rda")
cognitive_battery_scores <- data.frame(
  score = nyc_regents_scores$score,
  attention_task = nyc_regents_scores$integrated_algebra,
  memory_task = nyc_regents_scores$global_history,
  usability_task = nyc_regents_scores$living_environment,
  reading_task = nyc_regents_scores$english,
  reasoning_task = nyc_regents_scores$us_history
)
usethis::use_data(cognitive_battery_scores, overwrite = TRUE)

# --- 7. outlier_example -> reported_daily_screen_time --------------------
load("data/outlier_example.rda")
reported_daily_screen_time <- outlier_example
usethis::use_data(reported_daily_screen_time, overwrite = TRUE)

# --- 8. na_example -> daily_mood_ratings ---------------------------------
load("data/na_example.rda")
daily_mood_ratings <- na_example
usethis::use_data(daily_mood_ratings, overwrite = TRUE)

# --- 9. death_prob -> app_churn_prob --------------------------------------
load("data/death_prob.rda")
app_churn_prob <- data.frame(
  age = death_prob$age,
  sex = death_prob$sex,
  churn_prob = death_prob$prob
)
usethis::use_data(app_churn_prob, overwrite = TRUE)

# --- 10. polls_2008 -> feature_preference_trend --------------------------
load("data/polls_2008.rda")
feature_preference_trend <- data.frame(
  days_before_launch = polls_2008$day,
  preference_margin = polls_2008$margin
)
usethis::use_data(feature_preference_trend, overwrite = TRUE)

# --- 11. research_funding_rates -> tech_grant_funding_gender_gap ---------
load("data/research_funding_rates.rda")
.domain_map <- c(
  "Chemical sciences" = "AI/ML Research",
  "Physical sciences" = "Sensor Hardware",
  "Physics" = "Wearable Engineering",
  "Humanities" = "HCI & Digital Humanities",
  "Technical sciences" = "Software Engineering",
  "Interdisciplinary" = "Human-Centric Tech (Interdisciplinary)",
  "Earth/life sciences" = "Digital Health & Biosensing",
  "Social sciences" = "UX & Behavioural Research",
  "Medical sciences" = "Neurotech & Clinical Applications"
)
tech_grant_funding_gender_gap <- research_funding_rates
tech_grant_funding_gender_gap$discipline <- unname(.domain_map[research_funding_rates$discipline])
names(tech_grant_funding_gender_gap)[names(tech_grant_funding_gender_gap) == "discipline"] <- "tech_domain"
usethis::use_data(tech_grant_funding_gender_gap, overwrite = TRUE)

# --- 12. divorce_margarine -> screen_time_vs_smart_speaker_trend ---------
load("data/divorce_margarine.rda")
screen_time_vs_smart_speaker_trend <- data.frame(
  avg_daily_screen_time_hours = divorce_margarine$divorce_rate_maine,
  smart_speaker_sales_index = divorce_margarine$margarine_consumption_per_capita,
  year = divorce_margarine$year
)
usethis::use_data(screen_time_vs_smart_speaker_trend, overwrite = TRUE)

# --- 13. us_contagious_diseases -> fitness_app_downloads_by_state -------
load("data/us_contagious_diseases.rda")
.app_category_map <- c(
  "Hepatitis A" = "Macro/Nutrition Logging",
  "Measles" = "Guided Meditation",
  "Mumps" = "Sleep Tracking",
  "Pertussis" = "Yoga & Stretching",
  "Polio" = "Heart-Rate Monitoring",
  "Rubella" = "Running Coach",
  "Smallpox" = "Step Tracking"
)
fitness_app_downloads_by_state <- data.frame(
  app_category = unname(.app_category_map[as.character(us_contagious_diseases$disease)]),
  state = us_contagious_diseases$state,
  year = us_contagious_diseases$year,
  weeks_tracked = us_contagious_diseases$weeks_reporting,
  downloads = us_contagious_diseases$count,
  population = us_contagious_diseases$population
)
usethis::use_data(fitness_app_downloads_by_state, overwrite = TRUE)

# --- 14. gapminder -> global_tech_adoption -------------------------------
load("data/gapminder.rda")
.rescale_screen_time <- function(life_expectancy) {
  rng <- range(life_expectancy, na.rm = TRUE)
  1 + (life_expectancy - rng[1]) / (rng[2] - rng[1]) * 9
}
global_tech_adoption <- data.frame(
  country = gapminder$country,
  year = gapminder$year,
  continent = gapminder$continent,
  region = gapminder$region,
  gdp = gapminder$gdp,
  active_user_base = gapminder$population,
  avg_price_per_app_usd = gapminder$fertility,
  app_uninstall_rate_per_1000 = gapminder$infant_mortality,
  avg_daily_screen_time_hours = .rescale_screen_time(gapminder$life_expectancy)
)
usethis::use_data(global_tech_adoption, overwrite = TRUE)


# ======================================================================
# Tier-2 reflavoring (label / name relabels only; numeric values and
# array contents preserved exactly). Same disclaimer applies -- see each
# dataset's @note in R/.
# ======================================================================

# --- 15. mnist_27 -> gesture_swipe_data --------------------------------
# Label-only: the two digit classes (2, 7) become two swipe directions.
# Pixel-quadrant predictors x_1, x_2, the index vectors and the true_p
# probability surface are untouched (true_p$p, originally P(y = 7), now
# reads as P(y = "swipe_right") -- numerically identical).
load("data/mnist_27.rda")
.swipe_label <- function(y) {
  factor(ifelse(as.character(y) == "2", "swipe_left", "swipe_right"),
         levels = c("swipe_left", "swipe_right"))
}
gesture_swipe_data <- mnist_27
gesture_swipe_data$train$y <- .swipe_label(mnist_27$train$y)
gesture_swipe_data$test$y  <- .swipe_label(mnist_27$test$y)
usethis::use_data(gesture_swipe_data, overwrite = TRUE)

# --- 16. mnist_127 -> gesture_swipe_data_3class -----------------------
# Label-only: the three digit classes (1, 2, 7) become three gesture
# types. Predictors x_1, x_2 untouched.
load("data/mnist_127.rda")
.gesture3_label <- function(y) {
  m <- c("1" = "tap", "2" = "swipe", "7" = "pinch")
  factor(unname(m[as.character(y)]), levels = c("tap", "swipe", "pinch"))
}
gesture_swipe_data_3class <- mnist_127
gesture_swipe_data_3class$train$y <- .gesture3_label(mnist_127$train$y)
gesture_swipe_data_3class$test$y  <- .gesture3_label(mnist_127$test$y)
usethis::use_data(gesture_swipe_data_3class, overwrite = TRUE)

# --- 17. tissue_gene_expression -> sensor_activity_features -----------
# The 189 x 500 feature matrix is kept value-for-value; only its column
# names change from gene symbols to opaque feature_001..feature_500
# (they were never interpreted individually). The 7 tissue types are
# relabeled 1:1 to 7 activity contexts.
load("data/tissue_gene_expression.rda")
.activity_map <- c(
  "cerebellum"  = "walking",
  "colon"       = "typing",
  "endometrium" = "reading",
  "hippocampus" = "meditating",
  "kidney"      = "gaming",
  "liver"       = "driving",
  "placenta"    = "resting"
)
.saf_x <- tissue_gene_expression$x
colnames(.saf_x) <- sprintf("feature_%03d", seq_len(ncol(.saf_x)))
sensor_activity_features <- list(
  x = .saf_x,
  y = factor(unname(.activity_map[as.character(tissue_gene_expression$y)]),
             levels = unname(.activity_map))
)
usethis::use_data(sensor_activity_features, overwrite = TRUE)

# --- 18. pr_death_counts -> app_outage_engagement_impact -------------
# Interrupted-time-series counts kept exactly; deaths -> daily active
# users. The event date (a real hurricane landfall in the original) is
# reframed in the docs as a major app outage / forced update.
load("data/pr-death-counts.rda")
app_outage_engagement_impact <- data.frame(
  date = pr_death_counts$date,
  daily_active_users = pr_death_counts$deaths
)
usethis::use_data(app_outage_engagement_impact, overwrite = TRUE)

# --- 19. movielens -> app_ratings ------------------------------------
# userId/rating/timestamp/year preserved exactly. movieId -> app_id
# (unchanged), title -> a deterministic anonymized app_name, and the
# multi-genre string is collapsed to a single primary `category` via a
# fixed genre->category map (apps carry one store category, unlike a
# film's several genres). fit_recommender_model()'s @examples are a
# self-contained simulation -- they never referenced movielens -- so no
# change is needed there.
load("data/movielens.rda")
.genre_to_category <- c(
  "Action" = "Games", "Adventure" = "Games", "Animation" = "Entertainment",
  "Children" = "Kids", "Comedy" = "Entertainment", "Crime" = "News",
  "Documentary" = "Education", "Drama" = "Entertainment", "Fantasy" = "Games",
  "Film-Noir" = "Entertainment", "Horror" = "Entertainment", "IMAX" = "Entertainment",
  "Musical" = "Music", "Mystery" = "Entertainment", "Romance" = "Lifestyle",
  "Sci-Fi" = "Games", "Thriller" = "Entertainment", "War" = "News",
  "Western" = "Entertainment", "(no genres listed)" = "Uncategorized"
)
.first_genre <- sub("\\|.*$", "", as.character(movielens$genres))
.ar_category <- unname(.genre_to_category[.first_genre])
.ar_category[is.na(.ar_category)] <- "Uncategorized"
app_ratings <- data.frame(
  app_id = movielens$movieId,
  app_name = paste0("app_", movielens$movieId),
  year = movielens$year,
  category = .ar_category,
  user_id = movielens$userId,
  rating = movielens$rating,
  timestamp = movielens$timestamp
)
usethis::use_data(app_ratings, overwrite = TRUE)


# ======================================================================
# Tier-3 reflavoring: US election polling/results -> product-launch
# preference forecasting. Structures preserved exactly; numeric values
# unchanged. "Panels" (survey vendors) replace pollsters, "markets"
# replace states, and the three preference options map from the three
# main 2016 candidates: new version (Clinton), current version (Trump),
# switch to a competitor (Johnson). Same disclaimer -- see the @note in R/.
# ======================================================================

# --- 20. polls_us_election_2016 -> product_launch_forecast -------------
#         results_us_election_2016 -> product_launch_results
load("data/polls_us_election_2016.rda")   # loads both objects

.panel_id <- sprintf("Panel %03d", as.integer(factor(polls_us_election_2016$pollster)))

product_launch_forecast <- data.frame(
  market           = polls_us_election_2016$state,
  startdate        = polls_us_election_2016$startdate,
  enddate          = polls_us_election_2016$enddate,
  panel            = .panel_id,
  panel_grade      = polls_us_election_2016$grade,
  samplesize       = polls_us_election_2016$samplesize,
  respondents      = polls_us_election_2016$population,
  raw_pref_new     = polls_us_election_2016$rawpoll_clinton,
  raw_pref_current = polls_us_election_2016$rawpoll_trump,
  raw_pref_switch  = polls_us_election_2016$rawpoll_johnson,
  raw_pref_other   = polls_us_election_2016$rawpoll_mcmullin,
  adj_pref_new     = polls_us_election_2016$adjpoll_clinton,
  adj_pref_current = polls_us_election_2016$adjpoll_trump,
  adj_pref_switch  = polls_us_election_2016$adjpoll_johnson,
  adj_pref_other   = polls_us_election_2016$adjpoll_mcmullin
)

product_launch_results <- data.frame(
  market        = results_us_election_2016$state,
  market_weight = results_us_election_2016$electoral_votes,
  adopt_new     = results_us_election_2016$clinton,
  adopt_current = results_us_election_2016$trump,
  adopt_alt1    = results_us_election_2016$johnson,
  adopt_alt2    = results_us_election_2016$stein,
  adopt_alt3    = results_us_election_2016$mcmullin,
  adopt_other   = results_us_election_2016$others
)

usethis::use_data(product_launch_forecast, product_launch_results, overwrite = TRUE)

# --- 21. results_us_election_2012 -> prior_launch_results -------------
load("data/results_us_election_2012.rda")
prior_launch_results <- data.frame(
  market        = results_us_election_2012$state,
  market_weight = results_us_election_2012$electoral_votes,
  adopt_new     = results_us_election_2012$obama,
  adopt_current = results_us_election_2012$romney,
  adopt_alt1    = results_us_election_2012$johnson,
  adopt_alt2    = results_us_election_2012$stein
)
usethis::use_data(prior_launch_results, overwrite = TRUE)


# --- 22. brca -> wearable_stress_signals ------------------------------
# ML classification benchmark. 569 x 30 feature matrix kept value-for-
# value; the 10 base nuclear measures are relabeled to 10 wearable
# physiological signals, the mean/se/worst summary suffixes become
# mean/se/peak, and the benign/malignant label becomes low/high arousal.
load("data/brca.rda")
.signal_map <- c(
  radius       = "heart_rate",
  texture      = "hrv_rmssd",
  perimeter    = "breathing_rate",
  area         = "motion_intensity",
  smoothness   = "eda_tonic",
  compactness  = "eda_phasic",
  concavity    = "skin_temp",
  concave_pts  = "pulse_amplitude",
  symmetry     = "beat_regularity",
  fractal_dim  = "signal_complexity"
)
.suffix_map <- c(mean = "mean", se = "se", worst = "peak")
.old_cols <- colnames(brca$x)
.base <- sub("_(mean|se|worst)$", "", .old_cols)
.suf  <- sub("^.*_(mean|se|worst)$", "\\1", .old_cols)
.wss_x <- brca$x
colnames(.wss_x) <- paste0(unname(.signal_map[.base]), "_",
                           unname(.suffix_map[.suf]))
wearable_stress_signals <- list(
  x = .wss_x,
  y = factor(ifelse(as.character(brca$y) == "M", "high", "low"),
             levels = c("low", "high"))
)
usethis::use_data(wearable_stress_signals, overwrite = TRUE)


# --- 23. brexit_polls -> ui_redesign_surveys -------------------------
# 127 preference surveys for an app UI redesign. All numeric values and
# dates unchanged. pollster -> anonymized panel; poll_type Online/
# Telephone -> method remote/lab (the "mode effect" analogue: unmoderated
# remote surveys vs moderated in-lab sessions); remain/leave -> prefer
# new/current UI.
load("data/brexit_polls.rda")
ui_redesign_surveys <- data.frame(
  startdate      = brexit_polls$startdate,
  enddate        = brexit_polls$enddate,
  panel          = sprintf("Panel %02d", as.integer(factor(brexit_polls$pollster))),
  method         = factor(ifelse(brexit_polls$poll_type == "Online", "remote", "lab"),
                          levels = c("remote", "lab")),
  n_participants = brexit_polls$samplesize,
  prefer_new     = brexit_polls$remain,
  prefer_current = brexit_polls$leave,
  undecided      = brexit_polls$undecided,
  margin         = brexit_polls$spread
)
usethis::use_data(ui_redesign_surveys, overwrite = TRUE)


# --- 24. olive -> wearable_signal_profiles_by_cohort -----------------
# 572 wearable recordings; the 8 compositional fatty-acid percentages
# (they sum to ~100) are relabeled 1:1 to 8 signal-quality proportions,
# values unchanged. Nested geography region(3)/area(9) -> device_type(3)/
# device_model(9).
load("data/olive.rda")
.device_type_map <- c(
  "Northern Italy" = "smartwatch",
  "Sardinia"       = "chest_strap",
  "Southern Italy" = "smart_ring"
)
.device_model_map <- c(
  "East-Liguria"    = "Watch S",  "Umbria"       = "Watch X",  "West-Liguria" = "Watch SE",
  "Coast-Sardinia"  = "Strap Lite","Inland-Sardinia" = "Strap Pro",
  "Calabria"        = "Ring v1",  "North-Apulia" = "Ring v2",  "Sicily"       = "Ring v3",
  "South-Apulia"    = "Ring SE"
)
wearable_signal_profiles_by_cohort <- data.frame(
  device_type         = factor(unname(.device_type_map[as.character(olive$region)]),
                               levels = unname(.device_type_map)),
  device_model        = unname(.device_model_map[as.character(olive$area)]),
  pct_motion_artifact = olive$palmitic,
  pct_saturation      = olive$palmitoleic,
  pct_baseline_drift  = olive$stearic,
  pct_clean           = olive$oleic,
  pct_poor_contact    = olive$linoleic,
  pct_dropout         = olive$linolenic,
  pct_powerline_noise = olive$arachidic,
  pct_other           = olive$eicosenoic
)
usethis::use_data(wearable_signal_profiles_by_cohort, overwrite = TRUE)

# --- 25. stars -> cognitive_task_metrics ----------------------------
# The Hertzsprung-Russell teaching set: plot two continuous metrics,
# discover latent task-type clusters. magnitude/temp values unchanged;
# star names anonymized; the 10 spectral classes -> 10 task labels.
load("data/stars.rda")
.task_type_map <- c(
  "O" = "stroop", "B" = "visual_search", "A" = "mental_arithmetic",
  "F" = "sorting", "G" = "planning", "K" = "reading", "M" = "free_recall",
  "DA" = "n_back_1", "DB" = "n_back_2", "DF" = "n_back_3"
)
cognitive_task_metrics <- data.frame(
  session        = sprintf("S%02d", seq_len(nrow(stars))),
  cognitive_load = stars$magnitude,
  arousal_index  = stars$temp,
  task_type      = unname(.task_type_map[as.character(stars$type)])
)
usethis::use_data(cognitive_task_metrics, overwrite = TRUE)
