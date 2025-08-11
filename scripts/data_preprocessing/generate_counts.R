# scripts/generate_counts.R

# # Load necessary packages
# library(dplyr)
# library(readr)
# library(scales)  # To use comma() function for formatting

# Load cleaned dataframes from RDS files
coda_s <- readRDS("data/cleaned_data/coda_s_cleaned.rds")
fps <- readRDS("data/cleaned_data/fps_cleaned.rds")
pronouns <- readRDS("data/cleaned_data/pronouns_cleaned.rds")
subject_position <- readRDS("data/cleaned_data/subject_position_cleaned.rds")
subject_position_pronouns <- readRDS("data/cleaned_data/subject_position_pronouns_cleaned.rds")
general_subject_position <- readRDS("data/cleaned_data/general_subject_position_cleaned.rds")
liquids <- readRDS("data/cleaned_data/liquids_cleaned.rds")

# Count the number of rows for each dataset
liquids_num <- nrow(liquids)
coda_s_num <- nrow(coda_s)
pronouns_num <- nrow(pronouns)
fp_num <- nrow(fps)
general_subject_position_num <- nrow(general_subject_position)
subject_position_pronouns_num <- nrow(subject_position_pronouns)
all_subject_position_num <- nrow(subject_position)

# Calculate total counts
SIB_variables_count <- coda_s_num + pronouns_num + fp_num + general_subject_position_num + subject_position_pronouns_num
ALL_variables_count <- SIB_variables_count + liquids_num

# Directory to save counts
output_dir <- "data/token_counts/"

# Save the total counts to LaTeX files with commas
write_lines(comma(SIB_variables_count), paste0(output_dir, "SIB_variables_count_dissertation.tex"), sep = "")
write_lines(comma(ALL_variables_count), paste0(output_dir, "ALL_variables_count_dissertation.tex"), sep = "")
write_lines(comma(coda_s_num), paste0(output_dir, "coda_s_count_dissertation.tex"), sep = "")
write_lines(comma(pronouns_num), paste0(output_dir, "pronouns_count_dissertation.tex"), sep = "")
write_lines(comma(fp_num), paste0(output_dir, "filled_pauses_count_dissertation.tex"), sep = "")
write_lines(comma(all_subject_position_num), paste0(output_dir, "all_subject_position_count_dissertation.tex"), sep = "")
write_lines(comma(subject_position_pronouns_num), paste0(output_dir, "subject_position_pronouns_count_dissertation.tex"), sep = "")
write_lines(comma(general_subject_position_num), paste0(output_dir, "general_subject_position_count_dissertation.tex"), sep = "")
write_lines(comma(liquids_num), paste0(output_dir, "liquids_count_dissertation.tex"), sep = "")

# Specific counts for subsets of 's'
coda_s_deleted <- coda_s %>%
  filter(DELETION %in% c("deleted")) %>%
  droplevels()

coda_s_notdeleted <- coda_s %>%
  filter(DELETION %in% c("notdeleted")) %>%
  droplevels()

coda_s_mismatch <- coda_s %>%
  filter(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch") %>%
  droplevels()

coda_s_match <- coda_s %>%
  filter(PHONETIC_PHONOLOGICAL_AGREEMENT == "match") %>%
  droplevels()

coda_s_match_num <- nrow(coda_s_match)
coda_s_mismatch_num <- nrow(coda_s_mismatch)
# coda_s_num
# coda_s_match_num 
# coda_s_mismatch_num

# Save subset counts to LaTeX files with commas
write_lines(comma(nrow(coda_s_deleted)), paste0(output_dir, "coda_s_deleted_count_dissertation.tex"), sep = "")
write_lines(comma(nrow(coda_s_notdeleted)), paste0(output_dir, "coda_s_notdeleted_count_dissertation.tex"), sep = "")
write_lines(comma(nrow(coda_s_mismatch)), paste0(output_dir, "coda_s_mismatch_count_dissertation.tex"), sep = "")
write_lines(comma(nrow(coda_s_match)), paste0(output_dir, "coda_s_match_count_dissertation.tex"), sep = "")

#Compute and save proportions/percentages
writeLines(sprintf("%.2f", (coda_s_mismatch_num / coda_s_num) * 100), "data/token_counts/coda_s_mismatch_percentage.tex")
writeLines(sprintf("%.2f", (coda_s_match_num / coda_s_num) * 100), "data/token_counts/coda_s_match_percentage.tex")

# Specific counts for subsets of 'fps'
fps_a <- fps %>%
  filter(FP_VOWEL %in% c("a")) %>%
  droplevels()

fps_e <- fps %>%
  filter(FP_VOWEL %in% c("e")) %>%
  droplevels()

fps_schwa <- fps %>%
  filter(FP_VOWEL %in% c("schwa")) %>%
  droplevels()

fps_centralized <- fps %>%
  filter(FP_VOWEL %in% c("schwa", "a")) %>%
  droplevels()

fps_e_num <- nrow(fps_e)
fps_centralized_num <- nrow(fps_centralized)
fp_num

# Save subset counts to LaTeX files with commas
write_lines(comma(nrow(fps_a)), paste0(output_dir, "fps_count_a_dissertation.tex"), sep = "")
write_lines(comma(nrow(fps_e)), paste0(output_dir, "fps_count_e_dissertation.tex"), sep = "")
write_lines(comma(nrow(fps_schwa)), paste0(output_dir, "fps_count_schwa_dissertation.tex"), sep = "")
write_lines(comma(nrow(fps_centralized)), paste0(output_dir, "fps_count_centralized_dissertation.tex"), sep = "")

#Compute and save proportions/percentages
writeLines(sprintf("%.2f", (fps_centralized_num / fp_num) * 100), "data/token_counts/fps_centralized_percentage.tex")
writeLines(sprintf("%.2f", (fps_e_num / fp_num) * 100), "data/token_counts/fps_e_percentage.tex")

# Specific counts for subsets of 'all_subject_position'
all_subject_position_pre <- subject_position %>%
  filter(SUB_POSITION %in% c("preverbal")) %>%
  droplevels()

all_subject_position_post <- subject_position %>%
  filter(SUB_POSITION %in% c("postverbal")) %>%
  droplevels()

# Count the rows and save to LaTeX files with commas
all_subject_position_num_pre <- nrow(all_subject_position_pre)
all_subject_position_num_post <- nrow(all_subject_position_post)
all_subject_position_num

write_lines(comma(all_subject_position_num_pre), paste0(output_dir, "all_subject_position_count_preverbal_dissertation.tex"), sep = "")
write_lines(comma(all_subject_position_num_post), paste0(output_dir, "all_subject_position_count_postverbal_dissertation.tex"), sep = "")

#Compute and save proportions/percentages
writeLines(sprintf("%.2f", (all_subject_position_num_pre / all_subject_position_num) * 100), "data/token_counts/all_subject_position_pre_percentage.tex")
writeLines(sprintf("%.2f", (all_subject_position_num_post / all_subject_position_num) * 100), "data/token_counts/all_subject_position_post_percentage.tex")

# Specific counts for subsets of 'general_subject_position'
general_subject_position_pre <- general_subject_position %>%
  filter(SUB_POSITION %in% c("preverbal")) %>%
  droplevels()

general_subject_position_post <- general_subject_position %>%
  filter(SUB_POSITION %in% c("postverbal")) %>%
  droplevels()

# Count the rows and save to LaTeX files with commas
general_subject_position_num_pre <- nrow(general_subject_position_pre)
general_subject_position_num_post <- nrow(general_subject_position_post)

write_lines(comma(general_subject_position_num_pre), paste0(output_dir, "general_subject_position_count_preverbal_dissertation.tex"), sep = "")
write_lines(comma(general_subject_position_num_post), paste0(output_dir, "general_subject_position_count_postverbal_dissertation.tex"), sep = "")

# Specific counts for subsets of 'subject_position_pronouns'
subject_position_pronouns_pre <- subject_position_pronouns %>%
  filter(SUB_POSITION %in% c("preverbal")) %>%
  droplevels()

subject_position_pronouns_post <- subject_position_pronouns %>%
  filter(SUB_POSITION %in% c("postverbal")) %>%
  droplevels()

# subject_position_pronouns_pre_num <- nrow(subject_position_pronouns_pre)
# subject_position_pronouns_post_num <- nrow(subject_position_pronouns_post)


# Save subset counts to LaTeX files with commas
write_lines(comma(nrow(subject_position_pronouns_pre)), paste0(output_dir, "subject_position_pronouns_count_preverbal_dissertation.tex"), sep = "")
write_lines(comma(nrow(subject_position_pronouns_post)), paste0(output_dir, "subject_position_pronouns_count_postverbal_dissertation.tex"), sep = "")

# Specific counts for subsets of 'pronouns'
pronouns_present <- pronouns %>%
  filter(PRONOUN %in% c("present")) %>%
  droplevels()

pronouns_absent <- pronouns %>%
  filter(PRONOUN %in% c("absent")) %>%
  droplevels()

pronouns_present_num <- nrow(pronouns_present)
pronouns_absent_num <- nrow(pronouns_absent)
pronouns_num

# Save subset counts to LaTeX files with commas
write_lines(comma(nrow(pronouns_present)), paste0(output_dir, "pronouns_present_count_dissertation.tex"), sep = "")
write_lines(comma(nrow(pronouns_absent)), paste0(output_dir, "pronouns_absent_count_dissertation.tex"), sep = "")

#Compute and save proportions/percentages
writeLines(sprintf("%.2f", (pronouns_present_num / pronouns_num) * 100), "data/token_counts/pronouns_present_percentage.tex")
writeLines(sprintf("%.2f", (pronouns_absent_num / pronouns_num) * 100), "data/token_counts/pronouns_absent_percentage.tex")

# Specific counts for the main three 'liquids'
trill_num <- nrow(readRDS("data/cleaned_data/trill_cleaned.rds"))
tap_num <- nrow(readRDS("data/cleaned_data/tap_cleaned.rds"))
lateral_num <- nrow(readRDS("data/cleaned_data/lateral_cleaned.rds"))
# cat(trill_num)
# str(trill_num)
tap_num

# Save main liquids counts to LaTeX files with commas
write_lines(comma(trill_num), paste0(output_dir, "trill_count_dissertation.tex"), sep = "")
write_lines(comma(tap_num), paste0(output_dir, "tap_count_dissertation.tex"), sep = "")
write_lines(comma(lateral_num), paste0(output_dir, "lateral_count_dissertation.tex"), sep = "")

# Load the liquids subsets
tap_subset_lateral <- readRDS("data/cleaned_data/tap_subset_lateral.rds")
trill_subset_alveolar_fricative <- readRDS("data/cleaned_data/trill_subset_alveolar_fricative.rds")
lateral_subset_darkl <- readRDS("data/cleaned_data/lateral_subset_darkl.rds")
# tap_subset_lateral_num <- nrow(readRDS("data/cleaned_data/tap_subset_lateral.rds"))
# trill_subset_alveolar_fricative_num <- nrow(readRDS("data/cleaned_data/trill_subset_alveolar_fricative.rds"))
# lateral_subset_darkl_num <- nrow(readRDS("data/cleaned_data/lateral_subset_darkl.rds"))

# Counts for the liquids subsets
tap_subset_lateral_num <- nrow(tap_subset_lateral)
trill_subset_alveolar_fricative_num <- nrow(trill_subset_alveolar_fricative)
lateral_subset_darkl_num <- nrow(lateral_subset_darkl)

# Save liquids subset counts to LaTeX files with commas
write_lines(comma(tap_subset_lateral_num), paste0(output_dir, "tap_subset_lateral_count_dissertation.tex"), sep = "")
write_lines(comma(trill_subset_alveolar_fricative_num), paste0(output_dir, "trill_subset_alveolar_fricative_count_dissertation.tex"), sep = "")
write_lines(comma(lateral_subset_darkl_num), paste0(output_dir, "lateral_subset_darkl_count_dissertation.tex"), sep = "")

# Specific mis/match counts for liquids subsets

#Tap/Lateral Mismatch
tap_subset_lateral_mismatch <- tap_subset_lateral %>%
  filter(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch") %>%
  droplevels()

tap_subset_lateral_mismatch_num <- nrow(tap_subset_lateral_mismatch)

tap_subset_lateral_match <- tap_subset_lateral %>%
  filter(PHONETIC_PHONOLOGICAL_AGREEMENT == "match") %>%
  droplevels()

tap_subset_lateral_match_num <- nrow(tap_subset_lateral_match)

# writeLines(sprintf("%.2f", (tap_subset_lateral_mismatch_num / tap_subset_lateral_num) * 100), "data/token_counts/tap_subset_lateral_mismatch_percentage.tex")
# writeLines(sprintf("%.2f", (tap_subset_lateral_match_num / tap_subset_lateral_num) * 100), "data/token_counts/tap_subset_lateral_match_percentage.tex")


# tap_subset_lateral_mismatch_percentage <- (tap_subset_lateral_mismatch_num / tap_subset_lateral_num) * 100
# tap_subset_lateral_match_percentage <- (tap_subset_lateral_match_num / tap_subset_lateral_num) * 100

#Trill/Fricative Mismatch trill_subset_alveolar_fricative_num

trill_subset_alveolar_fricative_mismatch <- trill_subset_alveolar_fricative %>%
  filter(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch") %>%
  droplevels()

trill_subset_alveolar_fricative_mismatch_num <- nrow(trill_subset_alveolar_fricative_mismatch)


trill_subset_alveolar_fricative_match <- trill_subset_alveolar_fricative %>%
  filter(PHONETIC_PHONOLOGICAL_AGREEMENT == "match") %>%
  droplevels()

trill_subset_alveolar_fricative_match_num <- nrow(trill_subset_alveolar_fricative_match)

#Lateral/Velar [l] Mismatch

lateral_subset_darkl_mismatch <- lateral_subset_darkl %>%
  filter(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch") %>%
  droplevels()

lateral_subset_darkl_mismatch_num <- nrow(lateral_subset_darkl_mismatch)


lateral_subset_darkl_match <- lateral_subset_darkl %>%
  filter(PHONETIC_PHONOLOGICAL_AGREEMENT == "match") %>%
  droplevels()

lateral_subset_darkl_match_num <- nrow(lateral_subset_darkl_match)


# Save subset counts to LaTeX files with commas
write_lines(comma(nrow(tap_subset_lateral_mismatch)), paste0(output_dir, "tap_subset_lateral_mismatch_count_dissertation.tex"), sep = "")
write_lines(comma(nrow(tap_subset_lateral_match)), paste0(output_dir, "tap_subset_lateral_match_count_dissertation.tex"), sep = "")
write_lines(comma(nrow(trill_subset_alveolar_fricative_mismatch)), paste0(output_dir, "trill_subset_alveolar_fricative_mismatch_count_dissertation.tex"), sep = "")
write_lines(comma(nrow(trill_subset_alveolar_fricative_match)), paste0(output_dir, "trill_subset_alveolar_fricative_match_count_dissertation.tex"), sep = "")
write_lines(comma(nrow(lateral_subset_darkl_mismatch)), paste0(output_dir, "lateral_subset_darkl_mismatch_count_dissertation.tex"), sep = "")
write_lines(comma(nrow(lateral_subset_darkl_match)), paste0(output_dir, "lateral_subset_darkl_match_count_dissertation.tex"), sep = "")

#Compute and save proportions/percentages

writeLines(sprintf("%.2f", (tap_subset_lateral_mismatch_num / tap_subset_lateral_num) * 100), "data/token_counts/tap_subset_lateral_mismatch_percentage.tex")
writeLines(sprintf("%.2f", (tap_subset_lateral_match_num / tap_subset_lateral_num) * 100), "data/token_counts/tap_subset_lateral_match_percentage.tex")
# readLines("data/token_counts/tap_subset_lateral_mismatch_percentage.tex")
# readLines("data/token_counts/tap_subset_lateral_match_percentage.tex")


writeLines(sprintf("%.2f", (trill_subset_alveolar_fricative_mismatch_num / trill_subset_alveolar_fricative_num) * 100), "data/token_counts/trill_subset_alveolar_fricative_mismatch_percentage.tex")
writeLines(sprintf("%.2f", (trill_subset_alveolar_fricative_match_num / trill_subset_alveolar_fricative_num) * 100), "data/token_counts/trill_subset_alveolar_fricative_match_percentage.tex")
# readLines("data/token_counts/trill_subset_alveolar_fricative_mismatch_percentage.tex")
# readLines("data/token_counts/trill_subset_alveolar_fricative_match_percentage.tex")

writeLines(sprintf("%.2f", (lateral_subset_darkl_mismatch_num / lateral_subset_darkl_num) * 100), "data/token_counts/lateral_subset_darkl_mismatch_percentage.tex")
writeLines(sprintf("%.2f", (lateral_subset_darkl_match_num / lateral_subset_darkl_num) * 100), "data/token_counts/lateral_subset_darkl_match_percentage.tex")
# readLines("data/token_counts/lateral_subset_darkl_mismatch_percentage.tex")
# readLines("data/token_counts/lateral_subset_darkl_match_percentage.tex")

# 
# # Compute proportions
# tap_percentage <- (tap_count / total_liquids) * 100
# lateral_percentage <- (lateral_count / total_liquids) * 100
# trill_percentage <- (trill_count / total_liquids) * 100
# 
# # Print results
# sprintf("Tap: %.2f%%, Lateral: %.2f%%, Trill: %.2f%%", tap_percentage, lateral_percentage, trill_percentage)
