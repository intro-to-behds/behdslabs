# Multiplicative reflavoring constants: reflavoured numeric columns are the
# original dslabs values times a fixed per-column factor, so that no
# reflavoured value equals its dslabs original (REFLAVORING_PLAN.md ground
# rule 3). Default factor is 2; a few columns use another value to keep the
# reframed quantity plausible.
#
# This object is the single source of truth for the factors. It is sourced
# by data-raw/reflavor_datasets.R (which applies them) and read by the
# correspondence tests as behdslabs:::.reflavor_k (which re-derive the
# expected values) -- never edit a factor in one place only.
#
# Columns NOT listed here are kept byte-identical on purpose (dates / year,
# IDs and weights, proportions/probabilities bounded to [0,1] or [0,100],
# compositional percentages that sum to ~100, opaque pixel/feature
# matrices, free text) -- see the "Flagged value exceptions" section of
# REFLAVORING_PLAN.md. reaction_times$rt_ms and
# global_tech_adoption$avg_daily_screen_time_hours use a linear range
# rescale instead of a factor and are handled separately in data-raw.
#
# Divide-pairs: in every case the denominator is a kept-identical column,
# so the numerator's factor is the factor of the derived rate:
#   app_data_breaches:             incidents / population            -> rate x2
#   fitness_app_downloads_by_state:downloads / population            -> rate x2
#   global_tech_adoption:          gdp / active_user_base / 365      -> revenue_per_user_day x2

.reflavor_k <- list(
  app_data_breaches = c(
    incidents = 2                       # count; feeds incident_rate
  ),
  app_task_completion = c(
    n_attempts = 2                      # count; uniform factor keeps Simpson's paradox
  ),
  app_engagement_experiment = c(
    engagement_score = 2,
    consistency_index = 2,
    error_rate_pct = 1.3               # reads as a percent -- keep well under 100
  ),
  cognitive_battery_scores = c(
    score = 0.8,                        # 0-100 exam score, keep <= 100 (benchmark 65 -> 52)
    attention_task = 0.8,               # per-score frequency counts, same factor as score
    memory_task = 0.8,
    usability_task = 0.8,
    reading_task = 0.8,
    reasoning_task = 0.8
  ),
  reported_daily_screen_time = c(
    value = 2                           # bare numeric vector; outlier structure preserved
  ),
  tech_grant_funding_gender_gap = c(
    counts = 2                          # applied to all 6 application/award count columns;
                                       # keeps total = men + women and the success-rate ratio
  ),
  screen_time_vs_smart_speaker_trend = c(
    avg_daily_screen_time_hours = 2,
    smart_speaker_sales_index = 2
  ),
  fitness_app_downloads_by_state = c(
    downloads = 2                       # count; feeds download rate
  ),
  global_tech_adoption = c(
    gdp = 2,                            # feeds revenue_per_user_day
    avg_price_per_app_usd = 1.5         # keep app-store plausible
  ),
  app_outage_engagement_impact = c(
    daily_active_users = 2
  ),
  product_launch_forecast = c(
    samplesize = 2
  ),
  ui_redesign_surveys = c(
    n_participants = 2
  ),
  cognitive_task_metrics = c(
    cognitive_load = 2,
    arousal_index = 2
  ),
  tech_adoption_trends = c(
    adoption_index = 2
  ),
  connectivity_deep_history = c(
    connectivity_index = 2
  ),
  screentime_wellbeing_series = c(
    wellbeing_anomaly = 2,              # the three anomaly series are co-plotted -> same factor
    mood_anomaly = 2,
    sleep_anomaly = 2,
    screen_time_index = 2
  )
)
