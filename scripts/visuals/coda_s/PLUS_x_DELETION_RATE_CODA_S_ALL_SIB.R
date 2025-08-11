# Plot the data - coda s

# Create the plot with annotations for R^2 and p-value
PLUS_x_RATE_DELETION_CODA_S_ALL_SIB <- rates_all_SIB %>%
  ggplot(aes(x = PLUS, y = RATE_DELETION_CODA_S)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "#50625A") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", y = "Deletion Rate (%)\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) \n and Mismatch Rates for Coda /s/ among \n Puerto Rican and Dominican Spanish Speakers in Boston\n",
       # title = "Association between Percent Life in the US (PLUS) \nand Deletion Rates among 80 Bostonians\n",
       subtitle = "coda /s/\n" #,
       # caption = "Data Source: Spanish in Boston Corpus\n"
       ) +
  basic_custom_theme()

PLUS_x_RATE_DELETION_CODA_S_ALL_SIB

ggsave("output/plots/coda_s/PLUS_coda_s_deletion_ALL_SIB.pdf", PLUS_x_RATE_DELETION_CODA_S_ALL_SIB,device = cairo_pdf, width = 8, height = 8)

#50625A
#35413C