# scripts/visuals/liquids/tap/word_class_match_tap.R


#Calculate chi-square to include in plot WORD_CLASS
## Create a Contingency Table
tap_WORD_CLASS_match <- table(tap$PHONETIC_PHONOLOGICAL_AGREEMENT, tap$WORD_CLASS)
# 
# # Run χ² function -
chi_label_WORD_CLASS_tap_match <- create_chi_label(chisq.test(tap_WORD_CLASS_match))
# 
# 
WORD_CLASS_plot_tap_match <- tap %>%
  ggplot(aes(WORD_CLASS, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  geom_text(
    aes(label = ifelse(WORD_CLASS == "noun", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    size = 7) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  geom_text(
    aes(label = ifelse(WORD_CLASS == "adverb" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", chi_label_WORD_CLASS_tap_match, "")),
    position = position_fill(vjust = 0.55), # Adjust vertical position to center
    color = "white", size = 6, stat = "count") +
  geom_hline(
    yintercept = overall_proportion, 
    linetype = "dashed", 
    color = "white", 
    size = 1
  ) +
  labs(
    x= "\nWord Class", 
    y= "Proportion\n", 
    fill="", 
    title = "What is the proportional Phonetic/Phonological Agreement distribution\n of taps for Word Class?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers"
    ) +
  scale_fill_economist() +
  basic_custom_theme()


WORD_CLASS_plot_tap_match

# ggsave("output/plots/liquids/tap/WORD_CLASS_plot_tap_match.pdf", WORD_CLASS_plot_tap_match,device = cairo_pdf, width = 12, height = 7) 