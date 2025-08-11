# pronouns_proportion_distribution.R

# Summarize data
pronouns_summary <- pronouns %>%
  group_by(PRONOUN) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count))

# Create the plot
SPP_proportion_distribution <- ggplot(pronouns_summary, aes(x=PRONOUN, y=proportion, fill=PRONOUN)) +
  geom_bar(stat="identity") +
  geom_label(
    aes(label=paste("Count: ", count, "\n(", percent(proportion), ")", sep="")),
    position=position_stack(vjust=0.5),
    color="white",
    family = "charis"
  ) +
  scale_y_continuous(labels=scales::percent) +
  labs(
    title = "What is the proportional distribution between\npresent vs. absent Subject Pronouns?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    # x = paste("total count = ", nrow(pronouns), "\n Subject Pronouns"),
    x = paste("total count = ", nrow(pronouns)),
    # x = paste("total subject pronoun count = ", nrow(pronouns),"\n"),
    y = "Proportion\n"
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  # scale_fill_economist() +
  scale_x_discrete(position = "top") +
  basic_custom_theme()

SPP_proportion_distribution

# Save to PDF
ggsave("output/plots/pronouns/SPP_proportion_distribution.pdf", SPP_proportion_distribution, device = cairo_pdf, width = 8, height = 5)
