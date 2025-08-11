# scripts/visuals/liquids/lateral/preprocess_laterals.R

# Preprocess lateral df by adding column with total count for each SURF FORM and reordering factor levels

## Assuming 'lateral', the subset dataframe, with the only value in PHONO_FORM being '/r/'.  (May decide to not do this)
# lateral$SURF_FORM_COUNT <- AddNameStat(lateral, "SURF_FORM", "PHONO_FORM", stat = "count")
# 
# ## Relocate the new column
# lateral <- lateral %>% 
#   relocate(SURF_FORM_COUNT, .after = SURF_FORM)

#Order levels
# unique(lateral$SURF_FORM_COUNT)
# lateral$SURF_FORM_COUNT <- factor(lateral$SURF_FORM_COUNT, levels = c("[r]: n = 331", "[r̝]: n = 404", "[ɾ]: n = 24", "[ɹ]: n = 16", "[ɽ]: n = 16", "[x]: n = 51", "[h]: n = 8", "[∅]: n = 7" ))

lateral$POS_SYL<- factor(lateral$POS_SYL, levels = c("onset", "coda"))
lateral$POS_WORD <- factor(lateral$POS_WORD, levels = c("initial", "internal", "final"))
lateral$SYL_TYPE <- factor(lateral$SYL_TYPE, levels = c("open", "closed"))
lateral$STRESS<- factor(lateral$STRESS, levels = c("stressed", "unstressed"))
lateral$WORD_CLASS <-  factor(lateral$WORD_CLASS, levels = c("noun", "verb", "determiner", "adjective", "conjunction", "adverb", "preposition", "pronoun"))

lateral$IMMIGRATION_CATEGORY <-  factor(lateral$IMMIGRATION_CATEGORY, levels = c("recent_arrival", "est_immigrant", "us_born"))


# lateral_mismatch <- lateral %>%
#   filter(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch") %>%
#   droplevels()

# Calculate the overall proportion of PHONETIC_PHONOLOGICAL_AGREEMENT
overall_proportion <- prop.table(table(lateral$PHONETIC_PHONOLOGICAL_AGREEMENT))["mismatch"]

overall_proportion

prop.table(table(lateral$PHONETIC_PHONOLOGICAL_AGREEMENT,lateral$COUNTRY_OF_ORIGIN),margin=2)

# Create subset with velar l (dark-l) only to run regressions on

lateral_subset_darkl <- lateral %>%
  filter(SURF_FORM %in% c("[l]", "[ɫ]")) %>%
  droplevels()


# lateral_subset_deletion <- lateral %>%
#   filter(SURF_FORM %in% c("[l]", "[∅]")) %>%
#   # filter(!SURF_FORM %in% c("[ɫ]", "[ɾ]")) %>%
#   droplevels()
# 
lateral_subset_all_but_darkl <- lateral %>%
  # filter(SURF_FORM %in% c("[l]")) %>%
  filter(!SURF_FORM %in% c("[ɫ]")) %>%
  droplevels()


levels(lateral_subset_all_but_darkl$SURF_FORM)

lateral_subset_all_but_darkl$COUNTRY_OF_ORIGIN <-  factor(lateral_subset_all_but_darkl$COUNTRY_OF_ORIGIN, levels = c("pr", "dr"))
levels(lateral_subset_all_but_darkl$COUNTRY_OF_ORIGIN)

# Save the subset df
saveRDS(lateral_subset_darkl, "data/cleaned_data/lateral_subset_darkl.rds")


levels(lateral$SURF_FORM)

levels(lateral$SURF_FORM_TYPE)