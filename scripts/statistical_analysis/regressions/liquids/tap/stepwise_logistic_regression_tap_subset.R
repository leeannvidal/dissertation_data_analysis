### STEPWISE LOGISTIC REGRESSION - TAPS WITH LATERAL ONLY
# Rescale continuous variables
tap_subset_lateral$MS_PER_SYLL_SCALED <- scale(tap_subset_lateral$MS_PER_SYLL)

# # Create saturation model
# saturation_model_tap_subset_lateral <- glmer(MISMATCH ~ LOG_LEX_FREQ_DF_N + MS_PER_SYLL_SCALED +
#                                 POS_SYL + STRESS + COUNTRY_OF_ORIGIN +
#                                 PLUS + SEX + (1 | SPEAKER),
#                               data = tap_subset_lateral,
#                               family = binomial,
#                               na.action = "na.fail",
#                               control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 50000)))

tap_subset_lateral_dr <- tap_subset_lateral %>% 
  filter(COUNTRY_OF_ORIGIN %in% c("dr")) %>%
  droplevels()

tap_subset_lateral_pr <- tap_subset_lateral %>% 
  filter(COUNTRY_OF_ORIGIN %in% c("pr")) %>%
  droplevels()

saturation_model_tap_subset_lateral <- glmer(MISMATCH ~ 
                                LOG_LEX_FREQ_DF_N + 
                                MS_PER_SYLL_SCALED +
                                POS_SYL + 
                                STRESS + 
                                COUNTRY_OF_ORIGIN +
                                FOLL_SOUND_CATEGORY +
                                PREV_SOUND_CATEGORY +
                                PLUS + 
                                # LIKE_SIM_PR +
                                # LIKE_SIM_DR +
                                SEX + 
                                (1 | SPEAKER),
                              data = tap_subset_lateral,
                              family = binomial,
                              # na.action = "na.exclude",
                              na.action = "na.fail",
                              control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 50000)))

summary(saturation_model_tap_subset_lateral, correlation=TRUE)

##### Check for multicollinearity using VIF (car package)
vif(saturation_model_tap_subset_lateral)

# # Perform model selection
model_selection_tap_subset_lateral <- dredge(saturation_model_tap_subset_lateral)

### View the top models
head(model_selection_tap_subset_lateral)

#### Get the best model
best_model_tap_subset_lateral <- get.models(model_selection_tap_subset_lateral, subset = 1)[[1]]
summary(best_model_tap_subset_lateral)

# Save the model to folder to access when needed
saveRDS(best_model_tap_subset_lateral, "data/regressions/best_model_tap_subset_lateral.rds")
best_model_tap_subset_lateral<- readRDS("data/regressions/best_model_tap_subset_lateral.rds")

#### Run function to create LaTeX table
cat(create_table_w_random_effects(best_model_tap_subset_lateral, caption = "Mixed Effects Model: Tap Match vs. Lateral Mismatch Prediction", label = "tab:tap_subset_lateral_regression", dep_var_name = "Dep. Variable: Mismatch"))
### transfer printed code to latex

# Function uses parameters package to get CI, this is the call
# model_summary_tap_subset_lateral <- model_parameters(best_model_tap_subset_lateral,ci = 0.95, exponentiate = FALSE, effects = "fixed")

#Use this to check that the model added to LaTeX is correct
tab_model(best_model_tap_subset_lateral, transform = NULL) # so that the beta is not exponentiated, which is the norm for logistic regressions

################## DROP 1 ################## 

#### Refine top model with DROP 1
# drop1(best_model_tap_subset_lateral,test = "Chisq") ## Don't need to run this, can run code on line 68 automatically
### best_model_drop1 <- drop1(best_model_tap_subset_lateral, test = "Chisq")
### print(best_model_drop1)

################## PLOT DROP 1 RESULTS ################## 

### Plot the AIC Impact using the drop1 best model
tidy_best_model_tap_subset_lateral <- tidy(drop1(best_model_tap_subset_lateral,test = "Chisq"))

# Convert drop1 output to a data frame
tidy_best_model_tap_subset_lateral <- as.data.frame(tidy_best_model_tap_subset_lateral)

# Replace column names if they are either "Pr(Chi)" or "Pr.Chi"
names(tidy_best_model_tap_subset_lateral)[names(tidy_best_model_tap_subset_lateral) %in% c("Pr(Chi)", "Pr.Chi.")] <- "p_value"
names(tidy_best_model_tap_subset_lateral)[names(tidy_best_model_tap_subset_lateral) %in% c("term")] <- "Predictors"

names(tidy_best_model_tap_subset_lateral)


# Add new columns: AIC difference and categorized p-values, drop <none> row from Predictors column
tidy_best_model_tap_subset_lateral <- tidy_best_model_tap_subset_lateral %>%
  mutate(AIC_incr_if_drop = AIC - AIC[1]) %>%
  mutate(p_value = ifelse(p_value > 0.05, ">.05", "<.05")) %>%
  filter(Predictors != "<none>")

# View the resulting tidy data frame
tidy_best_model_tap_subset_lateral


# # Label the Predictors column to the data frame (row names represent the terms)
# tidy_best_model_tap_subset_lateral <- tidy_best_model_tap_subset_lateral %>%
#   filter(Predictors != "<none>")

# Now, filter, modify x-axis labels using replace_row_names, and plot
AIC_Impact_plot_tap_subset_lateral <- tidy_best_model_tap_subset_lateral %>%
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
    # y= "AIC increase if dropped\n",
    y= "AIC increase if dropped\n Tap: Lateral Mismatch", 
    # title = "/ɾ/ : [ɾ] & [l]", ### THis is so that the l doesnt get converted to small caps
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    color = "p-value"
  ) +
  # # Override legend point size
  guides(color = guide_legend(override.aes = list(size = 3))) +  # Smaller points in legend
  scale_color_manual(values = custom_green_palette) +  # Custom fill palette
  # Apply the label replacement function using scale_x_discrete
  scale_x_discrete(labels = function(x) replace_row_names(x))

# library(ggtext)
AIC_Impact_plot_tap_subset_lateral

ggsave("output/plots/liquids/tap/AIC_impact_tap_subset_lateral.pdf", AIC_Impact_plot_tap_subset_lateral,device = cairo_pdf, width = 10, height = 7)

### transfer printed code to latex

################## Constraint Hierarchy Table of  DROP 1 RESULTS ################## 
# 
# ## Ditch the table, added AIC values inside figure geompoints above
# # names(tidy_best_model_tap_subset_lateral)
# # library(dplyr)
# # class(tidy_best_model_tap_subset_lateral)
# 
# # Select Columns for Constraint Table, arrange from high to low, and update column names
# tidy_best_model_tap_subset_lateral_table <- tidy_best_model_tap_subset_lateral %>%
#   dplyr::select(Predictors, AIC_incr_if_drop, p_value) %>%
#   arrange(desc(AIC_incr_if_drop)) %>%
#   mutate(Predictors = replace_row_names(Predictors)) %>%  # Update row names
#   mutate(AIC_incr_if_drop = round(AIC_incr_if_drop, 1)) 
# # %>%   # Round the AIC column to 1 digit
# #   rename_with(~ replace_column_names(tidy_best_model_tap_subset_lateral_table, names_for_columns))  # Update column names
# 
# 
# # Display the updated table
# tidy_best_model_tap_subset_lateral_table
# 
# # # Apply the function to the column names of the data frame
# updated_col_names <- replace_column_names(tidy_best_model_tap_subset_lateral_table, names_for_columns)
# 
# # Apply \textsc{} to column names ### No longer needed since Im using shortstack
# # col_names_latex <- sapply(updated_col_names, function(name) paste0("\\textsc{", name, "}"))
# 
# # Create the LaTeX table with column names in small caps and prevent escaping
# kable(tidy_best_model_tap_subset_lateral_table, format = "latex", booktabs = TRUE, col.names = names_for_columns_latex, 
#       caption = "Predictor Impact on AIC in /\\textfishhookr/ to [l] Mismatch Model",
#       # label = "AIC_Impact_table_Tap_lateral_subset",
#       escape = FALSE) %>%
#   kable_styling(latex_options = "striped")
# 
# ### transfer printed code to latex
# 
