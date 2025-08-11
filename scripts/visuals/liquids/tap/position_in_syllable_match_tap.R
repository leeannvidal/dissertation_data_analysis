# scripts/visuals/liquids/tap/position_in_syllable_match_tap.R

#Extract beta and pvalue from regression summary and create label
# tap_model <- readRDS("data/regressions/best_model_tap.rds")
# summary(tap_model)
beta_label_POS_SYL_coda_mismatch_lateral <- get_estimate_and_pvalues(predictor = "POS_SYLcoda", model_path = "data/regressions/best_model_tap.rds")

#Create PIS Plot

Position_in_Syllable_plot_tap <- tap %>%
  ggplot(aes(POS_SYL, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) + # Label for phonetic agreement on one of the bars
  geom_text(
    aes(label = ifelse(POS_SYL == "onset", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")),
    position = position_fill(vjust = 0.5), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    family = "charis",
    stat = "count", # Use count to place labels according to the data distribution
    size = 8) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  # geom_text(
  #   aes(label = ifelse(POS_SYL == "coda" & PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", beta_label_POS_SYL_coda_mismatch_lateral, "")),
  #   position = position_fill(vjust = 0.55), # Adjust vertical position to center
  #   color = "white", size = 8, family = "charis", stat = "count") +
  # geom_hline(
  #   yintercept = overall_proportion, 
  #   linetype = "dashed", 
  #   color = "white", 
  #   size = 1
  # ) +
  labs(
    x= "", 
    y= "Proportion\n", 
    fill="", 
    # title = "What is the proportional Phonetic/Phonological Agreement distribution\n of taps for Position in Syllable?",
    # title = "Association between Position in Syllable \nand Phonetic-Phonological Agreement\n",
    title = "Position in Syllable",
    # subtitle = "Tap"
    # caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers\n"
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  basic_custom_theme()

Position_in_Syllable_plot_tap

# save to pdf
ggsave("output/plots/liquids/tap/Position_in_Syllable_plot_tap_mismatch.pdf", Position_in_Syllable_plot_tap,device = cairo_pdf, width = 11, height = 7)