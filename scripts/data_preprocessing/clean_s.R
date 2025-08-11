# scripts/clean_s.R

# Apply the COUNTRY_OF_ORIGIN mutation
s <- mutate_country_of_origin(s)

# Filter out non-coda tokens
coda_s <- s %>%
  filter(SYLPOSITION == "coda") %>%
  droplevels()

# Filter out ct tokens
coda_s <- coda_s %>%
  filter(SEGMENTAL != "ct") %>%
  droplevels()

# Create Match/Mismatch variable
match <- c("s", "z")
mismatch <- c("deletion", "g", "h")

coda_s <- coda_s %>%
  mutate(PHONETIC_PHONOLOGICAL_AGREEMENT = case_when(
    SEGMENTAL %in% match ~ 'match',
    TRUE  ~ 'mismatch'
  ), .after = DELETION)

# Check for NA values in the dataset
coda_s <- coda_s %>% filter(!is.na(PHONETIC_PHONOLOGICAL_AGREEMENT))

# Save the cleaned dataframe to avoid redundancy
saveRDS(coda_s, "data/cleaned_data/coda_s_cleaned.rds")
