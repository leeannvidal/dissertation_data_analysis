

# Plot the data - preverbal subjects

# Create the plot with annotations for R^2 and p-value
PLUS_x_RATE_PREVERBAL_SUBJECTS_ALL_SIB <- rates_all_SIB %>%
  ggplot(aes(x = PLUS, y = RATE_PREVERBAL_SUBJECTS)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", y = "Preverbal Rate (%)\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) \n and Preverbal Rates for Pronouns among \n Puerto Rican and Dominican Spanish Speakers in Boston\n",
         # title = "Association between Percent Life in the US (PLUS) \n and Preverbal Subjects among 80 Bostonians\n",
       subtitle = "subject position",
       # caption = "Data Source: Spanish in Boston Corpus\n"
       ) +
  basic_custom_theme()

PLUS_x_RATE_PREVERBAL_SUBJECTS_ALL_SIB

ggsave("output/plots/subject_position/PLUS_preverbal_subjects_ALL_SIB.pdf", PLUS_x_RATE_PREVERBAL_SUBJECTS_ALL_SIB,device = cairo_pdf, width = 8, height = 8)
