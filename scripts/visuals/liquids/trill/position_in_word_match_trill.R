# scripts/visuals/liquids/trill/position_in_word_match_trill.R

#Extract beta and pvalue from regression summary and create label
# summary(trill_model)
beta_label_POS_WORD_trill_mismatch <- get_estimate_and_pvalues(predictor = "POS_WORDinternal", model_path = "data/regressions/best_model_trill.rds")

#Create PIW Plot

Position_in_Word_plot_Trill_match <- trill %>%
  ggplot(aes(POS_WORD, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) + # Label for phonetic agreement on one of the bars
  geom_text(
    aes(label = ifelse(POS_WORD == "initial", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    family = "charis",
    size = 8) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  # geom_text(
  #   aes(label = ifelse(POS_WORD == "internal" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", beta_label_POS_WORD_trill_mismatch, "")),
  #   position = position_fill(vjust = 0.55), # Adjust vertical position to center
  #   color = "white", size = 8, family = "charis", stat = "count") +
  # geom_hline(
  #   yintercept = overall_proportion_trill, 
  #   linetype = "dashed", 
  #   color = "white", 
  #   size = 1
  # ) +
  labs(
    x= "",
    title= "Position in Word", 
    y= "Proportion\n", 
    fill="", 
    # title = "What is the proportional Phonetic/Phonological Agreement distribution\n for Position in Word?",
    # title = "Association between Position in Word \nand Phonetic-Phonological Agreement\n",
    # subtitle = "Trill"
    # caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers\n"
    ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  # scale_fill_economist() +
  basic_custom_theme()

Position_in_Word_plot_Trill_match

# save to pdf
ggsave("output/plots/liquids/trill/Position_in_Word_plot_Trill_match.pdf", Position_in_Word_plot_Trill_match,device = cairo_pdf, width = 11, height = 7)

