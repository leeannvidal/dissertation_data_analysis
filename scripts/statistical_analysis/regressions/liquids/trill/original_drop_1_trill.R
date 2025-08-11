
max_glm <- glm(MISMATCH~LOG_LEX_FREQ_DF_N +
                 MS_PER_SYLL_SCALED +
                 POS_WORD +
                 SYL_TYPE +
                 STRESS +
                 SEX +
                 COUNTRY_OF_ORIGIN +
                 PLUS, data = trill, family = "binomial")

glmer_trill <- glmer(MISMATCH ~ 
                           LOG_LEX_FREQ_DF_N + 
                           MS_PER_SYLL_SCALED +
                           POS_WORD + 
                           # SYL_TYPE + 
                           # STRESS + 
                           # SEX + 
                           COUNTRY_OF_ORIGIN + 
                           PLUS + (1 | SPEAKER), 
                         data = trill, 
                         family = binomial,
                         na.action = "na.fail",
                         control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 10000)))

summary(max_glm)
summary(glmer_trill)


# drop1(max_glm,test = "Chisq")
drop1(glmer_trill,test = "Chisq")
best_model_drop1 <- drop1(glmer_trill, test = "Chisq")
print(best_model_drop1)

# library(sjPlot)
# tab_model(glmer_trill, p.style = "numeric_stars", transform = NULL,show.re.var = FALSE, show.reflvl = TRUE)

### Plot the AIC Impact using the drop1 best model

# tidy_max_glm <- tidy(drop1(max_glm,test = "Chisq"))
tidy_best_model_trill <- tidy(drop1(glmer_trill,test = "Chisq"))

# Convert drop1 output to a data frame
tidy_best_model_trill <- as.data.frame(best_model_drop1)

# Rename columns for clarity and consistency
names(tidy_best_model_trill)[names(tidy_best_model_trill) == "Pr(Chi)"] <- "p_value"
# names(tidy_best_model_trill)[names(tidy_best_model_trill) == "LRT"] <- "LR_test"

# Add new columns: AIC difference and categorized p-values
tidy_best_model_trill <- tidy_best_model_trill %>%
  mutate(AIC_incr_if_drop = AIC - AIC[1]) %>%
  mutate(p_value = ifelse(p_value > 0.05, ">.05", "<.05"))

# View the resulting tidy data frame
tidy_best_model_trill


# Label the Predictors column to the data frame (row names represent the terms)
tidy_best_model_trill <- tidy_best_model_trill %>%
  rownames_to_column(var = "Predictors") %>%
  filter(Predictors != "<none>")

# Now, filter, modify x-axis labels using replace_row_names, and plot
AIC_Impact_plot_Trill <- tidy_best_model_trill %>%
  ggplot(aes(x = reorder(Predictors, AIC_incr_if_drop), y = AIC_incr_if_drop, color = p_value)) +
  geom_point(size = 4) +
  coord_flip() +
  geom_hline(yintercept = 0, color = "gray60", linetype = "dashed") +
  basic_custom_theme() +
  # ylab("AIC increase if dropped") +
  # xlab("Predictor Variable \n") +
  labs(
    x= "Predictor Variable \n", 
    y= "AIC increase if dropped\n", 
    # fill="", 
    title = "Impact of Predictor Variables on AIC in Mixed Effects Trill Model",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers"
  ) +
  # Apply the label replacement function using scale_x_discrete
  scale_x_discrete(labels = function(x) replace_row_names(x))

ggsave("output/plots/liquids/trill/AIC_impact_Trill.pdf", AIC_Impact_plot_Trill,device = cairo_pdf, width = 12, height = 7)

### transfer printed code to latex

### Constraint Hierarchy Table
# names(tidy_max_glm)
# library(dplyr)
# class(tidy_max_glm)

tidy_best_model_trill_table <- tidy_best_model_trill %>%
  dplyr::select(Predictors,AIC_incr_if_drop,p_value) %>%
  arrange(desc(AIC_incr_if_drop))

# Apply the function to change the labels to the "Predictors" column
tidy_best_model_trill_table <- tidy_best_model_trill_table %>%
  mutate(Predictors = replace_row_names(Predictors))

# Display the updated table
tidy_best_model_trill_table

# Apply the row label function to the "Predictors" column
tidy_best_model_trill_table <- tidy_best_model_trill_table %>%
  mutate(Predictors = replace_row_names(Predictors)) %>%
  # Round the AIC column to 1 digit and p-value to 2 digits
  mutate(AIC_incr_if_drop = round(AIC_incr_if_drop, 1))

# Apply the function to the column names of the data frame
updated_col_names <- replace_column_names(tidy_best_model_trill_table, names_for_columns)

# Apply \textsc{} to column names
col_names_latex <- sapply(updated_col_names, function(name) paste0("\\textsc{", name, "}"))

# Create the LaTeX table with column names in small caps and prevent escaping
kable(tidy_best_model_trill_table, format = "latex", booktabs = TRUE, col.names = col_names_latex, 
      caption = "AIC Increase for Predictor Variables in Mixed Effects Model of Trill Mismatches", 
      escape = FALSE) %>%
  kable_styling(latex_options = "striped")

