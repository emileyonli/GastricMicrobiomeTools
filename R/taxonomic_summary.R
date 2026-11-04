#' Summarise counts by taxonomic label
#'
#' @param counts A samples-by-taxa count matrix or data frame.
#' @param taxonomy A character vector with one taxonomic label per column
#'   of `counts`, in the same order.
#' @return A named numeric vector of total counts by taxonomic label.
#' @export
taxonomic_summary <- function(counts, taxonomy) {
  counts <- validate_count_table(counts)
  if (!is.character(taxonomy) || length(taxonomy) != ncol(counts)) {
    stop("`taxonomy` must be a character vector with one label per taxon.",
         call. = FALSE)
  }
  if (anyNA(taxonomy) || any(!nzchar(trimws(taxonomy)))) {
    stop("Taxonomic labels must be non-missing and non-empty.",
         call. = FALSE)
  }

  totals_by_taxon <- colSums(counts)
  result <- tapply(totals_by_taxon, taxonomy, sum)
  result[order(names(result))]
}
