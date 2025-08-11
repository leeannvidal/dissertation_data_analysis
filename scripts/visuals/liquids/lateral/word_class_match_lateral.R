# scripts/visuals/liquids/lateral/word_class_match_lateral.R


#Calculate chi-square to include in plot WORD_CLASS
## Create a Contingency Table
lateral_WORD_CLASS_match <- table(lateral$PHONETIC_PHONOLOGICAL_AGREEMENT, lateral$WORD_CLASS)
# 
# # Run χ² function -
chi_label_WORD_CLASS_lateral_match <- create_chi_label(chisq.test(lateral_WORD_CLASS_match))
# 
# 
WORD_CLASS_plot_lateral_match <- lateral %>%
  ggplot(aes(WORD_CLASS, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  geom_text(
    aes(label = ifelse(WORD_CLASS == "noun", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    size = 7) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  geom_text(
    aes(label = ifelse(WORD_CLASS == "adverb" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", chi_label_WORD_CLASS_lateral_match, "")),
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
    title = "What is the proportional Phonetic/Phonological Agreement distribution\n of laterals for Word Class?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers"
    ) +
  scale_fill_economist() +
  basic_custom_theme()


WORD_CLASS_plot_lateral_match

# ggsave("output/plots/liquids/lateral/WORD_CLASS_plot_lateral_match.pdf", WORD_CLASS_plot_lateral_match,device = cairo_pdf, width = 12, height = 7) 