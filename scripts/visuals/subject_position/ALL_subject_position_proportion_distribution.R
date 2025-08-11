# all_subject_position_proportion_distribution.R

# Check for NA values in the dataset
subject_position <- subject_position %>% filter(!is.na(SUB_POSITION))

# Summarize data
subject_position_summary <- subject_position %>%
  group_by(SUB_POSITION) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count))

# Create the plot
subject_position_proportion_distribution <- ggplot(subject_position_summary, aes(x=SUB_POSITION, y=proportion, fill=SUB_POSITION)) +
  geom_bar(stat="identity") +
  geom_label(
    aes(label=paste("Count: ", count, "\n(", percent(proportion), ")", sep="")),
    position=position_stack(vjust=0.5),
    color="white",
    family = "charis"
  ) +
  scale_y_continuous(labels=percent_format()) +
  labs(
    title = "What is the proportional distribution between\npre-verbal and post-verbal Subjects?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    # x = paste("total count = ", nrow(subject_position), "\n Subject Position"),
    x = paste("total count = ", nrow(subject_position)),
    y = "Proportion\n"
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  # scale_fill_economist() +
  scale_x_discrete(position = "top") +
  basic_custom_theme()

subject_position_proportion_distribution

# Save to PDF
ggsave("output/plots/subject_position/all_subject_position_proportion_distribution.pdf", subject_position_proportion_distribution, device = cairo_pdf, width = 8, height = 5)
