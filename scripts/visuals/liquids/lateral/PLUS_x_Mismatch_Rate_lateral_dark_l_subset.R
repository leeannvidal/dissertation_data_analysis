# scripts/visuals/liquids/lateral/PLUS_x_Mismatch_Rate_lateral_dark_l_subset.R

# #Extract beta and pvalue from regression summary and create label - PLUS didnt make it into model
# # summary(lateral_model)
# beta_label_PLUS_lateral_mismatch <- get_estimate_and_pvalues(predictor = "PLUS", model_path = "data/regressions/best_model_lateral.rds")


# Plot the data - lateral mismatch dark l

# Create the plot with annotations for R^2 and p-value 
# PLUS_MISMATCH_RATE_lateral_dark_l_subset <- lateral_subset_darkl %>% ## token level
  PLUS_MISMATCH_RATE_lateral_dark_l_subset <- rates_all_variables %>% ## Speaker level
  # ggplot(aes(x = PLUS, y = RATE_MISMATCH_LATERAL, color = COUNTRY_OF_ORIGIN)) +
  # ggplot(aes(x = PLUS, y = MISMATCH)) + ## token level
  ggplot(aes(x = PLUS, y = RATE_MISMATCH_LATERAL_SUBSET)) + ## Speaker level
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "#50625A") +  # Showing confidence interval
  # geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "PLUS", y = "Mismatch Rate (%)\n",
       # title = "\nAssociation between Percent Life in the US (PLUS) \n and Phonetic-Phonological Mismatch Rates\n among Puerto Rican and Dominican Spanish Speakers in Boston"
       # title = "\nAssociation between Percent Life in the US (PLUS) \nand Phonetic-Phonological Mismatch Rates\n",
       subtitle = "Lateral Mismatch dark-l\n",
       # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n"
       ) +
  basic_custom_theme()

# annotate("label", x = 0, y = Inf, label = chi_label_lateral_PHONO_AGREEMENT_by_PLUS,
#          hjust = -0.1, vjust = 1.5, size = 5, color = "black",
#          label.size = NA, # No border around the box
#          fill = "lightblue", # Background color of the box
#          fontface = "bold", # Bold text
#          label.padding = unit(1, "lines"))  # Padding inside the box

PLUS_MISMATCH_RATE_lateral_dark_l_subset

ggsave("output/plots/liquids/lateral/PLUS_lateral_mismatch_dark_l_subset.pdf", PLUS_MISMATCH_RATE_lateral_dark_l_subset,device = cairo_pdf, width = 8, height = 8)

