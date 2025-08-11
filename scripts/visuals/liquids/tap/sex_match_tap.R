# scripts/visuals/liquids/tap/sex_match_tap.R

#Extract beta and pvalue from regression summary and create label
# tap_model <- readRDS("data/regressions/best_model_tap.rds")
# summary(tap_model)
beta_label_SEXmale_mismatch_lateral <- get_estimate_and_pvalues(predictor = "SEXmale", model_path = "data/regressions/best_model_tap.rds")

#Create SEX Plot

SEX_plot_tap_match <- tap %>%
  ggplot(aes(SEX, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  geom_text(
    aes(label = ifelse(SEX == "female", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    family = "charis",
    stat = "count", # Use count to place labels according to the data distribution
    size = 8) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  # geom_text(
  #   aes(label = ifelse(SEX == "male" & PHONETIC_PHONOLOGICAL_AGREEMENT == "mismatch", beta_label_SEXmale_mismatch_lateral, "")),
  #   position = position_fill(vjust = 0.65), # Adjust vertical position to center
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
    # title = "What is the proportional Phonetic/Phonological Agreement distribution\n of taps for Sex?",
    # title = "Association between Sex \nand Phonetic-Phonological Agreement\n",
    title = "Sex",
    # subtitle = "Tap"
    # caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers\n"
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  basic_custom_theme()


SEX_plot_tap_match

ggsave("output/plots/liquids/tap/SEX_plot_tap_mismatch.pdf", SEX_plot_tap_match,device = cairo_pdf, width = 11, height = 7)
