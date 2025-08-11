
mismatch <- c("mismatch") 
caribbean <- c("caribbean", "pr", "dr", "el_dr", "mixed") 

### CODA S

coda_s_SIB_MISMATCH <- coda_s_SIB %>%
  mutate(MISMATCH = case_when(
    PHONETIC_PHONOLOGICAL_AGREEMENT %in% mismatch ~ 1,
    TRUE  ~ 0
  ), .after = PHONETIC_PHONOLOGICAL_AGREEMENT) %>% 
  mutate(REGIONAL_ORIGIN_BINARY = case_when(
    REGIONAL_ORIGIN %in% caribbean ~ "caribbean",
    TRUE  ~ "not_caribbean"
  ), .after = REGIONAL_ORIGIN) %>% mutate(
    REGIONAL_ORIGIN_BINARY = factor(REGIONAL_ORIGIN_BINARY, levels = c("not_caribbean", "caribbean"))
  ) %>%
  mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
  relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY)


SIB_model_coda_s_token_level <- glmer(MISMATCH ~ 
                                  REGIONAL_ORIGIN_BINARY +
                                  # IMMIGRATION_CATEGORY_binary +
                                  # COUNTRY_OF_ORIGIN +
                                  PLUS +
                                  AGE +
                                  SEX +
                                  # PERCENT_INTL_ENG_ONLY +
                                  # PERCENT_INTL_SPAN_ONLY +
                                  (1 | SPEAKER),
                                data = coda_s_SIB_MISMATCH,
                                family = binomial,
                                na.action = "na.fail",
                                control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 70000)))

summary(SIB_model_coda_s_token_level, correlation=TRUE)

# saveRDS(SIB_model_coda_s_token_level, "data/regressions/SIB_model_coda_s_token_level.rds")


### Filled Pauses

fps_SIB_CENTRALIZED_FPS_1 <- fps_SIB %>%
  mutate(CENTRALIZED_FPS_1 = case_when(
    CENTRALIZED_FPS == "centralized" ~ 1,
    TRUE  ~ 0
  ), .after = CENTRALIZED_FPS) %>% 
  mutate(REGIONAL_ORIGIN_BINARY = case_when(
    REGIONAL_ORIGIN %in% caribbean ~ "caribbean",
    TRUE  ~ "not_caribbean"
  ), .after = REGIONAL_ORIGIN) %>% mutate(
    REGIONAL_ORIGIN_BINARY = factor(REGIONAL_ORIGIN_BINARY, levels = c("not_caribbean", "caribbean"))
  ) %>%
  mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
  relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY)


SIB_model_fps_token_level <- glmer(CENTRALIZED_FPS_1 ~ 
                                        REGIONAL_ORIGIN_BINARY +
                                        # IMMIGRATION_CATEGORY_binary +
                                        # COUNTRY_OF_ORIGIN +
                                        PLUS +
                                        AGE +
                                        SEX +
                                        # PERCENT_INTL_ENG_ONLY +
                                        # PERCENT_INTL_SPAN_ONLY +
                                        (1 | SPEAKER),
                                      data = fps_SIB_CENTRALIZED_FPS_1,
                                      family = binomial,
                                      na.action = "na.fail",
                                      control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 70000)))

summary(SIB_model_fps_token_level, correlation=TRUE)


### Pronouns

pronouns_SIB_present <- pronouns_SIB %>%
  mutate(PRONOUN_PRESENT = case_when(
    PRONOUN == "present" ~ 1,
    TRUE  ~ 0
  ), .after = PRONOUN) %>% 
  mutate(REGIONAL_ORIGIN_BINARY = case_when(
    REGIONAL_ORIGIN %in% caribbean ~ "caribbean",
    TRUE  ~ "not_caribbean"
  ), .after = REGIONAL_ORIGIN) %>% mutate(
    REGIONAL_ORIGIN_BINARY = factor(REGIONAL_ORIGIN_BINARY, levels = c("not_caribbean", "caribbean"))
  ) %>%
  mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
  relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY)


SIB_model_pronouns_present_token_level <- glmer(PRONOUN_PRESENT ~ 
                                     REGIONAL_ORIGIN_BINARY +
                                     # IMMIGRATION_CATEGORY_binary +
                                     # COUNTRY_OF_ORIGIN +
                                     PLUS +
                                     AGE +
                                     SEX +
                                     # PERCENT_INTL_ENG_ONLY +
                                     # PERCENT_INTL_SPAN_ONLY +
                                     (1 | SPEAKER),
                                   data = pronouns_SIB_present,
                                   family = binomial,
                                   na.action = "na.fail",
                                   control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 100000)))

summary(SIB_model_pronouns_present_token_level, correlation=TRUE)


### SUBJECT POSITION

subject_position_preverbal_SIB <- subject_position_SIB %>%
  filter(INFINITIVE != "gustar") %>% 
  mutate(PREVERBAL_SUBJECTS = case_when(
    SUB_POSITION == "preverbal" ~ 1,
    TRUE  ~ 0
  ), .after = SUB_POSITION) %>% 
  mutate(REGIONAL_ORIGIN_BINARY = case_when(
    REGIONAL_ORIGIN %in% caribbean ~ "caribbean",
    TRUE  ~ "not_caribbean"
  ), .after = REGIONAL_ORIGIN) %>% 
  mutate(
    REGIONAL_ORIGIN_BINARY = factor(REGIONAL_ORIGIN_BINARY, levels = c("not_caribbean", "caribbean"))
  ) %>%
  mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
  relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY)


SIB_model_subject_position_preverbal_token_level <- glmer(PREVERBAL_SUBJECTS ~ 
                                     REGIONAL_ORIGIN_BINARY +
                                     # IMMIGRATION_CATEGORY_binary +
                                     # COUNTRY_OF_ORIGIN +
                                     PLUS +
                                     AGE +
                                     SEX +
                                     # PERCENT_INTL_ENG_ONLY +
                                     # PERCENT_INTL_SPAN_ONLY +
                                     (1 | SPEAKER),
                                   data = subject_position_preverbal_SIB,
                                   family = binomial,
                                   na.action = "na.fail",
                                   control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))

summary(SIB_model_subject_position_preverbal_token_level, correlation=TRUE)
# 
# 
# ### SUBJECT POSITION PRONOUNS
# 
# subject_position_preverbal_pronouns_SIB <- subject_position_pronouns_SIB %>%
#   filter(INFINITIVE != "gustar") %>% 
#   mutate(PREVERBAL_SUBJECTS = case_when(
#     SUB_POSITION == "preverbal" ~ 1,
#     TRUE  ~ 0
#   ), .after = SUB_POSITION) %>% 
#   mutate(REGIONAL_ORIGIN_BINARY = case_when(
#     REGIONAL_ORIGIN %in% caribbean ~ "caribbean",
#     TRUE  ~ "not_caribbean"
#   ), .after = REGIONAL_ORIGIN) %>%
#   mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
#   relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY)
# 
# 
# SIB_model_subject_position_preverbal_pronouns_token_level <- glmer(PREVERBAL_SUBJECTS ~ 
#                                                             REGIONAL_ORIGIN_BINARY +
#                                                             # IMMIGRATION_CATEGORY_binary +
#                                                             # COUNTRY_OF_ORIGIN +
#                                                             PLUS +
#                                                             # AGE +
#                                                             # SEX +
#                                                             # PERCENT_INTL_ENG_ONLY +
#                                                             # PERCENT_INTL_SPAN_ONLY +
#                                                             (1 | SPEAKER),
#                                                           data = subject_position_preverbal_pronouns_SIB,
#                                                           family = binomial,
#                                                           na.action = "na.fail",
#                                                           control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))
# 
# summary(SIB_model_subject_position_preverbal_pronouns_token_level, correlation=TRUE)
# 
# 
# ### SUBJECT POSITION - GENERAL SUBJECTS
# 
# general_preverbal_subject_position_SIB <- general_subject_position_SIB %>%
#   filter(INFINITIVE != "gustar") %>% 
#   mutate(PREVERBAL_SUBJECTS = case_when(
#     SUB_POSITION == "preverbal" ~ 1,
#     TRUE  ~ 0
#   ), .after = SUB_POSITION) %>% 
#   mutate(REGIONAL_ORIGIN_BINARY = case_when(
#     REGIONAL_ORIGIN %in% caribbean ~ "caribbean",
#     TRUE  ~ "not_caribbean"
#   ), .after = REGIONAL_ORIGIN) %>%
#   mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
#   relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY)
# 
# 
# SIB_model_general_subject_position_preverbal_token_level <- glmer(PREVERBAL_SUBJECTS ~ 
#                                                             REGIONAL_ORIGIN_BINARY +
#                                                             IMMIGRATION_CATEGORY_binary +
#                                                             # COUNTRY_OF_ORIGIN +
#                                                             PLUS +
#                                                             # AGE +
#                                                             # SEX +
#                                                             PERCENT_INTL_ENG_ONLY +
#                                                             # PERCENT_INTL_SPAN_ONLY +
#                                                             (1 | SPEAKER),
#                                                           data = general_preverbal_subject_position_SIB,
#                                                           family = binomial,
#                                                           na.action = "na.fail",
#                                                           control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))
# 
# summary(SIB_model_general_subject_position_preverbal_token_level, correlation=TRUE)