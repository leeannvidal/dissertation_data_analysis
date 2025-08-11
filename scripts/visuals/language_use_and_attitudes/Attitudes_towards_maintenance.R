# \item Do you think that Spanish speakers in Boston:
#   \begin{enumerate}[label=\arabic{enumi}\alph*.]
# \item Should continue speaking Spanish with their countrymen? \hfill Yes\_\_\_ No\_\_\_
# \item Should they avoid words that others might not know? \hfill Yes\_\_\_ No\_\_\_
# \item Should they learn how to speak Castilian Spanish? \hfill Yes\_\_\_ No\_\_\_
# \end{enumerate}

# "USE_SAME_SPAN"
# "NO_USE_DIFF_SPAN"
# "LEARN_CASTELLANO"  

# \item Should the kind of Spanish you speak be taught in schools? \hfill Yes \_\_\_ No \_\_\_

# "TEACH_ETHN_SPAN"   

# \item Do you think Spanish speakers in the US should maintain their Spanish?\\
# Yes \_\_\_ No \_\_\_
# # "KEEP_SPAN"

my_yes_no_levels <- c("yes","no")
# my_yes_no_levels <- c("no","yes")

SPAN_ATTITUDES <- socio_df_diss [c( "KEEP_SPAN", "USE_SAME_SPAN" , "TEACH_ETHN_SPAN", "NO_USE_DIFF_SPAN", "LEARN_CASTELLANO")] #subset the data so that only the columns needed are present
# SPAN_ATTITUDES <- socio_df [c( "KEEP_SPAN", "USE_SAME_SPAN" , "TEACH_ETHN_SPAN", "NO_USE_DIFF_SPAN", "LEARN_CASTELLANO")] #subset the data so that only the columns needed are present

# order <- c("KEEP_SPAN", "USE_SAME_SPAN" , "TEACH_ETHN_SPAN", "NO_USE_DIFF_SPAN", "LEARN_CASTELLANO") 
# ordered= FALSE, group.order=order group.order = names(SPAN_ATTITUDES)

# Here we will recode each factor and explicitly set the levels or else the graphs will not work as some levels were not used

for(i in seq_along(SPAN_ATTITUDES)) {SPAN_ATTITUDES[,i] <- factor(SPAN_ATTITUDES[,i], levels=my_yes_no_levels)}

trial <- likert(SPAN_ATTITUDES)
trial

SPAN_ATTITUDES_Plot <- plot(likert(SPAN_ATTITUDES), plot.percent.neutral=FALSE, plot.percent.low=FALSE, plot.percent.high=FALSE ,centered = FALSE,text.size = 6
                       #      , 
                       # group.order = c("TEACH_ETHN_SPAN", "KEEP_SPAN", "LEARN_CASTELLANO" ,"NO_USE_DIFF_SPAN", "USE_SAME_SPAN")
                       )+
  labs(
    title = "Attitudes towards maintenance and use of Spanish",
    caption = "Data Source: Spanish in Boston Corpus\nVidal Covas' Dissertation Speakers",
    x = "Question\n",
    y = "Percentage of Responses",
    fill = "Response"
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  likert_custom_theme() +
  # Relabel the x-axis with custom labels
  scale_x_discrete(labels = c("USE_SAME_SPAN" = "Should Spanish speakers in Boston \nmaintain national group's Spanish?",
                              "NO_USE_DIFF_SPAN" = "Should Spanish speakers in Boston \navoid unfamiliar words for \nother Spanish speakers?",
                              "LEARN_CASTELLANO" = "Should Spanish speakers in Boston \nlearn Castilian Spanish?",
                              "TEACH_ETHN_SPAN" = "Should your Spanish be taught \nin schools?", 
                              "KEEP_SPAN" = "Should US Spanish speakers \nmaintain their Spanish?")) +
  geom_text(
    aes(
      label = ifelse(Item == "LEARN_CASTELLANO", as.character(my_yes_no_levels[variable]), "")
    ), # Display labels only on LEARN_CASTELLANO
    position = position_stack(vjust = 0.5), # Stack text within each bar segment
    fontface = "bold",
    color = "white", # Adjust for visibility
    size = 7, # Adjust size as needed
    family = "charis" # Specify the font family
  ) +
  theme(legend.position = "none") +
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
    size = 7,  # Adjust size as needed
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
    size = 7,  # Adjust size as needed
    family = "charis"
  ) + 
  expand_limits(y= c(-4, 103)) ## to add space for percentages not to be cut off

SPAN_ATTITUDES_Plot 

# # Troubleshoot to remove some layers
# SPAN_ATTITUDES_Plot$layers
# # Remove layers responsible for bottom percentage labels
# SPAN_ATTITUDES_Plot$layers <- SPAN_ATTITUDES_Plot$layers[-c(4, 5)]
# # Display the updated plot
# SPAN_ATTITUDES_Plot
# # SPAN_ATTITUDES_Plot$data

# Save to PDF
ggsave("output/plots/language_use_and_attitudes/SPAN_ATTITUDES_Plot.pdf", SPAN_ATTITUDES_Plot, device = cairo_pdf, width = 17, height = 8)