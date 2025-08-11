# scripts/visuals/liquids/tap/preprocess_taps.R

# Preprocess tap df by adding column with total count for each SURF FORM and reordering factor levels

## Assuming 'tap', the subset dataframe, with the only value in PHONO_FORM being '/r/'.  (May decide to not do this)
# tap$SURF_FORM_COUNT <- AddNameStat(tap, "SURF_FORM", "PHONO_FORM", stat = "count")
# 
# ## Relocate the new column
# tap <- tap %>% 
#   relocate(SURF_FORM_COUNT, .after = SURF_FORM)

#Order levels
# unique(tap$SURF_FORM_COUNT)
# tap$SURF_FORM_COUNT <- factor(tap$SURF_FORM_COUNT, levels = c("[r]: n = 331", "[r̝]: n = 404", "[ɾ]: n = 24", "[ɹ]: n = 16", "[ɽ]: n = 16", "[x]: n = 51", "[h]: n = 8", "[∅]: n = 7" ))

tap$POS_SYL<- factor(tap$POS_SYL, levels = c("onset", "coda"))
tap$POS_WORD <- factor(tap$POS_WORD, levels = c("initial", "internal", "final"))
tap$SYL_TYPE <- factor(tap$SYL_TYPE, levels = c("open", "closed"))
tap$STRESS<- factor(tap$STRESS, levels = c("stressed", "unstressed"))
tap$WORD_CLASS <-  factor(tap$WORD_CLASS, levels = c("noun", "verb", "determiner", "adjective", "conjunction", "adverb", "preposition", "pronoun"))

tap$IMMIGRATION_CATEGORY <-  factor(tap$IMMIGRATION_CATEGORY, levels = c("recent_arrival", "est_immigrant", "us_born"))


# tap_mismatch <- tap %>%
#   filter(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch") %>%
#   droplevels()

# Calculate the overall proportion of PHONETIC_PHONOLOGICAL_AGREEMENT
overall_proportion <- prop.table(table(tap$PHONETIC_PHONOLOGICAL_AGREEMENT))["mismatch"]

overall_proportion

prop.table(table(tap$PHONETIC_PHONOLOGICAL_AGREEMENT,tap$COUNTRY_OF_ORIGIN),margin=2)

# Create subset with laterals only to run regressions on

tap_subset_lateral <- tap %>%
  filter(SURF_FORM %in% c("[l]", "[ɾ]")) %>%
  droplevels()

# Save the subset df
saveRDS(tap_subset_lateral, "data/cleaned_data/tap_subset_lateral.rds")


levels(tap$SURF_FORM)

levels(tap$SURF_FORM_TYPE)
