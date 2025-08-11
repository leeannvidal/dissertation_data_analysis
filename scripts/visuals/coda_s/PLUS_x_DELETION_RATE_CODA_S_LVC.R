# scripts/visuals/coda_s/PLUS_x_DELETION_RATE_CODA_S.R

# Plot the data - coda s

# Create the plot with annotations for R^2 and p-value
PLUS_x_RATE_DELETION_CODA_S_LVC <- rates_all_variables %>%
  ggplot(aes(x = PLUS, y = RATE_DELETION_CODA_S)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", y = "Deletion Rate (%)\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) \n and Mismatch Rates for Coda /s/ among \n Puerto Rican and Dominican Spanish Speakers in Boston\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) \nand Deletion Rates\n",
       subtitle = "coda /s/\n",
       # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n"
       ) +
  basic_custom_theme()

PLUS_x_RATE_DELETION_CODA_S_LVC

ggsave("output/plots/coda_s/PLUS_coda_s_deletion_LVC.pdf", PLUS_x_RATE_DELETION_CODA_S_LVC,device = cairo_pdf, width = 8, height = 8)