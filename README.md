# GastricMicrobiomeTools

**Starter project:** reusable base R functions for exploratory analysis of
16S rRNA microbiome count tables.

This repository is an early prototype created for the Bioconductor Developers
Mentorship Program application. It is not yet a Bioconductor-reviewed or
accepted package.

## Current functionality

- `validate_count_table()`: validates a samples-by-taxa count matrix.
- `relative_abundance()`: converts counts to within-sample proportions.
- `alpha_diversity()`: calculates observed richness, Shannon entropy and
  Simpson diversity (1 - sum of squared proportions).
- `taxonomic_summary()`: aggregates total counts by supplied taxonomic labels.

## Data convention

Rows are samples and columns are taxa (ASVs, OTUs, or other features).
The example table in `data-raw/example_counts.csv` is synthetic and is
provided only for testing and demonstration.

## Install development dependencies and test

```r
install.packages(c("devtools", "testthat", "roxygen2"))
devtools::document()
devtools::test()
devtools::check()
```

## Example

```r
counts <- as.matrix(read.csv(
  "data-raw/example_counts.csv",
  row.names = 1,
  check.names = FALSE
))

relative_abundance(counts)
alpha_diversity(counts)
taxonomic_summary(counts, c("Genus_A", "Genus_B", "Genus_C"))
```

## Development status

This is an initial educational prototype. Additional work is needed on
documentation, test coverage, input formats, Bioconductor data structures,
vignettes, and Bioconductor-specific checks before any package submission.

## Author

Emile Yonli — Burkina Faso
