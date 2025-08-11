# scripts/visuals/liquids/tap/following_sound_category_match_tap.R

#Extract beta and pvalue from regression summary and create label
# tap_model<- readRDS("data/regressions/best_model_tap.rds")
# summary(tap_model) 
beta_label_PREV_SOUND_CAT_pause_mismatch_tap <- get_estimate_and_pvalues(predictor = "FOLL_SOUND_CATEGORYpause", model_path = "data/regressions/best_model_tap.rds")
beta_label_PREV_SOUND_CAT_vowel_mismatch_tap <- get_estimate_and_pvalues(predictor = "FOLL_SOUND_CATEGORYvowel", model_path = "data/regressions/best_model_tap.rds")


FOLL_SOUND_CATEGORY_plot_tap_match <- tap %>%
  ggplot(aes(FOLL_SOUND_CATEGORY, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  # Label for phonetic agreement on one of the bars
  geom_text(
    aes(label = ifelse(FOLL_SOUND_CATEGORY == "consonant", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.4), # Position labels in center
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    family = "charis",
    size = 8) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  # geom_text(
  #   aes(label = ifelse(FOLL_SOUND_CATEGORY == "vowel" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", beta_label_PREV_SOUND_CAT_vowel_mismatch_tap, "")),
  #   position = position_fill(vjust = 0.55), # Adjust vertical position to center
  #   color = "white", size = 8, family = "charis", stat = "count") +
  # geom_text(
  #   aes(label = ifelse(FOLL_SOUND_CATEGORY == "pause" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", beta_label_PREV_SOUND_CAT_pause_mismatch_tap, "")),
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
    # title = "What is the proportional Phonetic/Phonological Agreement distribution\n of taps for Following Sound Category?",      
    # title = "Association between Following Sound Category \nand Phonetic-Phonological Mismatch Rates\n",
    title = "Following Sound Category",
    # subtitle = "Tap"
    # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n"
    ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  basic_custom_theme()

FOLL_SOUND_CATEGORY_plot_tap_match

ggsave("output/plots/liquids/tap/FOLL_SOUND_CATEGORY_plot_tap_match.pdf", FOLL_SOUND_CATEGORY_plot_tap_match,device = cairo_pdf, width = 11, height = 7)
