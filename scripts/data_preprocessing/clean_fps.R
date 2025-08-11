# scripts/clean_fps.R

# Apply the COUNTRY_OF_ORIGIN mutation
fps <- mutate_country_of_origin(fps)

# Relevel the FP_VOWEL factor
fps$FP_VOWEL <- factor(fps$FP_VOWEL, levels = c("schwa", "a", "e"))

# Create Centralized/ Not-Centralized variable

centralized <- c("a", "schwa")

fps <- fps %>% 
  mutate(CENTRALIZED_FPS = case_when(
    FP_VOWEL %in% centralized ~ 'centralized',
    TRUE ~ 'not centralized'
  ), .after = FP_VOWEL)

# Check for NA values in the dataset
fps <-  fps %>% 
  filter(!is.na(CENTRALIZED_FPS))

# Save the cleaned dataframe
saveRDS(fps, "data/cleaned_data/fps_cleaned.rds")
