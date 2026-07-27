# CLAUDE.md

## What this repo is

Fork of Rafael Irizarry & Amy Gill's `dslabs` R package, renamed `behdslabs` for the *Behavioural Data Science* course (PS0000002, UniPD, AY 2026/2027). Provides datasets and helper functions used for exercises, homework, and case studies across both `behdsbook-part-1` and `behdsbook-part-2`. Published at https://github.com/intro-to-behds/behdslabs.

Course planning lives in the separate course hub: `/Users/giorgioarcara/Documents/Teaching/2026 - Behavioural Data Science/CLAUDE.md` and `BDS_course_structure.md`.

## Adaptation rule

Original datasets (murders, baseball, elections, genomics) are being replaced with behavioural equivalents — reaction times, accuracy scores, survey/Likert data, experiment logs — per the course's key adaptation rule. See `REFLAVORING_PLAN.md` for the full dataset-by-dataset plan (Tier 1 implemented, Tier 2/3 proposed) and `REFRAMING_PLAN_ARCHIVE.md` for an earlier, superseded approach whose analogy content was mined into the current plan.

## Structure

Standard R package layout: `R/` (functions), `data/` (datasets), `man/` (docs), `DESCRIPTION`/`NAMESPACE`.

Two separate script conventions coexist deliberately — don't merge them:
- `inst/script/make-<dataset>.R` — one file per **original** upstream dslabs dataset, documenting how each `.rda` was originally constructed. Not part of the reflavoring effort; leave untouched.
- `data-raw/reflavor_datasets.R` — a single script covering all **derived/relabeled** Tier-1+ datasets added by this course's reflavoring effort (loads an original dataset, transforms/renames it, writes the new object). One script rather than one-per-dataset because every block is a rename/rescale of something that already exists, not an independent construction.
