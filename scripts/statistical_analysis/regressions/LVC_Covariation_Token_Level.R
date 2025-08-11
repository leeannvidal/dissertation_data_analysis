### SALIENT VARIABLES

### TAP

tap_subset_lateral_pr <- tap_subset_lateral %>%
  filter(COUNTRY_OF_ORIGIN %in% c("pr")) %>%
  droplevels()

tap_subset_lateral_dr <- tap_subset_lateral %>%
  filter(COUNTRY_OF_ORIGIN %in% c("dr")) %>%
  droplevels()

LVC_model_tap_subset_lateral_token_level <- glmer(MISMATCH ~ 
                                                      COUNTRY_OF_ORIGIN +
                                                      LIKE_SIM_PR +
                                                     LIKE_SIM_DR +
                                                      PLUS +
                                                      AGE +
                                                      SEX +
                                                      (1 | SPEAKER),
                                                    data = tap_subset_lateral,
                                                    family = binomial,
                                                    na.action = "na.exclude",
                                                    # na.action = "na.fail",
                                                    control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))

summary(LVC_model_tap_subset_lateral_token_level, correlation=TRUE)

## BY COUNTRY
LVC_model_tap_subset_lateral_token_level_pr <- glmer(MISMATCH ~ 
                                                    LIKE_SIM_PR +
                                                    # LIKE_SIM_DR +
                                                    PLUS +
                                                    AGE +
                                                    SEX +
                                                    (1 | SPEAKER),
                                                  data = tap_subset_lateral_pr,
                                                  family = binomial,
                                                  na.action = "na.exclude",
                                                  # na.action = "na.fail",
                                                  control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))

summary(LVC_model_tap_subset_lateral_token_level_pr, correlation=TRUE)

LVC_model_tap_subset_lateral_token_level_dr <- glmer(MISMATCH ~ 
                                                       # LIKE_SIM_PR +
                                                       LIKE_SIM_DR +
                                                       PLUS +
                                                       AGE +
                                                       SEX +
                                                       (1 | SPEAKER),
                                                     data = tap_subset_lateral_dr,
                                                     family = binomial,
                                                     na.action = "na.exclude",
                                                     # na.action = "na.fail",
                                                     control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))

summary(LVC_model_tap_subset_lateral_token_level_dr, correlation=TRUE)

tap_theoretical_r2 <- suppressWarnings(r.squaredGLMM(LVC_model_tap_subset_lateral_token_level)["theoretical", ])
tap_theoretical_r2

model_call_tap <- paste(deparse(LVC_model_tap_subset_lateral_token_level@call), collapse = " ")
cat("\\begin{verbatim}\n", model_call_tap, "\n\\end{verbatim}")
# model_call_latex <- gsub("_", "\\\\_", model_call)  # Escape underscores
# model_call_latex <- gsub("~", "$\\\\sim$", model_call_latex)  # Replace tilde
# model_call_latex <- gsub("\\|", "$\\\\vert$", model_call_latex)  # Replace vertical bar
# cat(model_call_latex)  # Print in a LaTeX-friendly forma


trill_pr <- trill %>%
  filter(COUNTRY_OF_ORIGIN %in% c("pr")) %>%
  droplevels()

trill_dr <- trill %>%
  filter(COUNTRY_OF_ORIGIN %in% c("dr")) %>%
  droplevels()

## TRILL
LVC_model_trill_subset_token_level <- glmer(MISMATCH ~
                                             COUNTRY_OF_ORIGIN +
                                            # PERCENT_INTL_ENG_ONLY +
                                              # LIKE_SIM_PR +
                                              LIKE_SIM_DR +
                                             PLUS +
                                             AGE +
                                             SEX +
                                             (1 | SPEAKER),
                                             data = trill,
                                             family = binomial,
                                            # na.action = "na.exclude",
                                             na.action = "na.fail",
                                             control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))
# 
summary(LVC_model_trill_subset_token_level, correlation=TRUE)

##BY COUNTRY
LVC_model_trill_subset_token_level_pr <- glmer(MISMATCH ~
                                              # PERCENT_INTL_ENG_ONLY +
                                              LIKE_SIM_PR +
                                              # LIKE_SIM_DR +
                                              PLUS +
                                              AGE +
                                              SEX +
                                              (1 | SPEAKER),
                                            data = trill_pr,
                                            family = binomial,
                                            na.action = "na.exclude",
                                            # na.action = "na.fail",
                                            control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))
summary(LVC_model_trill_subset_token_level_pr, correlation=TRUE)

LVC_model_trill_subset_token_level_dr <- glmer(MISMATCH ~
                                                 # PERCENT_INTL_ENG_ONLY +
                                                 # LIKE_SIM_PR +
                                                 LIKE_SIM_DR +
                                                 PLUS +
                                                 AGE +
                                                 SEX +
                                                 (1 | SPEAKER),
                                               data = trill_dr,
                                               family = binomial,
                                               na.action = "na.exclude",
                                               # na.action = "na.fail",
                                               control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))
summary(LVC_model_trill_subset_token_level_dr, correlation=TRUE)

## TRILL ALVEOLAR FRICATIVE

trill_subset_alveolar_fricative_pr <- trill_subset_alveolar_fricative %>%
  filter(COUNTRY_OF_ORIGIN %in% c("pr")) %>%
  droplevels()

trill_subset_alveolar_fricative_dr <- trill_subset_alveolar_fricative %>%
  filter(COUNTRY_OF_ORIGIN %in% c("dr")) %>%
  droplevels()

LVC_model_trill_subset_alveolar_fricative_token_level <- glmer(MISMATCH ~ 
                                                      COUNTRY_OF_ORIGIN +
                                                      # PERCENT_INTL_ENG_ONLY +
                                                      LIKE_SIM_PR +
                                                      LIKE_SIM_DR +
                                                        # NO_USE_DIFF_SPAN +
                                                      PLUS +
                                                      AGE +
                                                      SEX +
                                                      (1 | SPEAKER),
                                                    data = trill_subset_alveolar_fricative,
                                                    family = binomial,
                                                    na.action = "na.exclude",
                                                    # na.action = "na.fail",
                                                    control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))

summary(LVC_model_trill_subset_alveolar_fricative_token_level, correlation=TRUE)

trill_theoretical_r2 <- suppressWarnings(r.squaredGLMM(LVC_model_trill_subset_alveolar_fricative_token_level)["theoretical", ])
trill_theoretical_r2
# 
# ##PR 
LVC_model_trill_subset_alveolar_fricative_token_level_pr <- glmer(MISMATCH ~
                                                                 # COUNTRY_OF_ORIGIN +
                                                                 # PERCENT_INTL_ENG_ONLY +
                                                                 LIKE_SIM_PR +
                                                                 # LIKE_SIM_DR +
                                                                 PLUS +
                                                                 AGE +
                                                                 SEX +
                                                                 (1 | SPEAKER),
                                                               data = trill_subset_alveolar_fricative_pr,
                                                               family = binomial,
                                                               na.action = "na.exclude",
                                                               # na.action = "na.fail",
                                                               control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))

summary(LVC_model_trill_subset_alveolar_fricative_token_level_pr, correlation=TRUE)
# 
# ##DR 
LVC_model_trill_subset_alveolar_fricative_token_level_dr <- glmer(MISMATCH ~
                                                                 # COUNTRY_OF_ORIGIN +
                                                                 # PERCENT_INTL_ENG_ONLY +
                                                                 # LIKE_SIM_PR +
                                                                 LIKE_SIM_DR +
                                                                 PLUS +
                                                                 AGE +
                                                                 SEX +
                                                                 (1 | SPEAKER),
                                                               data = trill_subset_alveolar_fricative_dr,
                                                               family = binomial,
                                                               na.action = "na.exclude",
                                                               # na.action = "na.fail",
                                                               control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))

summary(LVC_model_trill_subset_alveolar_fricative_token_level_dr, correlation=TRUE)

# 
# ## TRILL VELAR FRICATIVE (x)
# LVC_model_trill_subset_velar_fricative_token_level <- glmer(MISMATCH ~ 
#                                                                  COUNTRY_OF_ORIGIN +
#                                                                  # PERCENT_INTL_ENG_ONLY +
#                                                                  PLUS +
#                                                                  AGE +
#                                                                  SEX +
#                                                                  (1 | SPEAKER),
#                                                                data = trill_subset_velar_fricative,
#                                                                family = binomial,
#                                                                na.action = "na.fail",
#                                                                control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))
# 
# summary(LVC_model_trill_subset_velar_fricative_token_level, correlation=TRUE)
# 
# trill_theoretical_r2 <- suppressWarnings(r.squaredGLMM(LVC_model_trill_subset_velar_fricative_token_level)["theoretical", ])
# trill_theoretical_r2

## LATERAL DARK L

LVC_model_lateral_subset_darkl_token_level <- glmer(MISMATCH ~ 
                                                      # IMMIGRATION_CATEGORY_binary +
                                                      COUNTRY_OF_ORIGIN +
                                                      # LIKE_SIM_PR +
                                                      # LIKE_SIM_DR +
                                                      PLUS +
                                                      AGE +
                                                      SEX +
                                                      # PERCENT_INTL_ENG_ONLY +
                                                      # PERCENT_INTL_SPAN_ONLY +
                                                      (1 | SPEAKER),
                                                    data = lateral_subset_darkl,
                                                    family = binomial,
                                                    na.action = "na.exclude",
                                                    # na.action = "na.fail",
                                                    control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))

summary(LVC_model_lateral_subset_darkl_token_level, correlation=TRUE)

lateral_theoretical_r2 <- suppressWarnings(r.squaredGLMM(LVC_model_lateral_subset_darkl_token_level)["theoretical", ])
lateral_theoretical_r2

## LATERAL ALL BUT DARK L


lateral_subset_all_but_darkl_pr <- lateral_subset_all_but_darkl %>%
  filter(COUNTRY_OF_ORIGIN %in% c("pr")) %>%
  droplevels()

lateral_subset_all_but_darkl_dr <- lateral_subset_all_but_darkl %>%
  filter(COUNTRY_OF_ORIGIN %in% c("dr")) %>%
  droplevels()

LVC_model_lateral_subset_all_but_darkl_token_level <- glmer(MISMATCH ~
# LVC_model_lateral_subset_all_but_darkl_token_level <- lm(MISMATCH ~
                                                      # IMMIGRATION_CATEGORY_binary +
                                                      COUNTRY_OF_ORIGIN +
                                                      PLUS +
                                                      AGE +
                                                      SEX +
                                                      # PERCENT_INTL_ENG_ONLY +
                                                      # PERCENT_INTL_SPAN_ONLY +
                                                      (1 | SPEAKER),
                                                    data = lateral_subset_all_but_darkl,
                                                    family = binomial,
                                                    na.action = "na.fail",
                                                    control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))

summary(LVC_model_lateral_subset_all_but_darkl_token_level, correlation=TRUE)
lateral_theoretical_r2 <- suppressWarnings(r.squaredGLMM(LVC_model_lateral_subset_all_but_darkl_token_level)["theoretical", ])

# ## BY COUNTRY
# LVC_model_lateral_subset_all_but_darkl_token_level_pr <- glmer(MISMATCH ~
#                                                               # IMMIGRATION_CATEGORY_binary +
#                                                               LIKE_SIM_PR +
#                                                               # LIKE_SIM_DR +
#                                                               PLUS +
#                                                               AGE +
#                                                               SEX +
#                                                               # PERCENT_INTL_ENG_ONLY +
#                                                               # PERCENT_INTL_SPAN_ONLY +
#                                                               (1 | SPEAKER),
#                                                             data = lateral_subset_all_but_darkl_pr,
#                                                             family = binomial,
#                                                             na.action = "na.exclude",
#                                                             control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))
# 
# summary(LVC_model_lateral_subset_all_but_darkl_token_level_pr, correlation=TRUE)
# 
# ## BY COUNTRY
# LVC_model_lateral_subset_all_but_darkl_token_level_dr <- glmer(MISMATCH ~
#                                                                  # IMMIGRATION_CATEGORY_binary +
#                                                                  # LIKE_SIM_PR +
#                                                                  LIKE_SIM_DR +
#                                                                  PLUS +
#                                                                  AGE +
#                                                                  SEX +
#                                                                  # PERCENT_INTL_ENG_ONLY +
#                                                                  # PERCENT_INTL_SPAN_ONLY +
#                                                                  (1 | SPEAKER),
#                                                                data = lateral_subset_all_but_darkl_dr,
#                                                                family = binomial,
#                                                                na.action = "na.exclude",
#                                                                control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))
# 
# summary(LVC_model_lateral_subset_all_but_darkl_token_level_pr, correlation=TRUE)


# table(lateral_subset_all_but_darkl$MISMATCH, lateral_subset_all_but_darkl$SEX)
vif(lm(MISMATCH ~ COUNTRY_OF_ORIGIN + PLUS + AGE + SEX, data = lateral_subset_all_but_darkl)) # VIF is greater than 5, collinearity could be an issue. Not the case here

model_without_speaker <- glm(MISMATCH ~ COUNTRY_OF_ORIGIN + PLUS + AGE + SEX,
                            data = lateral_subset_all_but_darkl, 
                            family = binomial)
summary(model_without_speaker, correlation=TRUE)

AIC(LVC_model_lateral_subset_all_but_darkl_token_level, model_without_speaker)

### Although the model with the speaker as a random effect has a lowe AIC, the difference is relatively small (4.48)
performance::icc(LVC_model_lateral_subset_all_but_darkl_token_level)
### ICC is on the low side, meaning SPEAKER only accounts for a small portion of the variability in the model.

### CODA S
mismatch <- c("mismatch") 

coda_s_LVC_MISMATCH <- coda_s %>%
  mutate(MISMATCH = case_when(
    PHONETIC_PHONOLOGICAL_AGREEMENT %in% mismatch ~ 1,
    TRUE  ~ 0
  ), .after = PHONETIC_PHONOLOGICAL_AGREEMENT) %>% 
  mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
  relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY) %>%
  mutate(COUNTRY_OF_ORIGIN = as.factor(COUNTRY_OF_ORIGIN))  # Convert to factor here

coda_s_pr <- coda_s_LVC_MISMATCH %>%
  filter(COUNTRY_OF_ORIGIN %in% c("pr")) %>%
  droplevels()

coda_s_dr <- coda_s_LVC_MISMATCH %>%
  filter(COUNTRY_OF_ORIGIN %in% c("dr")) %>%
  droplevels()

LVC_model_coda_s_token_level <- glmer(MISMATCH ~ 
                                        # IMMIGRATION_CATEGORY_binary +
                                        COUNTRY_OF_ORIGIN +
                                        # LIKE_SIM_PR +
                                        # LIKE_SIM_DR +
                                        PLUS +
                                        AGE +
                                        SEX +
                                        # PERCENT_INTL_ENG_ONLY +
                                        # PERCENT_INTL_SPAN_ONLY +
                                        (1 | SPEAKER),
                                      data = coda_s_LVC_MISMATCH,
                                      family = binomial,
                                      na.action = "na.exclude",
                                      # na.action = "na.fail",
                                      control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 70000)))

summary(LVC_model_coda_s_token_level, correlation=TRUE)

coda_s_theoretical_r2 <- suppressWarnings(r.squaredGLMM(LVC_model_coda_s_token_level)["theoretical", ])
coda_s_theoretical_r2

# by Country
#PR
LVC_model_coda_s_token_level_pr <- glmer(MISMATCH ~ 
                                        # IMMIGRATION_CATEGORY_binary +
                                        LIKE_SIM_PR +
                                        # LIKE_SIM_DR +
                                        PLUS +
                                        AGE +
                                        SEX +
                                        # PERCENT_INTL_ENG_ONLY +
                                        # PERCENT_INTL_SPAN_ONLY +
                                        (1 | SPEAKER),
                                      data = coda_s_pr,
                                      family = binomial,
                                      na.action = "na.exclude",
                                      control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 70000)))

summary(LVC_model_coda_s_token_level_pr, correlation=TRUE)
#DR
LVC_model_coda_s_token_level_dr <- glmer(MISMATCH ~ 
                                           # IMMIGRATION_CATEGORY_binary +
                                           # LIKE_SIM_PR +
                                           LIKE_SIM_DR +
                                           PLUS +
                                           AGE +
                                           SEX +
                                           # PERCENT_INTL_ENG_ONLY +
                                           # PERCENT_INTL_SPAN_ONLY +
                                           (1 | SPEAKER),
                                         data = coda_s_dr,
                                         family = binomial,
                                         na.action = "na.exclude",
                                         control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 70000)))

summary(LVC_model_coda_s_token_level_dr, correlation=TRUE)

# # Create models list to map unto table function
# high_salience_LVC_latex_table_models_list <- list(
#   LVC_model_coda_s_token_level,
#   LVC_model_tap_subset_lateral_token_level,
#   LVC_model_trill_subset_alveolar_fricative_token_level
# )

# Create models list to map unto table function
high_salience_LVC_latex_table_models_list <- list(
  LVC_model_coda_s_token_level,
  LVC_model_tap_subset_lateral_token_level,
  LVC_model_trill_subset_alveolar_fricative_token_level,
  LVC_model_lateral_subset_darkl_token_level
)

# Generate the LaTeX table
high_salience_LVC_latex_table <- create_compact_table(
  models = high_salience_LVC_latex_table_models_list,
  dep_var_labels = c("Coda/s/ Mismatch", "/\\textfishhookr/-[l] Mismatch", "/r/-fricative Mismatch", "/l/-[ɫ] Mismatch"),
  row_names = variable_names,
  caption = "Summary of Model Results Corresponding to Coda /s/ Mismatch, Tap-Lateral Mismatch, Trill-Fricative Trill, and Lateral Velarization Mismatch among 22 Spanish-speaking Bostonians",
  label = "tab:regression_high_salience_LVC"
)

cat(high_salience_LVC_latex_table)

### LOW SALIENCE VARIABLES


### Filled Pauses

fps_LVC_CENTRALIZED <- fps %>%
  mutate(CENTRALIZED_FPS_1 = case_when(
    CENTRALIZED_FPS == "centralized" ~ 1,
    TRUE  ~ 0
  ), .after = CENTRALIZED_FPS) %>% 
  mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
  relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY) %>%
  mutate(COUNTRY_OF_ORIGIN = as.factor(COUNTRY_OF_ORIGIN))  # Convert to factor here


LVC_model_fps_token_level <- glmer(CENTRALIZED_FPS_1 ~ 
                                     # IMMIGRATION_CATEGORY_binary +
                                     COUNTRY_OF_ORIGIN +
                                     PLUS +
                                     AGE +
                                     SEX +
                                     # PERCENT_INTL_ENG_ONLY +
                                     # PERCENT_INTL_SPAN_ONLY +
                                     (1 | SPEAKER),
                                   data = fps_LVC_CENTRALIZED,
                                   family = binomial,
                                   na.action = "na.fail",
                                   control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 70000)))

# summary(LVC_model_fps_token_level, correlation=TRUE)

fps_theoretical_r2 <- suppressWarnings(r.squaredGLMM(LVC_model_fps_token_level)["theoretical", ])
fps_theoretical_r2
### Pronouns


LVC_pronouns_present <- pronouns %>%
  mutate(PRONOUN_PRESENT = case_when(
    PRONOUN == "present" ~ 1,
    TRUE ~ 0
  ), .after = PRONOUN) %>%
  mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>%
  relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY) %>%
  mutate(COUNTRY_OF_ORIGIN = as.factor(COUNTRY_OF_ORIGIN))  # Convert to factor here

LVC_model_pronouns_present_token_level <- glmer(PRONOUN_PRESENT ~ 
                                                  # IMMIGRATION_CATEGORY_binary +
                                                  COUNTRY_OF_ORIGIN +
                                                  PLUS +
                                                  AGE +
                                                  SEX +
                                                  # PERCENT_INTL_ENG_ONLY +
                                                  # PERCENT_INTL_SPAN_ONLY +
                                                  (1 | SPEAKER),
                                                data = LVC_pronouns_present,
                                                family = binomial,
                                                na.action = "na.fail",
                                                control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 100000)))

# summary(LVC_model_pronouns_present_token_level, correlation=TRUE)

pronouns_present_theoretical_r2 <- suppressWarnings(r.squaredGLMM(LVC_model_pronouns_present_token_level)["theoretical", ])
pronouns_present_theoretical_r2

model_call_pronouns <- paste(deparse(LVC_model_pronouns_present_token_level@call), collapse = " ")
cat(model_call_pronouns)

### SUBJECT POSITION

subject_position_preverbal_LVC <- subject_position %>%
  filter(INFINITIVE != "gustar") %>% 
  mutate(PREVERBAL_SUBJECTS = case_when(
    SUB_POSITION == "preverbal" ~ 1,
    TRUE  ~ 0
  ), .after = SUB_POSITION) %>% 
  mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
  relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY) %>%
  mutate(COUNTRY_OF_ORIGIN = as.factor(COUNTRY_OF_ORIGIN))  # Convert to factor here


LVC_model_subject_position_preverbal_token_level <- glmer(PREVERBAL_SUBJECTS ~ 
                                                            # IMMIGRATION_CATEGORY_binary +
                                                            COUNTRY_OF_ORIGIN +
                                                            PLUS +
                                                            AGE +
                                                            SEX +
                                                            # PERCENT_INTL_ENG_ONLY +
                                                            # PERCENT_INTL_SPAN_ONLY +
                                                            (1 | SPEAKER),
                                                          data = subject_position_preverbal_LVC,
                                                          family = binomial,
                                                          na.action = "na.fail",
                                                          control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))

# summary(LVC_model_subject_position_preverbal_token_level, correlation=TRUE)
preverval_subjects_theoretical_r2 <- suppressWarnings(r.squaredGLMM(LVC_model_subject_position_preverbal_token_level)["theoretical", ])
preverval_subjects_theoretical_r2


# Create models list to map unto table function
low_salience_LVC_latex_table_models_list <- list(
  LVC_model_pronouns_present_token_level,
  LVC_model_subject_position_preverbal_token_level,
  LVC_model_fps_token_level#,
  # LVC_model_lateral_subset_darkl_token_level
)

# Generate the LaTeX table
low_salience_LVC_latex_table <- create_compact_table(
  models = low_salience_LVC_latex_table_models_list,
  dep_var_labels = c("Pronouns Present", "Preverbal Subjects", "Centralized FPS"),
  row_names = variable_names,
  caption = "Summary of Model Results Corresponding to Pronoun Presence, Pre-Verbal Subjects, and Centralized Filled Pauses among 22 Spanish-speaking Bostonians",
  label = "tab:regression_low_salience_LVC"
)

# # Generate the LaTeX table
# low_salience_LVC_latex_table <- create_compact_table(
#   models = low_salience_LVC_latex_table_models_list,
#   dep_var_labels = c("Pronouns Present", "Preverbal Subjects", "Centralized FPS", "/l/-[ɫ] Mismatch"),
#   row_names = variable_names,
#   caption = "Summary of Model Results Corresponding to Pronoun Presence, Pre-Verbal Subjects, Centralized Filled Pauses, and Lateral Velarization among 22 Spanish-speaking Bostonians",
#   label = "tab:regression_low_salience_LVC"
# )

cat(low_salience_LVC_latex_table)

# 
# ### SUBJECT POSITION PRONOUNS
# 
# subject_position_preverbal_pronouns_LVC <- subject_position_pronouns %>%
#   filter(INFINITIVE != "gustar") %>% 
#   mutate(PREVERBAL_SUBJECTS = case_when(
#     SUB_POSITION == "preverbal" ~ 1,
#     TRUE  ~ 0
#   ), .after = SUB_POSITION) %>% 
#   mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
#   relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY)
# 
# 
# LVC_model_subject_position_preverbal_pronouns_token_level <- glmer(PREVERBAL_SUBJECTS ~ 
#                                                                      # IMMIGRATION_CATEGORY_binary +
#                                                                      # COUNTRY_OF_ORIGIN +
#                                                                      PLUS +
#                                                                      AGE +
#                                                                      SEX +
#                                                                      # PERCENT_INTL_ENG_ONLY +
#                                                                      # PERCENT_INTL_SPAN_ONLY +
#                                                                      (1 | SPEAKER),
#                                                                    data = subject_position_preverbal_pronouns_LVC,
#                                                                    family = binomial,
#                                                                    na.action = "na.fail",
#                                                                    control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))
# 
# summary(LVC_model_subject_position_preverbal_pronouns_token_level, correlation=TRUE)
# 
# 
# ### SUBJECT POSITION - GENERAL SUBJECTS
# 
# general_preverbal_subject_position_LVC <- general_subject_position %>%
#   filter(INFINITIVE != "gustar") %>% 
#   mutate(PREVERBAL_SUBJECTS = case_when(
#     SUB_POSITION == "preverbal" ~ 1,
#     TRUE  ~ 0
#   ), .after = SUB_POSITION) %>% 
#   mutate(IMMIGRATION_CATEGORY_binary = ifelse(IMMIGRATION_CATEGORY %in% c("recent_arrival", "est_immigrant"), "NOT_US_Born", "US_Born")) %>% 
#   relocate(IMMIGRATION_CATEGORY_binary, .after = IMMIGRATION_CATEGORY)
# 
# 
# LVC_model_general_subject_position_preverbal_token_level <- glmer(PREVERBAL_SUBJECTS ~ 
#                                                                     # IMMIGRATION_CATEGORY_binary +
#                                                                     COUNTRY_OF_ORIGIN +
#                                                                     PLUS +
#                                                                     AGE +
#                                                                     SEX +
#                                                                     # PERCENT_INTL_ENG_ONLY +
#                                                                     # PERCENT_INTL_SPAN_ONLY +
#                                                                     (1 | SPEAKER),
#                                                                   data = general_preverbal_subject_position_LVC,
#                                                                   family = binomial,
#                                                                   na.action = "na.fail",
#                                                                   control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 90000)))
# 
# summary(LVC_model_general_subject_position_preverbal_token_level, correlation=TRUE)