# scripts/visuals/pronouns/PLUS_x_RATE_PRONOUNS_PRESENT.R

# Plot the data - pronouns

# Create the plot with annotations for R^2 and p-value
PLUS_RATE_PRONOUNS_PRESENT <- rates_all_variables %>%
  ggplot(aes(x = PLUS, y = RATE_PRONOUNS_PRESENT)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", y = "Presence Rate (%)\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) \n and Present Rates for Pronouns among \n Puerto Rican and Dominican Spanish Speakers in Boston\n",
       # title = "Association between Percent Life in the US (PLUS) \n and Pronoun Presence\n",
       subtitle = "Pronouns",
       # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n"
       ) +
  basic_custom_theme()

PLUS_RATE_PRONOUNS_PRESENT

ggsave("output/plots/pronouns/PLUS_present_pronouns.pdf", PLUS_RATE_PRONOUNS_PRESENT,device = cairo_pdf, width = 8, height = 8)
