# scripts/visuals/liquids/tap/PLUS_x_Mismatch_Rate_tap_subset.R

## TO CREATE TAP SUBSET VISUAL

#Extract beta and pvalue from regression summary and create label
# tap_model <- readRDS("data/regressions/best_model_tap.rds")
# summary(tap_model)
# beta_label_PLUS_tap_mismatch <- get_estimate_and_pvalues(predictor = "PLUS", model_path = "data/regressions/best_model_tap.rds")

# Plot the data - tap

# Create the plot with annotations for R^2 and p-value
PLUS_MISMATCH_RATE_tap_subset <- rates_all_variables %>%
  # ggplot(aes(x = PLUS, y = RATE_MISMATCH_TAP_SUBSET, color = COUNTRY_OF_ORIGIN)) +
  ggplot(aes(x = PLUS, y = RATE_MISMATCH_TAP_SUBSET)) +
  geom_point(size = 5) +  # Increase point size
  # geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
  geom_smooth(method = "lm", se = TRUE, color = "#50625A") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", y = "Mismatch Rate (%)\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) and Phonetic-Phonological Mismatch Rates for /ɾ/\n among Puerto Rican and Dominican Spanish Speakers in Boston",
       # title = "Association between Percent Life in the US (PLUS) \nand Phonetic-Phonological Mismatch Rates\n",
       subtitle = "Tap Mismatch Lateral" #,
       # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation"
       ) +
  basic_custom_theme() 
# +
#   # Annotating with the label at the bottom-right
#   annotate("label",
#            x = min(rates_all_variables$PLUS),  # Near the max x-value
#            y = max(rates_all_variables$RATE_MISMATCH_TAP_SUBSET),   # Near the min y-value
#            label = beta_label_PLUS_tap_mismatch,
#            hjust = 0.25, vjust = 1, size = 5, color = "black",  # Right aligned, bottom aligned
#            label.size = NA,  # No border around the box
#            fill = "#7FACA2", # Background color of the box
#            fontface = "bold", # Bold text
#            label.padding = unit(1, "lines"))  # Padding inside the box

# "#9A4F41"
PLUS_MISMATCH_RATE_tap_subset

# ggsave("output/plots/liquids/tap/PLUS_MISMATCH_RATE_tap_subset.pdf", PLUS_MISMATCH_RATE_tap_subset,device = cairo_pdf, width = 12, height = 10)
ggsave("output/plots/liquids/tap/PLUS_MISMATCH_RATE_tap_subset.pdf", PLUS_MISMATCH_RATE_tap_subset,device = cairo_pdf, width = 8, height = 8)

