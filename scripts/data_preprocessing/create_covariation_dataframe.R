# Load main cleaned dfs from RDS files

coda_s <- readRDS("data/cleaned_data/s_cleaned.rds")
fps <- readRDS("data/cleaned_data/fps_cleaned.rds")
pronouns <- readRDS("data/cleaned_data/pronouns_cleaned.rds")
subject_position_pronouns <- readRDS("data/cleaned_data/subject_position_pronouns_cleaned.rds")
general_subject_position <- readRDS("data/cleaned_data/general_subject_position_cleaned.rds")
liquids <- readRDS("data/cleaned_data/liquids_cleaned.rds")

# Load individual dfs for each PHONO_FORM for the Liquids
trill <- readRDS("data/cleaned_data/trill_cleaned.rds")
tap<- readRDS("data/cleaned_data/tap_cleaned.rds")
lateral<- readRDS("data/cleaned_data/lateral_cleaned.rds")

# STEP 1 - Calculate RATE for all tokens as well as each individual phonological form

# ALL
rates_mismatch_all_liquids <- liquids %>%
  group_by(SPEAKER, PSEUDONYM, PLUS, COUNTRY_OF_ORIGIN, REGIONAL_ORIGIN, IMMIGRATION_CATEGORY, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY) %>%
  summarise(COUNT_ALL_LIQUIDS = n(), RATE_MISMATCH_ALL_LIQUIDS = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

# FLAP
tap_mismatch <- tap %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_FLAP = n(), RATE_MISMATCH_TAP = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

# FLAP SUBSET
tap_subset_mismatch <- tap %>%
  filter(SURF_FORM %in% c("[l]", "[ɾ]")) %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_TAP_SUBSET = n(), RATE_MISMATCH_TAP_SUBSET = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

# TRILL  
trill_mismatch <- trill %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_TRILL = n(), RATE_MISMATCH_TRILL = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

# TRILL SUBSET
trill_subset_mismatch_alveolar_fricative <- trill %>%
  filter(SURF_FORM %in% c("[r]", "[r̝]")) %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_TRILL_SUBSET = n(), RATE_MISMATCH_TRILL_SUBSET = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

#LATERAL  
lateral_mismatch <- lateral %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_LATERAL = n(), RATE_MISMATCH_LATERAL = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))


#LATERAL SUBSET
lateral_subset_mismatch_dark_l <- lateral %>%
  filter(SURF_FORM %in% c("[l]", "[ɫ]")) %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_LATERAL_SUBSET = n(), RATE_MISMATCH_LATERAL_SUBSET = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

#CODA S MISMATCH
coda_s_mismatch <- coda_s %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_CODA_S_MISMATCH = n(), RATE_MISMATCH_CODA_S = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

#CODA S DELETION
coda_s_deletion <- coda_s %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_CODA_S_DELETION = n(), RATE_DELETION_CODA_S = 100 * mean(DELETION == "deleted", na.rm = TRUE))


#FILLED PAUSES  
fp_centralized <- fps %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_FPS = n(), RATE_CENTRALIZED_FPS = 100 * mean(CENTRALIZED_FPS == "centralized", na.rm = TRUE))

#PRONOUNS PRESENT 
pronouns_present <- pronouns %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_PRONOUNS = n(), RATE_PRONOUNS_PRESENT = 100 * mean(PRONOUN == "present", na.rm = TRUE))

# PRE VERBAL PRONOUNS
pronouns_preverbal <- subject_position_pronouns %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_PRONOUNS_POSITION = n(), RATE_PREVERBAL_PRONOUNS = 100 * mean(SUB_POSITION == "preverbal", na.rm = TRUE))

# PRE VERBAL GENERAL SUBJECTS
general_subjects_preverbal <- general_subject_position %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_GEN_SUBJECT_POSITION = n(), RATE_GEN_PREVERBAL_SUBJECTS = 100 * mean(SUB_POSITION == "preverbal", na.rm = TRUE))

# PRE VERBAL SUBJECTS ALL
all_subjects_preverbal <- subject_position %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_ALL_SUBJECT_POSITION = n(), RATE_ALL_PREVERBAL_SUBJECTS = 100 * mean(SUB_POSITION == "preverbal", na.rm = TRUE))


# STEP 2 - COMBINE ALL FOUR INTO ONE DF
rates_all_variables <- rates_mismatch_all_liquids %>% 
  left_join(tap_mismatch, by = "SPEAKER") %>% 
  left_join(tap_subset_mismatch, by = "SPEAKER") %>% 
  left_join(trill_mismatch, by = "SPEAKER") %>% 
  left_join(trill_subset_mismatch_alveolar_fricative, by = "SPEAKER") %>% 
  left_join(lateral_mismatch, by = "SPEAKER") %>% 
  left_join(lateral_subset_mismatch_dark_l, by = "SPEAKER") %>% 
  left_join(coda_s_mismatch, by = "SPEAKER") %>% 
  left_join(coda_s_deletion, by = "SPEAKER") %>% 
  left_join(fp_centralized, by = "SPEAKER") %>% 
  left_join(pronouns_present, by = "SPEAKER") %>% 
  left_join(pronouns_preverbal, by = "SPEAKER") %>% 
  left_join(general_subjects_preverbal, by = "SPEAKER") %>% 
  left_join(all_subjects_preverbal, by = "SPEAKER") 

# Save the cleaned dataframe
saveRDS(rates_all_variables, "data/cleaned_data/rates_all_variables.rds")
# 
# # Correlation Matrix
# selected_correlation_columns <- rates_all %>%
#   ungroup() %>%  # Remove grouping
#   select(RATE_MISMATCH_ALL_LIQUIDS, RATE_MISMATCH_TAP, RATE_MISMATCH_TRILL, RATE_MISMATCH_LATERAL, 
#          RATE_MISMATCH_CODA_S, RATE_CENTRALIZED_FPS, RATE_PRONOUNS_PRESENT, 
#          RATE_PREVERBAL_PRONOUNS, RATE_GEN_PREVERBAL_SUBJECTS) %>%
#   select_if(is.numeric)  # Only keep numeric columns
# 
# 
# # Run the correlation
# correlation_matrix <- cor(selected_correlation_columns, use = "complete.obs")
# 
# # Print the correlation matrix
# print(correlation_matrix)
# 
# # Install the corrplot package if you don't have it
# install.packages("corrplot")
# library(corrplot)
# 
# # # Plot the correlation matrix
# # corrplot(correlation_matrix, method = "circle")
# 
# # Reduce text label size by adjusting tl.cex
# corrplot(correlation_matrix, method = "circle", tl.cex = 0.4)
# corrplot(correlation_matrix, tl.cex = 0.4)
# 
# 
