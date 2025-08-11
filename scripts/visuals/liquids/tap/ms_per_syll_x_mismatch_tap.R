# scripts/visuals/liquids/tap/ms_per_syll_x_mismatch_tap.R

#Extract beta and pvalue from regression summary and create label
# tap_model <- readRDS("data/regressions/best_model_tap.rds")
# summary(tap_model)
beta_label_MS_PER_SYL_tap_mismatch <- get_estimate_and_pvalues(predictor = "MS_PER_SYLL_SCALED", model_path = "data/regressions/best_model_tap.rds")

#  Boxplot Comparing Speech Rate for Matches vs. Mismatches
duration_tap_mismatch <- tap %>% 
  ggplot(aes(x = PHONETIC_PHONOLOGICAL_AGREEMENT, y = MS_PER_SYLL)) +
  geom_boxplot(varwidth=TRUE) +
  # geom_violin() + ##another way to visualize the distribution the sample, like varwidth
  labs(
    x = "Agreement", 
    y = "(ms per syllable)\n", 
    # title = "\nMean Duration (ms per syllable)\nby Phonetic/Phonological Agreement\n",
    # title = "Association between Duration (ms per syllable) \nand Phonetic/Phonological Agreement\n",
    title = "Syllable Duration",
    # subtitle = "Tap"
    # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n"
    ) +
  basic_custom_theme() 
# +
#   annotate("label", 
#            x = .85,  # Rightmost x-value (convert categorical to numeric if necessary)
#            y = max(tap$MS_PER_SYLL),   # Top of the y-axis (max y-value)
#            label = beta_label_MS_PER_SYL_tap_mismatch,
#            hjust = 1, vjust = 1, size = 7, family = "charis", color = "black",  # Right aligned, top aligned
#            label.size = NA,  # No border around the box
#            fill = "#7FACA2", # Background color of the box
#            fontface = "bold", # Bold text
#            label.padding = unit(1, "lines"))  # Padding inside the box

duration_tap_mismatch

ggsave("output/plots/liquids/tap/duration_tap_mismatch.pdf", duration_tap_mismatch,device = cairo_pdf, width = 11, height = 7)
