
  
  covariation_SIB_speakers_PLUS <-  lm(PLUS ~  
                             RATE_MISMATCH_CODA_S + 
                             RATE_CENTRALIZED_FPS + 
                              RATE_PREVERBAL_SUBJECTS + 
                             RATE_PRONOUNS_PRESENT,
                           data = rates_all_SIB)
  summary(covariation_SIB_speakers_PLUS)
  
  covariation_SIB_speakers_SPAN <-  lm(PERCENT_INTL_SPAN_ONLY ~  
                                     RATE_MISMATCH_CODA_S + 
                                     RATE_CENTRALIZED_FPS + 
                                     RATE_PREVERBAL_SUBJECTS + 
                                     RATE_PRONOUNS_PRESENT,
                                   data = rates_all_SIB)
  summary(covariation_SIB_speakers_SPAN)
  
  covariation_SIB_speakers_ENGL <-  lm(PERCENT_INTL_ENG_ONLY ~  
                                         RATE_MISMATCH_CODA_S + 
                                         RATE_CENTRALIZED_FPS + 
                                         RATE_PREVERBAL_SUBJECTS + 
                                         RATE_PRONOUNS_PRESENT,
                                       data = rates_all_SIB)
  summary(covariation_SIB_speakers_ENGL)
  
  # Separate the data by Caribbean and non-Caribbean and use PLUS as dependent variables
  
  caribbean <- c("caribbean", "pr", "dr", "el_dr", "mixed") 
  
  rates_all_SIB_caribbean <- rates_all_SIB %>%
    filter(REGIONAL_ORIGIN %in% caribbean) %>%
    droplevels()
  
  rates_all_SIB_not_caribbean <- rates_all_SIB %>%
    filter(!REGIONAL_ORIGIN %in% caribbean) %>%
    droplevels()
  
  
  covariation_SIB_Caribbean <-  lm(PLUS ~  
                                     RATE_MISMATCH_CODA_S + 
                                     RATE_CENTRALIZED_FPS + 
                                     RATE_PREVERBAL_SUBJECTS + 
                                     RATE_PRONOUNS_PRESENT,
                                   data = rates_all_SIB_caribbean)
  
  summary(covariation_SIB_Caribbean)
  
  covariation_SIB_NOT_Caribbean <-  lm(PLUS ~  
                                     RATE_MISMATCH_CODA_S + 
                                     RATE_CENTRALIZED_FPS + 
                                     RATE_PREVERBAL_SUBJECTS + 
                                     RATE_PRONOUNS_PRESENT,
                                   data = rates_all_SIB_not_caribbean)
  
  summary(covariation_SIB_NOT_Caribbean)
  summary(covariation_SIB_Caribbean)
  
  ### CHECK PERCENT_INTL_SPAN_ONLY BY REGION
  # covariation_SIB_Caribbean_speakers_SPAN <-  lm(PERCENT_INTL_SPAN_ONLY ~  
  #                                    RATE_MISMATCH_CODA_S + 
  #                                    RATE_CENTRALIZED_FPS + 
  #                                    RATE_PREVERBAL_SUBJECTS + 
  #                                    RATE_PRONOUNS_PRESENT,
  #                                  data = rates_all_SIB_caribbean)
  # 
  summary(covariation_SIB_Caribbean_speakers_SPAN)
  # 
  # covariation_SIB_NOT_Caribbean_speakers_SPAN <-  lm(PERCENT_INTL_SPAN_ONLY ~  
  #                                        RATE_MISMATCH_CODA_S + 
  #                                        RATE_CENTRALIZED_FPS + 
  #                                        RATE_PREVERBAL_SUBJECTS + 
  #                                        RATE_PRONOUNS_PRESENT,
  #                                      data = rates_all_SIB_not_caribbean)
  # 
  summary(covariation_SIB_NOT_Caribbean_speakers_SPAN)

  ## Mutate IMMIGRATION_CATEGORY into a binary with US BORN and not US Born and use as dependent variable
  rates_all_SIB_IMMIGRATION_CAT <- rates_all_SIB %>%
    mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
    relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY)
  
  rates_all_SIB_IMMIGRATION_CAT <- rates_all_SIB_IMMIGRATION_CAT %>%
    mutate(
      IMMIGRATION_CATEGORY_binary_numeric = case_when(
        IMMIGRATION_CATEGORY_binary == "NOT_US_Born" ~ 0,
        IMMIGRATION_CATEGORY_binary == "US_Born" ~ 1,
        TRUE ~ NA_real_
      )
    ) %>%
    relocate(IMMIGRATION_CATEGORY_binary_numeric, .after = IMMIGRATION_CATEGORY_binary)
  
  
  unique(rates_all_SIB_IMMIGRATION_CAT$IMMIGRATION_CATEGORY_binary)

  
  
  covariation_SIB_IMMIGRATION_BINARY <-  glm(IMMIGRATION_CATEGORY_binary_numeric ~  
                                     RATE_MISMATCH_CODA_S + 
                                     RATE_CENTRALIZED_FPS + 
                                     RATE_PREVERBAL_SUBJECTS + 
                                     RATE_PRONOUNS_PRESENT,
                                   data = rates_all_SIB_IMMIGRATION_CAT,
                                   family = binomial)
  
  summary(covariation_SIB_IMMIGRATION_BINARY)
