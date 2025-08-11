# scripts/clean_subject_position.R

# Apply the COUNTRY_OF_ORIGIN mutation
subject_position <- mutate_country_of_origin(subject_position)

subject_position <- subject_position %>% filter(!is.na(SUB_POSITION))

# Relevel the SUB_POSITION factor
subject_position$SUB_POSITION <- factor(subject_position$SUB_POSITION, levels = c("preverbal", "postverbal"))

# Separate pronouns and general subjects
pronoun_categories <- c("personal_pronoun", "clitic_pronoun", "demonstrative_pronoun", "indefinite_pronoun", "interrogative_pronoun")

subject_position_pronouns <- subject_position %>%
  filter(SUBJECT_TYPE %in% pronoun_categories) %>%
  droplevels()

general_subject_position <- subject_position %>%
  filter(!SUBJECT_TYPE %in% pronoun_categories) %>%
  droplevels()

# Save the cleaned dataframes
saveRDS(subject_position, "data/cleaned_data/subject_position_cleaned.rds")
saveRDS(subject_position_pronouns, "data/cleaned_data/subject_position_pronouns_cleaned.rds")
saveRDS(general_subject_position, "data/cleaned_data/general_subject_position_cleaned.rds")
