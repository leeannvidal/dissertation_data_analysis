# scripts/visuals/liquids/trill/PLUS_x_Mismatch_Rate_trill.R


#Extract beta and pvalue from regression summary and create label
# summary(trill_model)
beta_label_PLUS_trill_mismatch <- get_estimate_and_pvalues(predictor = "PLUS", model_path = "data/regressions/best_model_trill.rds")

# Plot the data - TRILL

# Create the plot with annotations for R^2 and p-value
PLUS_MISMATCH_RATE_trill <- rates_mismatch_all %>%
  # ggplot(aes(x = PLUS, y = RATE_MISMATCH_TRILL, color = COUNTRY_OF_ORIGIN)) +
  ggplot(aes(x = PLUS, y = RATE_MISMATCH_TRILL)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(
    x = "", 
    title = "PLUS",
    y = "Mismatch Rate (%)\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) and Phonetic-Phonological Mismatch Rates for /r/\n among Puerto Rican and Dominican Spanish Speakers in Boston",
       # title = "Association between Percent Life in the US (PLUS) \nand Phonetic-Phonological Mismatch Rates\n",
       # subtitle = "Trill"
       # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n"
       ) +
  basic_custom_theme() 
# +
#   # Annotating with the label at the bottom-right
#   annotate("label", 
#            x = max(rates_mismatch_all$PLUS),  # Near the max x-value
#            y = min(rates_mismatch_all$RATE_MISMATCH_TRILL),   # Near the min y-value
#            label = beta_label_PLUS_trill_mismatch,
#            hjust = 1, vjust = 0, size = 8, color = "black",  # Right aligned, bottom aligned
#            label.size = NA,  # No border around the box
#            fill = "#7FACA2", # Background color of the box
#            fontface = "bold", # Bold text
#            family = "charis",
#            label.padding = unit(1, "lines"))  # Padding inside the box

PLUS_MISMATCH_RATE_trill

ggsave("output/plots/liquids/trill/PLUS_mismatch_trill.pdf", PLUS_MISMATCH_RATE_trill,device = cairo_pdf, width = 11, height = 7)
