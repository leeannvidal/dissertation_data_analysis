### STEPWISE LOGISTIC REGRESSION - LATERALS WITH DARK L ONLY
# Rescale continuous variables
lateral_subset_darkl$MS_PER_SYLL_SCALED <- scale(lateral_subset_darkl$MS_PER_SYLL)

# # Create model with all contact measures to compare to model with only % English and PLUS (the model that is equal to the full laterals model call)
# combined_model_lateral_subset_darkl <- glmer(MISMATCH ~
#                                                LOG_LEX_FREQ_DF_N + 
#                                                MS_PER_SYLL_SCALED +
#                                                POS_SYL + 
#                                                SYL_TYPE + 
#                                                STRESS + 
#                                                COUNTRY_OF_ORIGIN +
#                                                FOLL_SOUND_CATEGORY +
#                                                PREV_SOUND_CATEGORY + 
#                                                PLUS + 
#                                                PERCENT_INTL_ENG_ONLY + 
#                                                PERCENT_INTL_SPAN_ONLY +
#                                                (1 | SPEAKER),
#                                              data = lateral_subset_darkl,
#                                              family = binomial,
#                                              na.action = "na.fail",
#                                              control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 50000)))
# summary(combined_model_lateral_subset_darkl, correlation=TRUE)
# vif(combined_model_lateral_subset_darkl)
# anova(combined_model_lateral_subset_darkl,best_model_lateral_subset_darkl)
# ### The combined model performs worst, so it doesnt make sense to include the extra contact measures when they're not significant and adding them makes the AIC and BIC jump up by a lot.
# 
# model_selection_combined_lateral_subset_darkl <- dredge(combined_model_lateral_subset_darkl)
# head(model_selection_combined_lateral_subset_darkl)
# #### Get the best model
# best_model_combined_lateral_subset_darkl <- get.models(model_selection_combined_lateral_subset_darkl, subset = 1)[[1]]
# summary(best_model_combined_lateral_subset_darkl)
# 
# refitted_model_combined_lateral_subset_darkl <- update(best_model_combined_lateral_subset_darkl, control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 50000)))
# summary(refitted_model_combined_lateral_subset_darkl)
# anova(refitted_model_combined_lateral_subset_darkl,best_model_lateral_subset_darkl)
# 
# ### Got a warning that indicated a potential issue with convergence for the combined model
# ### so i refitted the top model to ensure convergence and ran an anova to compare the two models
# #### AIC: The Akaike Information Criterion for the refitted model is slightly lower (505.34 vs. 505.48), suggesting a marginal improvement in model fit.
# #### BIC: The Bayesian Information Criterion for the refitted model is higher (546.13 vs. 534.62), which typically penalizes more complex models.
# #### Log-Likelihood: The refitted model has a higher log-likelihood (-245.67 vs. -247.74), indicating a better fit to the data.
# #### Chi-Square Test (Chisq): The Chi-square value is 4.1437 with 2 degrees of freedom.
# #### p-value (Pr(>Chisq)): The p-value is 0.1259, which is not statistically significant (usually the threshold is 0.05).

# Create saturation model with the same factors as the full lateral
#Age, Sex, not significant and increases convergence issues when running dredge()
saturation_model_lateral_subset_darkl <- glmer(MISMATCH ~
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
                                             data = lateral_subset_darkl,
                                             family = binomial,
                                             na.action = "na.fail",
                                             control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 50000)))

summary(saturation_model_lateral_subset_darkl, correlation=TRUE)

##### Check for multicollinearity using VIF (car package)
vif(saturation_model_lateral_subset_darkl)

# # Perform model selection
model_selection_lateral_subset_darkl <- dredge(saturation_model_lateral_subset_darkl)

### View the top models
head(model_selection_lateral_subset_darkl)

#### Get the best model
best_model_lateral_subset_darkl <- get.models(model_selection_lateral_subset_darkl, subset = 1)[[1]]
summary(best_model_lateral_subset_darkl)
# anova(saturation_model_lateral_subset_darkl,best_model_lateral_subset_darkl)

# Save the model to folder to access when needed
saveRDS(best_model_lateral_subset_darkl, "data/regressions/best_model_lateral_subset_darkl.rds")
best_model_lateral_subset_darkl<- readRDS("data/regressions/best_model_lateral_subset_darkl.rds")

#### Run function to create LaTeX table
cat(create_table_w_random_effects(best_model_lateral_subset_darkl, caption = "Mixed Effects Model: Non-velarized lateral [l] Match vs. Velar lateral [ɫ]  Mismatch Prediction", label = "tab:lateral_subset_darkl_regression", dep_var_name = "Dep. Variable: Mismatch"))
### transfer printed code to latex

# Function uses parameters package to get CI, this is the call
# model_summary_lateral_subset_darkl <- model_parameters(best_model_lateral_subset_darkl,ci = 0.95, exponentiate = FALSE, effects = "fixed")

#Use this to check that the model added to LaTeX is correct
tab_model(best_model_lateral_subset_darkl, transform = NULL) # so that the beta is not exponentiated, which is the norm for logistic regressions

################## DROP 1 ################## 

#### Refine top model with DROP 1
# drop1(best_model_lateral_subset_darkl,test = "Chisq")  ## Don't need to run this, can run code on line 107 automatically
### best_model_drop1 <- drop1(best_model_lateral_subset_darkl, test = "Chisq")
### print(best_model_drop1)

################## PLOT DROP 1 RESULTS ################## 

### Plot the AIC Impact using the drop1 best model
tidy_best_model_lateral_subset_darkl <- tidy(drop1(best_model_lateral_subset_darkl,test = "Chisq"))

# Convert drop1 output to a data frame
tidy_best_model_lateral_subset_darkl <- as.data.frame(tidy_best_model_lateral_subset_darkl)

# Replace column names if they are either "Pr(Chi)" or "Pr.Chi"
names(tidy_best_model_lateral_subset_darkl)[names(tidy_best_model_lateral_subset_darkl) %in% c("Pr(Chi)", "Pr.Chi.")] <- "p_value"
names(tidy_best_model_lateral_subset_darkl)[names(tidy_best_model_lateral_subset_darkl) %in% c("term")] <- "Predictors"

names(tidy_best_model_lateral_subset_darkl)


# Add new columns: AIC difference and categorized p-values, drop <none> row from Predictors column
tidy_best_model_lateral_subset_darkl <- tidy_best_model_lateral_subset_darkl %>%
  mutate(AIC_incr_if_drop = AIC - AIC[1]) %>%
  mutate(p_value = ifelse(p_value > 0.05, ">.05", "<.05")) %>%
  filter(Predictors != "<none>")

# View the resulting tidy data frame
tidy_best_model_lateral_subset_darkl


# # Label the Predictors column to the data frame (row names represent the terms)
# tidy_best_model_lateral_subset_darkl <- tidy_best_model_lateral_subset_darkl %>%
#   filter(Predictors != "<none>")

# Now, filter, modify x-axis labels using replace_row_names, and plot
AIC_Impact_plot_lateral_subset_darkl <- tidy_best_model_lateral_subset_darkl %>%
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
    y= "AIC increase if dropped\n Lateral: Dark-l Mismatch", 
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

AIC_Impact_plot_lateral_subset_darkl

ggsave("output/plots/liquids/lateral/AIC_impact_lateral_subset_darkl.pdf", AIC_Impact_plot_lateral_subset_darkl,device = cairo_pdf, width = 10, height = 7)

### transfer printed code to latex

# ################## Constraint Hierarchy Table of  DROP 1 RESULTS ################## 
# 
# ## Ditch the table, added AIC values inside figure geompoints above
# # names(tidy_best_model_lateral_subset_darkl)
# # library(dplyr)
# # class(tidy_best_model_lateral_subset_darkl)
# 
# # Select Columns for Constraint Table, arrange from high to low, and update column names
# tidy_best_model_lateral_subset_darkl_table <- tidy_best_model_lateral_subset_darkl %>%
#   dplyr::select(Predictors, AIC_incr_if_drop, p_value) %>%
#   arrange(desc(AIC_incr_if_drop)) %>%
#   mutate(Predictors = replace_row_names(Predictors)) %>%  # Update row names
#   mutate(AIC_incr_if_drop = round(AIC_incr_if_drop, 1)) 
# # %>%   # Round the AIC column to 1 digit
# #   rename_with(~ replace_column_names(tidy_best_model_lateral_subset_darkl_table, names_for_columns))  # Update column names
# 
# 
# # Display the updated table
# tidy_best_model_lateral_subset_darkl_table
# 
# # # Apply the function to the column names of the data frame
# updated_col_names <- replace_column_names(tidy_best_model_lateral_subset_darkl_table, names_for_columns)
# 
# # Create the LaTeX table with column names in small caps and prevent escaping
# kable(tidy_best_model_lateral_subset_darkl_table, format = "latex", booktabs = TRUE, col.names = names_for_columns_latex, 
#       caption = "Predictor Impact on AIC in /l/ to [ɫ] Mismatch Model", 
#       escape = FALSE) %>%
#   kable_styling(latex_options = "striped")
# 
# ### transfer printed code to latex
# 
# 
# 
