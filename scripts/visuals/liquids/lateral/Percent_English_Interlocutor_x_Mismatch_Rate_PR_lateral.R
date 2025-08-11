# scripts/visuals/liquids/lateral/Percent_English_Interlocutor_x_Mismatch_Rate_PR_lateral.R

### Run linear regression to label plot

# Fit the linear model
PERCENT_INTL_ENG_ONLY_model_lateral_pr <- lm(RATE_MISMATCH_LATERAL ~ PERCENT_INTL_ENG_ONLY, data = pr_rates_mismatch_all)

# # Run R² function to create label-
PERCENT_INTL_ENG_ONLY_r2_pvalue_label_lateral_pr <- create_regression_label(summary(PERCENT_INTL_ENG_ONLY_model_lateral_pr))
# PERCENT_INTL_ENG_ONLY_r2_pvalue_label_lateral_pr
# Plot the data - LATERAL

# Create the plot with annotations for R^2 and p-value
PERCENT_INTL_ENG_ONLY_MISMATCH_RATE_PR_lateral <- pr_rates_mismatch_all %>%
  ggplot(aes(x = PERCENT_INTL_ENG_ONLY, y = RATE_MISMATCH_LATERAL)) +
  # geom_point(size = 5) +  # Increase point size (use this one for individual plot)
  geom_point(size = 3) +  # Smaller geom size (use this one for ggarrange)
  geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
  geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "% of English only with Interlocutors", y = "Mismatch Rate (%)\n",
       title = "Rate of Phonetic-Phonological Mismatch for /l/ by Percent of English only with Interlocutors for Puerto Rican Speakers",
       caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation"
  ) +
  basic_custom_theme() +
  scale_y_continuous(limits = c(0, 100))  # Set the y-axis limits from 0 to 100

PERCENT_INTL_ENG_ONLY_MISMATCH_RATE_PR_lateral
