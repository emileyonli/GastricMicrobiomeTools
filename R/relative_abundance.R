#' Calculate relative abundance
#'
#' Normalises each sample to sum to one. Samples with a total count of zero
#' remain all-zero rows.
#'
#' @param counts A samples-by-taxa count matrix or data frame.
#' @return A numeric matrix of relative abundances.
#' @export
relative_abundance <- function(counts) {
  counts <- validate_count_table(counts)
  totals <- rowSums(counts)
  out <- counts
  nonzero <- totals > 0
  out[nonzero, ] <- counts[nonzero, , drop = FALSE] / totals[nonzero]
  out[!nonzero, ] <- 0
  out
}
