# Plot the data - Language Use Spanish

## Calculate the correlation and significance 
# Exclusive Spanish use vs. PLUS
cor_spanish <- cor.test(socio_df_diss$PLUS, socio_df_diss$PERCENT_INTL_SPAN_ONLY)
cor_spanish
# Generate the label
cor_spanish_label <- create_correlation_label(cor_spanish)

# Create the plot with annotations for R^2 and p-value
PLUS_X_Language_Use_SPAN_Plot <- socio_df_diss %>%
  ggplot(aes(x = PLUS, y = PERCENT_INTL_SPAN_ONLY)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = F, color = "black") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", 
       y = "% Interlocutors Spanish Only \n" #,
       # title = "Association between Percent Life in the US (PLUS) \n and % of Spanish only Interlocutors\n",
       # caption = "Data Source: Spanish in Boston Corpus\n") +
      # caption = "Data Source: Spanish in Boston Corpus\nVidal Covas' Dissertation Speakers"
      ) +
  basic_custom_theme() +
annotate("label", x = 50, y = Inf, label = cor_spanish_label,
         hjust = -0.1, vjust = 1.5, size = 8, color = "black",
         label.size = NA, # No border around the box
         fill = "#7FACA2", # Background color of the box
         family = "charis",
         fontface = "bold", # Bold text
         label.padding = unit(1, "lines"))  # Padding inside the box

PLUS_X_Language_Use_SPAN_Plot

ggsave("output/plots/language_use_and_attitudes/PLUS_X_Language_Use_SPAN_Plot.pdf", PLUS_X_Language_Use_SPAN_Plot, device = cairo_pdf, width = 8, height = 8)
