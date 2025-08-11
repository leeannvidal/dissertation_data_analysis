# scripts/clean_liquids.R

# Apply the COUNTRY_OF_ORIGIN mutation
liquids <- mutate_country_of_origin(liquids)  # Assuming it might need it, but likely already has it

# Convert raw lexical frequency to create log frequency

liquids <- liquids %>%
  mutate(LOG_LEX_FREQ_DF_N = log(LEX_FREQ_DF_N)) %>%
  relocate(LOG_LEX_FREQ_DF_N, .after = LEX_FREQ_DF_N)


# Separate the data by phonological form
trill <- liquids %>%
  filter(PHONO_FORM %in% c("/r/")) %>%
  droplevels()

trill$SURF_FORM <- factor(trill$SURF_FORM, levels = c("[r]", "[r̝]", "[ɾ]", "[ɹ]", "[ɽ]", "[x]", "[h]", "[∅]"))

tap <- liquids %>%
  filter(PHONO_FORM %in% c("/ɾ/")) %>%
  filter(!SURF_FORM %in% c("[v]", "[ð]", "[i]", "[ɽ]")) %>%
  droplevels()

tap$SURF_FORM <- factor(tap$SURF_FORM, levels = c("[ɾ]", "[r]", "[r̝]", "[ɹ]", "[l]", "[ɫ]", "[h]", "[ʔ]", "[∅]"))

lateral <- liquids %>%
  filter(PHONO_FORM %in% c("/l/")) %>%
  filter(!SURF_FORM %in% c("[r]", "[i]")) %>%
  droplevels()

lateral$SURF_FORM <- factor(lateral$SURF_FORM, levels = c("[l]", "[ɫ]", "[ɾ]", "[h]", "[ʔ]", "[∅]"))

liquids <- liquids %>%
  mutate(
    SURF_FORM = if_else(
      PHONO_FORM == "/ɾ/" & SURF_FORM %in% c("[v]", "[ð]", "[i]", "[ɽ]"), 
      NA_character_, 
      as.character(SURF_FORM)
    ),
    SURF_FORM = if_else(
      PHONO_FORM == "/l/" & SURF_FORM %in% c("[r]", "[i]"), 
      NA_character_, 
      as.character(SURF_FORM)
    )
  ) %>%
  filter(!is.na(SURF_FORM)) %>%
  droplevels()


# Save the cleaned dataframes
saveRDS(liquids, "data/cleaned_data/liquids_cleaned.rds")
saveRDS(trill, "data/cleaned_data/trill_cleaned.rds")
saveRDS(tap, "data/cleaned_data/tap_cleaned.rds")
saveRDS(lateral, "data/cleaned_data/lateral_cleaned.rds")
