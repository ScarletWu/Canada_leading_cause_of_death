library(dplyr)
library(janitor)
library(readr)
library(stringr)

# Assuming data_path is already defined and points to your CSV file
data_path <- "/cloud/project/data/downloaded_data.csv" 

# Read, clean, and select columns
data <- read_csv(data_path) %>%
  clean_names() %>%
  select(ref_date, sex, age_at_time_of_death, cause_of_death_icd_10, characteristics, value)

# Filter the dataset
filtered_data <- data %>%
  filter(sex == 'Both sexes',
         age_at_time_of_death == 'Age at time of death, all ages',
         characteristics == 'Number of deaths',
         !str_detect(cause_of_death_icd_10, " all "),
         !str_detect(cause_of_death_icd_10, "All "))
         
less_col <- filtered_data %>%
  select(ref_date, cause_of_death_icd_10, value)

# Rank the data
ranked_data2 <- less_col %>%
  group_by(ref_date) %>%
  arrange(ref_date, desc(value)) %>%
  mutate(rank = row_number()) %>%
  ungroup()

# Filter to retain top 30 causes per year
top_30_causes <- ranked_data2 %>%
  filter(rank <= 30)

# Save the cleaned dataset
write_csv(top_30_causes, "/cloud/project/data/cleaned/cleaned_top_30.csv")

