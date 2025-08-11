# scripts/visuals/liquids/trill/previous_sound_category_match_trill.R

#Calculate chi-square to include in plot PREV_SOUND_CATEGORY
## Create a Contingency Table
trill_PREV_SOUND_CATEGORY_match <- table(trill$PHONETIC_PHONOLOGICAL_AGREEMENT, trill$PREV_SOUND_CATEGORY)

# # Run χ² function -
chi_label_PREV_SOUND_CATEGORY_trill_match <- create_chi_label(chisq.test(trill_PREV_SOUND_CATEGORY_match))

PREV_SOUND_CATEGORY_plot_Trill_match <- trill %>%
  ggplot(aes(PREV_SOUND_CATEGORY, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  # Label for phonetic agreement on one of the bars
  geom_text(
    aes(label = ifelse(PREV_SOUND_CATEGORY == "consonant", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    size = 7) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  geom_text(
    aes(label = ifelse(PREV_SOUND_CATEGORY == "vowel" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", chi_label_PREV_SOUND_CATEGORY_trill_match, "")),
    position = position_fill(vjust = 0.55), # Adjust vertical position to center
    color = "white", size = 6, stat = "count") +
  geom_hline(
    yintercept = overall_proportion_trill, 
    linetype = "dashed", 
    color = "white", 
    size = 1
  ) +
  labs(
    x= "\nPrevious Sound Category", 
    y= "Proportion\n", 
    fill="", 
    title = "What is the proportional Phonetic/Phonological Agreement distribution\n of trills for Previous Sound Category?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers"
      ) +
  scale_fill_economist() +
  basic_custom_theme()

PREV_SOUND_CATEGORY_plot_Trill_match

# ggsave("output/plots/liquids/trill/PREV_SOUND_CATEGORY_plot_Trill_match.pdf", PREV_SOUND_CATEGORY_plot_Trill_match,device = cairo_pdf, width = 12, height = 7) 
