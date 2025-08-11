# Load main dfs 
# 
# s <- read.csv("/Users/leeannvidal/Desktop/Dissertation/data/dataframes/SIB/s_master_df.csv", stringsAsFactors = TRUE) # CLEAN & READY
# 
# fps <- read.csv("/Users/leeannvidal/Desktop/Dissertation/data/dataframes/aggregates/DE_aggregates/aggregate_fp.csv", stringsAsFactors = TRUE) # CLEAN & READY
# 
# pronouns <- read.csv("/Users/leeannvidal/Desktop/Dissertation/data/dataframes/aggregates/DE_aggregates/aggregate_pronouns.csv", stringsAsFactors = TRUE) # CLEAN & READY
# 
subject_position <- read.csv("/Users/leeannvidal/Desktop/Dissertation/data/dataframes/SIB/subject_position_master_df.csv", stringsAsFactors = TRUE) # CLEAN & READY
# 
# # Clean dfs from RDS files
# 
# # CLEAN s
# 
# # Filter out non-coda tokens
# coda_s <- s %>%
#   filter(SYLPOSITION == "coda") %>%
#   droplevels()
# 
# # Filter out ct tokens
# coda_s <- coda_s %>%
#   filter(SEGMENTAL != "ct") %>%
#   droplevels()
# 
# # Create Match/Mismatch variable
# match <- c("s", "z")
# mismatch <- c("deletion", "g", "h")
# 
# coda_s <- coda_s %>%
#   mutate(PHONETIC_PHONOLOGICAL_AGREEMENT = case_when(
#     SEGMENTAL %in% match ~ 'match',
#     TRUE  ~ 'mismatch'
#   ), .after = DELETION)
# 
# # Check for NA values in the dataset
# coda_s <- coda_s %>% filter(!is.na(PHONETIC_PHONOLOGICAL_AGREEMENT))
# 
# saveRDS(coda_s, "data/cleaned_data/coda_s_cleaned_ALL_SIB.rds")
# 
# 
# # Clean fps
# 
# # Relevel the FP_VOWEL factor
# fps$FP_VOWEL <- factor(fps$FP_VOWEL, levels = c("schwa", "a", "e"))
# 
# # Create Centralized/ Not-Centralized variable
# 
# centralized <- c("a", "schwa")
# 
# fps <- fps %>% 
#   mutate(CENTRALIZED_FPS = case_when(
#     FP_VOWEL %in% centralized ~ 'centralized',
#     TRUE ~ 'not centralized'
#   ), .after = FP_VOWEL)
# 
# # Check for NA values in the dataset
# fps <-  fps %>% 
#   filter(!is.na(CENTRALIZED_FPS))
# 
# saveRDS(fps, "data/cleaned_data/fps_cleaned_ALL_SIB.rds")
# 
# # Clean pronouns
# # Check for NA values in the dataset
# pronouns <- pronouns %>% filter(!is.na(PRONOUN))
# 
# # Relevel the PRONOUN factor
# pronouns$PRONOUN <- factor(pronouns$PRONOUN, levels = c("present", "absent"))
# 
# saveRDS(pronouns, "data/cleaned_data/pronouns_cleaned_ALL_SIB.rds")
# 
# Clean subject position

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
saveRDS(subject_position, "data/cleaned_data/subject_position_cleaned_ALL_SIB.rds")
saveRDS(subject_position_pronouns, "data/cleaned_data/subject_position_pronouns_cleaned_ALL_SIB.rds")
saveRDS(general_subject_position, "data/cleaned_data/general_subject_position_cleaned_ALL_SIB.rds")