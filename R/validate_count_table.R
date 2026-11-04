#' Validate a microbiome count table
#'
#' Rows must represent samples and columns must represent taxa.
#' Values must be finite, non-negative numeric counts.
#'
#' @param counts A numeric matrix or data frame.
#' @return The validated count matrix.
#' @export
validate_count_table <- function(counts) {
  if (!is.matrix(counts) && !is.data.frame(counts)) {
    stop("`counts` must be a matrix or data frame.", call. = FALSE)
  }

  counts <- as.matrix(counts)

  if (!is.numeric(counts)) {
    stop("All columns in `counts` must be numeric.", call. = FALSE)
  }
  if (length(dim(counts)) != 2L || nrow(counts) < 1L || ncol(counts) < 1L) {
    stop("`counts` must have at least one sample and one taxon.", call. = FALSE)
  }
  if (anyNA(counts) || any(!is.finite(counts))) {
    stop("`counts` cannot contain missing or non-finite values.", call. = FALSE)
  }
  if (any(counts < 0)) {
    stop("`counts` cannot contain negative values.", call. = FALSE)
  }
  if (is.null(rownames(counts))) {
    rownames(counts) <- paste0("Sample", seq_len(nrow(counts)))
  }
  if (is.null(colnames(counts))) {
    colnames(counts) <- paste0("Taxon", seq_len(ncol(counts)))
  }
  if (anyDuplicated(rownames(counts)) || anyDuplicated(colnames(counts))) {
    stop("Sample and taxon names must be unique.", call. = FALSE)
  }

  storage.mode(counts) <- "double"
  counts
}
