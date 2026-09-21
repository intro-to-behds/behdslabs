.take_poll <- function(n, plot = TRUE, return_values = FALSE, blue_prob = 0.529, jitter_factor = 1, cex=1.2, ...){
  bead_color <- sample(c("Blue","Red"), n, prob=c(blue_prob, 1-blue_prob), replace = TRUE)
  if(plot){
    cols <- ifelse(bead_color=="Blue", "#0072B2", "#D55E00")
    x <- jitter(ifelse(bead_color=="Blue", 1, 2), factor = jitter_factor)
    y <- stats::rnorm(n)
    plot(x,y, pch=21, bg=cols, xlim=c(0.5,2.5), xlab="", ylab="", xaxt="n", yaxt="n", cex = cex, bty = "n", ...)
    graphics::axis(side=3, at=c(1,2), labels = c("Blue", "Red"), tick=FALSE)
    }
  if(return_values) return(bead_color) 
}

.take_review_sample <- function(n, plot = TRUE, return_values = FALSE, positive_prob = 0.529, jitter_factor = 1, cex = 1.2, ...){
  review <- sample(c("Positive", "Negative"), n, prob = c(positive_prob, 1 - positive_prob), replace = TRUE)
  if(plot){
    cols <- ifelse(review == "Positive", "#0072B2", "#D55E00")
    x <- jitter(ifelse(review == "Positive", 1, 2), factor = jitter_factor)
    y <- stats::rnorm(n)
    plot(x, y, pch = 21, bg = cols, xlim = c(0.5, 2.5), xlab = "", ylab = "", xaxt = "n", yaxt = "n", cex = cex, bty = "n", ...)
    graphics::axis(side = 3, at = c(1, 2), labels = c("Positive", "Negative"), tick = FALSE)
  }
  if(return_values) return(review)
}

## ---- simulate_* family ------------------------------------------------
## Generative simulators for the measurement chapter. Unlike the reflavoured
## datasets, these are not transforms of a dslabs original, so the k-constant
## rules in R/reflavor_constants.R do not apply to them.

## Default cut points for an ordinal response scale. Returns n_levels - 1
## thresholds on the latent (z) scale.
##
## The default is deliberately asymmetric, shifted down so that most of the
## latent distribution falls in the top categories. That is what satisfaction
## and usability scales actually look like: ratings pile up at the top end and
## the scale runs out of room -- a ceiling. The equally spaced alternative is
## the idealised interval-scale response process, kept for contrast.
.likert_thresholds <- function(n_levels, equal_spacing = FALSE){
  k <- n_levels - 1L
  even <- stats::qnorm(seq_len(k) / n_levels)
  if(equal_spacing) return(even)
  even * 1.3 - 0.85
}

.simulate_likert <- function(n = 200,
                             n_items = 5,
                             n_levels = 5,
                             true_score = NULL,
                             group = NULL,
                             group_effect = 0.5,
                             group_sd = 1,
                             error_sd = 1,
                             thresholds = NULL,
                             equal_spacing = FALSE,
                             seed = NULL){

  if(!is.null(seed)) set.seed(seed)

  if(n_items < 2) stop("`n_items` must be at least 2.")
  if(n_levels < 2) stop("`n_levels` must be at least 2.")
  if(error_sd < 0) stop("`error_sd` must be non-negative.")

  ## --- the group each respondent belongs to
  if(is.null(group)){
    group_vec <- factor(rep("all", n))
  } else if(length(group) == n){
    group_vec <- factor(group)
  } else {
    ## a vector of level names: split the n respondents evenly between them
    group_vec <- factor(rep_len(group, n), levels = unique(group))
  }
  n <- length(group_vec)

  ## --- the true score T, on a standardised latent scale
  if(is.null(true_score)){
    ## The group effect shifts the latent construct: the second level sits
    ## `group_effect` SDs above the first, and so on. `group_sd` lets the
    ## groups differ in how spread out they are as well as in where they sit
    ## -- two populations can share a mean and still not be alike.
    idx <- as.integer(group_vec)
    shift <- (idx - 1L) * group_effect
    sds <- rep_len(as.numeric(group_sd), nlevels(group_vec))[idx]
    true_score <- stats::rnorm(n, mean = shift, sd = sds)
  } else {
    if(length(true_score) != n)
      stop("`true_score` must have one value per respondent (length ", n, ").")
    true_score <- as.numeric(true_score)
  }

  ## --- each item is the true score plus its own independent error: X = T + E
  latent <- matrix(true_score, nrow = n, ncol = n_items) +
    matrix(stats::rnorm(n * n_items, mean = 0, sd = error_sd),
           nrow = n, ncol = n_items)

  ## --- the ordinal response process: cut the latent value into categories
  if(is.null(thresholds)) thresholds <- .likert_thresholds(n_levels, equal_spacing)
  if(length(thresholds) != n_levels - 1L)
    stop("`thresholds` must have `n_levels - 1` = ", n_levels - 1L, " values.")

  items <- matrix(
    findInterval(latent, sort(thresholds)) + 1L,
    nrow = n, ncol = n_items
  )
  colnames(items) <- paste0("item_", seq_len(n_items))

  out <- data.frame(
    respondent = sprintf("R%03d", seq_len(n)),
    group = group_vec,
    items,
    total = rowSums(items),
    true_score = true_score,
    stringsAsFactors = FALSE
  )
  if(is.null(group)) out$group <- NULL
  out
}

.simulate_sdt <- function(n = 40,
                          n_trials = 100,
                          signal_prob = 0.5,
                          d_prime = 1.5,
                          criterion = 0,
                          seed = NULL){

  if(!is.null(seed)) set.seed(seed)

  if(n_trials < 1) stop("`n_trials` must be at least 1.")
  if(signal_prob <= 0 || signal_prob >= 1)
    stop("`signal_prob` must be strictly between 0 and 1.")

  ## d_prime and criterion may be scalars (same for everyone) or one value
  ## per participant.
  d_prime <- rep_len(as.numeric(d_prime), n)
  criterion <- rep_len(as.numeric(criterion), n)

  n_signal <- round(n_trials * signal_prob)
  n_noise <- n_trials - n_signal

  ## Signal trials are drawn from a distribution centred at d', noise trials
  ## from one centred at 0; the participant answers "yes" whenever the
  ## evidence on a trial exceeds their criterion. Sensitivity (d') and bias
  ## (criterion) are therefore separate knobs, which is the whole point.
  hit_rate <- stats::pnorm(d_prime - criterion)
  fa_rate <- stats::pnorm(-criterion)

  hits <- stats::rbinom(n, n_signal, hit_rate)
  false_alarms <- stats::rbinom(n, n_noise, fa_rate)

  data.frame(
    participant = sprintf("P%02d", seq_len(n)),
    hits = hits,
    misses = n_signal - hits,
    false_alarms = false_alarms,
    correct_rejections = n_noise - false_alarms,
    prop_correct = (hits + (n_noise - false_alarms)) / n_trials,
    d_prime = d_prime,
    criterion = criterion,
    stringsAsFactors = FALSE
  )
}
