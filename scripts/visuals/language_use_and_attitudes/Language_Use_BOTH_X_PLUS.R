# Plot the data - Language Use Both English and Spanish

#  English & SPAN use vs. PLUS
cor_both_engl_and_span <- cor.test(socio_df_diss$PLUS, socio_df_diss$PERCENT_INTL_BOTH)
cor_both_engl_and_span
# Generate the label
cor_both_engl_and_span_label <- create_correlation_label(cor_both_engl_and_span)

# Create the plot with annotations for R^2 and p-value
PLUS_X_Language_Use_BOTH_Plot <- socio_df_diss %>%
  ggplot(aes(x = PLUS, y = PERCENT_INTL_BOTH)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = F, color = "black") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", y = "% Interlocutors Both\n"#,
       # title = "Association between Percent Life in the US (PLUS) \n and % of English only Interlocutors\n",
       # caption = "Data Source: Spanish in Boston Corpus\n") +
       # caption = "Data Source: Spanish in Boston Corpus\nVidal Covas' Dissertation Speakers"
       ) +
  basic_custom_theme() +
  annotate("label", x = 0, y = Inf, label = cor_both_engl_and_span_label,
           hjust = -0.1, vjust = 1.5, size = 8, color = "black",
           label.size = NA, # No border around the box
           fill = "#7FACA2", # Background color of the box
           family = "charis",
           fontface = "bold", # Bold text
           label.padding = unit(1, "lines"))  # Padding inside the box

PLUS_X_Language_Use_BOTH_Plot

ggsave("output/plots/language_use_and_attitudes/PLUS_X_Language_Use_BOTH_Plot.pdf", PLUS_X_Language_Use_BOTH_Plot, device = cairo_pdf, width = 8, height = 8)
