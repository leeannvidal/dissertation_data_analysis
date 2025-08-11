# scripts/visuals/liquids/trill/preprocess_trills.R

# Preprocess trill df by adding column with total count for each SURF FORM and reordering factor levels

# ## Assuming 'trill', the subset dataframe, with the only value in PHONO_FORM being '/r/'.  (May decide to not do this)
# trill$SURF_FORM_COUNT <- AddNameStat(trill, "SURF_FORM", "PHONO_FORM", stat = "count")
# 
# ## Relocate the new column
# trill <- trill %>% 
#   relocate(SURF_FORM_COUNT, .after = SURF_FORM)

#Order levels
# unique(trill$SURF_FORM_COUNT)
# trill$SURF_FORM_COUNT <- factor(trill$SURF_FORM_COUNT, levels = c("[r]: n = 331", "[r̝]: n = 404", "[ɾ]: n = 24", "[ɹ]: n = 16", "[ɽ]: n = 16", "[x]: n = 51", "[h]: n = 8", "[∅]: n = 7" ))

trill$POS_SYL<- factor(trill$POS_SYL, levels = c("onset", "coda"))
trill$POS_WORD <- factor(trill$POS_WORD, levels = c("initial", "internal", "final"))
trill$SYL_TYPE <- factor(trill$SYL_TYPE, levels = c("open", "closed"))
trill$STRESS<- factor(trill$STRESS, levels = c("stressed", "unstressed"))
trill$WORD_CLASS <-  factor(trill$WORD_CLASS, levels = c("noun", "verb", "determiner", "adjective", "conjunction", "adverb", "preposition", "pronoun"))

trill$IMMIGRATION_CATEGORY <-  factor(trill$IMMIGRATION_CATEGORY, levels = c("recent_arrival", "est_immigrant", "us_born"))


# trill_mismatch <- trill %>%
#   filter(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch") %>%
#   droplevels()

# Calculate the overall proportion of PHONETIC_PHONOLOGICAL_AGREEMENT
overall_proportion_trill <- prop.table(table(trill$PHONETIC_PHONOLOGICAL_AGREEMENT))["mismatch"]

overall_proportion_trill

prop.table(table(trill$PHONETIC_PHONOLOGICAL_AGREEMENT,trill$COUNTRY_OF_ORIGIN),margin=2)


# Create subset with velar l (dark-l) only to run regressions on

trill_subset_alveolar_fricative <- trill %>%
  filter(SURF_FORM %in% c("[r]", "[r̝]")) %>%
  droplevels()

trill_subset_alveolar_fricative_pr <- trill %>%
  filter(SURF_FORM %in% c("[r]", "[r̝]")) %>%
  filter(COUNTRY_OF_ORIGIN %in% c("pr")) %>%
  droplevels()

trill_subset_alveolar_fricative_dr <- trill %>%
  filter(SURF_FORM %in% c("[r]", "[r̝]")) %>%
  filter(COUNTRY_OF_ORIGIN %in% c("dr")) %>%
  droplevels()
# 
trill_subset_velar_fricative <- trill %>%
  filter(SURF_FORM %in% c("[r]", "[x]")) %>%
  droplevels()

# Save the subset df
saveRDS(trill_subset_alveolar_fricative, "data/cleaned_data/trill_subset_alveolar_fricative.rds")


# trill_subset <- trill %>%
#   filter(SURF_FORM %in% c("[r]", "[r̝]", "[x]")) %>% 
#   droplevels()

# trill_subset_velar_fricative <- trill %>%
#   filter(SURF_FORM %in% c("[r]", "[x]")) %>%
#   droplevels()

# trill_subset_internal <- trill %>%
#   filter(POS_WORD == "internal") %>%
#   filter(SURF_FORM %in% c("[r]", "[r̝]")) %>%
#   droplevels()
# 
# levels(trill_subset_internal$SURF_FORM)
# 
# trill_subset_initial <- trill %>%
#   filter(POS_WORD == "initial") %>%
#   filter(SURF_FORM %in% c("[r]", "[r̝]")) %>%
#   droplevels()

levels(trill$SURF_FORM)

levels(trill$SURF_FORM_TYPE)