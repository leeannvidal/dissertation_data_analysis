# scripts/visuals/liquids/trill/syllable_type_match_trill.R

#Calculate chi-square to include in plot SYL_TYPE
## Create a Contingency Table
trill_SYL_TYPE_match <- table(trill$PHONETIC_PHONOLOGICAL_AGREEMENT, trill$SYL_TYPE)

# # Run χ² function -
chi_label_SYL_TYPE_trill_match <- create_chi_label(chisq.test(trill_SYL_TYPE_match))

Syllable_Type_plot_Trill_match <- trill %>%
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
    aes(label = ifelse(SYL_TYPE == "closed" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", chi_label_SYL_TYPE_trill_match, "")),
    position = position_fill(vjust = 0.55), # Adjust vertical position to center
    color = "white", size = 6, stat = "count") +
  geom_hline(
    yintercept = overall_proportion_trill, 
    linetype = "dashed", 
    color = "white", 
    size = 1
  ) +
  labs(
    x= "\nSyllable Type", 
    y= "Proportion\n", 
    fill="", 
    title = "What is the proportional Phonetic/Phonological Agreement distribution\n of trills for Syllable Type?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers"
    ) +
  scale_fill_economist() +
  basic_custom_theme()

Syllable_Type_plot_Trill_match

# ggsave("output/plots/liquids/trill/Syllable_Type_plot_Trill_match.pdf", Syllable_Type_plot_Trill_match,device = cairo_pdf, width = 12, height = 7) 