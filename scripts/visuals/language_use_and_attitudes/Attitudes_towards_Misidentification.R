# \item If someone told you that you sounded (X) would you like that?\\
# %		
# \begin{tabular}{llll}
# Como un & I'd like it  & I wouldn't like it & Why? \\
# Colombians & \_\_\_\_\_\_ & \_\_\_\_\_\_\_\_\_  & \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   \\
# Dominicans & \_\_\_\_\_\_  & \_\_\_\_\_\_\_\_\_   & \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   \\
# Guatemalans & \_\_\_\_\_\_  & \_\_\_\_\_\_\_\_\_   & \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   \\
# Mexicans & \_\_\_\_\_\_  & \_\_\_\_\_\_\_\_\_  & \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   \\
# Puerto Ricans & \_\_\_\_\_\_  & \_\_\_\_\_\_\_\_\_ & \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   \\
# Salvadorans& \_\_\_\_\_\_  & \_\_\_\_\_\_\_\_\_   & \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   \\
# \end{tabular}

### WITH PERU
MISIDENTIFICATION_ATTITUDES <- socio_df_diss [c("COUNTRY_OF_ORIGIN", "LIKE_SIM_CO", "LIKE_SIM_CU", "LIKE_SIM_DR", "LIKE_SIM_GU", "LIKE_SIM_ME", "LIKE_SIM_PR", "LIKE_SIM_EL", "LIKE_SIM_PU")] #subset the data so that only the columns needed are present

# # Apply the COUNTRY_OF_ORIGIN mutation
MISIDENTIFICATION_ATTITUDES <- mutate_country_of_origin(MISIDENTIFICATION_ATTITUDES)
#
# # misidentification_levels <- c("like", "indifferent", "dislike")
misidentification_levels <- c("dislike", "indifferent")
# # misidentification_levels <- c("indifferent", "dislike")
#
# # Apply consistent factor levels to columns 2 through 9
for (i in 2:9) {
  MISIDENTIFICATION_ATTITUDES[, i] <- factor(
    MISIDENTIFICATION_ATTITUDES[, i],
    levels = misidentification_levels
  )
}
#
# # Verify Levels Across Columns
sapply(MISIDENTIFICATION_ATTITUDES[, 2:9], levels)
#
# ## Rename Cols
MISIDENTIFICATION_ATTITUDES  <- MISIDENTIFICATION_ATTITUDES  %>%
  rename("Colombia" = "LIKE_SIM_CO",
         "Cuba" = "LIKE_SIM_CU",
         "Dominican Republic" = "LIKE_SIM_DR",
         "Guatemala" = "LIKE_SIM_GU",
         "Mexico" = "LIKE_SIM_ME",
         "Puerto Rico" = "LIKE_SIM_PR",
         "El Salvador" = "LIKE_SIM_EL",
         "Peru" = "LIKE_SIM_PU")

# # Troubleshoot problem with Likert when centering false and grouped
# MISIDENTIFICATION_ATTITUDES
# trial <- likert(MISIDENTIFICATION_ATTITUDES[,c(2:9)], grouping = MISIDENTIFICATION_ATTITUDES[,1])
# trial
# 
# likert_plot <- likert(MISIDENTIFICATION_ATTITUDES[,c(2:9)], grouping = MISIDENTIFICATION_ATTITUDES$COUNTRY_OF_ORIGIN)
# plot(likert_plot, centered = FALSE)
# 
# trialplot <- plot(likert(MISIDENTIFICATION_ATTITUDES[,c(2:9)], grouping = MISIDENTIFICATION_ATTITUDES$COUNTRY_OF_ORIGIN),centered = FALSE)
# trialplot <- plot(likert(MISIDENTIFICATION_ATTITUDES[,c(2:9)], grouping = MISIDENTIFICATION_ATTITUDES$COUNTRY_OF_ORIGIN))
# 
# 
# trialplot$layers
# trialplot$data
# trialplot$mapping
# table(MISIDENTIFICATION_ATTITUDES$COUNTRY_OF_ORIGIN)



### ORIGINAL LIKERT PLOT THAT MESSES UP PERCENTAGES WHEN CENTERED
### If I want to exclude a country, just dont choose it
MISIDENTIFICATION_ATTITUDES_Plot <- plot(likert(MISIDENTIFICATION_ATTITUDES[,c(2:8)], grouping = MISIDENTIFICATION_ATTITUDES[,1]), plot.percent.neutral=FALSE, plot.percent.low=FALSE, plot.percent.high=FALSE,centered = FALSE, text.size = 6
                              )+
      labs(
        title = "If someone said that you sound like an X,would you like it?",
        caption = "Data Source: Spanish in Boston Corpus\nVidal Covas' Dissertation Speakers",
        subtitle = "National Group (X)\n",
        x = "National Origin of Respondent\n",
        y = "Percentage of Responses",
        fill = "Response"
      ) +
      # scale_fill_manual(values = custom_green_palette, breaks = c( "indifferent", "dislike")) +  # change fill of values, reorder the levels
      scale_fill_manual(values = custom_green_palette) +  # change fill of values
      likert_custom_theme() +
      # # Relabel the x-axis with custom country labels
      scale_x_discrete(labels = c("pr" = "PR",
                                  "dr" = "DR"))  +
      geom_text(
        aes(
          label = ifelse(
            # Group == "pr" & Item == "Colombia" & value > 0, # Ensure value is non-zero
            Group == "pr" & Item == "Colombia", # Choose the top row
            as.character(misidentification_levels[variable]), # Assign labels
            NA # Omit labels with zero values
          )
        ),
        # position = position_stack(reverse = TRUE), # Reverse the percentaged to display correctly
        position = position_stack(vjust = 0.5), # Stack text within each bar segment
        # fontface = "bold",
        color = "white", # Adjust for visibility
        size = 6, # Adjust size as needed
        family = "charis" # Specify the font family
      ) +
      theme(legend.position = "none") +
  scale_y_continuous( 
    labels = NULL,  # Removes y-axis percentage labels
    breaks = NULL   # Removes ticks on the y-axis
  )+
  # Add labels outside bars for "indifferent" responses
  geom_text(
    aes(
      label = ifelse(
        variable == "indifferent" & value > 0,  # Include only non-zero "like" labels
        paste0(round(value, 0), "%"),
        NA_character_)
      ),
      position = position_stack(vjust = 0), # Stack text within each bar segment
    hjust = 1.5,  # Align text slightly to the left of the bar
    color = "black",  # Adjust for visibility
    size = 6,  # Adjust size as needed
    family = "charis"
  ) +
  # Add labels outside bars for "dislike" responses
  geom_text(
    aes(
      label = ifelse(
        variable == "dislike" & value > 0,  # Include only non-zero "like" labels
        paste0(round(value, 0), "%"),
        NA_character_)
    ),
    position = position_stack(vjust = 1), # Stack text within each bar segment
    hjust = -0.5,  # Align text slightly to the left of the bar
    color = "black",  # Adjust for visibility
    size = 6,  # Adjust size as needed
    family = "charis"
  ) + 
  expand_limits(y= c(-5, 103)) ## to add space for percentages not to be cut off



MISIDENTIFICATION_ATTITUDES_Plot
# MISIDENTIFICATION_ATTITUDES_Plot$data

ggsave("output/plots/language_use_and_attitudes/MISIDENTIFICATION_ATTITUDES_Plot.pdf", MISIDENTIFICATION_ATTITUDES_Plot, device = cairo_pdf, width = 12, height = 14)

# ### RECREATED LIKERT PLOT USING GGPLOT
# # Extract percentages and create a custom plot
# likert_data <- likert(MISIDENTIFICATION_ATTITUDES[, c(2:9)], 
#                       grouping = MISIDENTIFICATION_ATTITUDES$COUNTRY_OF_ORIGIN)
# custom_data <- as.data.frame(likert_data$results)
# custom_data
# 
# custom_data_long <- custom_data %>%
#   pivot_longer(cols = c(like, indifferent, dislike),
#                names_to = "response",
#                values_to = "percentage")
# 
# # Plot grouped and horizontal bar plot
# ggplot(custom_data_long, aes(x = percentage, y = Group, fill = response)) +
#   geom_bar(stat = "identity", position = "stack") +
#   facet_wrap(~ Item, ncol = 1) +  # One panel per Group
#   # coord_flip() +                  # Flip to horizontal bars
#   theme_minimal() +
#   labs(
#     title = "If someone said that you sound like an X,would you like it?\n",
#     caption = "Data Source: Spanish in Boston Corpus\nVidal Covas' Dissertation Speakers",
#     subtitle = "National Group (X)",
#     x = "Percentage of Responses",
#     y = "Item\n",
#     fill = "Response",
#   ) +
#   scale_fill_manual(values = custom_green_palette) +  # change fill of values
#   likert_custom_theme() +
#   # # Relabel the x-axis with custom country labels
#   scale_y_discrete(labels = c("pr" = "PR",
#                               "dr" = "DR")) + # Add text labels
#   geom_text(
#     aes(
#       label = ifelse(
#         Group == "pr" & Item == "Colombia", # Specify condition
#         as.character(response), # Display response level
#         NA_character_ # No label otherwise
#       )
#     ),
#     position = position_stack(vjust = 0.5), # Center the labels within the bars
#     color = "white", # Adjust for visibility
#     size = 5, # Adjust size as needed
#     family = "charis" # Font family
#   ) +
#   theme(legend.position = "none") +
#   # Add labels outside bars for "like" responses
#   geom_text(
#     aes(
#       label = ifelse(
#         response == "like" & percentage > 0,  # Include only non-zero "like" labels
#         paste0(round(percentage, 1), "%"),
#         NA_character_
#       ),
#       x = 0  # Adjust position to place "like" outside left
#     ),
#     hjust = 1,  # Align text to the right
#     color = "black",  # Adjust for visibility
#     size = 4,  # Adjust size as needed
#     family = "charis"
#   ) +
#   
#   # Add labels outside bars for "dislike" responses
#   geom_text(
#     aes(
#       label = ifelse(
#         response == "dislike" & percentage > 0,  # Include only non-zero "dislike" labels
#         paste0(round(percentage, 1), "%"),
#         NA_character_
#       ),
#       x = 100  # Adjust position to place "dislike" outside right
#     ),
#     hjust = 0,  # Align text to the left
#     color = "black",  # Adjust for visibility
#     size = 4,  # Adjust size as needed
#     family = "charis"
#   ) +
#   # Add labels for "indifferent" responses
#   geom_text(
#     aes(
#       label = ifelse(response == "indifferent" & percentage > 0,
#                      paste0(round(percentage, 1), "%"),
#                      NA_character_
#       ),
#       x = 45  # Adjust position to place "dislike" outside right
#     ),
#     # position = position_stack(vjust = 0.5),
#     color = "white",
#     size = 4,
#     family = "charis"
#   )



# scale_x_discrete(labels = c("LIKE_SIM_CO" = "Colombia",
#                             "LIKE_SIM_CU" = "Cuba",
#                             "LIKE_SIM_DR" = "Dominican Republic",
#                             "LIKE_SIM_GU" = "Guatemala",
#                             "LIKE_SIM_ME" = "Mexico",
#                             "LIKE_SIM_PR" = "Puerto Rico",
#                             "LIKE_SIM_EL" = "El Salvador",
#                             "LIKE_SIM_PU" = "Peru"))  +
