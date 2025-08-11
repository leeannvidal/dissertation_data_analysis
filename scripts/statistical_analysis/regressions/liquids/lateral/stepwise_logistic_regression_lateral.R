### STEPWISE LOGISTIC REGRESSION - LATERALS
# Rescale continuous variables
lateral$MS_PER_SYLL_SCALED <- scale(lateral$MS_PER_SYLL)
# 
# # Define four models with PLUS/IMMIGRATION CATEGORY/% ENGLISH/ % SPANISH and run an anova to determine which one to use for the stepwise model (full model)
# plus_model_lateral <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                                      POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                                      PLUS + (1 | SPEAKER), 
#                                    data = lateral, 
#                                    family = binomial,
#                                    na.action = "na.fail",
#                                    control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# 
# immigration_cat_model_lateral <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                                                 POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                                                 IMMIGRATION_CATEGORY + (1 | SPEAKER), 
#                                               data = lateral, 
#                                               family = binomial,
#                                               na.action = "na.fail",
#                                               control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# 
# engl_perc_model_lateral <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                                           POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                                           PERCENT_INTL_ENG_ONLY + (1 | SPEAKER), 
#                                         data = lateral, 
#                                         family = binomial,
#                                         na.action = "na.fail",
#                                         control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# 
# span_perc_model_lateral <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                                           POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                                           PERCENT_INTL_SPAN_ONLY + (1 | SPEAKER), 
#                                         data = lateral, 
#                                         family = binomial,
#                                         na.action = "na.fail",
#                                         control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# 
# # summary(saturation_model_lateral, correlation=TRUE)
# summary(plus_model_lateral, correlation=TRUE) # PLUS Significant **
# summary(immigration_cat_model_lateral, correlation=TRUE) # US Born* / Recent Arrivals (Reference ***) Significant
# summary(engl_perc_model_lateral, correlation=TRUE) # significant **
# summary(span_perc_model_lateral, correlation=TRUE) # not significant XXX
# 
# anova(plus_model_lateral, immigration_cat_model_lateral, engl_perc_model_lateral, span_perc_model_lateral)
# ## Best fit is engl_perc_model_lateral followed by plus_model_lateral
# 
# # # Define a model with selected contact measures and include PREV and FOLL SOUND categories to verify convergence
# combined_model_lateral_w_sounds <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                               POS_SYL + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN +
#                               PLUS + PERCENT_INTL_ENG_ONLY + 
#                                 FOLL_SOUND_CATEGORY +
#                                 PREV_SOUND_CATEGORY +
#                                 (1 | SPEAKER),
#                             data = lateral,
#                             family = binomial,
#                             na.action = "na.fail",
#                             control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 50000)))
# 
# summary(combined_model_lateral_w_sounds, correlation=TRUE)
# vif(combined_model_lateral_w_sounds)
# 
# # # # Define a model with above predictors to check vif and modify
# # combined_model_lateral <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
# #                                 POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN +
# #                                 PLUS + PERCENT_INTL_ENG_ONLY + (1 | SPEAKER),
# #                               data = lateral,
# #                               family = binomial,
# #                               na.action = "na.fail",
# #                               control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# # 
# # summary(combined_model_lateral, correlation=TRUE)
# ##### Check for multicollinearity using VIF (car package)
# # vif(combined_model_lateral)
# 
# ### Compare the two models with and without sound categories of previous and following sound categories
# # anova(combined_model_lateral, combined_model_lateral_w_sounds)
# ### anova says BEST FIT includes sounds categories and is statistically significant
# 
# 
# 
# # ### Create two models, one with POS_WORD and one with POS_SYL to determine best fit .Do this for Lateral and Tap only as Trill has all onsets
# # # # Define a model with above predictors to check vif and modify
# # syl_pos_model_lateral <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
# #                                   POS_SYL + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN +
# #                                   PLUS + PERCENT_INTL_ENG_ONLY + (1 | SPEAKER),
# #                                 data = lateral,
# #                                 family = binomial,
# #                                 na.action = "na.fail",
# #                                 control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# # 
# # word_pos_model_lateral <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
# #                                  POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN +
# #                                  PLUS + PERCENT_INTL_ENG_ONLY + (1 | SPEAKER),
# #                                data = lateral,
# #                                family = binomial,
# #                                na.action = "na.fail",
# #                                control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# # 
# # summary(syl_pos_model_lateral, correlation=TRUE)
# # summary(word_pos_model_lateral, correlation=TRUE)
# # 
# # ## Run anova to determine best fit
# # anova(syl_pos_model_lateral, word_pos_model_lateral)
# 
# ### Although not statistically significant, syl_pos_model_lateral performs better


# Create saturation model based on above 
#Age, Sex, not significant and increases convergence issues
saturation_model_lateral <- glmer(MISMATCH ~ 
                                    LOG_LEX_FREQ_DF_N + 
                                    MS_PER_SYLL_SCALED +
                                    POS_SYL + 
                                    SYL_TYPE + 
                                    STRESS + 
                                    COUNTRY_OF_ORIGIN +
                                    PLUS + 
                                    # AGE +
                                    # SEX +
                                    PERCENT_INTL_ENG_ONLY + 
                                    FOLL_SOUND_CATEGORY +
                                    PREV_SOUND_CATEGORY +
                                    (1 | SPEAKER),
                                data = lateral,
                                family = binomial,
                                na.action = "na.fail",
                                control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 40000)))

vif (saturation_model_lateral)
summary(saturation_model_lateral, correlation=TRUE)

# # Perform model selection
model_selection_lateral <- dredge(saturation_model_lateral)

### View the top models
head(model_selection_lateral)

#### Get the best model
best_model_lateral <- get.models(model_selection_lateral, subset = 1)[[1]]
summary(best_model_lateral)

# Save the model to folder to access when needed
saveRDS(best_model_lateral, "data/regressions/best_model_lateral.rds")
best_model_lateral<- readRDS("data/regressions/best_model_lateral.rds")

#### Run function to create LaTeX table and transfer printed code to latex
cat(create_table_w_random_effects(best_model_lateral, caption = "Mixed Effects Model: Lateral Mis-(match) Prediction", label = "tab:lateral_regression", dep_var_name = "Dep. Variable: Mismatch"))

# Function uses parameters package to get CI, this is the call
# model_summary_lateral <- model_parameters(best_model_lateral,ci = 0.95, exponentiate = FALSE, effects = "fixed")

#Use this to check that the model added to LaTeX is correct
tab_model(best_model_lateral, transform = NULL) # so that the beta is not exponentiated, which is the norm for logistic regressions

################## DROP 1 ################## 

#### Refine top model with DROP 1

drop1(best_model_lateral,test = "Chisq")
### best_model_drop1 <- drop1(best_model_lateral, test = "Chisq")
### print(best_model_drop1)

################## PLOT DROP 1 RESULTS ################## 

### Plot the AIC Impact using the drop1 best model
tidy_best_model_lateral <- tidy(drop1(best_model_lateral,test = "Chisq"))

# Convert drop1 output to a data frame
tidy_best_model_lateral <- as.data.frame(tidy_best_model_lateral)

names(tidy_best_model_lateral)

# Replace column names if they are either "Pr(Chi)" or "Pr.Chi"
names(tidy_best_model_lateral)[names(tidy_best_model_lateral) %in% c("Pr(Chi)", "Pr.Chi.")] <- "p_value"
names(tidy_best_model_lateral)[names(tidy_best_model_lateral) %in% c("term")] <- "Predictors"



# Add new columns: AIC difference and categorized p-values, drop <none> row from Predictors column
tidy_best_model_lateral <- tidy_best_model_lateral %>%
  mutate(AIC_incr_if_drop = AIC - AIC[1]) %>%
  mutate(p_value = ifelse(p_value > 0.05, ">.05", "<.05")) %>%
  filter(Predictors != "<none>")

# View the resulting tidy data frame
tidy_best_model_lateral


# # Label the Predictors column to the data frame (row names represent the terms)
# tidy_best_model_lateral <- tidy_best_model_lateral %>%
#   filter(Predictors != "<none>")

# Now, filter, modify x-axis labels using replace_row_names, and plot
AIC_Impact_plot_lateral <- tidy_best_model_lateral %>%
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
    x= "Predictor Variable \n", 
    y= "AIC increase if dropped\n Lateral", 
    # fill="", 
    # title = "Impact of Predictor Variables on AIC in Mixed Effects Lateral Model",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    color = "p-value"
  ) +
  # # Override legend point size
  guides(color = guide_legend(override.aes = list(size = 3))) +  # Smaller points in legend
  scale_color_manual(values = custom_green_palette) +  # Custom fill palette
  # Apply the label replacement function using scale_x_discrete
  scale_x_discrete(labels = function(x) replace_row_names(x))

AIC_Impact_plot_lateral

ggsave("output/plots/liquids/lateral/AIC_impact_lateral.pdf", AIC_Impact_plot_lateral,device = cairo_pdf, width = 10, height = 7)

################## Constraint Hierarchy Table of  DROP 1 RESULTS ################## 
# 
# ## Ditch the table, added AIC values inside figure geompoints above
# # names(tidy_best_model_lateral)
# # library(dplyr)
# # class(tidy_best_model_lateral)
# 
# # Select Columns for Constraint Table, arrange from high to low, and update column names
# tidy_best_model_lateral_table <- tidy_best_model_lateral %>%
#   dplyr::select(Predictors, AIC_incr_if_drop, p_value) %>%
#   arrange(desc(AIC_incr_if_drop)) %>%
#   mutate(Predictors = replace_row_names(Predictors)) %>%  # Update row names
#   mutate(AIC_incr_if_drop = round(AIC_incr_if_drop, 1)) # Round the AIC column to 1 digit
# 
# # %>%   # Round the AIC column to 1 digit
# #   rename_with(~ replace_column_names(tidy_best_model_lateral_table, names_for_columns))  # Update column names ## threw error so ran it by itself
# 
# # Display the updated table
# tidy_best_model_lateral_table
# 
# # # Apply the function to the column names of the data frame -- added it to main call block
# updated_col_names <- replace_column_names(tidy_best_model_lateral_table, names_for_columns)
# 
# # Apply \textsc{} to column names ### No longer needed since Im using shortstack
# # col_names_latex <- sapply(updated_col_names, function(name) paste0("\\textsc{", name, "}"))
# 
# # Create the LaTeX table with column names in small caps and prevent escaping
# kable(tidy_best_model_lateral_table, format = "latex", booktabs = TRUE, col.names = names_for_columns_latex, 
#       caption = "Predictor Impact on AIC in Lateral Mismatch Model", 
#       escape = FALSE) %>%
#   kable_styling(latex_options = "striped")
# 
# ### transfer printed code to latex
