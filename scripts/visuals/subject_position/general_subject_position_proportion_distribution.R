# general_subject_positionproportion_distribution.R

# Check for NA values in the dataset
general_subject_position <- general_subject_position %>% filter(!is.na(SUB_POSITION))

# Summarize data
general_subject_position_summary <- general_subject_position %>%
  group_by(SUB_POSITION) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count))

# Create the plot
general_subject_position_proportion_distribution <- ggplot(general_subject_position_summary, aes(x=SUB_POSITION, y=proportion, fill=SUB_POSITION)) +
  geom_bar(stat="identity") +
  geom_label(
    aes(label=paste("Count: ", count, "\n(", percent(proportion), ")", sep="")),
    position=position_stack(vjust=0.5),
    color="white"
  ) +
  scale_y_continuous(labels=percent_format()) +
  labs(
    title = "What is the proportional distribution between\npre-verbal and post-verbal General Subjects?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    x = paste("total count = ", nrow(general_subject_position), "\n Subject Position : General Subjects"),
    y = "Proportion\n"
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  # scale_fill_economist() +
  scale_x_discrete(position = "top") +
  basic_custom_theme()

general_subject_position_proportion_distribution

# Save to PDF
ggsave("output/plots/subject_position/general_subject_position_proportion_distribution.pdf", general_subject_position_proportion_distribution, device = cairo_pdf, width = 8, height = 5)
