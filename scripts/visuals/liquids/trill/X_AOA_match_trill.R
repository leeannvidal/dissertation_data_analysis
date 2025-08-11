# scripts/visuals/liquids/trill/AOA_match_trill.R

#Calculate chi-square to include in plot AOA
## Create a Contingency Table
trill_AOA_match <- table(trill$PHONETIC_PHONOLOGICAL_AGREEMENT, trill$AOA)
# 
# # Run χ² function -
chi_label_AOA_trill_match <- create_chi_label(chisq.test(trill_AOA_match))
# 
chi_label_AOA_trill_match
# 
unique(trill$AOA)

### MORE MISMATCH W LOWER AOA - should use immigration category instead of this.
# Scatter Plot with Jitter

ggplot(trill_mismatch, aes(x = PHONETIC_PHONOLOGICAL_AGREEMENT, y = AOA)) +
  geom_jitter(width = 0.2) +
  labs(x = "Phonetic/Phonological Agreement", y = "Age of Arrival") +
  theme_minimal()

AOA_plot_Trill_match <- trill %>%
  ggplot(aes(AOA, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  # geom_text(
  #   aes(label = ifelse(AOA == "female", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
  #   position = position_fill(vjust = 0.5), # Position labels near the top of the bar
  #   color = "white", # Set label color for visibility
  #   stat = "count", # Use count to place labels according to the data distribution
  #   size = 7) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  # geom_text(
  #   aes(label = ifelse(AOA == "male" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", chi_label_AOA_trill_match, "")),
  #   position = position_fill(vjust = 0.55), # Adjust vertical position to center
  #   color = "white", size = 6, stat = "count") +
  geom_hline(
    yintercept = overall_proportion_trill, 
    linetype = "dashed", 
    color = "white", 
    size = 1
  ) +
  labs(
    x= "\nAOA", 
    y= "Proportion\n", 
    fill="", 
    title = "What is the proportional Phonetic/Phonological Agreement distribution\n of trills for Age of Arrival?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers"
  ) +
  scale_fill_economist() +
  basic_custom_theme()


AOA_plot_Trill_match

# ggsave("output/plots/liquids/trill/AOA_plot_Trill_match.pdf", AOA_plot_Trill_match,device = cairo_pdf, width = 12, height = 7) 
