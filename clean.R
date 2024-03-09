library(dplyr)
library(janitor)
library(readr)
library(stringr)

# Assuming data_path is already defined and points to your CSV file
data_path <- "/cloud/project/data/13100392.csv" 

# Read, clean, and select columns
data <- read_csv(data_path) %>%
  clean_names() %>%
  select(ref_date, sex, cause_of_death_icd_10, characteristics, value)

# Filter the dataset
filtered_data2 <- data %>%
  filter(sex == 'Both sexes',
         characteristics == 'Number of deaths',
         cause_of_death_icd_10 != 'Total, all causes of death [A00-Y89]',
         cause_of_death_icd_10 != 'All other diseases (residual)',
         !str_detect(cause_of_death_icd_10, ","))

no_sex <- filtered_data2 %>%
  select(ref_date, cause_of_death_icd_10, value)

# Remove repeats in the causes
no_repeat_data <- no_sex %>%
  group_by(ref_date, cause_of_death_icd_10) %>%
  slice_max(order_by = value, n = 1) %>%
  ungroup()

# Rank the data
ranked_data2 <- no_repeat_data %>%
  group_by(ref_date) %>%
  arrange(ref_date, desc(value)) %>%
  mutate(rank = row_number()) %>%
  ungroup()

# Filter to retain top 30 causes per year
top_30_causes <- ranked_data2 %>%
  filter(rank <= 30)

# Save the cleaned dataset
write_csv(top_30_causes, "/cloud/project/data/cleaned/cleaned_top_30.csv")

