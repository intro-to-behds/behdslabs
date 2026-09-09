## Set working directory to package main directory
##
## Synthetic raw survey data: self-reported daily screen time (minutes),
## collected via a free-text web form (like dslabs::reported_heights,
## which asked for "height in inches" but got free text back). Modeled on
## the same messy-format *pattern* as reported_heights -- a compound
## unit'unit" notation, a digit-literal decimal typo, an alternate base
## unit needing a linear conversion, plus outright junk -- but with
## independently synthesized values (there is no real dslabs source for
## this case study; see the @note in R/reported_screen_time.R).
##
## Plausible range for a single day of self-reported screen time, in
## minutes, mirrors reported_heights' inches range (50-84) in spirit:
## narrow enough that a meaningful chunk of entries will fall outside it
## and need fixing.
set.seed(2024)

n <- 1095
smallest <- 15   # minutes
tallest  <- 600  # minutes

# start dates spread across a two-week window, like reported_heights
timestamps <- as.POSIXct("2024-09-02 09:00:00") +
  sample(0:(14 * 24 * 60 * 60), n, replace = TRUE)
time_stamp <- format(timestamps, "%Y-%m-%d %H:%M:%S")

platform <- sample(c("iOS", "Android"), n, replace = TRUE, prob = c(0.55, 0.45))

n_clean   <- 855
n_clock   <- 60   # H'M" style (feet'inches analog)
n_literal <- 60   # H.MM / H,MM digit-literal (decimal feet.inches analog)
n_seconds <- 90   # bare number, actually seconds (centimeters analog)
n_dechour <- 15   # bare decimal < 1, actually hours (meters analog)
n_garbage <- n - n_clean - n_clock - n_literal - n_seconds - n_dechour  # 15

## --- clean: already a plausible number of minutes, as entered ---
## (rejection sampling, not clamping, so values don't pile up at the
## boundary -- we want a natural gradient near the low end)
clean_vals <- numeric(0)
while (length(clean_vals) < n_clean) {
  draw <- round(rnorm(n_clean, mean = 245, sd = 95))
  draw <- draw[draw >= smallest & draw <= tallest]
  clean_vals <- c(clean_vals, draw)
}
clean_vals <- clean_vals[seq_len(n_clean)]
clean <- as.character(clean_vals)

## --- clock notation: H'M" (and variants), hours 1-9, minutes 0-59 ---
hh <- sample(1:9, n_clock, replace = TRUE)
mm <- sample(0:59, n_clock, replace = TRUE)
clock_variant <- function(h, m) {
  v <- sample(1:8, 1)
  switch(v,
    paste0(h, "'", m, "\""),
    paste0(h, "'", m, "''"),
    paste0(h, "' ", m, "\""),
    paste0(h, "'", m),
    paste0(h, " ' ", m),
    paste0(h, " hours ", m, " minutes"),
    paste0(h, "'", m, ".5''"),
    if (m == 0) paste0(h, "'") else paste0(h, "'", m)  # trailing, no minutes
  )
}
clock <- mapply(clock_variant, hh, mm)
## make sure a few of the "no minutes" (trailing quote), fully spelled-out,
## and "hr"/"min" abbreviation forms are present, mirroring "6'" and
## "Five foot eight inches"
clock[1] <- "2'"
clock[2] <- "3'"
clock[3] <- "Two hours fifteen minutes"
clock[4] <- "One hour thirty minutes"
clock[5] <- "4hr 20min"
clock[6] <- "5 hr 6 min"
clock <- unname(clock)

## --- digit-literal H.MM / H,MM: written as if decimal, meant as clock ---
hh2 <- sample(1:9, n_literal, replace = TRUE)
mm2 <- sample(0:59, n_literal, replace = TRUE)
sep <- sample(c(".", ","), n_literal, replace = TRUE)
mm2_str <- ifelse(mm2 < 10 & sample(c(TRUE, FALSE), n_literal, replace = TRUE, prob = c(0.3, 0.7)),
                   as.character(mm2), sprintf("%02d", mm2))
literal <- paste0(hh2, sep, mm2_str)

## --- seconds, entered as a bare number (needs /60) ---
target_min <- runif(n_seconds, smallest, tallest)
seconds <- round(target_min * 60 + rnorm(n_seconds, 0, 5))
seconds_str <- as.character(pmax(seconds, 1))
## a handful spell out the unit instead of a bare number
seconds_str[1] <- paste(seconds_str[1], "sec")
seconds_str[2] <- paste0(seconds_str[2], "s")
seconds_str[3] <- paste(seconds_str[3], "seconds")

## --- decimal hours < 1, entered as a bare number (needs *60) ---
target_min2 <- runif(n_dechour, smallest, 59)
dechour <- round(target_min2 / 60, 2)
dechour_str <- as.character(dechour)
## a couple use a European comma instead of a period
dechour_str[1] <- sub("\\.", ",", dechour_str[1])
dechour_str[2] <- sub("\\.", ",", dechour_str[2])

## --- garbage / genuinely unfixable ---
garbage <- c(">500", "9999", "0", "N/A", "lots", "1", "2", "asdf",
             "24/7", "1,234,567", "44*60", "screen time",
             "3 . 4 5", "-30", "idk")
garbage <- garbage[seq_len(n_garbage)]

screen_time <- c(clean, clock, literal, seconds_str, dechour_str, garbage)
ord <- sample(length(screen_time))
screen_time <- screen_time[ord]

reported_screen_time <- data.frame(
  time_stamp = time_stamp,
  platform = platform,
  screen_time = screen_time,
  stringsAsFactors = FALSE
)

save(reported_screen_time, file = "data/reported_screen_time.rda")
