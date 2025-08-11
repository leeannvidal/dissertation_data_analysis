# scripts/visuals/liquids/tap/country_of_origin_match_tap.R

#Extract beta and pvalue from regression summary and create label
# tap_model <- readRDS("data/regressions/best_model_tap.rds")
# summary(tap_model)
beta_label_COUNTRY_OF_ORIGIN_tap_match <- get_estimate_and_pvalues(predictor = "COUNTRY_OF_ORIGINpr", model_path = "data/regressions/best_model_tap.rds")
# print(beta_label_COUNTRY_OF_ORIGIN_tap_match)

COUNTRY_OF_ORIGIN_plot_tap_match <- tap %>%
  ggplot(aes(COUNTRY_OF_ORIGIN, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(position = "fill", width = .75) +
  geom_text(
    aes(label = ifelse(COUNTRY_OF_ORIGIN == "dr", as.character(PHONETIC_PHONOLOGICAL_AGREEMENT), "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.7), # Position labels near the top of the bar
    color = "white", # Set label color for visibility
    stat = "count", # Use count to place labels according to the data distribution
    family = "charis",
    size = 8) +  # Adjust text size as needed, # Label for chi-square results on a specific bar
  # geom_text(
  #   aes(label = ifelse(COUNTRY_OF_ORIGIN == "pr" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", beta_label_COUNTRY_OF_ORIGIN_tap_match, "")),
  #   position = position_fill(vjust = 0.55), # Adjust vertical position to center
  #   color = "white", size = 8, family = "charis", stat = "count") +
  # geom_hline(
  #   yintercept = overall_proportion, 
  #   linetype = "dashed", 
  #   color = "white", 
  #   size = 1
  # ) +
  labs(
    x= "", 
    y= "Proportion\n", 
    fill="", 
    # title = "What is the proportional Phonetic/Phonological Agreement distribution\n of taps for Country of Origin?",
    # title = "Association between Country of Origin \nand Phonetic-Phonological Agreement\n",
    title = "Country of Origin",
    # subtitle = "Tap"
    # caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers\n"
  ) +
  scale_x_discrete(labels = c(
    "dr" = "Dominican Republic", 
    "pr" = "Puerto Rico"
  )) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  basic_custom_theme()


COUNTRY_OF_ORIGIN_plot_tap_match

ggsave("output/plots/liquids/tap/COUNTRY_OF_ORIGIN_plot_tap_match.pdf", COUNTRY_OF_ORIGIN_plot_tap_match,device = cairo_pdf, width = 11, height = 7)
