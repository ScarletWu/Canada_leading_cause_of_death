library(readr)
library(dplyr)
library(stringr)
library(modelsummary)
library(rstanarm)
library(broom) 
library(broom.mixed)
library(ggplot2)
library(bayesplot)

data_path <- "/cloud/project/data/cleaned/cleaned_top_30.csv"

data <- read_csv(data_path) %>%
  add_count(cause_of_death_icd_10) %>%
  mutate(cause_of_death_icd_10 = str_trunc(cause_of_death_icd_10, 30))


top_nine <-
  data |>
  filter(
    ref_date == 2022
  ) |>
  slice_max(order_by = desc(rank), n = 9) |>
  pull(cause_of_death_icd_10)


top_9 <-
  data |>
  filter(cause_of_death_icd_10 %in% top_nine)

datasummary(
  value ~ Min + Mean + Max + SD + Var + N,
  fmt = 0,
  data = top_9
)

cause_of_death_poisson <-
  stan_glm(
    value ~ cause_of_death_icd_10,
    data = top_9,
    family = poisson(link = "log"),
    seed = 853
  )

cause_of_death_neg_binomial <-
  stan_glm(
    value ~ cause_of_death_icd_10,
    data = top_9,
    family = neg_binomial_2(link = "log"),
    seed = 853
  )

# Save models

saveRDS(
  cause_of_death_poisson,
  file = "/cloud/project/outputs/model/cause_of_death_poisson.rds"
)

saveRDS(
  cause_of_death_neg_binomial,
  file = "/cloud/project/outputs/model/cause_of_death_neg_binomial.rds"
)

poisson_summary <- summary(cause_of_death_poisson)
neg_binomial_summary <- summary(cause_of_death_neg_binomial)


tidy_poisson <- tidy(cause_of_death_poisson)
tidy_neg_binomial <- tidy(cause_of_death_neg_binomial)

combined_summary <- bind_rows(
  mutate(tidy_poisson, model = "Poisson"),
  mutate(tidy_neg_binomial, model = "Negative Binomial")
)

coef_short_names <- 
  c("cause_of_death_icd_10Malignant Neoplasms"
    = "Malignant Neoplasms",
    "cause_of_death_icd_10Diseases of Heart"
    = "Diseases of Heart",
    "cause_of_death_icd_10Respiratory Malignant Neoplasms"
    = "Respiratory Malignant Neoplasms",
    "cause_of_death_icd_10Dementia [F010-F019, F03]"
    = "Dementia",
    "cause_of_death_icd_10COVID-19"
    = "COVID-19",
    "cause_of_death_icd_10Major Cardiovascular Diseases"
    = "Major Cardiovascular Diseases",
    "cause_of_death_icd_10Ischaemic Heart Diseases"
    = "Ischaemic Heart Diseases",
    "cause_of_death_icd_10Unspecified Dementia"
    = "Unspecified Dementia",
    "cause_of_death_icd_10Other Chronic Ischchaemic Heart Diseases"
    = "Other Chronic Ischchaemic Heart Diseases"
  )

combined_summary$term <- 
  ifelse(combined_summary$term %in% names(coef_short_names),
         coef_short_names[combined_summary$term],
         combined_summary$term)

models_list <- list(
  Poisson = cause_of_death_poisson,
  `Negative Binomial` = cause_of_death_neg_binomial
)


modelsummary(models_list, coef_map = coef_short_names)

pp_check(cause_of_death_poisson) +
  theme(legend.position = "bottom")

pp_check(cause_of_death_neg_binomial) +
  theme(legend.position = "bottom")