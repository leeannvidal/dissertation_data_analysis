# scripts/visuals/subject_position/PLUS_x_RATE_GEN_PREVERBAL_SUBJECTS.R

# Plot the data - preverbal general subjects

# Create the plot with annotations for R^2 and p-value
PLUS_x_RATE_GEN_PREVERBAL_SUBJECTS <- rates_all_variables %>%
  ggplot(aes(x = PLUS, y = RATE_GEN_PREVERBAL_SUBJECTS)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", y = "Preverbal Rate (%)\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) \n and Preverbal Rates for General Subjects among \n Puerto Rican and Dominican Spanish Speakers in Boston\n",
       title = "Association between Percent Life in the US (PLUS) \n and Preverbal Subjects\n",
       subtitle = "General Subjects",
       caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n") +
  basic_custom_theme()

PLUS_x_RATE_GEN_PREVERBAL_SUBJECTS

ggsave("output/plots/subject_position/PLUS_preverbal_general_subjects.pdf", PLUS_x_RATE_GEN_PREVERBAL_SUBJECTS,device = cairo_pdf, width = 8, height = 8)
