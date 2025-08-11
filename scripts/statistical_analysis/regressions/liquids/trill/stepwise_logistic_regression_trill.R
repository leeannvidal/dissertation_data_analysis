### STEPWISE LOGISTIC REGRESSION - TRILLS
# 
# # citation("car")
# # citation() ### to cite base R
# # Rescale continuous variables
trill$MS_PER_SYLL_SCALED <- scale(trill$MS_PER_SYLL)
# 
# # Define four models with PLUS/IMMIGRATION CATEGORY/% ENGLISH/ % SPANISH and run an anova to determine which one to use for the stepwise model (full model)
#v
# 
# immigration_cat_model_trill <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                                      POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                                      IMMIGRATION_CATEGORY + (1 | SPEAKER), 
#                                    data = trill, 
#                                    family = binomial,
#                                    na.action = "na.fail",
#                                    control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# 
# engl_perc_model_trill <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                                POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                                PERCENT_INTL_ENG_ONLY + (1 | SPEAKER), 
#                              data = trill, 
#                              family = binomial,
#                              na.action = "na.fail",
#                              control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# 
# span_perc_model_trill <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                                POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN + 
#                                PERCENT_INTL_SPAN_ONLY + (1 | SPEAKER), 
#                              data = trill, 
#                              family = binomial,
#                              na.action = "na.fail",
#                              control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# 
# # summary(saturation_model_trill, correlation=TRUE)
# summary(plus_model_trill, correlation=TRUE) # Significant ***
# summary(immigration_cat_model_trill, correlation=TRUE) # US Born *** (REFERENCE NOT SIGN)
# summary(engl_perc_model_trill, correlation=TRUE) # Significant ***
# summary(span_perc_model_trill, correlation=TRUE) # Significant **
# 
# anova(plus_model_trill, immigration_cat_model_trill, engl_perc_model_trill, span_perc_model_trill)
# ## Best fit is plus_model_trill based on lowest AIC, lowest BIC, highest log-likelihood, and lowest deviance.
# 
# # # # Define a model with above predictors to check vif and modify
# # combined_model_trill <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
# #                               POS_WORD + SYL_TYPE + STRESS + SEX + COUNTRY_OF_ORIGIN +
# #                               PLUS + IMMIGRATION_CATEGORY + (1 | SPEAKER),
# #                             data = trill,
# #                             family = binomial,
# #                             na.action = "na.fail",
# #                             control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))
# # 
# # summary(combined_model_trill, correlation=TRUE)
# # 
# # ##### Check for multicollinearity using VIF (car package)
# # vif(combined_model_trill)

# Create saturation model based on above 
#sex, syl type, prev and following sound categories not significant and increases convergence issues when running dredge so dropped
saturation_model_trill <- glmer(MISMATCH ~ 
                                  LOG_LEX_FREQ_DF_N + 
                                  MS_PER_SYLL_SCALED +
                                  POS_WORD + 
                                  # SYL_TYPE + 
                                  # STRESS + 
                                  # FOLL_SOUND_CATEGORY +
                                  # PREV_SOUND_CATEGORY +
                                  COUNTRY_OF_ORIGIN +
                                  PLUS + 
                                  # AGE +
                                  SEX +
                                  # PERCENT_INTL_ENG_ONLY + 
                                  # PERCENT_INTL_SPAN_ONLY +
                                  (1 | SPEAKER),
                              data = trill,
                              family = binomial,
                              na.action = "na.fail",
                              control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 70000)))

summary(saturation_model_trill, correlation=TRUE)
# levels(trill$SURF_FORM)

##### Check for multicollinearity using VIF (car package)
vif(saturation_model_trill)

# # Perform model selection
model_selection_trill <- dredge(saturation_model_trill)
### View the top models
head(model_selection_trill)

#### Get the best model
best_model_trill <- get.models(model_selection_trill, subset = 1)[[1]]
summary(best_model_trill)
vif(best_model_trill)

# Save the model to folder to access when needed
saveRDS(best_model_trill, "data/regressions/best_model_trill.rds")
best_model_trill<- readRDS("data/regressions/best_model_trill.rds")

#### Run function to create LaTeX table and transfer printed code to latex
cat(create_table_w_random_effects(best_model_trill, caption = "Mixed Effects Model: Trill Mis-(match) Prediction", label = "tab:trill_regression", dep_var_name = "Dep. Variable: Mismatch"))

# Function uses parameters package to get CI, this is the call
# model_summary_trill <- model_parameters(best_model_trill,ci = 0.95, exponentiate = FALSE, effects = "fixed")

#Use this to check that the model added to LaTeX is correct
tab_model(best_model_trill, transform = NULL) # so that the beta is not exponentiated, which is the norm for logistic regressions

################## DROP 1 ################## 
#### Refine top model with DROP 1

# drop1(best_model_trill,test = "Chisq")
### best_model_drop1 <- drop1(saturation_model_trill, test = "Chisq")  ## Don't need to run this, can run code on line 128 automatically
### print(best_model_drop1)

################## PLOT DROP 1 RESULTS ################## 

### Plot the AIC Impact using the drop1 best model
tidy_best_model_trill <- tidy(drop1(best_model_trill,test = "Chisq"))

# Convert drop1 output to a data frame
tidy_best_model_trill <- as.data.frame(tidy_best_model_trill)

# Replace column names if they are either "Pr(Chi)" or "Pr.Chi"
names(tidy_best_model_trill)[names(tidy_best_model_trill) %in% c("Pr(Chi)", "Pr.Chi.")] <- "p_value"
names(tidy_best_model_trill)[names(tidy_best_model_trill) %in% c("term")] <- "Predictors" ### trill comes out differently for some reason and this column is not labelled

names(tidy_best_model_trill)

# # Label the Predictors column to the data frame (row names represent the terms)
# tidy_best_model_trill <- tidy_best_model_trill %>%
#   rownames_to_column(var = "Predictors") %>%
#   filter(Predictors != "<none>")

# Add new columns: AIC difference and categorized p-values, drop <none> row from Predictors column
tidy_best_model_trill <- tidy_best_model_trill %>%
  mutate(AIC_incr_if_drop = AIC - AIC[1]) %>%
  mutate(p_value = ifelse(p_value > 0.05, ">.05", "<.05")) %>%
    filter(Predictors != "<none>")

# View the resulting tidy data frame
tidy_best_model_trill

# Now, filter, modify x-axis labels using replace_row_names, and plot
AIC_Impact_plot_trill <- tidy_best_model_trill %>%
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
    y= "AIC increase if dropped\n Trill", 
    # fill="", 
    # title = "Impact of Predictor Variables on AIC in Mixed Effects Trill Model",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    color = "p-value"
  ) +
  # # Override legend point size
  guides(color = guide_legend(override.aes = list(size = 3))) +  # Smaller points in legend
  scale_color_manual(values = custom_green_palette) +  # Custom fill palette
  # Apply the label replacement function using scale_x_discrete
  scale_x_discrete(labels = function(x) replace_row_names(x))

AIC_Impact_plot_trill

ggsave("output/plots/liquids/trill/AIC_impact_trill.pdf", AIC_Impact_plot_trill,device = cairo_pdf, width = 10, height = 7)

################## Constraint Hierarchy Table of  DROP 1 RESULTS ################## 
# 
# ## Ditch the table, added AIC values inside figure geompoints above
# # names(tidy_best_model_trill)
# # library(dplyr)
# # class(tidy_best_model_trill)
# 
# # Select Columns for Constraint Table, arrange from high to low, and update column names
# tidy_best_model_trill_table <- tidy_best_model_trill %>%
#   dplyr::select(Predictors, AIC_incr_if_drop, p_value) %>%
#   arrange(desc(AIC_incr_if_drop)) %>%
#   mutate(Predictors = replace_row_names(Predictors)) %>%  # Update row names
#   mutate(AIC_incr_if_drop = round(AIC_incr_if_drop, 1)) %>%   # Round the AIC column to 1 digit
#   rename_with(~ replace_column_names(tidy_best_model_trill_table, names_for_columns))  # Update column names
# 
# 
# # Display the updated table
# tidy_best_model_trill_table
# 
# # # Apply \textsc{} to column names
# # col_names_latex <- sapply(updated_col_names, function(name) paste0("\\textsc{", name, "}"))
# 
# # Create the LaTeX table with column names in small caps and prevent escaping
# kable(tidy_best_model_trill_table, format = "latex", booktabs = TRUE, col.names = names_for_columns_latex, 
#       caption = "Predictor Impact on AIC in Trill Mismatch Model", 
#       escape = FALSE,
#       label = "AIC_Impact_table_Trill") %>%
#   kable_styling(latex_options = "striped")
# 
# ### transfer printed code to latex
# 
