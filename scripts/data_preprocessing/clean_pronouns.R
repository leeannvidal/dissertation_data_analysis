# scripts/clean_pronouns.R

# Check for NA values in the dataset
pronouns <- pronouns %>% filter(!is.na(PRONOUN))

# Apply the COUNTRY_OF_ORIGIN mutation
pronouns <- mutate_country_of_origin(pronouns)

# Relevel the PRONOUN factor
pronouns$PRONOUN <- factor(pronouns$PRONOUN, levels = c("present", "absent"))

# Save the cleaned dataframe
saveRDS(pronouns, "data/cleaned_data/pronouns_cleaned.rds")
