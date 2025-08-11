# subject_position_pronouns_proportion_distribution.R

# Summarize data
subject_position_summary <- subject_position_pronouns %>%
  group_by(SUB_POSITION) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count))

# Create the plot
pronoun_subject_position_proportion_distribution <- ggplot(subject_position_summary, aes(x=SUB_POSITION, y=proportion, fill=SUB_POSITION)) +
  geom_bar(stat="identity") +
  geom_label(
    aes(label=paste("Count: ", count, "\n(", percent(proportion), ")", sep="")),
    position=position_stack(vjust=0.5),
    color="white"
  ) +
  scale_y_continuous(labels=percent_format()) +
  labs(
    title = "What is the proportional distribution between\npre-verbal and post-verbal Subject Pronouns?",
    caption = "\n Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    x = paste("total count = ", nrow(subject_position_pronouns), "\n Subject Position : Pronouns"),
    y = "Proportion\n"
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  # scale_fill_economist() +
  scale_x_discrete(position = "top") +
  basic_custom_theme()

pronoun_subject_position_proportion_distribution

# Save to PDF
ggsave("output/plots/subject_position/pronoun_subject_position_proportion_distribution.pdf", pronoun_subject_position_proportion_distribution, device = cairo_pdf, width = 8, height = 5)
