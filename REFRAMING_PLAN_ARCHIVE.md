> **Archived, superseded plan.** This is a verbatim copy of an earlier, never-implemented plan for adapting this package (originally drafted June 2026 in a since-retired duplicate clone of this repo). It proposed a **documentation-only** reframe: keep every dataset/column/value byte-identical to stock `dslabs`, and only rewrite the roxygen2 prose to draw HCI/UX analogies. That approach was superseded by the renaming-based strategy in `REFLAVORING_PLAN.md` (new dataset objects with renamed columns, values preserved/rescaled), which better serves students inspecting data directly in the console. This file is kept as a source of analogy ideas and worked examples that were mined into `REFLAVORING_PLAN.md` and into several Tier-1 datasets' roxygen docs — see `REFLAVORING_PLAN.md` for the current, active plan.

---
output:
  pdf_document: default
  html_document: default
---
# Plan: Reframe `behdslabs` for Behavioral Data Science (Cognitive Sciences Master's, UNIPD)

## Context

`behdslabs` is a fork of the `dslabs` R package used to teach introductory data science. The goal is to adapt it for a **"Cognitive Sciences: Human-Centric Technologies"** master's course at the University of Padova. Students come from cognitive psychology, neuroscience, linguistics, and HCI backgrounds.

The data stays **identical**. Only the roxygen2 documentation in `R/*.R` files changes — titles, descriptions, `@details` sections, and `@examples` — so each dataset's educational framing maps to behavioral/HCI concepts. Running `devtools::document()` after editing regenerates `man/` automatically.

The examples should connect to **behavioral data from technology use**: smartphone app analytics, usability questionnaires (SUS, UEQ, NPS), user experience experiments, A/B testing, interaction logs, and digital behavioral traces.

---

## Files to Edit

### 1. `DESCRIPTION`

Update:
- `Title`: `Behavioral Data Science Labs`
- `Description`: reframe around behavioral/HCI topics (UX research, human-technology interaction, usability, app analytics, AI fairness, recommendation systems, digital behavioral data)
- Add Giorgio Arcara as `[aut, cre]` fork maintainer

---

### 2. Dataset documentation files (`R/*.R`) — by priority

For each file: update the title line, description paragraph, `@details`, and `@examples`. **Do not change variable names or the closing `"dataset_name"` string.**

---

#### High Priority

---

##### `R/admissions.R` — Simpson's Paradox in UX conversion data

**HCI/UX reframe:** App A/B testing and conversion funnels often show Simpson's Paradox: an interface variant that appears worse overall is actually better within every user segment. Aggregate completion rates across user groups can reverse when controlling for task type — the exact pattern shown here with gender and academic major.

**Example questions:**
```r
# Imagine 'major' = app feature area, 'gender' = user group (novice/expert),
# 'admitted' = task completion rate. Overall, which group appears to perform better?
library(dplyr)
admissions |>
  group_by(gender) |>
  summarise(overall_completion = sum(admitted * applicants) / sum(applicants))

# Now break down by feature area. Does the group difference persist within each area?
# This mirrors checking whether a UX improvement is genuine or a mix-proportions artifact.
library(ggplot2)
admissions |>
  ggplot(aes(x = major, y = admitted, fill = gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Completion rate by feature area and user group",
       x = "App feature area", y = "Completion rate (%)")
```

---

##### `R/heights.R` — Self-report bias in technology use surveys

**HCI/UX reframe:** Self-reported height is a textbook example of social-desirability bias — males over-report by a systematic margin. The same bias is documented in self-reported smartphone use: users consistently underestimate daily screen time relative to device logs (a well-replicated finding in digital well-being research). This dataset teaches the analytical pipeline for detecting and quantifying self-report bias.

**Example questions:**
```r
# Analogous to comparing self-reported vs. device-logged screen time:
# do males and females differ in their self-reported height relative to population norms?
t.test(heights$height[heights$sex == "Male"], mu = 69.1)   # 69.1 in = population mean

# Visualize the distribution — the same plot used for SUS or UEQ scale responses
library(ggplot2)
ggplot(heights, aes(x = height, fill = sex)) +
  geom_density(alpha = 0.5) +
  labs(title = "Self-reported height by sex (proxy for self-report bias analysis)",
       subtitle = "Same approach applies to self-reported app use vs. device logs")
```

---

##### `R/reported_heights.R` — Messy free-text data from online UX surveys

**HCI/UX reframe:** Online UX surveys frequently contain free-text entry fields (age, years of experience, version numbers) that produce mixed units, typos, and impossible values. This dataset — raw height entries from an open-form survey field — is the prototypical dirty-data cleaning exercise for behavioral technology research.

**Example questions:**
```r
# Identify entries that look like centimeters entered in an inches field —
# analogous to detecting version numbers typed as "3.11" vs. "3" in a survey form.
library(dplyr)
reported_heights |>
  mutate(height_num = suppressWarnings(as.numeric(height))) |>
  filter(height_num > 84) |>  # implausibly tall in inches => likely cm
  select(height)

# What proportion of responses are non-numeric (free-text entry errors)?
# Benchmark: typical online UX surveys see 2–8% invalid open-text responses.
mean(is.na(suppressWarnings(as.numeric(reported_heights$height))))
```

---

##### `R/research_funding_rates.R` — Gender bias and Simpson's Paradox in tech evaluation

**HCI/UX reframe:** Gender disparities in tech industry hiring and promotion show the same confounding pattern as this research funding dataset: aggregate differences shrink or reverse when controlling for the role category applied for. The same statistical approach is used to audit algorithmic hiring tools for disparate impact across demographic groups.

**Example questions:**
```r
# Compute overall success rates by gender — does a gap appear at the aggregate level?
library(dplyr)
research_funding_rates |>
  summarise(rate_men   = sum(awards_men)   / sum(applications_men),
            rate_women = sum(awards_women) / sum(applications_women))

# Now break down by discipline (analogous to job category in a hiring audit).
# Does the within-category pattern match the aggregate pattern?
research_funding_rates |>
  ggplot(aes(x = reorder(discipline, success_rates_men - success_rates_women),
             y = success_rates_men - success_rates_women)) +
  geom_col() + coord_flip() +
  labs(title = "Gender gap in success rate by discipline",
       subtitle = "Analogous to auditing an algorithmic hiring tool by job category")
```

---

##### `R/polls_us_election_2016.R` — Aggregating user satisfaction surveys

**HCI/UX reframe:** Opinion polling shares its methodology with aggregating NPS (Net Promoter Score) or UEQ (User Experience Questionnaire) scores from multiple studies or user panels. The 2016 polling failure — herding, non-response bias, overconfident forecasts — mirrors the pitfalls in UX benchmarking when vendors selectively report favorable satisfaction scores.

**Example questions:**
```r
# Treat poll spread as analogous to a satisfaction gap between two interface versions.
# Compute the mean and SD of the estimated spread across all national polls.
library(dplyr)
polls_us_election_2016 |>
  filter(state == "U.S.") |>
  summarise(mean_spread = mean(rawpoll_clinton - rawpoll_trump, na.rm = TRUE),
            sd_spread   = sd(rawpoll_clinton   - rawpoll_trump, na.rm = TRUE))

# Do higher-grade (more rigorous) pollsters agree more with each other?
# Analogous to asking whether standardised UX metrics (SUS) show less variance
# than ad-hoc satisfaction questions.
polls_us_election_2016 |>
  filter(state == "U.S.", !is.na(grade)) |>
  group_by(grade) |>
  summarise(spread_sd = sd(rawpoll_clinton - rawpoll_trump, na.rm = TRUE))
```

---

##### `R/brexit_polls.R` — Online vs. in-lab UX study mode effects

**HCI/UX reframe:** The systematic gap between online and telephone Brexit polls is a direct analogue of the **mode effect** in usability research: participants tested remotely (unmoderated online studies) consistently give different ratings than those tested in a lab. This dataset lets students quantify a real-world mode effect and build confidence intervals that account for it.

**Example questions:**
```r
# Do online and telephone polls systematically differ in their Leave estimate?
# Directly parallels comparing unmoderated remote testing vs. lab testing SUS scores.
library(dplyr)
brexit_polls |>
  group_by(poll_type) |>
  summarise(mean_leave = mean(leave), sd_leave = sd(leave),
            n = n())

# Build a 95% CI for the Remain proportion using the final two weeks of polls.
# In UX: this is the CI around your benchmark usability score before launch.
final_polls <- brexit_polls |> filter(enddate >= as.Date("2016-06-09"))
t.test(final_polls$remain)$conf.int
```

---

##### `R/gapminder.R` — Digital divide and technology adoption across countries

**HCI/UX reframe:** The same longitudinal framework used to track infant mortality and GDP across countries applies to studying **digital inequality**: internet penetration rates, smartphone adoption, and digital literacy scores vary dramatically by country and income level and have converged (or not) over decades. Gapminder data trains the analytical habits needed for cross-national HCI research.

**Example questions:**
```r
# Has the gap in life expectancy between regions narrowed since 1960?
# Analogous to asking: is the digital divide in smartphone adoption closing over time?
library(dplyr); library(ggplot2)
gapminder |>
  filter(continent %in% c("Africa", "Europe"), !is.na(life_expectancy)) |>
  group_by(continent, year) |>
  summarise(mean_le = mean(life_expectancy)) |>
  ggplot(aes(x = year, y = mean_le, color = continent)) +
  geom_line() +
  labs(title = "Convergence over time — same analysis used for digital divide data")

# Does GDP (proxy for technology access) still predict life expectancy in 2016?
gapminder |> filter(year == 2016, !is.na(gdp), !is.na(life_expectancy)) |>
  with(cor.test(log(gdp / population), life_expectancy))
```

---

##### `R/brca.R` — Predicting user churn or fraud detection in app stores

**HCI/UX reframe:** The binary classification pipeline — feature extraction, model training, sensitivity/specificity tradeoff — is identical to building a **user churn predictor** or an **app-store fraud detector** (fake reviews, bot accounts). The false-positive/false-negative tradeoff discussed in the cancer diagnosis context (missing a tumour vs. unnecessary biopsy) maps directly to the cost asymmetry in automated content moderation (missing harmful content vs. wrongly removing legitimate posts).

**Example questions:**
```r
# Train a logistic regression classifier.
# In UX terms: which behavioural features best predict churn (malignant = churned)?
library(caret)
set.seed(1)
train_idx <- createDataPartition(brca$y, p = 0.8, list = FALSE)
df_train  <- data.frame(y = brca$y, brca$x)[train_idx, ]
fit_glm   <- train(y ~ ., data = df_train, method = "glm")

# Evaluate sensitivity and specificity on the held-out test set.
# Which threshold minimises false negatives (missed churns / missed cancers)?
pred <- predict(fit_glm, data.frame(brca$x)[-train_idx, ])
confusionMatrix(pred, brca$y[-train_idx])

# Which features are most predictive? These become the leading indicators
# to monitor in a real-time user behaviour dashboard.
cor(brca$x, as.numeric(brca$y == "M")) |> sort() |> tail(5)
```

---

##### `R/mnist_27.R` — Visual UI element recognition and CAPTCHA

**HCI/UX reframe:** Handwritten digit recognition is the prototype task for **visual interface element classification**: icon similarity detection, CAPTCHA generation and solving, OCR of form inputs, and automated UI screenshot testing. Comparing logistic regression (linear boundary) to k-NN (flexible boundary) on this dataset teaches the model-selection reasoning used when building visual classifiers for interaction data.

**Example questions:**
```r
# Compare a linear classifier (logistic regression) and a flexible one (k-NN).
# In HCI: linear = a simple rule-based classifier for UI elements;
#          k-NN  = a nearest-neighbour matcher in an icon similarity engine.
library(caret)
fit_glm <- train(y ~ ., data = mnist_27$train, method = "glm")
fit_knn <- train(y ~ ., data = mnist_27$train, method = "knn",
                 tuneGrid = data.frame(k = 5))
confusionMatrix(predict(fit_glm, mnist_27$test), mnist_27$test$y)
confusionMatrix(predict(fit_knn, mnist_27$test), mnist_27$test$y)

# Visualise the decision boundary against the true probability surface.
# Analogous to mapping the confidence regions of an icon-matching algorithm.
```

---

##### `R/movielens.R` — App recommendation and content personalisation

**HCI/UX reframe:** Movie ratings are behavioral logs of user preferences — the same data structure as in-app ratings, thumbs-up/down feedback, and implicit signals (play time, skip rate). Collaborative filtering is the engine behind personalisation in every major platform. The `fit_recommender_model()` function implements the same penalised ALS algorithm used in production recommendation systems.

**Example questions:**
```r
# Do users show systematic rating biases (some rate everything 5 stars; others 2)?
# This is the user-level baseline effect 'a' in any recommendation model.
library(dplyr)
movielens |>
  group_by(userId) |>
  summarise(mean_rating = mean(rating), sd_rating = sd(rating)) |>
  ggplot(aes(mean_rating)) + geom_histogram(bins = 30) +
  labs(title = "User rating bias distribution",
       subtitle = "Analogous to individual response style in UX Likert surveys")

# Fit a collaborative filtering model with fit_recommender_model().
# Inspect user effects 'a': which users are systematic over- or under-raters?
\dontrun{
  fit <- with(movielens, fit_recommender_model(rating, userId, movieId, K = 5))
  sort(fit$a) |> head(10)  # most negative user biases
}
```

---

##### `R/nyc_regents_scores.R` — Response clustering at SUS and UX scale thresholds

**HCI/UX reframe:** The spike at score 65 (the passing threshold) in Regents exam data mirrors a response-clustering artifact in usability scales: respondents anchor on the "acceptable usability" boundary (SUS = 68, or the midpoint of a Likert scale), inflating counts near that value. The same histogram analysis used here is applied to detect floor/ceiling effects and threshold-anchoring biases in UX questionnaire data.

**Example questions:**
```r
# Visualise all five exam distributions and mark the passing threshold.
# In UX research: replace 65 with SUS = 68 (the 'acceptable usability' boundary).
library(tidyr); library(ggplot2)
pivot_longer(nyc_regents_scores, -score, names_to = "exam", values_to = "freq") |>
  ggplot(aes(x = score, y = freq)) + geom_col() + facet_wrap(~exam) +
  geom_vline(xintercept = 65, color = "red", linetype = "dashed") +
  labs(title = "Score distribution with threshold marked",
       subtitle = "Same plot used to detect anchoring at SUS = 68 in usability studies")

# Is the spike at 65 larger for some exams than others?
# Compute the ratio of frequency at 65 to the average of scores 62-64.
nyc_regents_scores |>
  dplyr::summarise(across(-score, ~ .[score == 65] / mean(.[score %in% 62:64]),
                          .names = "{.col}_spike"))
```

---

##### `R/divorce_margarine.R` — Spurious correlations in app analytics

**HCI/UX reframe:** App analytics dashboards routinely surface high correlations between unrelated metrics that share a seasonal time trend — e.g., daily app opens correlating with ambient temperature, step count, or competing platform usage. This near-perfect spurious correlation (r > 0.99) is a memorable anchor for teaching analysts to detrend before interpreting app engagement metrics.

**Example questions:**
```r
# A nearly perfect correlation — but obviously non-causal.
# Analogous to: "daily active users correlates 0.97 with average outdoor temperature."
with(divorce_margarine, cor(margarine_consumption_per_capita, divorce_rate_maine))

# Detrend both variables to remove the shared time trend.
# This is the standard pre-processing step in app engagement time-series analysis.
fit_div  <- lm(divorce_rate_maine               ~ year, data = divorce_margarine)
fit_marg <- lm(margarine_consumption_per_capita ~ year, data = divorce_margarine)
cor(resid(fit_div), resid(fit_marg))
# Does the strong correlation survive detrending? What does this tell us?
```

---

#### Medium Priority

---

##### `R/murders.R` — Regional variation in technology-related incidents

**HCI/UX reframe:** Computing population-adjusted rates and comparing regional patterns is the same operation used to analyse regional variation in smartphone theft reports, cyberbullying incidents per user, or app privacy-complaint rates across states. The workflow here (compute rate per capita, visualise by region) is a template for any geographically stratified behavioral technology dataset.

**Example questions:**
```r
# Compute the gun murder rate per 100,000 — the same formula used for
# app incident rates per 100,000 installs or cybercrime reports per 100,000 users.
library(dplyr)
murders |>
  mutate(rate = total / population * 1e5) |>
  group_by(region) |>
  summarise(mean_rate = mean(rate)) |>
  arrange(desc(mean_rate))

# Does raw count mislead about regional risk (as it does in app analytics
# when comparing large vs. small user bases)?
with(murders, cor(population, total))
```

---

##### `R/outlier_example.R` — Unit-error artifacts in sensor and log data

**HCI/UX reframe:** In behavioral technology research, response-time data logged in milliseconds by some devices and in seconds by others creates an extreme outlier identical to the one in this dataset. A single sensor reporting in the wrong unit inflates the mean dramatically while leaving the median unaffected — a critical reason to use median rather than mean for reaction-time and interaction latency data.

**Example questions:**
```r
# Analogous to one device logging response times in seconds while
# all others log in milliseconds — how much does the outlier shift the mean?
mean(outlier_example); median(outlier_example)

# Remove the outlier (unit-corrected or excluded) and compare:
clean <- outlier_example[outlier_example < 10]
mean(clean); median(clean)
# Lesson: always use median (or trimmed mean) for latency/RT data in HCI studies.
```

---

##### `R/polls_2008.R` — Tracking daily user sentiment during a product launch

**HCI/UX reframe:** Daily NPS or satisfaction scores during a product launch produce noisy time series with the same structure as election polling margins. LOESS smoothing extracts the underlying satisfaction trend from day-to-day noise — the same technique used in product analytics dashboards to distinguish genuine engagement shifts from random fluctuation.

**Example questions:**
```r
# Fit a LOESS smooth to the margin over time.
# In UX product analytics: substitute NPS scores for poll margins,
# and app version release dates for key campaign events.
library(ggplot2)
ggplot(polls_2008, aes(x = day, y = margin)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "loess", span = 0.3) +
  labs(title = "Opinion trend over time",
       subtitle = "Same method: daily satisfaction score smoothing during app launch")

# What is the noise-to-signal ratio (SD of raw values vs. SD of smoothed values)?
sd(polls_2008$margin)
```

---

##### `R/mice_weights.R` — A/B testing with demographic blocking

**HCI/UX reframe:** The two-factor design (diet x sex) directly mirrors a UX A/B experiment testing two interface variants across two user groups (e.g., interface version x expertise level). The interaction term is crucial: an interface improvement that helps novices may slow down experts. This is the same two-way ANOVA logic, and `mice_weights` provides clean experimental data to practise it before applying it to UX study data.

**Example questions:**
```r
# Is the effect of diet on body weight the same for both sexes?
# Substitute: is the effect of interface version on task time the same for
# novice and expert users? (interface_version * expertise interaction)
fit <- aov(body_weight ~ diet * sex, data = mice_weights)
summary(fit)

# Visualise the interaction — the same violin plot used for UX condition × group designs.
library(ggplot2)
ggplot(mice_weights, aes(x = diet, y = percent_fat, fill = sex)) +
  geom_violin() + geom_jitter(width = 0.1, alpha = 0.3) +
  labs(title = "Interaction plot: diet x sex (analogous to interface x user group)")
```

---

##### `R/tissue_gene_expression.R` — User segmentation from interaction logs

**HCI/UX reframe:** The same PCA and clustering workflow used to identify tissue types from gene expression profiles is used in UX research to discover **behavioral user archetypes** from clickstream data, gesture logs, or eye-tracking matrices. Each "gene" maps to a logged interaction feature; each "tissue type" maps to a user segment with a distinct interaction style.

**Example questions:**
```r
# Apply PCA — analogous to reducing a high-dimensional clickstream feature matrix
# to a 2D user-behaviour space for visualisation and segmentation.
pca <- prcomp(tissue_gene_expression$x)
data.frame(PC1 = pca$x[, 1], PC2 = pca$x[, 2],
           tissue = tissue_gene_expression$y) |>
  ggplot(aes(PC1, PC2, color = tissue)) + geom_point() +
  labs(title = "PCA of high-dimensional data",
       subtitle = "Same plot used for user segmentation from interaction logs")

# k-means clustering: how well do 7 clusters recover the true tissue labels?
# In UX: how well do k behavioural clusters align with self-reported user personas?
library(mclust)
km <- kmeans(tissue_gene_expression$x, centers = 7, nstart = 25)
adjustedRandIndex(km$cluster, tissue_gene_expression$y)
```

---

##### `R/mnist_127.R` — Three-class UI element and gesture classification

**HCI/UX reframe:** Extending binary classification to three classes mirrors a common HCI task: recognising three gesture types (tap, swipe, pinch), classifying three levels of usability severity, or distinguishing three types of user states (engaged, distracted, frustrated) from physiological or interaction signals.

**Example questions:**
```r
# LDA for three-class discrimination — the same model used for
# classifying three user states from behavioural signals.
library(MASS)
fit_lda <- lda(y ~ x_1 + x_2, data = mnist_127$train)
pred    <- predict(fit_lda, mnist_127$test)

# Which pair of classes is most easily confused?
# In HCI: which gesture pair causes most recognition errors?
table(predicted = pred$class, actual = mnist_127$test$y)
```

---

##### `R/us_contagious_diseases.R` — Technology adoption and abandonment curves

**HCI/UX reframe:** App adoption and abandonment follow epidemic-like dynamics: rapid spread along social networks, plateau after market saturation, sharp decline after a reputation crisis. The visualization pipeline here — rate computation, time series by region, annotation of key events — is directly applicable to app store download and uninstall data.

**Example questions:**
```r
# Compute incidence rate and annotate vaccine introduction (analogous to
# annotating a product launch or a major app redesign).
library(dplyr); library(ggplot2)
us_contagious_diseases |>
  filter(disease == "Measles") |>
  group_by(year) |>
  summarise(rate = sum(count) / sum(population) * 1e5) |>
  ggplot(aes(x = year, y = rate)) + geom_line() +
  geom_vline(xintercept = 1963, color = "blue", linetype = "dashed") +
  labs(title = "Incidence rate over time with intervention annotated",
       subtitle = "Same plot: daily active users with app launch / redesign annotated")
```

---

##### `R/pr_death_counts.R` — Measuring engagement impact of an app outage or major update

**HCI/UX reframe:** Excess mortality estimation (observed minus expected) is the same interrupted time series method used in product analytics to measure the engagement impact of a major app outage, a forced update, or a controversial policy change. The challenge — choosing the right pre-event baseline — is identical in both contexts.

**Example questions:**
```r
# Visualise the structural break — analogous to identifying the drop-off
# in daily active users after a major app outage or controversial redesign.
library(ggplot2)
ggplot(pr_death_counts, aes(x = date, y = deaths)) +
  geom_line() +
  geom_vline(xintercept = as.Date("2017-09-20"), color = "red",
             linetype = "dashed") +
  labs(title = "Daily counts with event annotated",
       subtitle = "Same method: DAU time series with app outage date marked")

# Estimate excess events in the 90 days after the structural break.
# Compare to the same 90-day window in a baseline year.
```

---

##### `R/na_example.R` — Dropout and missing responses in online UX surveys

**HCI/UX reframe:** In online usability studies, participants skip items, abandon questionnaires mid-way, or fail attention checks. Understanding whether missingness is random (MCAR), conditional on observed variables (MAR — e.g., users who found the interface confusing skip the satisfaction items), or systematic (MNAR — dissatisfied users don't answer at all) is essential before computing any aggregate usability score.

**Example questions:**
```r
# What proportion of responses are missing?
# Benchmark: well-designed online UX surveys typically see 3-10% item-level missingness.
mean(is.na(na_example))

# How much does excluding missing values change the mean?
# Sensitivity analysis: critical when scoring SUS or UEQ with incomplete responses.
mean(na_example, na.rm = TRUE)
mean(na_example[!is.na(na_example)])
# What would the mean be if missing values were systematically from dissatisfied users
# (i.e., below-average ratings)? Discuss MNAR implications.
```

---

#### Low Priority (light reframe, same statistical concept)

| File | HCI/UX analogy | Key concept |
|---|---|---|
| `R/stars.R` | Visualization-driven discovery; analogy to 2D scatter plots of usability metrics revealing latent user groups | Category learning, visualization for insight |
| `R/olive.R` | Multivariate classification benchmark; parallels classifying user types from multi-item UX questionnaire profiles | Multi-class classification, feature profiling |
| `R/greenhouse_gases.R` | Long-horizon trend visualization; analogous to multi-year engagement or digital-divide trend data | Environmental data literacy, trend viz |
| `R/temp_carbon.R` | Causal claims from observational time series; relevant to interpreting correlations between screen time and wellbeing | Correlation vs. causation |
| `R/historic_co2.R` | Deep-time context and cognitive scale effects; how to frame long-term technology change data | Risk/scale perception |
| `R/results_us_election_2012.R` | Reference dataset for anchoring-bias exercises; used alongside 2016 polling data | Anchoring, forecast calibration |
| `R/rfalling_object.R` | Measurement error; analogous to noisy RT or biometric data from wearables | Measurement error, signal recovery |
| `R/ds_theme_set.R` | Rename: "Set a Clean ggplot2 Theme for Behavioural HCI Data Plots" | Utility |

---

### 3. Function documentation files

| File | Key HCI/UX addition |
|---|---|
| `R/take_poll.R` | Reframe as sampling variability in user satisfaction surveys: each "poll" is a usability study with n participants; repeated studies will yield different SUS scores. Build intuition for why confidence intervals are essential before reporting a benchmark score. |
| `R/read_mnist.R` | Add: full MNIST provides training data for icon/glyph recognition pipelines used in accessibility tools, document digitisation, and app testing automation. CNNs trained on MNIST develop internal feature detectors analogous to V1/V2 simple cells in human visual cortex. |
| `R/fit_recommender_model.R` | Add to `@details`: the latent factors `p` (users) and `q` (items) are analogous to person scores and item loadings in factor analysis of preference data. The user effect `a` captures individual rating style (optimistic vs. critical evaluators) — the same individual difference controlled for in UX benchmark studies using standardised questionnaires. |

---

## Implementation Sequence

1. Edit `DESCRIPTION`
2. Edit all High-priority `R/*.R` files (12 files)
3. Edit Medium-priority `R/*.R` files (10 files)
4. Edit Low-priority `R/*.R` files (8 files)
5. Run `devtools::document()` to regenerate `man/`
6. Run `devtools::check()` to validate the package

---

## Verification

```r
# Reload documentation
devtools::document()

# Check reframed help pages
?admissions
?heights
?divorce_margarine
?nyc_regents_scores
?movielens

# Full package check
devtools::check()

# Confirm all datasets still load correctly
library(behdslabs)
head(admissions)
head(heights)
head(movielens)
```
