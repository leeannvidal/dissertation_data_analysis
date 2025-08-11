# scripts/visuals/liquids/tap/log_frequency_x_mismatch_tap.R

# Calculate the Percentage of Mismatch for Each Log Frequency
  ## Group the data by log frequency and then calculate the percentage of mismatch

tap_percent_mismatch_log <- tap %>%
  group_by(LOG_LEX_FREQ_DF_N) %>%
  summarize(
    total_count = n(),
    mismatch_count = sum(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch"),
    percent_mismatch = (mismatch_count / total_count) * 100
  )

#Extract beta and pvalue from regression summary and create label
# tap_model <- readRDS("data/regressions/best_model_tap.rds")
# summary(tap_model)
beta_label_LOG_FREQ_tap_mismatch <- get_estimate_and_pvalues(predictor = "LOG_LEX_FREQ_DF_N", model_path = "data/regressions/best_model_tap.rds")
# print(beta_label_COUNTRY_OF_ORIGIN_tap_match)

# Create the plot
log_frequency_mismatch_tap <- tap_percent_mismatch_log %>%
  ggplot(aes(x = LOG_LEX_FREQ_DF_N, y = percent_mismatch)) +
  # geom_point(size = 5) +  # Increase point size (use this one for individual plot)
  geom_point(size = 5) +  # Smaller geom size (use this one for ggarrange)
  geom_smooth(method = "lm", se = TRUE, color = "black", linetype = "dashed") +  # Showing confidence interval
  labs(x = "", 
       y = "Mismatch Rate (%)\n", 
       # title = "\n% mismatch within each Log Frequency\n",
       # title = "Association between Log Frequency \nand Mismatch Rate\n",
       title = "Log Lexical Frequency",
       # subtitle = "Tap"
       # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n"
  ) +
  basic_custom_theme() 
# +
#   annotate("label", 
#            x = min(tap_percent_mismatch_log$LOG_LEX_FREQ_DF_N),  # Near the max x-value
#            y = max(tap_percent_mismatch_log$percent_mismatch),   # Near the min y-value
#            label = beta_label_LOG_FREQ_tap_mismatch,
#            hjust = 0, vjust = 1, size = 8, color = "black",  # Right aligned, bottom aligned
#            label.size = NA,  # No border around the box
#            fill = "#7FACA2", # Background color of the box
#            fontface = "bold", # Bold text
#            family = "charis",
#            label.padding = unit(1, "lines"))  # Padding inside the box
  
  log_frequency_mismatch_tap
  
  ggsave("output/plots/liquids/tap/log_frequency_mismatch_tap.pdf", log_frequency_mismatch_tap,device = cairo_pdf, width = 11, height = 7)
  
  # NOTE TO SELF - Dispersion: Notice if there is more variation in mismatch percentages at different log frequency levels, 
  # which could indicate that other factors may be influencing the percentage of mismatch.