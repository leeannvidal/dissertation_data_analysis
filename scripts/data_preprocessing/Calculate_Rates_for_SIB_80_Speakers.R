

coda_s_SIB <- readRDS("data/cleaned_data/coda_s_cleaned_ALL_SIB.rds")
fps_SIB <- readRDS("data/cleaned_data/fps_cleaned_ALL_SIB.rds")
pronouns_SIB <- readRDS("data/cleaned_data/pronouns_cleaned_ALL_SIB.rds")
subject_position_SIB <- readRDS("data/cleaned_data/subject_position_cleaned_ALL_SIB.rds")
subject_position_pronouns_SIB <- readRDS("data/cleaned_data/subject_position_pronouns_cleaned_ALL_SIB.rds")
general_subject_position_SIB <- readRDS("data/cleaned_data/general_subject_position_cleaned_ALL_SIB.rds")

# 

# STEP 1 - Calculate RATE for all tokens as well as each individual phonological form

#CODA S MISMATCH
coda_s_mismatch_SIB <- coda_s_SIB %>%
  group_by(SPEAKER, PLUS, COUNTRY_OF_ORIGIN, REGIONAL_ORIGIN, IMMIGRATION_CATEGORY, PERCENT_INTL_SPAN_ONLY, PERCENT_INTL_ENG_ONLY) %>%
  summarise(COUNT_CODA_S_MISMATCH = n(), RATE_MISMATCH_CODA_S = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

#CODA S DELETION
coda_s_deletion_SIB <- coda_s_SIB %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_CODA_S_DELETION = n(), RATE_DELETION_CODA_S = 100 * mean(DELETION == "deleted", na.rm = TRUE))


#FILLED PAUSES  
fp_centralized_SIB <- fps_SIB %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_FPS = n(), RATE_CENTRALIZED_FPS = 100 * mean(CENTRALIZED_FPS == "centralized", na.rm = TRUE))

#PRONOUNS PRESENT 
pronouns_present_SIB <- pronouns_SIB %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_PRONOUNS = n(), RATE_PRONOUNS_PRESENT = 100 * mean(PRONOUN == "present", na.rm = TRUE))

# PRE VERBAL SUBJECTS
preverbal_subjects_SIB <- subject_position_SIB %>%
  filter(INFINITIVE != "gustar") %>% 
  group_by(SPEAKER) %>%
  summarise(COUNT_SUBJECT_POSITION = n(), RATE_PREVERBAL_SUBJECTS = 100 * mean(SUB_POSITION == "preverbal", na.rm = TRUE))


# STEP 2 - COMBINE ALL FOUR INTO ONE DF
rates_all_SIB <- coda_s_mismatch_SIB %>% 
  left_join(coda_s_deletion_SIB, by = "SPEAKER") %>% 
  left_join(fp_centralized_SIB, by = "SPEAKER") %>% 
  left_join(pronouns_present_SIB, by = "SPEAKER") %>% 
  left_join(preverbal_subjects_SIB, by = "SPEAKER") 

# Save the cleaned dataframe
saveRDS(rates_all_SIB, "data/cleaned_data/rates_SIB_80speakers.rds")
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
