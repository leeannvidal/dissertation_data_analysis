# scripts/visuals/coda_s/PLUS_x_MISMATCH_RATE_CODA_S_SIB.R

# Plot the data - coda s

# Create the plot with annotations for R^2 and p-value
PLUS_x_RATE_MISMATCH_CODA_S_SIB <- rates_all_SIB %>%
  ggplot(aes(x = PLUS, y = RATE_MISMATCH_CODA_S)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "#50625A") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", y = "Mismatch Rate (%)\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) \n and Mismatch Rates for Coda /s/ among \n Puerto Rican and Dominican Spanish Speakers in Boston\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) \nand Phonetic-Phonological Mismatch Rates\n",
       subtitle = "coda /s/\n",
       # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n"
  ) +
  basic_custom_theme()

PLUS_x_RATE_MISMATCH_CODA_S_SIB

ggsave("output/plots/coda_s/PLUS_coda_s_mismatch_SIB.pdf", PLUS_x_RATE_MISMATCH_CODA_S_SIB,device = cairo_pdf, width = 8, height = 8)


# 9A4F41
# f1b348