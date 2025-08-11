# scripts/visuals/liquids/lateral/log_frequency_x_mismatch_lateral.R

# Calculate the Percentage of Mismatch for Each Log Frequency
  ## Group the data by log frequency and then calculate the percentage of mismatch

lateral_percent_mismatch_log <- lateral %>%
  group_by(LOG_LEX_FREQ_DF_N) %>%
  summarize(
    total_count = n(),
    mismatch_count = sum(PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch"),
    percent_mismatch = (mismatch_count / total_count) * 100
  )

# ggplot(lateral_percent_mismatch, aes(x = LOG_LEX_FREQ_DF_N, y = percent_mismatch)) +
#   geom_point() +
#   geom_smooth(method = "lm", se = TRUE, color = "blue", linetype = "dashed") + # Optional: Adds a linear fit line
#   labs(x = "Log Frequency", y = "Percent Mismatch") +
#   theme_minimal()

# Create the plot
log_frequency_mismatch_lateral <- lateral_percent_mismatch_log %>%
  ggplot(aes(x = LOG_LEX_FREQ_DF_N, y = percent_mismatch)) +
  # geom_point(size = 5) +  # Increase point size (use this one for individual plot)
  geom_point(size = 3) +  # Smaller geom size (use this one for ggarrange)
  geom_smooth(method = "lm", se = TRUE, color = "black", linetype = "dashed") +  # Showing confidence interval
  labs(x = "Log Frequency", 
       y = "Mismatch Rate (%)\n", 
       title = "Percent mismatch of laterals within each log frequency",
       caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation"
  ) +
  # scale_fill_economist() +
  basic_custom_theme()

  
  log_frequency_mismatch_lateral
  
  # NOTE TO SELF - Dispersion: Notice if there is more variation in mismatch percentages at different log frequency levels, 
  # which could indicate that other factors may be influencing the percentage of mismatch.