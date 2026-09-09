# Tier-1/2/3 reflavoring: rename + transform existing dslabs datasets into
# Behavioural Data Science / digital-technology / wearable / neurophysiological
# themed examples for teaching. These are NOT real behavioural, usage, or
# physiological data -- see each dataset's @note in R/ for the full disclaimer.
#
# NUMERIC VALUES: no reflavoured numeric column is byte-identical to its dslabs
# original (REFLAVORING_PLAN.md ground rule 3). Most scaled columns are the
# original values times a fixed factor from R/reflavor_constants.R
# (.reflavor_k), round()ed for counts; two columns use a linear range rescale
# (.rt_from_height, .rescale_screen_time). Columns kept identical on purpose
# (dates/year, IDs/weights, bounded proportions, compositional %, opaque
# feature matrices, free text) are marked "# EXC" below.
#
# This script is the single source of truth for the transforms. The
# correspondence tests in tests/testthat/ re-derive the same values from
# .reflavor_k to guard against drift.

library(usethis)
source("R/reflavor_constants.R")  # .reflavor_k

# --- 1. murders -> app_data_breaches -----------------------------------
load("data/murders.rda")
app_data_breaches <- data.frame(
  state = murders$state,
  abb = murders$abb,
  region = murders$region,
  population = murders$population,                          # EXC: real state populations
  incidents = round(.reflavor_k$app_data_breaches[["incidents"]] * murders$total)
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
  completion_rate = admissions$admitted,                    # EXC: bounded [0,100]
  n_attempts = round(.reflavor_k$app_task_completion[["n_attempts"]] * admissions$applicants)
)
usethis::use_data(app_task_completion, overwrite = TRUE)

# --- 5. mice_weights -> app_engagement_experiment ------------------------
load("data/mice_weigths.rda")
.k_aee <- .reflavor_k$app_engagement_experiment
app_engagement_experiment <- data.frame(
  engagement_score = .k_aee[["engagement_score"]] * mice_weights$body_weight,
  consistency_index = .k_aee[["consistency_index"]] * mice_weights$bone_density,
  error_rate_pct = .k_aee[["error_rate_pct"]] * mice_weights$percent_fat,
  sex = mice_weights$sex,
  ui_version = factor(ifelse(mice_weights$diet == "chow", "standard", "redesigned")),
  cohort = mice_weights$gen,
  test_batch = mice_weights$litter
)
usethis::use_data(app_engagement_experiment, overwrite = TRUE)

# --- 6. nyc_regents_scores -> cognitive_battery_scores -------------------
load("data/nyc_regents_scores.rda")
.k_cbs <- .reflavor_k$cognitive_battery_scores   # one shared factor (0.8) for all 6 columns
cognitive_battery_scores <- data.frame(
  score = round(.k_cbs[["score"]] * nyc_regents_scores$score),
  attention_task = round(.k_cbs[["attention_task"]] * nyc_regents_scores$integrated_algebra),
  memory_task = round(.k_cbs[["memory_task"]] * nyc_regents_scores$global_history),
  usability_task = round(.k_cbs[["usability_task"]] * nyc_regents_scores$living_environment),
  reading_task = round(.k_cbs[["reading_task"]] * nyc_regents_scores$english),
  reasoning_task = round(.k_cbs[["reasoning_task"]] * nyc_regents_scores$us_history)
)
usethis::use_data(cognitive_battery_scores, overwrite = TRUE)

# --- 7. outlier_example -> reported_daily_screen_time --------------------
load("data/outlier_example.rda")
reported_daily_screen_time <- .reflavor_k$reported_daily_screen_time[["value"]] * outlier_example
usethis::use_data(reported_daily_screen_time, overwrite = TRUE)

# --- 8. na_example -> daily_mood_ratings ---------------------------------
load("data/na_example.rda")
daily_mood_ratings <- na_example                            # EXC: 1-7 Likert + NA
usethis::use_data(daily_mood_ratings, overwrite = TRUE)

# --- 9. death_prob -> app_churn_prob --------------------------------------
load("data/death_prob.rda")
app_churn_prob <- data.frame(
  age = death_prob$age,                                     # EXC: demographic reference
  sex = death_prob$sex,
  churn_prob = death_prob$prob                              # EXC: probability [0,1]
)
usethis::use_data(app_churn_prob, overwrite = TRUE)

# --- 10. polls_2008 -> feature_preference_trend --------------------------
load("data/polls_2008.rda")
feature_preference_trend <- data.frame(
  days_before_launch = polls_2008$day,                      # EXC: time index
  preference_margin = polls_2008$margin                     # EXC: bounded margin (-1,1)
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
# one shared factor across all 6 count columns: keeps total = men + women and
# the success_rates ratio (awards/applications) invariant. success_rates_* stay EXC.
.k_grants <- .reflavor_k$tech_grant_funding_gender_gap[["counts"]]
.grant_count_cols <- c("applications_total", "applications_men", "applications_women",
                       "awards_total", "awards_men", "awards_women")
for (.cc in .grant_count_cols)
  tech_grant_funding_gender_gap[[.cc]] <- round(.k_grants * research_funding_rates[[.cc]])
usethis::use_data(tech_grant_funding_gender_gap, overwrite = TRUE)

# --- 12. divorce_margarine -> screen_time_vs_smart_speaker_trend ---------
load("data/divorce_margarine.rda")
.k_stss <- .reflavor_k$screen_time_vs_smart_speaker_trend
screen_time_vs_smart_speaker_trend <- data.frame(
  avg_daily_screen_time_hours = .k_stss[["avg_daily_screen_time_hours"]] * divorce_margarine$divorce_rate_maine,
  smart_speaker_sales_index = .k_stss[["smart_speaker_sales_index"]] * divorce_margarine$margarine_consumption_per_capita,
  year = divorce_margarine$year                             # EXC: year
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
  year = us_contagious_diseases$year,                       # EXC: year
  weeks_tracked = us_contagious_diseases$weeks_reporting,   # EXC: 0-52 coverage count
  downloads = round(.reflavor_k$fitness_app_downloads_by_state[["downloads"]] * us_contagious_diseases$count),
  population = us_contagious_diseases$population             # EXC: real state populations
)
usethis::use_data(fitness_app_downloads_by_state, overwrite = TRUE)

# --- 14. gapminder -> global_tech_adoption -------------------------------
load("data/gapminder.rda")
.rescale_screen_time <- function(life_expectancy) {
  rng <- range(life_expectancy, na.rm = TRUE)
  1 + (life_expectancy - rng[1]) / (rng[2] - rng[1]) * 9
}
.k_gta <- .reflavor_k$global_tech_adoption
global_tech_adoption <- data.frame(
  country = gapminder$country,
  year = gapminder$year,                                    # EXC: year
  continent = gapminder$continent,
  region = gapminder$region,
  gdp = .k_gta[["gdp"]] * gapminder$gdp,                    # feeds revenue_per_user_day
  active_user_base = gapminder$population,                  # EXC: real populations; divide denominator
  avg_price_per_app_usd = .k_gta[["avg_price_per_app_usd"]] * gapminder$fertility,
  app_uninstall_rate_per_1000 = gapminder$infant_mortality, # EXC (flag "revisit"): per-1000 rate feeding logit-scale plots
  avg_daily_screen_time_hours = .rescale_screen_time(gapminder$life_expectancy)  # linear rescale
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
  date = pr_death_counts$date,                              # EXC: date
  daily_active_users = round(.reflavor_k$app_outage_engagement_impact[["daily_active_users"]] * pr_death_counts$deaths)
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
  startdate        = polls_us_election_2016$startdate,       # EXC: date
  enddate          = polls_us_election_2016$enddate,         # EXC: date
  panel            = .panel_id,
  panel_grade      = polls_us_election_2016$grade,
  samplesize       = round(.reflavor_k$product_launch_forecast[["samplesize"]] * polls_us_election_2016$samplesize),
  respondents      = polls_us_election_2016$population,      # EXC: character screen type
  raw_pref_new     = polls_us_election_2016$rawpoll_clinton, # EXC: poll % [0,100]
  raw_pref_current = polls_us_election_2016$rawpoll_trump,   # EXC: poll %
  raw_pref_switch  = polls_us_election_2016$rawpoll_johnson, # EXC: poll %
  raw_pref_other   = polls_us_election_2016$rawpoll_mcmullin,# EXC: poll %
  adj_pref_new     = polls_us_election_2016$adjpoll_clinton, # EXC: poll %
  adj_pref_current = polls_us_election_2016$adjpoll_trump,   # EXC: poll %
  adj_pref_switch  = polls_us_election_2016$adjpoll_johnson, # EXC: poll %
  adj_pref_other   = polls_us_election_2016$adjpoll_mcmullin # EXC: poll %
)

product_launch_results <- data.frame(
  market        = results_us_election_2016$state,
  market_weight = results_us_election_2016$electoral_votes,  # EXC: weight
  adopt_new     = results_us_election_2016$clinton,          # EXC: % [0,100]
  adopt_current = results_us_election_2016$trump,            # EXC: %
  adopt_alt1    = results_us_election_2016$johnson,          # EXC: %
  adopt_alt2    = results_us_election_2016$stein,            # EXC: %
  adopt_alt3    = results_us_election_2016$mcmullin,         # EXC: %
  adopt_other   = results_us_election_2016$others            # EXC: %
)

usethis::use_data(product_launch_forecast, product_launch_results, overwrite = TRUE)

# --- 21. results_us_election_2012 -> prior_launch_results -------------
load("data/results_us_election_2012.rda")
prior_launch_results <- data.frame(                         # all EXC (weight / % [0,100])
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
  n_participants = round(.reflavor_k$ui_redesign_surveys[["n_participants"]] * brexit_polls$samplesize),
  prefer_new     = brexit_polls$remain,                     # EXC: proportion [0,1]
  prefer_current = brexit_polls$leave,                      # EXC: proportion
  undecided      = brexit_polls$undecided,                  # EXC: proportion
  margin         = brexit_polls$spread                      # EXC: derived margin
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
.k_ctm <- .reflavor_k$cognitive_task_metrics
cognitive_task_metrics <- data.frame(
  session        = sprintf("S%02d", seq_len(nrow(stars))),
  cognitive_load = .k_ctm[["cognitive_load"]] * stars$magnitude,
  arousal_index  = .k_ctm[["arousal_index"]] * stars$temp,
  task_type      = unname(.task_type_map[as.character(stars$type)])
)
usethis::use_data(cognitive_task_metrics, overwrite = TRUE)


# ======================================================================
# Tier-3 reflavoring: long-run climate time series -> technology-adoption
# trend series. Three separate objects (different schemas), thematically
# grouped. All numeric values and years unchanged.
# ======================================================================

# --- 26. greenhouse_gases -> tech_adoption_trends -------------------
load("data/greenhouse_gases.rda")
.tech_map <- c("CO2" = "smartphones", "CH4" = "social_media", "N2O" = "streaming")
tech_adoption_trends <- data.frame(
  year           = greenhouse_gases$year,                   # EXC: timeline index
  technology     = unname(.tech_map[greenhouse_gases$gas]),
  adoption_index = .reflavor_k$tech_adoption_trends[["adoption_index"]] * greenhouse_gases$concentration
)
usethis::use_data(tech_adoption_trends, overwrite = TRUE)

# --- 27. historic_co2 -> connectivity_deep_history -----------------
load("data/historic_co2.rda")
.co2_source_map <- c("Ice Cores" = "reconstructed", "Mauna Loa" = "direct")
connectivity_deep_history <- historic_co2
names(connectivity_deep_history)[names(connectivity_deep_history) == "co2"] <- "connectivity_index"
connectivity_deep_history$connectivity_index <-
  .reflavor_k$connectivity_deep_history[["connectivity_index"]] * historic_co2$co2
# year kept as-is (EXC: deep-time index, includes large negatives)
connectivity_deep_history$source <- unname(.co2_source_map[historic_co2$source])
usethis::use_data(connectivity_deep_history, overwrite = TRUE)

# --- 28. temp_carbon -> screentime_wellbeing_series ----------------
load("data/temp_carbon.rda")
.k_sws <- .reflavor_k$screentime_wellbeing_series
screentime_wellbeing_series <- data.frame(
  year              = temp_carbon$year,                     # EXC: year
  wellbeing_anomaly = .k_sws[["wellbeing_anomaly"]] * temp_carbon$temp_anomaly,
  mood_anomaly      = .k_sws[["mood_anomaly"]] * temp_carbon$land_anomaly,
  sleep_anomaly     = .k_sws[["sleep_anomaly"]] * temp_carbon$ocean_anomaly,
  screen_time_index = .k_sws[["screen_time_index"]] * temp_carbon$carbon_emissions
)
usethis::use_data(screentime_wellbeing_series, overwrite = TRUE)
