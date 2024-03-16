library(tibble)
library(testthat)
library(readr)
library(dplyr)
library(stringr)


death_simulation <- 
  tibble(
    cause = rep(x = c("Malignant Neoplasms", "Cardiovascular Diseases", "Ischaemic Heart Diseases"), each = 23),
    year = rep(x = 2000:2022, times = 3),
    deaths = rnbinom(n = 69, size = 20, prob = 0.1)
  )

# Tests for simulation
test_that("Data frame has the correct dimensions", {
  expect_equal(dim(death_simulation), c(69, 3))
})

test_that("There are no NA values in deaths", {
  expect_true(all(!is.na(death_simulation$deaths)))
})

test_that("Years and causes have correct unique values", {
  expect_equal(length(unique(death_simulation$year)), 23)
  expect_equal(length(unique(death_simulation$cause)), 3)
  expect_equal(unique(death_simulation$cause), 
               c("Malignant Neoplasms", "Cardiovascular Diseases", "Ischaemic Heart Diseases"))
})



# Tests for the data
data_path <- "/cloud/project/data/cleaned/cleaned_top_30.csv"

data <- read_csv(data_path) %>%
  add_count(cause_of_death_icd_10) %>%
  mutate(cause_of_death_icd_10 = str_trunc(cause_of_death_icd_10, 30))

# Tests
test_that("Data frame is loaded with the correct number of columns", {
  expect_equal(ncol(data), 5) 
})

test_that("Years are within the expected range", {
  expect_true(all(data$ref_date >= 2000 & data$ref_date <= 2022))
})

test_that("Deaths column contains reasonable values", {
  expect_true(all(data$value >= 0))
})
