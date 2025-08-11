# scripts/visuals/liquids/trill/city_of_origin_match_trill.R

#Calculate chi-square to include in plot CITY_OF_ORIGIN
## Create a Contingency Table
trill_CITY_OF_ORIGIN_match <- table(trill$PHONETIC_PHONOLOGICAL_AGREEMENT, trill$CITY_OF_ORIGIN)
# 
# # Run χ² function -
chi_label_CITY_OF_ORIGIN_trill_match <- create_chi_label(chisq.test(trill_CITY_OF_ORIGIN_match))
# 
chi_label_CITY_OF_ORIGIN_trill_match
# 
unique(trill$CITY_OF_ORIGIN)

CITY_OF_ORIGIN_plot_Trill_match <- trill %>%
  ggplot(aes(CITY_OF_ORIGIN, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  # geom_text(
  #   aes(label = ifelse(CITY_OF_ORIGIN == "female", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
  #   position = position_fill(vjust = 0.5), # Position labels near the top of the bar
  #   color = "white", # Set label color for visibility
  #   stat = "count", # Use count to place labels according to the data distribution
  #   size = 7) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  # geom_text(
  #   aes(label = ifelse(CITY_OF_ORIGIN == "male" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", chi_label_CITY_OF_ORIGIN_trill_match, "")),
  #   position = position_fill(vjust = 0.55), # Adjust vertical position to center
  #   color = "white", size = 6, stat = "count") +
  geom_hline(
    yintercept = overall_proportion_trill, 
    linetype = "dashed", 
    color = "white", 
    size = 1
  ) +
  labs(
    x= "\nCity of Origin", 
    y= "Proportion\n", 
    fill="", 
    title = "What is the proportional Phonetic/Phonological Agreement distribution\n of trills for City of Origin?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers"
  ) +
  scale_fill_economist() +
  basic_custom_theme()


CITY_OF_ORIGIN_plot_Trill_match

# ggsave("output/plots/liquids/trill/CITY_OF_ORIGIN_plot_Trill_match.pdf", CITY_OF_ORIGIN_plot_Trill_match,device = cairo_pdf, width = 12, height = 7) 
