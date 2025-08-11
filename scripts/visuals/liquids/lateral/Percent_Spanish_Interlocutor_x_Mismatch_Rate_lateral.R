# scripts/visuals/liquids/lateral/Percent_Spanish_Interlocutor_x_Mismatch_Rate_lateral.R

# #Calculate chi-square to include in plot
# ## Create a Contingency Table
# 
# lateral_PHONO_AGREEMENT_by_PERCENT_INTL_SPAN_ONLY <- table(rates_mismatch_all$PHONETIC_PHONOLOGICAL_AGREEMENT,rates_mismatch_all$PERCENT_INTL_SPAN_ONLY)
# 
# # ## Print the contingency table to see the distribution
# lateral_PHONO_AGREEMENT_by_PERCENT_INTL_SPAN_ONLY
# 
# # # # Run χ² function -
# chi_label_lateral_PHONO_AGREEMENT_by_PERCENT_INTL_SPAN_ONLY <- create_chi_label(chisq.test(lateral_PHONO_AGREEMENT_by_PERCENT_INTL_SPAN_ONLY))
# 
# # chi_label_lateral_PHONO_AGREEMENT_by_PERCENT_INTL_SPAN_ONLY
#
# 
# ### Run linear regression to label plot
# 
# # Fit the linear model
# PERCENT_INTL_SPAN_ONLY_model_lateral <- lm(RATE_MISMATCH_lateral ~ PERCENT_INTL_SPAN_ONLY, data = rates_mismatch_all)
# 
# # Get summary of the model
# PERCENT_INTL_SPAN_ONLY_lateral_model_summary <- summary(PERCENT_INTL_SPAN_ONLY_model_lateral)
# 
# 
# # # Run R² function to create label-
# r2_pvalue_label_lateral_PERCENT_INTL_SPAN_ONLY <- create_regression_label(PERCENT_INTL_SPAN_ONLY_lateral_model_summary)

# Plot the data - lateral

# Create the plot with annotations for R^2 and p-value
PERCENT_INTL_SPAN_ONLY_MISMATCH_RATE_lateral <- rates_mismatch_all %>%
  ggplot(aes(x = PERCENT_INTL_SPAN_ONLY, y = RATE_MISMATCH_lateral, color = COUNTRY_OF_ORIGIN)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
  geom_text_repel(aes(label = SPEAKER), size = 3, box.padding = 0.5, point.padding = 0.5, max.overlaps = Inf) +  # Add speaker labels & Repel labels from geom_points
  labs(x = "% of Spanish only with interlocutor", y = "Mismatch Rate (%)\n",
       title = "\nAssociation between Percent of Spanish only with Interlocutors and Phonetic-Phonological Mismatch Rates for /l/\n among Puerto Rican and Dominican Spanish Speakers in Boston",
       caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n") +
  basic_custom_theme()
  
  # annotate("label", x = 0, y = Inf, label = chi_label_lateral_PHONO_AGREEMENT_by_PERCENT_INTL_SPAN_ONLY,
  #          hjust = -0.1, vjust = 1.5, size = 5, color = "black",
  #          label.size = NA, # No border around the box
  #          fill = "lightblue", # Background color of the box
  #          fontface = "bold", # Bold text
  #          label.padding = unit(1, "lines"))  # Padding inside the box

PERCENT_INTL_SPAN_ONLY_MISMATCH_RATE_lateral
