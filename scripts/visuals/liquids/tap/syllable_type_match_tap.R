# scripts/visuals/liquids/tap/syllable_type_match_tap.R

#Calculate chi-square to include in plot SYL_TYPE
## Create a Contingency Table
tap_SYL_TYPE_match <- table(tap$PHONETIC_PHONOLOGICAL_AGREEMENT, tap$SYL_TYPE)

# # Run χ² function -
chi_label_SYL_TYPE_tap_match <- create_chi_label(chisq.test(tap_SYL_TYPE_match))

Syllable_Type_plot_tap_match <- tap %>%
  ggplot(aes(SYL_TYPE, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  # Label for phonetic agreement on one of the bars
  geom_text(
    aes(label = ifelse(SYL_TYPE == "open", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    size = 7 ) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  geom_text(
    aes(label = ifelse(SYL_TYPE == "closed" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", chi_label_SYL_TYPE_tap_match, "")),
    position = position_fill(vjust = 0.55), # Adjust vertical position to center
    color = "white", size = 6, stat = "count") +
  geom_hline(
    yintercept = overall_proportion, 
    linetype = "dashed", 
    color = "white", 
    size = 1
  ) +
  labs(
    x= "\nSyllable Type", 
    y= "Proportion\n", 
    fill="", 
    title = "What is the proportional Phonetic/Phonological Agreement distribution\n of taps for Syllable Type?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers"
    ) +
  scale_fill_economist() +
  basic_custom_theme()

Syllable_Type_plot_tap_match

# ggsave("output/plots/liquids/tap/Syllable_Type_plot_tap_match.pdf", Syllable_Type_plot_tap_match,device = cairo_pdf, width = 12, height = 7) 