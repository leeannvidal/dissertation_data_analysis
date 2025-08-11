# scripts/visuals/liquids/lateral/position_in_word_match_lateral.R

#Calculate chi-square to include in plot POS_WORD

## Create a Contingency Table
lateral_pos_word_match <- table(lateral$PHONETIC_PHONOLOGICAL_AGREEMENT, lateral$POS_WORD)

# # Run χ² function -
chi_label_POS_WORD_lateral_match <- create_chi_label(chisq.test(lateral_pos_word_match))

#Create PIW Plot

Position_in_Word_plot_lateral_match <- lateral %>%
  ggplot(aes(POS_WORD, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) + # Label for phonetic agreement on one of the bars
  geom_text(
    aes(label = ifelse(POS_WORD == "initial", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    size = 7) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  geom_text(
    aes(label = ifelse(POS_WORD == "internal" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", chi_label_POS_WORD_lateral_match, "")),
    position = position_fill(vjust = 0.55), # Adjust vertical position to center
    color = "white", size = 6, stat = "count") +
  geom_hline(
    yintercept = overall_proportion, 
    linetype = "dashed", 
    color = "white", 
    size = 1
  ) +
  # annotate(
  #   "text", x = 1.5, y = overall_proportion + 0.05, label = paste("Overall proportion:", round(overall_proportion * 100, 1), "%"),
  #   size = 5, color = "red", hjust = 0
  # ) +
  labs(
    x= "\nPosition in Word", 
    y= "Proportion\n", 
    fill="", 
    title = "What is the proportional Phonetic/Phonological Agreement distribution\n of laterals in Position in Word?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers"
    ) +
  scale_fill_economist() +
  basic_custom_theme()

Position_in_Word_plot_lateral_match

# save to pdf
# ggsave("output/plots/liquids/lateral/Position_in_Word_plot_lateral_match.pdf", Position_in_Word_plot_lateral_match,device = cairo_pdf, width = 12, height = 7) 