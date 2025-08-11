# scripts/visuals/liquids/trill/PLUS_x_Mismatch_Rate_DR_trill.R


### Run linear regression to label plot

# Fit the linear model
PLUS_model_trill_pr <- lm(RATE_MISMATCH_TRILL ~ PLUS, data = pr_rates_mismatch_all)

# # Run R² function to create label-
PLUS_r2_pvalue_label_trill_pr <- create_regression_label(summary(PLUS_model_trill_pr))

# Plot the data - TRILL

# Create the plot with annotations for R^2 and p-value
PLUS_MISMATCH_RATE_DR_trill <- pr_rates_mismatch_all %>%
  ggplot(aes(x = PLUS, y = RATE_MISMATCH_TRILL)) +
  # geom_point(size = 5) +  # Increase point size (use this one for individual plot)
  geom_point(size = 3) +  # Smaller geom size (use this one for ggarrange)
  geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
  geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", y = "Mismatch Rate (%)\n",
       title = "Rate of Phonetic-Phonological Mismatch for /r/ by PLUS for Dominican Speakers",
       caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation"
  ) +
  basic_custom_theme() +
  scale_y_continuous(limits = c(0, 100))  # Set the y-axis limits from 0 to 100

PLUS_MISMATCH_RATE_DR_trill