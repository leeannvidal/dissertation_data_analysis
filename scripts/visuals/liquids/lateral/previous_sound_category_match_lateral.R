# scripts/visuals/liquids/lateral/previous_sound_category_match_lateral.R

#Extract beta and pvalue from regression summary and create label
# lateral_model<- readRDS("data/regressions/best_model_lateral.rds")
summary(lateral_model) 
beta_label_PREV_SOUND_CAT_pause_mismatch_lateral <- get_estimate_and_pvalues(predictor = "PREV_SOUND_CATEGORYpause", model_path = "data/regressions/best_model_lateral.rds")
beta_label_PREV_SOUND_CAT_vowel_mismatch_lateral <- get_estimate_and_pvalues(predictor = "PREV_SOUND_CATEGORYvowel", model_path = "data/regressions/best_model_lateral.rds")


PREV_SOUND_CATEGORY_plot_lateral_match <- lateral %>%
  ggplot(aes(PREV_SOUND_CATEGORY, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  # Label for phonetic agreement on one of the bars
  geom_text(
    aes(label = ifelse(PREV_SOUND_CATEGORY == "consonant", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # # Position labels in center
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    family = "charis",
    size = 8) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  # geom_text(
  #   aes(label = ifelse(PREV_SOUND_CATEGORY == "vowel" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", beta_label_PREV_SOUND_CAT_vowel_mismatch_lateral, "")),
  #   position = position_fill(vjust = 0.55), # Adjust vertical position to center
  #   color = "white", size = 8, family = "charis", stat = "count") +
  # geom_text(
  #   aes(label = ifelse(PREV_SOUND_CATEGORY == "pause" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", beta_label_PREV_SOUND_CAT_pause_mismatch_lateral, "")),
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
    title= "Previous Sound Category", 
    y= "Proportion\n", 
    fill="", 
    # title = "What is the proportional Phonetic/Phonological Agreement distribution\n of laterals for Previous Sound Category?",      
    # title = "Association between Previous Sound Category \nand Phonetic-Phonological Mismatch Rates\n",
    # subtitle = "Lateral",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation") +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  # scale_fill_economist() +
  basic_custom_theme()

PREV_SOUND_CATEGORY_plot_lateral_match

ggsave("output/plots/liquids/lateral/PREV_SOUND_CATEGORY_plot_lateral_match.pdf", PREV_SOUND_CATEGORY_plot_lateral_match,device = cairo_pdf, width = 11, height = 7)
