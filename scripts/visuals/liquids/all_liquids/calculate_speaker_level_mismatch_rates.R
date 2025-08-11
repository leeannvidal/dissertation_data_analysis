# scripts/visuals/liquids/all_liquids/calculate_speaker_level_mismatch_rates.R
#
# Script: calculate_mismatch_rates
# Description: This script calculates the mismatch rates for all tokens, as well as for each individual phonological form (/ɾ/, /r/, /l/). 
#              It then combines these rates into a single data frame and creates separate data frames for each country of origin.
#
# Steps:
#       Step 1 - Calculate mismatch rates for all tokens and individual phonological forms
#       Step 2 - Combine the mismatch rates into one data frame
#       Step 3 - Create separate data frames for Puerto Rico and the Dominican Republic

# STEP 1 - Calculate MISMATCH_RATE for all tokens as well as each individual phonological form

# Calculate mismatch rate for all phonological forms combined
rates_mismatch_all <- liquids %>%
  # group_by(SPEAKER, PLUS, COUNTRY_OF_ORIGIN) %>%
  group_by(SPEAKER, PLUS, COUNTRY_OF_ORIGIN, PERCENT_INTL_ENG_ONLY, PERCENT_INTL_SPAN_ONLY, AGE, AOA) %>%
  summarise(COUNT_ALL = n(), RATE_MISMATCH_ALL = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

# Calculate mismatch rate specifically for the TAP (/ɾ/) phonological form
TAP_mismatch <- liquids %>%
  filter(PHONO_FORM == "/ɾ/") %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_TAP = n(), RATE_MISMATCH_TAP = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

# Calculate mismatch rate specifically for the trill (/r/) phonological form
trill_mismatch <- liquids %>%
  filter(PHONO_FORM == "/r/") %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_TRILL = n(), RATE_MISMATCH_TRILL = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

# Calculate mismatch rate specifically for the lateral (/l/) phonological form
lateral_mismatch <- liquids %>%
  filter(PHONO_FORM == "/l/") %>%
  group_by(SPEAKER) %>%
  summarise(COUNT_LATERAL = n(), RATE_MISMATCH_LATERAL = 100 * mean(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", na.rm = TRUE))

# STEP 2 - COMBINE ALL FOUR INTO ONE DF

# Combine mismatch rates for all forms, TAP, trill, and lateral into a single data frame
rates_mismatch_all <- rates_mismatch_all %>% 
  left_join(TAP_mismatch, by = "SPEAKER") %>% 
  left_join(trill_mismatch, by = "SPEAKER") %>% 
  left_join(lateral_mismatch, by = "SPEAKER") %>% 
  mutate(COUNTRY_OF_ORIGIN = case_when(
    COUNTRY_OF_ORIGIN %in% c("dr", "el_dr") ~ "dr", 
    TRUE ~ COUNTRY_OF_ORIGIN
  ))

# Create separate data frames for each country of origin

# Filter and create a data frame for speakers from Puerto Rico
pr_rates_mismatch_all <- rates_mismatch_all %>%
  filter(COUNTRY_OF_ORIGIN == "pr") %>%
  droplevels()

# Filter and create a data frame for speakers from the Dominican Republic
dr_rates_mismatch_all <- rates_mismatch_all %>%
  filter(COUNTRY_OF_ORIGIN == "dr") %>%
  droplevels()
