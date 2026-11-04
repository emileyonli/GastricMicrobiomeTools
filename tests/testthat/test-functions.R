test_that("relative abundance sums to one for non-empty samples", {
  x <- matrix(c(10, 30, 20, 20), nrow = 2, byrow = TRUE,
              dimnames = list(c("S1", "S2"), c("T1", "T2")))
  y <- relative_abundance(x)
  expect_equal(rowSums(y), c(1, 1))
})

test_that("alpha diversity returns expected columns", {
  x <- matrix(c(10, 10, 0, 5, 5, 0), nrow = 2, byrow = TRUE,
              dimnames = list(c("S1", "S2"), c("T1", "T2", "T3")))
  y <- alpha_diversity(x)
  expect_named(y, c("sample_id", "observed_richness", "shannon", "simpson"))
  expect_equal(y$observed_richness, c(2L, 2L))
})

test_that("negative counts are rejected", {
  x <- matrix(c(1, -1), nrow = 1)
  expect_error(validate_count_table(x), "negative")
})

test_that("taxonomic counts are aggregated", {
  x <- matrix(c(2, 3, 4, 5), nrow = 2,
              dimnames = list(c("S1", "S2"), c("ASV1", "ASV2")))
  y <- taxonomic_summary(x, c("GenusA", "GenusA"))
  expect_equal(unname(y), 14)
})
