# CLAUDE.md

## What this repo is

Fork of Rafael Irizarry & Amy Gill's `dslabs` R package, renamed `behdslabs` for the *Behavioural Data Science* course (PS0000002, UniPD, AY 2026/2027). Provides datasets and helper functions used for exercises, homework, and case studies across both `behdsbook-part-1` and `behdsbook-part-2`. Published at https://github.com/intro-to-behds/behdslabs.

Course planning lives in the separate course hub: `/Users/giorgioarcara/Documents/Teaching/2026 - Behavioural Data Science/CLAUDE.md` and `BDS_course_structure.md`.

## Adaptation rule

Original datasets (murders, baseball, elections, genomics) are being replaced with behavioural equivalents — reaction times, accuracy scores, survey/Likert data, experiment logs — per the course's key adaptation rule. See `REFLAVORING_PLAN.md` for the full dataset-by-dataset plan (Tier 1 implemented, Tier 2/3 proposed) and `REFRAMING_PLAN_ARCHIVE.md` for an earlier, superseded approach whose analogy content was mined into the current plan.

**Values must differ from the dslabs originals.** Every reflavoured numeric column is a deterministic transform of its dslabs source and must not be byte-identical to it. The default transform is multiplicative — `new = k * old`, one documented constant `k ≠ 1` per column (`round()`ed for count columns) — with documented exceptions that stay identical (dates/`year`, IDs and weights, proportions/probabilities bounded to [0,1]/[0,100], compositional percentages, opaque pixel/feature matrices, free text) plus two columns that are linearly range-rescaled instead (`reaction_times$rt_ms`, `global_tech_adoption$avg_daily_screen_time_hours`). Constants live in `R/reflavor_constants.R` and are enforced by `tests/testthat/`.

## Structure

Standard R package layout: `R/` (functions), `data/` (datasets), `man/` (docs), `DESCRIPTION`/`NAMESPACE`.

Two separate script conventions coexist deliberately — don't merge them:
- `inst/script/make-<dataset>.R` — one file per **original** upstream dslabs dataset, documenting how each `.rda` was originally constructed. Not part of the reflavoring effort; leave untouched.
- `data-raw/reflavor_datasets.R` — a single script covering all **derived/relabeled** Tier-1+ datasets added by this course's reflavoring effort (loads an original dataset, transforms/renames it, writes the new object). One script rather than one-per-dataset because every block is a rename/rescale of something that already exists, not an independent construction.
