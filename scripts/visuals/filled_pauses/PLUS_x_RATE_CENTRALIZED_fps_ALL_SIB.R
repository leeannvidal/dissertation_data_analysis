# Plot the data - fps

# Create the plot with annotations for R^2 and p-value
PLUS_RATE_CENTRALIZED_fps_ALL_SIB <- rates_all_SIB %>%
  ggplot(aes(x = PLUS, y = RATE_CENTRALIZED_FPS)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", y = "Centralized Rate (%)\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) \n and Centralized Rates for Filled Pauses among \n Puerto Rican and Dominican Spanish Speakers in Boston",
       # title = "Association between Percent Life in the US (PLUS) \n and Centralized Filled Pauses among 80 Bostonians\n",
       subtitle = "Filled Pauses",
       # caption = "Data Source: Spanish in Boston Corpus\n"
       ) +
  basic_custom_theme()

# annotate("label", x = 0, y = Inf, label = chi_label_fps_CENTRALIZATION_by_PLUS,
#          hjust = -0.1, vjust = 1.5, size = 5, color = "black",
#          label.size = NA, # No border around the box
#          fill = "lightblue", # Background color of the box
#          fontface = "bold", # Bold text
#          label.padding = unit(1, "lines"))  # Padding inside the box

PLUS_RATE_CENTRALIZED_fps_ALL_SIB

ggsave("output/plots/filled_pauses/PLUS_centralized_fps_ALL_SIB.pdf", PLUS_RATE_CENTRALIZED_fps_ALL_SIB,device = cairo_pdf, width = 8, height = 8)
