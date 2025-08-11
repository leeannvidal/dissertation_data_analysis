# scripts/visuals/liquids/lateral/sex_match_lateral.R

#Calculate chi-square to include in plot SEX
## Create a Contingency Table
lateral_SEX_match <- table(lateral$PHONETIC_PHONOLOGICAL_AGREEMENT, lateral$SEX)
# 
# # Run χ² function -
chi_label_SEX_lateral_match <- create_chi_label(chisq.test(lateral_SEX_match))
# 
# 
# unique(lateral$SEX)

SEX_plot_lateral_match <- lateral %>%
  ggplot(aes(SEX, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  geom_text(
    aes(label = ifelse(SEX == "female", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    size = 7) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  geom_text(
    aes(label = ifelse(SEX == "male" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", chi_label_SEX_lateral_match, "")),
    position = position_fill(vjust = 0.55), # Adjust vertical position to center
    color = "white", size = 6, stat = "count") +
  geom_hline(
    yintercept = overall_proportion, 
    linetype = "dashed", 
    color = "white", 
    size = 1
  ) +
  labs(
    x= "\nSex", 
    y= "Proportion\n", 
    fill="", 
    title = "What is the proportional Phonetic/Phonological Agreement distribution\n of laterals for Sex?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers"
  ) +
  scale_fill_economist() +
  basic_custom_theme()


SEX_plot_lateral_match

# ggsave("output/plots/liquids/lateral/SEX_plot_lateral_match.pdf", SEX_plot_lateral_match,device = cairo_pdf, width = 12, height = 7) 
