# scripts/visuals/liquids/lateral/Percent_English_Interlocutor_x_Mismatch_Rate_lateral.R

#Extract beta and pvalue from regression summary and create label
# lateral_model<- readRDS("data/regressions/best_model_lateral.rds")
# summary(lateral_model) 
beta_label_PERCENT_INTL_ENG_ONLY_lateral_mismatch <- get_estimate_and_pvalues(predictor = "PERCENT_INTL_ENG_ONLY", model_path = "data/regressions/best_model_lateral.rds")

# Plot the data - lateral

# Create the plot with annotations for R^2 and p-value
PERCENT_INTL_ENG_ONLY_MISMATCH_RATE_lateral <- rates_mismatch_all %>%
  # ggplot(aes(x = PERCENT_INTL_ENG_ONLY, y = RATE_MISMATCH_LATERAL, color = COUNTRY_OF_ORIGIN)) +
  ggplot(aes(x = PERCENT_INTL_ENG_ONLY, y = RATE_MISMATCH_LATERAL)) +
  geom_point(size = 5) +  # Increase point size
  geom_smooth(method = "lm", se = TRUE, color = "black") +  # Showing confidence interval
 # # Add speaker labels and use repel to avoid overlapping
 # geom_text_repel(aes(label = SPEAKER),
 #                 size = 3,
 #                 box.padding = 0.5,
 #                 point.padding = 0.5,
 #                 max.overlaps = Inf,
 #                 nudge_y = 0.1) +  # Adjust nudge_y if necessary to shift labels
  labs(
    x = "", 
    title = "% of English only with Interlocutor", 
    y = "Mismatch Rate (%)\n",
       # title = "\nAssociation between Percent of English only with Interlocutors and Phonetic-Phonological Mismatch Rates for /l/\n among Puerto Rican and Dominican Spanish Speakers in Boston",
       # title = "Association between Percent of English only with Interlocutors \nand Phonetic-Phonological Mismatch Rates\n",
       # subtitle = "Lateral"
       # caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation\n"
       ) +
  basic_custom_theme() 
# +
#   # Annotating with the label at the top-left
#   annotate("label", 
#            x = min(rates_mismatch_all$PERCENT_INTL_ENG_ONLY),  # Near the max x-value
#            y = max(rates_mismatch_all$RATE_MISMATCH_LATERAL),   # Near the min y-value
#            label = beta_label_PERCENT_INTL_ENG_ONLY_lateral_mismatch,
#            hjust = 0, vjust = 1, size = 8, color = "black",  # Right aligned, bottom aligned
#            label.size = NA,  # No border around the box
#            fill = "#7FACA2", # Background color of the box
#            fontface = "bold", # Bold text
#            family = "charis",
#            label.padding = unit(1, "lines"))  # Padding inside the box

PERCENT_INTL_ENG_ONLY_MISMATCH_RATE_lateral

ggsave("output/plots/liquids/lateral/PERCENT_INTL_ENG_ONLY_mismatch_lateral.pdf", PERCENT_INTL_ENG_ONLY_MISMATCH_RATE_lateral,device = cairo_pdf, width = 11, height = 7)
