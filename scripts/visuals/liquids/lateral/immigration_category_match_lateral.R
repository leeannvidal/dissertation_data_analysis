# scripts/visuals/liquids/lateral/immigration_category_match_lateral.R

#Calculate chi-square to include in plot IMMIGRATION_CATEGORY
## Create a Contingency Table
lateral_IMMIGRATION_CATEGORY_match <- table(lateral$PHONETIC_PHONOLOGICAL_AGREEMENT, lateral$IMMIGRATION_CATEGORY)
# 
# # Run χ² function -
chi_label_IMMIGRATION_CATEGORY_lateral_match <- create_chi_label(chisq.test(lateral_IMMIGRATION_CATEGORY_match))
# 
# 
unique(lateral$IMMIGRATION_CATEGORY)

IMMIGRATION_CATEGORY_plot_lateral_match <- lateral %>%
  ggplot(aes(IMMIGRATION_CATEGORY, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  geom_text(
    aes(label = ifelse(IMMIGRATION_CATEGORY == "recent_arrival", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    size = 7) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  geom_text(
    aes(label = ifelse(IMMIGRATION_CATEGORY == "us_born" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", chi_label_IMMIGRATION_CATEGORY_lateral_match, "")),
    position = position_fill(vjust = 0.55), # Adjust vertical position to center
    color = "white", size = 6, stat = "count") +
  geom_hline(
    yintercept = overall_proportion, 
    linetype = "dashed", 
    color = "white", 
    size = 1
  ) +
  labs(
    x= "\nImmigration Category", 
    y= "Proportion\n", 
    fill="", 
    title = "What is the proportional Phonetic/Phonological Agreement distribution\n of laterals for Immigration Category?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers"
  ) +
  scale_x_discrete(labels = c(
    "est_immigrant" = "Established Immigrant", 
    "recent_arrival" = "Recent Arrival", 
    "us_born" = "US Born"
  )) +
  scale_fill_economist() +
  basic_custom_theme()


IMMIGRATION_CATEGORY_plot_lateral_match

# ggsave("output/plots/liquids/lateral/IMMIGRATION_CATEGORY_plot_lateral_match.pdf", IMMIGRATION_CATEGORY_plot_lateral_match,device = cairo_pdf, width = 12, height = 7) 
