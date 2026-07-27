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
