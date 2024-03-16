death_simulation <- 
  tibble(
    cause = rep(x = c("Malignant Neoplasms", "Cardiovascular Diseases", "Ischaemic Heart Diseases"), each = 23),
    year = rep(x = 2000:2022, times = 3),
    deaths = rnbinom(n = 69, size = 20, prob = 0.1)
  )

malignant_neoplasms <- death_simulation %>%
  filter(cause == "Malignant Neoplasms")

ggplot(malignant_neoplasms, aes(x = factor(year), y = deaths)) +
  geom_bar(stat = "identity", fill = "blue") +
  theme_minimal() +
  labs(title = "Simulated Deaths for Malignant Neoplasms Over Time",
       x = "Year",
       y = "Number of Deaths") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


cardiovascular_diseases <- death_simulation %>%
  filter(cause == "Cardiovascular Diseases")

ggplot(cardiovascular_diseases, aes(x = factor(year), y = deaths)) +
  geom_bar(stat = "identity", fill = "red") +
  theme_minimal() +
  labs(title = "Simulated Deaths for Cardiovascular Diseases Over Time",
       x = "Year",
       y = "Number of Deaths") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


ischaemic_heart_diseases <- death_simulation %>%
  filter(cause == "Ischaemic Heart Diseases")

ggplot(ischaemic_heart_diseases, aes(x = factor(year), y = deaths)) +
  geom_bar(stat = "identity", fill = "green") +
  theme_minimal() +
  labs(title = "Simulated Deaths for Ischaemic Heart Diseases Over Time",
       x = "Year",
       y = "Number of Deaths") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

