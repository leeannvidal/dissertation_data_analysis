# scripts/visuals/liquids/tap/Percent_English_Interlocutor_x_Mismatch_Rate_tap.R

# #Calculate chi-square to include in plot
# ## Create a Contingency Table
# 
# tap_PHONO_AGREEMENT_by_PERCENT_INTL_ENG_ONLY <- table(rates_mismatch_all$PHONETIC_PHONOLOGICAL_AGREEMENT,rates_mismatch_all$PERCENT_INTL_ENG_ONLY)
# 
# # ## Print the contingency table to see the distribution
# tap_PHONO_AGREEMENT_by_PERCENT_INTL_ENG_ONLY
# 
# # # # Run χ² function -
# chi_label_tap_PHONO_AGREEMENT_by_PERCENT_INTL_ENG_ONLY <- create_chi_label(chisq.test(tap_PHONO_AGREEMENT_by_PERCENT_INTL_ENG_ONLY))

# chi_label_tap_PHONO_AGREEMENT_by_PERCENT_INTL_ENG_ONLY
#
# 
# ### Run linear regression to label plot
# 
# # Fit the linear model
# PERCENT_INTL_ENG_ONLY_model_tap <- lm(RATE_MISMATCH_tap ~ PERCENT_INTL_ENG_ONLY, data = rates_mismatch_all)
# 
# # Get summary of the model
# PERCENT_INTL_ENG_ONLY_tap_model_summary <- summary(PERCENT_INTL_ENG_ONLY_model_tap)
# 
# 
# # # Run R² function to create label-
# r2_pvalue_label_tap_PERCENT_INTL_ENG_ONLY <- create_regression_label(PERCENT_INTL_ENG_ONLY_tap_model_summary)

# Plot the data - tap

# Create the plot with annotations for R^2 and p-value
PERCENT_INTL_ENG_ONLY_MISMATCH_RATE_tap <- rates_mismatch_all %>%
  ggplot(aes(x = PERCENT_INTL_ENG_ONLY, y = RATE_MISMATCH_tap, color = COUNTRY_OF_ORIGIN)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
  geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "% of English only with interlocutor", y = "Mismatch Rate (%)\n",
       title = "\nAssociation between Percent of English only with Interlocutors and Phonetic-Phonological Mismatch Rates for /ɾ/\n among Puerto Rican and Dominican Spanish Speakers in Boston",
       caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n") +
  basic_custom_theme()
  
  # annotate("label", x = 0, y = Inf, label = chi_label_tap_PHONO_AGREEMENT_by_PERCENT_INTL_ENG_ONLY,
  #          hjust = -0.1, vjust = 1.5, size = 5, color = "black",
  #          label.size = NA, # No border around the box
  #          fill = "lightblue", # Background color of the box
  #          fontface = "bold", # Bold text
  #          label.padding = unit(1, "lines"))  # Padding inside the box

PERCENT_INTL_ENG_ONLY_MISMATCH_RATE_tap
