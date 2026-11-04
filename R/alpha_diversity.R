#' Calculate common alpha-diversity metrics
#'
#' Computes observed richness, Shannon entropy, and Simpson diversity
#' (1 - sum(p^2)) for each sample.
#'
#' @param counts A samples-by-taxa count matrix or data frame.
#' @return A data frame with one row per sample.
#' @export
alpha_diversity <- function(counts) {
  counts <- validate_count_table(counts)
  totals <- rowSums(counts)

  observed <- rowSums(counts > 0)
  shannon <- rep(NA_real_, nrow(counts))
  simpson <- rep(NA_real_, nrow(counts))

  nonzero <- totals > 0
  if (any(nonzero)) {
    proportions <- counts[nonzero, , drop = FALSE] /
      totals[nonzero]
    shannon[nonzero] <- -rowSums(ifelse(
      proportions > 0, proportions * log(proportions), 0
    ))
    simpson[nonzero] <- 1 - rowSums(proportions^2)
  }

  data.frame(
    sample_id = rownames(counts),
    observed_richness = as.integer(observed),
    shannon = shannon,
    simpson = simpson,
    row.names = NULL,
    check.names = FALSE
  )
}
