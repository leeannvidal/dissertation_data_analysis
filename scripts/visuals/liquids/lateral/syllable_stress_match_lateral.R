# scripts/visuals/liquids/lateral/syllable_stress_match_lateral.R

#Extract beta and pvalue from regression summary and create label
# lateral_model<- readRDS("data/regressions/best_model_lateral.rds")
# summary(lateral_model) 
beta_label_STRESS_mismatch_lateral <- get_estimate_and_pvalues(predictor = "STRESSunstressed", model_path = "data/regressions/best_model_lateral.rds")


Stress_plot_lateral_match <- lateral %>%
  ggplot(aes(STRESS, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  # Label for phonetic agreement on one of the bar
  geom_text(
    aes(label = ifelse(STRESS == "stressed", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    family = "charis",
    size = 8) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  # geom_text(
  #   aes(label = ifelse(STRESS == "unstressed" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", beta_label_STRESS_mismatch_lateral, "")),
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
    title= "Stress", 
    y= "Proportion\n", 
    fill="", 
    # title = "What is the proportional Phonetic/Phonological Agreement distribution\n of laterals for Stress?",
    # title = "Association between Stress \nand Phonetic-Phonological Mismatch Rates\n",
    # subtitle = "Lateral"
    # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n"
    ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  # scale_fill_economist() +
  basic_custom_theme()

Stress_plot_lateral_match

ggsave("output/plots/liquids/lateral/Stress_plot_lateral_match.pdf", Stress_plot_lateral_match,device = cairo_pdf, width = 11, height = 7)

