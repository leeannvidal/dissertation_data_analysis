### STEPWISE LOGISTIC REGRESSION - TRILLS WITH VOICED ALVEOLAR FRICATIVE TRILL ONLY
# Rescale continuous variables
trill_subset_alveolar_fricative$MS_PER_SYLL_SCALED <- scale(trill_subset_alveolar_fricative$MS_PER_SYLL)

### Create saturation model
#sex, syl type, prev and following sound categories not significant and increases convergence issues when running dredge so dropped
saturation_model_trill_subset_fricative <- glmer(MISMATCH ~ 
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
                                data = trill_subset_alveolar_fricative,
                                family = binomial,
                                na.action = "na.fail",
                                control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 70000)))
# levels(trill_subset$SURF_FORM)
levels(trill_subset_alveolar_fricative$SURF_FORM)
summary(saturation_model_trill_subset_fricative, correlation=TRUE)

# # Perform model selection
model_selection_trill_subset <- dredge(saturation_model_trill_subset_fricative)
### View the top models
head(model_selection_trill_subset)

#### Get the best model
best_model_trill_subset <- get.models(model_selection_trill_subset, subset = 1)[[1]]
summary(best_model_trill_subset)

# Save the model to folder to access when needed
saveRDS(best_model_trill_subset, "data/regressions/best_model_trill_subset.rds")
best_model_trill_subset<- readRDS("data/regressions/best_model_trill_subset.rds")
#### Run function to create LaTeX tableq
cat(create_table_w_random_effects(best_model_trill_subset, caption = "Mixed Effects Model: /r/ Match vs. [$ \\underset{\\text{˔}}{\\text{r}} $] Mismatch Prediction", label = "tab:trill_subset_fricative_regression", dep_var_name = "Dep. Variable: Mismatch"))
### transfer printed code to latex

#Use this to check that the model added to LaTeX is correct
tab_model(best_model_trill_subset, transform = NULL) # so that the beta is not exponentiated, which is the norm for logistic regressions

################## DROP 1 ################## 

#### Refine top model with DROP 1
# drop1(best_model_trill_subset,test = "Chisq")  ## Don't need to run this, can run code on line 56 automatically
### best_model_drop1 <- drop1(best_model_trill_subset_alveolar_fricative, test = "Chisq")
### print(best_model_drop1)

################## PLOT DROP 1 RESULTS ################## 

### Plot the AIC Impact using the drop1 best model
tidy_best_model_trill_subset_alveolar_fricative <- tidy(drop1(best_model_trill_subset,test = "Chisq"))

# Convert drop1 output to a data frame
tidy_best_model_trill_subset_alveolar_fricative <- as.data.frame(tidy_best_model_trill_subset_alveolar_fricative)

# Replace column names if they are either "Pr(Chi)" or "Pr.Chi"
names(tidy_best_model_trill_subset_alveolar_fricative)[names(tidy_best_model_trill_subset_alveolar_fricative) %in% c("Pr(Chi)", "Pr.Chi.")] <- "p_value"
names(tidy_best_model_trill_subset_alveolar_fricative)[names(tidy_best_model_trill_subset_alveolar_fricative) %in% c("term")] <- "Predictors"

names(tidy_best_model_trill_subset_alveolar_fricative)


# Add new columns: AIC difference and categorized p-values, drop <none> row from Predictors column
tidy_best_model_trill_subset_alveolar_fricative <- tidy_best_model_trill_subset_alveolar_fricative %>%
  mutate(AIC_incr_if_drop = AIC - AIC[1]) %>%
  mutate(p_value = ifelse(p_value > 0.05, ">.05", "<.05")) %>%
  filter(Predictors != "<none>")

# View the resulting tidy data frame
tidy_best_model_trill_subset_alveolar_fricative


# # Label the Predictors column to the data frame (row names represent the terms)
# tidy_best_model_trill_subset_alveolar_fricative <- tidy_best_model_trill_subset_alveolar_fricative %>%
#   filter(Predictors != "<none>")

# Now, filter, modify x-axis labels using replace_row_names, and plot
AIC_Impact_plot_trill_subset_alveolar_fricative <- tidy_best_model_trill_subset_alveolar_fricative %>%
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
    y= "AIC increase if dropped\n",
    # y= "AIC increase if dropped\n Trills: [r̝] Mismatch", the trill gets printed in small caps - use the one below
    # fill="", 
    title = "/r/ : [r] & [r̝]", ### THis is so that the trills dont get converted to small caps
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    color = "p-value"
  ) +
  # # Override legend point size
  guides(color = guide_legend(override.aes = list(size = 3))) +  # Smaller points in legend
  scale_color_manual(values = custom_green_palette) +  # Custom fill palette
  # Apply the label replacement function using scale_x_discrete
  scale_x_discrete(labels = function(x) replace_row_names(x))

# library(ggtext)
AIC_Impact_plot_trill_subset_alveolar_fricative

ggsave("output/plots/liquids/trill/AIC_impact_trill_subset_alveolar_fricative.pdf", AIC_Impact_plot_trill_subset_alveolar_fricative,device = cairo_pdf, width = 10, height = 7)

### transfer printed code to latex

################## Constraint Hierarchy Table of  DROP 1 RESULTS ################## 
# 
# ## Ditch the table, added AIC values inside figure geompoints above
# # names(tidy_best_model_trill_subset_alveolar_fricative)
# # library(dplyr)
# # class(tidy_best_model_trill_subset_alveolar_fricative)
# 
# # Select Columns for Constraint Table, arrange from high to low, and update column names
# tidy_best_model_trill_subset_alveolar_fricative_table <- tidy_best_model_trill_subset_alveolar_fricative %>%
#   dplyr::select(Predictors, AIC_incr_if_drop, p_value) %>%
#   arrange(desc(AIC_incr_if_drop)) %>%
#   mutate(Predictors = replace_row_names(Predictors)) %>%  # Update row names
#   mutate(AIC_incr_if_drop = round(AIC_incr_if_drop, 1)) 
# # %>%   # Round the AIC column to 1 digit
# #   rename_with(~ replace_column_names(tidy_best_model_trill_subset_alveolar_fricative_table, names_for_columns))  # Update column names
# 
# 
# # Display the updated table
# tidy_best_model_trill_subset_alveolar_fricative_table
# 
# # # Apply the function to the column names of the data frame
# updated_col_names <- replace_column_names(tidy_best_model_trill_subset_alveolar_fricative_table, names_for_columns)
# 
# # Apply \textsc{} to column names ### No longer needed since Im using shortstack
# # col_names_latex <- sapply(updated_col_names, function(name) paste0("\\textsc{", name, "}"))
# 
# # Create the LaTeX table with column names in small caps and prevent escaping
# kable(tidy_best_model_trill_subset_alveolar_fricative_table, format = "latex", booktabs = TRUE, col.names = names_for_columns_latex, 
#       caption = "Predictor Impact on AIC in /r/ to [$ \\underset{\\text{˔}}{\\text{r}} $] Mismatch Model",
#       label = "AIC_Impact_table_trill_alveolar_fricative_trill_subset",
#       escape = FALSE) %>%
#   kable_styling(latex_options = "striped")
# 
# ### transfer printed code to latex
# 
# 
# 
# ### CHECK A SUBSET WITH [r] and [x]
# # ## VELAR FRICATIVE
# # trill_subset_velar_fricative$MS_PER_SYLL_SCALED <- scale(trill_subset_velar_fricative$MS_PER_SYLL)
# # 
# # saturation_model_trill_subset_velar_fricative <- glmer(MISMATCH ~ 
# #                                                   LOG_LEX_FREQ_DF_N + 
# #                                                   MS_PER_SYLL_SCALED +
# #                                                   POS_WORD +
# #                                                   # SYL_TYPE +
# #                                                   # STRESS +
# #                                                   # FOLL_SOUND_CATEGORY +
# #                                                   # PREV_SOUND_CATEGORY +
# #                                                   COUNTRY_OF_ORIGIN +
# #                                                   PLUS + 
# #                                                   # AGE +
# #                                                   SEX +
# #                                                   PERCENT_INTL_ENG_ONLY +
# #                                                   PERCENT_INTL_SPAN_ONLY +
# #                                                   (1 | SPEAKER),
# #                                                 data = trill_subset_velar_fricative,
# #                                                 family = binomial,
# #                                                 na.action = "na.fail",
# #                                                 control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 70000)))
# # 
# # summary(saturation_model_trill_subset_velar_fricative, correlation=TRUE)
# # levels(trill_subset_velar_fricative$SURF_FORM)
# # 
# # model_selection_trill_subset_velar_fricative <- dredge(saturation_model_trill_subset_velar_fricative)
# # 
# # ### View the top models
# # head(model_selection_trill_subset_velar_fricative)
# # 
# # #### Get the best model
# # best_model_trill_subset_velar_fricative <- get.models(model_selection_trill_subset_velar_fricative, subset = 1)[[1]]
# # summary(best_model_trill_subset_velar_fricative)
# ### PLUS seems to be the only significant factor for /r/ to appear as [x]. [x] is the third most used surface form after [r] and [r̝]
# # #### PLUS         0.05957    0.01777   3.351 0.000804 ***
#   
