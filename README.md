# behdslabs

This package is the adaptation of the dslabs package by R. A. Irizarry. The package is meant to be used together with the book "Introduction to Behavioral Data Science", a direct adapation of the "Introduction to Data Science" book by R. A. Irizarry. Modifications and new chapters by C. Costa e G. Arcara.

## Relabeled datasets

A subset of datasets (`app_data_breaches`, `reaction_times`, `wearable_onboarding_height`, `app_task_completion`, `app_engagement_experiment`, `cognitive_battery_scores`, `reported_daily_screen_time`, `daily_mood_ratings`, `app_churn_prob`, `feature_preference_trend`, `tech_grant_funding_gender_gap`, `screen_time_vs_smart_speaker_trend`) have been added alongside the original dslabs datasets, relabeled with a digital-technology / wearable / neurophysiological theme to match the *Behavioural Data Science* course.

**These are not real behavioural, usage, or physiological data.** They are the original dslabs datasets (Irizarry & Gill), renamed and in some cases linearly rescaled for narrative fit — see each dataset's help page (e.g. `?reaction_times`) for the exact transform. A synthetic or real, ethically-sourced replacement is planned for a future release. All original dslabs datasets remain unchanged and available under their original names.
