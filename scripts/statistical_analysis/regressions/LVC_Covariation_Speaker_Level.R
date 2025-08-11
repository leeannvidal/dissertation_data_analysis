


covariation_LVC_speakers <-  lm(PLUS ~ RATE_MISMATCH_TAP + 
                          # RATE_MISMATCH_TAP_SUBSET +
                           RATE_MISMATCH_TRILL + 
                           RATE_MISMATCH_LATERAL + 
                           RATE_MISMATCH_CODA_S + 
                           RATE_CENTRALIZED_FPS + 
                           RATE_ALL_PREVERBAL_SUBJECTS + 
                           RATE_PRONOUNS_PRESENT,
                         data = rates_all_variables)

summary(covariation_LVC_speakers)

covariation_LVC_speakers_SPAN <-  lm(PERCENT_INTL_SPAN_ONLY ~ RATE_MISMATCH_TAP + 
                                  RATE_MISMATCH_TRILL + 
                                  RATE_MISMATCH_LATERAL + 
                                  RATE_MISMATCH_CODA_S + 
                                  RATE_CENTRALIZED_FPS + 
                                  RATE_ALL_PREVERBAL_SUBJECTS + 
                                  RATE_PRONOUNS_PRESENT,
                                data = rates_all_variables)

summary(covariation_LVC_speakers_SPAN)

covariation_LVC_speakers_ENGL <-  lm(PERCENT_INTL_ENG_ONLY ~ RATE_MISMATCH_TAP + 
                                       RATE_MISMATCH_TRILL + 
                                       RATE_MISMATCH_LATERAL + 
                                       RATE_MISMATCH_CODA_S + 
                                       RATE_CENTRALIZED_FPS + 
                                       RATE_ALL_PREVERBAL_SUBJECTS + 
                                       RATE_PRONOUNS_PRESENT,
                                     data = rates_all_variables)

summary(covariation_LVC_speakers_ENGL)

## Mutate IMMIGRATION_CATEGORY into a binary with US BORN and not US Born and use as dependent variable
rates_LVC_IMMIGRATION_CAT <- rates_all_variables %>%
  mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
  relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY)

rates_LVC_IMMIGRATION_CAT <- rates_LVC_IMMIGRATION_CAT %>%
  mutate(
    IMMIGRATION_CATEGORY_binary_numeric = case_when(
      IMMIGRATION_CATEGORY_binary == "NOT_US_Born" ~ 0,
      IMMIGRATION_CATEGORY_binary == "US_Born" ~ 1,
      TRUE ~ NA
    )
  ) %>%
  relocate(IMMIGRATION_CATEGORY_binary_numeric, .after = IMMIGRATION_CATEGORY_binary)


unique(rates_LVC_IMMIGRATION_CAT$IMMIGRATION_CATEGORY_binary)

## ADD TRILL AND LATERAL SUBSETS

covariation_LVC_IMMIGRATION_BINARY <-  glm(IMMIGRATION_CATEGORY_binary_numeric ~  
                                             RATE_MISMATCH_TAP + 
                                             RATE_MISMATCH_TAP_SUBSET +
                                             RATE_MISMATCH_TRILL + 
                                             RATE_MISMATCH_LATERAL +
                                             RATE_MISMATCH_CODA_S + 
                                             RATE_CENTRALIZED_FPS + 
                                             RATE_ALL_PREVERBAL_SUBJECTS + 
                                             RATE_PRONOUNS_PRESENT,
                                           data = rates_LVC_IMMIGRATION_CAT,
                                           family = binomial)


summary(covariation_LVC_IMMIGRATION_BINARY)
