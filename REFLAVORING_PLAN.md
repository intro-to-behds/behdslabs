# Reflavoring plan: `behdslabs` datasets for Behavioural Data Science / CogTech

Status as of this file's creation: **Tier 1 implemented** (branch `reflavor-tier1-datasets`), Tier 2/3 proposed but not yet built.

## Why

`behdslabs` is a fork of Irizarry & Gill's `dslabs` package (29 datasets: US murders, elections, olive oil, movies, breast cancer, etc.). The course it supports — *Behavioural Data Science* (PS3140, Cognitive Science for Human-Centric Technologies) — is about behavioural data with a focus on digital technologies, apps, wearables, and neurophysiological methods. This plan reflavors the package's examples to match: same numbers (unchanged, or linearly rescaled only where needed for a plausible range), new names/framing so every example reads as an app/wearable/neuro scenario.

This is an **interim step**. It is not synthetic or real behavioural data — see the disclaimer rule below. A fully synthetic `bdslabs` dataset set (RT/accuracy/Likert/longitudinal constructs) is a separate, later phase (`BDS_development_plan.md` Phase 2).

## Ground rules

1. **Additive, non-destructive.** Original datasets (`murders`, `heights`, `gapminder`, etc.) are never modified or deleted. New reflavored datasets are added as new objects, coexisting in the same package. This is deliberate: the two book repos (`behdsbook-part-1`, `behdsbook-part-2`) reference the old dataset names in 60+ places, so nothing there breaks. Retiring the old names is a distinct future step (`BDS_development_plan.md` Phase 3, book adaptation) — not part of this plan.
2. **Disclaimer everywhere.** Every reflavored dataset's roxygen doc (`R/<name>.R`) carries a `@note` explaining it's relabeled/rescaled `dslabs` data, not real behavioural data. The same disclaimer is echoed once in `DESCRIPTION` and `README.md`.
3. **Numeric correspondence is enforced by tests, not just checked once.** `tests/testthat/test-<name>.R` asserts each new dataset's numeric columns equal the original `dslabs` values (or the documented rescale formula). Run `devtools::test()` after touching `data-raw/reflavor_datasets.R` to catch drift.
4. **Transforms live in one script.** `data-raw/reflavor_datasets.R` is the single source of truth — one block per dataset, loading the original `.rda`, transforming, and writing via `usethis::use_data(..., overwrite = TRUE)`. Extending Tier 2/3 means adding blocks here, a matching `R/<name>.R` doc file, and a matching test file, then running `devtools::document()`.
5. **Identifiable real-person data is out regardless of tier.** `trump_tweets` gets depersonalized (drop identity + raw text, keep only structural/numeric fields) whenever it's tackled — that's a privacy concern, not a thematic-fit one.

## Tier 1 — done

| Original | New name | What changed | Concept preserved |
|---|---|---|---|
| `murders` | `app_data_breaches` | `total` → `incidents`; geo columns unchanged | population-adjusted rate vs. raw count |
| `heights` | `reaction_times` | `height` → `rt_ms`, linearly rescaled to ~200–500ms | distributions, group comparison, CLT |
| `reported_heights` | `wearable_onboarding_height` | reframed as messy self-reported height at fitness-wearable app onboarding (same messy strings — kept as height, not screen time, since the unit-confusion artifacts are height-specific) | messy string parsing / data cleaning |
| `admissions` | `app_task_completion` | `major`→`task`, `gender`→`device` (mobile/desktop), `admitted`→`completion_rate`, `applicants`→`n_attempts` | Simpson's paradox |
| `mice_weights` | `app_engagement_experiment` | body/bone/fat → engagement/consistency/error-rate; `diet`→`ui_version` (standard/redesigned); `gen`→`cohort`; `litter`→`test_batch` | 2-way factorial experimental design |
| `nyc_regents_scores` | `cognitive_battery_scores` | 5 subject columns → attention/memory/usability/reading/reasoning task | distribution shape / histograms |
| `outlier_example` | `reported_daily_screen_time` | no rescale — values already read as plausible daily hours | outlier detection |
| `na_example` | `daily_mood_ratings` | reinterpreted as a 1–7 Likert mood scale (no rescale) | missing data handling |
| `death_prob` | `app_churn_prob` | `prob`→`churn_prob` (1-year app-discontinuation probability) | expected value / actuarial-style probability |
| `polls_2008` | `feature_preference_trend` | `day`→`days_before_launch`, `margin`→`preference_margin` | time-series trend estimation |
| `research_funding_rates` | `tech_grant_funding_gender_gap` | `discipline`→`tech_domain`, 9 levels remapped to tech domains (AI/ML, Sensor Hardware, Wearable Engineering, HCI, Software Engineering, Digital Health, UX Research, Neurotech, Interdisciplinary Human-Centric Tech) | gender-gap-in-funding analysis |
| `divorce_margarine` | `screen_time_vs_smart_speaker_trend` | `divorce_rate_maine`→`avg_daily_screen_time_hours`, `margarine_consumption_per_capita`→`smart_speaker_sales_index` | spurious correlation ≠ causation |

## Tier 2 — proposed, not yet implemented

| Original | Proposed new name | Sketch |
|---|---|---|
| `brca` | `wearable_stress_signals` | 30 features → physiological-signal summaries (HR, EDA, HRV mean/SE/worst); binary label → Low/High arousal state |
| `brexit_polls` | `ui_redesign_surveys` | pollster→panel; poll_type Online/Telephone→App-survey/Call-center; remain→prefer_new_ui |
| `olive` | `wearable_signal_profiles_by_cohort` | region/area→device_type/os_version; 8 fatty-acid %s→8 signal-feature proportions |
| `stars` | `cognitive_task_metrics` | magnitude→cognitive_load_index; temp→arousal_level; type→task_category |
| `mnist_27` / `mnist_127` | `gesture_swipe_data` | label-only: classes→swipe_left/swipe_right (pixel predictors untouched) |
| `tissue_gene_expression` | `sensor_activity_features` | 500 opaque features kept as-is; 7 tissue types→7 activity contexts (walking/typing/reading/meditating/gaming/driving/resting) |
| `us_contagious_diseases` | `digital_safety_incidents_by_state` | 7 diseases→7 incident types (phishing, cyberbullying, data breach, malware, identity theft, misinformation, account hacking) |
| `movielens` | `app_ratings` | movieId/title→app_id/anonymized app name; genres→category; also reframe `fit_recommender_model()`'s example |
| `take_poll()` / `.take_poll()` | — | relabel Blue/Red beads → Positive/Negative app-review simulator (function, not a dataset) |

## Tier 3 — proposed, larger or lower priority

| Original | Proposed new name | Sketch |
|---|---|---|
| `trump_tweets` | `social_media_posts` | drop real identity + raw tweet text; keep only structural/numeric fields (share_count, sentiment counts by device type) |
| `gapminder` | `global_tech_adoption` | infant_mortality→app_uninstall_rate_per_1000 (rescaled); life_expectancy→avg_daily_screen_time_hours (rescaled); fertility→devices_owned_per_capita; population→active_user_base; oecd/opec→mature/emerging tech markets |
| `polls_us_election_2016` + `results_us_election_2016` | `product_launch_forecast` | state→market; pollster→panel; poll shares→pct_prefer_featureA/B; central to Part 2's forecasting case study |
| `results_us_election_2012` | — | companion "prior launch" comparison dataset, same treatment |
| `greenhouse_gases` + `historic_co2` + `temp_carbon` | `tech_adoption_trends` | grouped long-run-trend storyline (e.g. smartphone/social-media/screen-time adoption curves) |

## Helper functions (light touch, not yet done)
- `rfalling_object()` — optional cosmetic rename to a "signal decay" framing (wearable battery/signal degradation). No data change.
- `fit_recommender_model()` — reframe example to pair with `app_ratings` once that exists (Tier 2). No logic change.
- `read_mnist()`, `ds_theme_set()` — no change planned (external download / pure ggplot theme utility).

## How to extend this (Tier 2/3, or fixing Tier 1)

1. Add a block to `data-raw/reflavor_datasets.R`: load the original `.rda`, transform, `usethis::use_data(new_name, overwrite = TRUE)`.
2. Add `R/<new_name>.R` with roxygen docs modeled on an existing Tier-1 file (e.g. `R/app_task_completion.R`) — include the `@note` disclaimer.
3. Run `devtools::document()` to regenerate `man/` and `NAMESPACE`.
4. Add `tests/testthat/test-<new_name>.R` asserting numeric correspondence with the original (see any existing test file for the pattern).
5. Run `devtools::test()` then `devtools::check()` — both should stay clean (0 errors/warnings/notes).
6. Confirm `git diff --stat data/` shows only new files, never modified ones.
