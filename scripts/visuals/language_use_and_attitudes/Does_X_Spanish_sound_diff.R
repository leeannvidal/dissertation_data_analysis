# \item Do you think that the Spanish spoken by (mention each national group in the study) is different?\\
# %		Yes \_\_\_ No \_\_\_
# \begin{tabular}{lll}
# Colombians & Yes \_\_\_ & No \_\_\_ \\
# Dominicans & Yes \_\_\_ & No \_\_\_ \\
# Guatemalans & Yes \_\_\_ & No \_\_\_ \\
# Mexicans & Yes \_\_\_ & No \_\_\_ \\
# Puerto Ricans & Yes \_\_\_ & No \_\_\_ \\
# Salvadorans & Yes \_\_\_ & No \_\_\_ \\
# \end{tabular}

# "CO_SPAN_DIFF"                   
# "DR_SPAN_DIFF"                    
# "GU_SPAN_DIFF"                    
# "ME_SPAN_DIFF"
# "PR_SPAN_DIFF"
# "EL_SPAN_DIFF"                   
# "PU_SPAN_DIFF"

my_yes_no_levels <- c("yes","no")

# SPAN_DIFF <- socio_df_diss [c("CO_SPAN_DIFF" ,"DR_SPAN_DIFF", "GU_SPAN_DIFF", "ME_SPAN_DIFF", "PR_SPAN_DIFF", "EL_SPAN_DIFF", "PU_SPAN_DIFF")] #subset the data so that only the columns needed are present
SPAN_DIFF <- socio_df_diss [c("CO_SPAN_DIFF" , "ME_SPAN_DIFF", "PU_SPAN_DIFF", "PR_SPAN_DIFF", "DR_SPAN_DIFF","GU_SPAN_DIFF", "EL_SPAN_DIFF")] #subset the data so that only the columns needed are present

# colnames(SPAN_DIFF)

# Here we will recode each factor and explicitly set the levels or else the graphs will not work as some levels were not used

for(i in seq_along(SPAN_DIFF)) {SPAN_DIFF[,i] <- factor(SPAN_DIFF[,i], levels=my_yes_no_levels)}

SPAN_DIFF_Plot <- plot(likert(SPAN_DIFF), plot.percent.neutral=FALSE, plot.percent.low=FALSE, plot.percent.high=FALSE , centered = FALSE, text.size = 6
                       # group.order = c("CO_SPAN_DIFF" ,"DR_SPAN_DIFF", "GU_SPAN_DIFF", "ME_SPAN_DIFF", "PR_SPAN_DIFF", "EL_SPAN_DIFF", "PU_SPAN_DIFF")
                       )+
  labs(
    title = "Do you think that the Spanish spoken by\nX national group is different?",
    caption = "Data Source: Spanish in Boston Corpus\n Vidal Covas' Dissertation Speakers",
    x = "National Group\n",
    y = "Percentage of Responses",
    fill = "Response"
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  likert_custom_theme() +
  theme(legend.position = "bottom") +
  # Relabel the x-axis with custom country labels
  scale_x_discrete(labels = c("CO_SPAN_DIFF" = "Colombia",
                              "DR_SPAN_DIFF" = "Dominican Republic",
                              "GU_SPAN_DIFF" = "Guatemala",
                              "ME_SPAN_DIFF" = "Mexico",
                              "PR_SPAN_DIFF" = "Puerto Rico",
                              "EL_SPAN_DIFF" = "El Salvador",
                              "PU_SPAN_DIFF" = "Peru"))  +
  geom_text(
    aes(
      label = ifelse(
        Item == "EL_SPAN_DIFF" & value > 0, # Ensure value is non-zero
        as.character(my_yes_no_levels[variable]), # Assign label for "Yes"
        NA # Omit labels for "No" or zero values
      )
    ),
    position = position_stack(vjust = 0.5), # Stack text within each bar segment
    fontface = "bold",
    color = "white", # Adjust for visibility
    size = 6, # Adjust size as needed
    family = "charis" # Specify the font family
  ) +
  theme(legend.position = "none")+
  scale_y_continuous( 
    labels = NULL,  # Removes y-axis percentage labels
    breaks = NULL   # Removes ticks on the y-axis
  ) +
  # Add percentage labels outside to the right bars for "yes" responses
  geom_text(
    aes(
      label = ifelse(
        variable == "yes" & value > 0,  # Include only non-zero "like" labels
        paste0(round(value, 0), "%"),
        NA_character_)
    ),
    position = position_stack(vjust = 1), # Stack text within each bar segment
    hjust = -0.15,  # Align text slightly to the left of the bar
    color = "black",  # Adjust for visibility
    size = 6,  # Adjust size as needed
    family = "charis"
  ) + expand_limits(y= c(0.1, 106)) ## to add space for percentages not to be cut off on the right side. (change the right number)


SPAN_DIFF_Plot

# Save to PDF
ggsave("output/plots/language_use_and_attitudes/SPAN_DIFF_Plot.pdf", SPAN_DIFF_Plot, device = cairo_pdf, width = 11, height = 7)

SPAN_DIFF_SIB <- socio_df [c("CO_SPAN_DIFF" ,"DR_SPAN_DIFF", "GU_SPAN_DIFF", "ME_SPAN_DIFF", "PR_SPAN_DIFF", "EL_SPAN_DIFF", "PU_SPAN_DIFF")] #subset the data so that only the columns needed are present


for(i in seq_along(SPAN_DIFF_SIB)) {SPAN_DIFF_SIB[,i] <- factor(SPAN_DIFF_SIB[,i], levels=my_yes_no_levels)}

SPAN_DIFF_SIB_Plot <- plot(likert(SPAN_DIFF_SIB), plot.percent.neutral=FALSE, plot.percent.low=FALSE, plot.percent.high=FALSE, centered = FALSE, text.size = 6
                       # group.order = c("CO_SPAN_DIFF" ,"DR_SPAN_DIFF", "GU_SPAN_DIFF", "ME_SPAN_DIFF", "PR_SPAN_DIFF", "EL_SPAN_DIFF", "PU_SPAN_DIFF")
)+
  labs(
    title = "Do you think that the Spanish spoken by \nX national group is different?\n",
    caption = "Data Source: Spanish in Boston Corpus\n 192 Speakers",
    x = "National Group\n",
    y = "Percentage of Responses",
    fill = "Response"
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  likert_custom_theme() +
  theme(legend.position = "bottom") +
  # Relabel the x-axis with custom country labels
  scale_x_discrete(labels = c("CO_SPAN_DIFF" = "Colombia",
                              "DR_SPAN_DIFF" = "Dominican Republic",
                              "GU_SPAN_DIFF" = "Guatemala",
                              "ME_SPAN_DIFF" = "Mexico",
                              "PR_SPAN_DIFF" = "Puerto Rico",
                              "EL_SPAN_DIFF" = "El Salvador",
                              "PU_SPAN_DIFF" = "Peru"))  +
  geom_text(
    aes(
      label = ifelse(
        Item == "EL_SPAN_DIFF" & value > 0, # Ensure value is non-zero
        as.character(my_yes_no_levels[variable]), # Assign label for "Yes"
        NA # Omit labels for "No" or zero values
      )
    ),
    position = position_stack(vjust = 0.5), # Stack text within each bar segment
    fontface = "bold",
    color = "white", # Adjust for visibility
    size = 6, # Adjust size as needed
    family = "charis" # Specify the font family
  ) +
  theme(legend.position = "none")+
  scale_y_continuous( 
    labels = NULL,  # Removes y-axis percentage labels
    breaks = NULL   # Removes ticks on the y-axis
  ) +
  # Add labels outside bars for "yes" responses
  geom_text(
    aes(
      label = ifelse(
        variable == "yes" & value > 0,  # Include only non-zero "like" labels
        paste0(round(value, 0), "%"),
        NA_character_)
    ),
    position = position_stack(vjust = 0), # Stack text within each bar segment
    hjust = 1.15,  # Align text slightly to the left of the bar
    color = "black",  # Adjust for visibility
    size = 6,  # Adjust size as needed
    family = "charis"
  ) +
  # Add labels outside bars for "no" responses
  geom_text(
    aes(
      label = ifelse(
        variable == "no" & value > 0,  # Include only non-zero "like" labels
        paste0(round(value, 0), "%"),
        NA_character_)
    ),
    position = position_stack(vjust = 1), # Stack text within each bar segment
    hjust = -0.15,  # Align text slightly to the left of the bar
    color = "black",  # Adjust for visibility
    size = 6,  # Adjust size as needed
    family = "charis"
  ) + 
  expand_limits(y= c(-4, 103)) ## to add space for percentages not to be cut off



SPAN_DIFF_SIB_Plot

# Save to PDF
ggsave("output/plots/language_use_and_attitudes/SPAN_DIFF_SIB_Plot.pdf", SPAN_DIFF_SIB_Plot, device = cairo_pdf, width = 11, height = 7)
