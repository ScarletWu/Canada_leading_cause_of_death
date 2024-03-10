library(readr)


# Download and unzip the data file
url <- "https://www150.statcan.gc.ca/n1/tbl/csv/13100392-eng.zip"

destfile <- "/cloud/project/data/data.zip" 

download.file(url, destfile, mode = "wb")

unzip(destfile, exdir = "/cloud/project/data")

data_path <- "/cloud/project/data/13100392.csv" 


data <- read_csv(data_path) %>%
  clean_names() %>%
  select(ref_date, sex, age_at_time_of_death, cause_of_death_icd_10, characteristics, value)

write_csv(data, "/cloud/project/data/downloaded_data.csv")
