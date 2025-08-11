### STEPWISE LOGISTIC REGRESSION - TAPS
# Rescale continuous variables
tap$MS_PER_SYLL_SCALED <- scale(tap$MS_PER_SYLL)

# # Define four models with contact measures and run an anova to determine which one to use for the stepwise model (full model)
# plus_model_tap <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                               POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                               PLUS + (1 | SPEAKER), 
#                             data = tap, 
#                             family = binomial,
#                             na.action = "na.fail",
#                             control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# 
# immigration_cat_model_tap <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                                          POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                                          IMMIGRATION_CATEGORY + (1 | SPEAKER), 
#                                        data = tap, 
#                                        family = binomial,
#                                        na.action = "na.fail",
#                                        control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# 
# engl_perc_model_tap <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                                    POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                                    PERCENT_INTL_ENG_ONLY + (1 | SPEAKER), 
#                                  data = tap, 
#                                  family = binomial,
#                                  na.action = "na.fail",
#                                  control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# 
# span_perc_model_tap <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                                    POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                                    PERCENT_INTL_SPAN_ONLY + (1 | SPEAKER), 
#                                  data = tap, 
#                                  family = binomial,
#                                  na.action = "na.fail",
#                                  control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# 
# # summary(saturation_model_tap, correlation=TRUE)
# summary(plus_model_tap, correlation=TRUE) # Not Significant **
# summary(immigration_cat_model_tap, correlation=TRUE) # Not Significant
# summary(engl_perc_model_tap, correlation=TRUE) # Not significant
# summary(span_perc_model_tap, correlation=TRUE) # Mildly Significant but not really .07
# 
# anova(plus_model_tap, immigration_cat_model_tap, engl_perc_model_tap, span_perc_model_tap)
### Best fit is span_perc_model_tap followed by plus_model_tap, but not statistically significant so doesnt matter

# # Define a model with selected contact measures and include PREV and FOLL SOUND categories to verify convergence
combined_model_tap_w_sounds <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
                              POS_SYL + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN +
                              PLUS + PERCENT_INTL_SPAN_ONLY + 
                                FOLL_SOUND_CATEGORY +
                                PREV_SOUND_CATEGORY +
                                (1 | SPEAKER),
                            data = tap,
                            family = binomial,
                            na.action = "na.fail",
                            control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 50000)))

summary(combined_model_tap_w_sounds, correlation=TRUE)
vif(combined_model_tap_w_sounds)

### FOLL_SOUND vowel is significant

# # Define a model with above predictors to check vif and modify
combined_model_tap <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
                                  POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN +
                                  PLUS + PERCENT_INTL_SPAN_ONLY + (1 | SPEAKER),
                                data = tap,
                                family = binomial,
                                na.action = "na.fail",
                                control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))

summary(combined_model_tap, correlation=TRUE)
anova(combined_model_tap, combined_model_tap_w_sounds)
### anova says BEST FIT includes sounds categories

##### Check for multicollinearity using VIF (car package)
vif(combined_model_tap)

### Create two models, one with POS_WORD and one with POS_SYL to determine best fit .Do this for Lateral and Tap only as Trill has all onsets
# # Define a model with above predictors to check vif and modify
syl_pos_model_tap <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
                                 POS_SYL + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN +
                                 PLUS + (1 | SPEAKER),
                               data = tap,
                               family = binomial,
                               na.action = "na.fail",
                               control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))

word_pos_model_tap <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
                                  POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN +
                                  PLUS + (1 | SPEAKER),
                                data = tap,
                                family = binomial,
                                na.action = "na.fail",
                                control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))

summary(syl_pos_model_tap, correlation=TRUE)
summary(word_pos_model_tap, correlation=TRUE)

## Run anova to determine best fit
anova(syl_pos_model_tap, word_pos_model_tap)

### Although not statistically significant, syl_pos_model_tap performs better


# Create saturation model based on above 
#Even though it is a better fit, PERCENT_INTL_SPAN_ONLY, not significant and increases convergence issues
# Syl type and POS_SYL have some colinearity, dropped syl_type
# age, not significant, dropped to help with convergence issues
# Increased number of iterations to help with convergence

tap_dr <- tap %>% 
  filter(COUNTRY_OF_ORIGIN %in% c("dr")) %>%
  droplevels()

tap_pr <- tap %>% 
  filter(COUNTRY_OF_ORIGIN %in% c("pr")) %>%
  droplevels()

saturation_model_tap <- glmer(MISMATCH ~ 
                                LOG_LEX_FREQ_DF_N + 
                                MS_PER_SYLL_SCALED +
                                POS_SYL + 
                                STRESS + 
                                COUNTRY_OF_ORIGIN +
                                FOLL_SOUND_CATEGORY +
                                PREV_SOUND_CATEGORY +
                                PLUS + 
                                LIKE_SIM_PR +
                                LIKE_SIM_DR +
                                # TEACH_ETHN_SPAN +
                                SEX + 
                                (1 | SPEAKER),
                                  data = tap,
                                  family = binomial,
                              na.action = "na.exclude",
                              # na.action = "na.fail",
                                  control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 50000)))

summary(saturation_model_tap, correlation=TRUE)

##### Check for multicollinearity using VIF (car package)
vif(saturation_model_tap)

# # Perform model selection
model_selection_tap <- dredge(saturation_model_tap)

### View the top models
head(model_selection_tap)

#### Get the best model
best_model_tap <- get.models(model_selection_tap, subset = 1)[[1]]
summary(best_model_tap)

### Got a warning that indicated a potential issue with convergence, so i refit the top model to ensure convergence. 

refitted_model_tap <- update(best_model_tap, control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 50000)))
summary(refitted_model_tap)
anova(refitted_model_tap, best_model_tap)

#### The results from best_model_tap and refitted_model_tap are identical, as they both show the same output with no changes after refitting. 
#### This means the refitting step did not alter the model's fit or estimates, which is a good sign that the model was already well-optimized.

# Save the model to folder to access when needed
saveRDS(refitted_model_tap, "data/regressions/best_model_tap.rds")
refitted_model_tap<- readRDS("data/regressions/best_model_tap.rds")

refitted_model_tap

#### Run function to create LaTeX table
cat(create_table_w_random_effects(refitted_model_tap, caption = "Mixed Effects Model: Tap Mis-(match) Prediction", label = "tab:tap_regression", dep_var_name = "Dep. Variable: Mismatch"))
### transfer printed code to latex

# Function uses parameters package to get CI, this is the call
# model_summary_tap <- model_parameters(refitted_model_tap,ci = 0.95, exponentiate = FALSE, effects = "fixed")

#Use this to check that the model added to LaTeX is correct
tab_model(refitted_model_tap, transform = NULL) # so that the beta is not exponentiated, which is the norm for logistic regressions

################## DROP 1 ################## 

#### Refine top model with DROP 1
# drop1(refitted_model_tap,test = "Chisq")  ## Don't need to run this, can run code on line 176 automatically
### best_model_drop1 <- drop1(best_model_tap, test = "Chisq")
### print(best_model_drop1)

################## PLOT DROP 1 RESULTS ################## 

### Plot the AIC Impact using the drop1 best model
tidy_best_model_tap <- tidy(drop1(refitted_model_tap,test = "Chisq"))

# Convert drop1 output to a data frame
tidy_best_model_tap <- as.data.frame(tidy_best_model_tap)

names(tidy_best_model_tap)

# Replace column names if they are either "Pr(Chi)" or "Pr.Chi"
names(tidy_best_model_tap)[names(tidy_best_model_tap) %in% c("Pr(Chi)", "Pr.Chi.")] <- "p_value"
names(tidy_best_model_tap)[names(tidy_best_model_tap) %in% c("term")] <- "Predictors"




# Add new columns: AIC difference and categorized p-values, drop <none> row from Predictors column
tidy_best_model_tap <- tidy_best_model_tap %>%
  mutate(AIC_incr_if_drop = AIC - AIC[1]) %>%
  mutate(p_value = ifelse(p_value > 0.05, ">.05", "<.05")) %>%
  filter(Predictors != "<none>")

# View the resulting tidy data frame
tidy_best_model_tap


# # Label the Predictors column to the data frame (row names represent the terms)
# tidy_best_model_tap <- tidy_best_model_tap %>%
#   filter(Predictors != "<none>")

# Now, filter, modify x-axis labels using replace_row_names, and plot
AIC_Impact_plot_tap <- tidy_best_model_tap %>%
  ggplot(aes(x = reorder(Predictors, AIC_incr_if_drop), y = AIC_incr_if_drop, color = p_value)) +
  coord_flip() +
  geom_hline(yintercept = 0, color = "gray60", linetype = "dashed") +
  # # geom_point(size = 4) +
  geom_point(size = 15) +
  geom_text(aes(label = round(AIC_incr_if_drop, 1)),  # Add labels for the y-values
            size = 4,
            fontface = "bold",
            vjust = 0.25,  # Adjust vertical position of the label (can change to fit better)
            hjust = 0.5,   # Adjust horizontal position (align center by default)
            color = "white") +  # You can change the color to match your preference
  custom_theme_AIC_tables() +
  labs(
    x= "Predictor Variable\n", 
    y= "AIC increase if dropped\n Tap", 
    # fill="", 
    # title = "Impact of Predictor Variables on AIC in Mixed Effects Tap Model",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    color = "p-value"
  ) +
  # # Override legend point size
  guides(color = guide_legend(override.aes = list(size = 3))) +  # Smaller points in legend
  scale_color_manual(values = custom_green_palette) +  # Custom fill palette
  # Apply the label replacement function using scale_x_discrete
  scale_x_discrete(labels = function(x) replace_row_names(x))

AIC_Impact_plot_tap

ggsave("output/plots/liquids/tap/AIC_impact_tap.pdf", AIC_Impact_plot_tap,device = cairo_pdf, width = 10, height = 7)

### transfer printed code to latex

################## Constraint Hierarchy Table of  DROP 1 RESULTS ################## 
# 
# # ## Ditch the table, added AIC values inside figure geompoints above
# # names(tidy_best_model_tap)
# # library(dplyr)
# # class(tidy_best_model_tap)
# 
# # Select Columns for Constraint Table, arrange from high to low, and update column names
# tidy_best_model_tap_table <- tidy_best_model_tap %>%
#   dplyr::select(Predictors, AIC_incr_if_drop, p_value) %>%
#   arrange(desc(AIC_incr_if_drop)) %>%
#   mutate(Predictors = replace_row_names(Predictors)) %>%  # Update row names
#   mutate(AIC_incr_if_drop = round(AIC_incr_if_drop, 1)) %>%   # Round the AIC column to 1 digit
#   rename_with(~ replace_column_names(tidy_best_model_tap_table, names_for_columns_latex))  # Update column names
# 
# 
# # Display the updated table
# tidy_best_model_tap_table
# 
# # Apply \textsc{} to column names ### No longer needed since Im using shortstack
# # col_names_latex <- sapply(updated_col_names, function(name) paste0("\\textsc{", name, "}"))
# 
# # Create the LaTeX table with column names in small caps and prevent escaping
# kable(tidy_best_model_tap_table, format = "latex", booktabs = TRUE, col.names = names_for_columns_latex, 
#       caption = "Predictor Impact on AIC in Tap Mismatch Model", 
#       escape = FALSE) %>%
#   kable_styling(latex_options = "striped")
# 
# ### transfer printed code to latex
# 
