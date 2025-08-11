# scripts/visuals/liquids/trill/ms_per_syll_x_mismatch_trill.R

#Extract beta and pvalue from regression summary and create label
# summary(trill_model)
beta_label_MS_PER_SYLL_trill_mismatch <- get_estimate_and_pvalues(predictor = "MS_PER_SYLL_SCALED", model_path = "data/regressions/best_model_trill.rds")


#  Boxplot Comparing Speech Rate for Matches vs. Mismatches - This but make it pretty
duration_trill_mismatch <- trill %>% 
  ggplot(aes(x = PHONETIC_PHONOLOGICAL_AGREEMENT, y = MS_PER_SYLL)) +
  geom_boxplot(varwidth=TRUE) +
  labs(
    x = "Agreement", 
    y = "(ms per syllable)\n", 
    # title = "\nMean Duration (ms per syllable)\nby Phonetic/Phonological Agreement\n",
    # title = "Association between Duration (ms per syllable) \nand Phonetic/Phonological Agreement\n",
    title = "Syllable Duration",
    # subtitle = "Trill"
  ) +
    # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n") +
  basic_custom_theme() 
# +
#   annotate("label", 
#            x = .85,  # Rightmost x-value (convert categorical to numeric if necessary)
#            y = max(trill$MS_PER_SYLL),   # Top of the y-axis (max y-value)
#            label = beta_label_MS_PER_SYLL_trill_mismatch,
#            hjust = 1, vjust = 1, size = 7, color = "black",  # Right aligned, top aligned
#            label.size = NA,  # No border around the box
#            fill = "#7FACA2", # Background color of the box
#            fontface = "bold", # Bold text
#            family = "charis",
#            label.padding = unit(1, "lines"))  # Padding inside the box

duration_trill_mismatch

ggsave("output/plots/liquids/trill/duration_trill_mismatch.pdf", duration_trill_mismatch,device = cairo_pdf, width = 11, height = 7)

# 
# # Density Plot to Compare Distributions
# ggplot(trill, aes(x = MS_PER_SYLL, fill = PHONETIC_PHONOLOGICAL_AGREEMENT)) +
#   geom_density(alpha = 0.5) +
#   labs(x = "Speech Rate (ms per syllable)\n", y = "Density\n", fill = "Agreement") +
#   basic_custom_theme()
# 
# # Scatter Plot with Jitter
# 
# ggplot(trill, aes(x = PHONETIC_PHONOLOGICAL_AGREEMENT, y = MS_PER_SYLL)) +
#   geom_jitter(width = 0.2) +
#   labs(x = "Phonetic/Phonological Agreement", y = "Speech Rate (ms per syllable)\n") +
#   basic_custom_theme()
# 
# 
# # Separate Histograms for Each Category
# ggplot(trill, aes(x = MS_PER_SYLL, fill = PHONETIC_PHONOLOGICAL_AGREEMENT)) +
#   geom_histogram(aes(y = ..density..), alpha = 0.5, position = "identity", bins = 30) +
#   labs(x = "Speech Rate (ms per syllable)\n", y = "Frequency\n", fill = "Agreement") +
#   basic_custom_theme()
# 
# 
# # Faceted Histograms
# ggplot(trill, aes(x = MS_PER_SYLL)) +
#   geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black") +
#   facet_wrap(~ PHONETIC_PHONOLOGICAL_AGREEMENT) +
#   labs(x = "Speech Rate (ms per syllable)\n", y = "Frequency\n") +
#   basic_custom_theme()
