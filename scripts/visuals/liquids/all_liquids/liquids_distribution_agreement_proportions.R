# scripts/visuals/liquids/all_liquids/liquids_distribution_agreement_proportion.R

#PROPORTIONAL AGREEMENT DISTRIBUTION OF PHONO FORMS

# #Calculate chi-square to include in plot
# # 
# # Create a Contingency Table
# liquids_agreement_table <- table(liquids$PHONO_FORM, liquids$PHONETIC_PHONOLOGICAL_AGREEMENT)
# 
# # Print the contingency table to see the distribution
# # print(liquids_agreement_table)
# 
# # Perform chi-square test
# chi_test_result_liquids_agreement <- chisq.test(liquids_agreement_table)
# 
# # Print the test results to verify against label
# # print(chi_test_result_liquids_agreement)
# 
# # # Run χ² function -
# chi_label_liquids_agreement <- create_chi_label(chi_test_result_liquids_agreement)
# # print(chi_label_liquids_agreement) WORKS

# Set the desired order for PHONO_LABEL_W_COUNT
liquids <- liquids %>%
  mutate(PHONO_LABEL_W_COUNT = factor(PHONO_LABEL_W_COUNT, 
                                      levels = c("/ɾ/: n = 3871", "/r/: n = 857", "/l/: n = 2626")))


# Build Plot
liquid_distribution_agreement_prop <- liquids %>%
  ggplot(aes(x= PHONO_LABEL_W_COUNT, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) + 
  geom_bar(position = "fill") +  # Adjust bar heights to proportion
  
  # Label for phonetic agreement on one of the bars
  geom_text(
    aes(label = ifelse(PHONO_LABEL_W_COUNT == "/ɾ/: n = 3871",
                       as.character(PHONETIC_PHONOLOGICAL_AGREEMENT),
                       "")), # Conditionally label "X" bar
    position = position_fill(vjust = 0.5), # Position labels in the center for each value
    color = "white", # Set label color for visibility
    family = "charis",
    stat = "count", # Use count to place labels according to the data distribution
    size = 8  ) +  # Adjust text size as needed
  # Label for chi-square results on a specific bar
  # geom_text(
  #   aes(label = ifelse(PHONO_LABEL_W_COUNT == "/ɾ/: n = 3883" & PHONETIC_PHONOLOGICAL_AGREEMENT == "match", chi_label_liquids_agreement, "")), 
  #   position = position_fill(vjust = 0.8), # Adjust vertical position to center
  #   color = "white", size = 4, stat = "count") +
  labs(
    # title = "What is the proportional Phonetic/Phonological \nAgreement distribution for each Phonological Form?", 
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    x = "Phoneme\n", 
    y = "Proportion\n", 
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  # scale_fill_economist() +
  scale_x_discrete(position = "top") + #Place x-axis label on top
  basic_custom_theme()

# Print the plot
liquid_distribution_agreement_prop

# Save to PDF
#Dissertation
ggsave("output/plots/liquids/all_liquids/liquids_distribution_agreement_proportions.pdf", liquid_distribution_agreement_prop, device = cairo_pdf, width =12, height = 7)

#Presentations (with the extra labels and titles)
ggsave("output/presentation_visuals/liquids_distribution_agreement_proportions_presentation_version.pdf", liquid_distribution_agreement_prop, device = cairo_pdf, width =12, height = 7)
