# filled_pauses_proportion_distribution.R

# Summarize data
fps_summary <- fps %>%
  group_by(CENTRALIZED_FPS) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count))

# Create the plot
fp_proportion_distribution <- ggplot(fps_summary, aes(x=CENTRALIZED_FPS, y=proportion, fill=CENTRALIZED_FPS)) +
  geom_bar(stat="identity") +
  geom_label(
    aes(label=paste("Count: ", count, "\n(", percent(proportion), ")", sep="")),
    position=position_stack(vjust=0.5),
    color="white",
    family = "charis"
  ) +
  scale_y_continuous(labels=scales::percent) +
  labs(
    title = "What is the proportional distribution of\nfilled pauses by centralization?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    # x = paste("total FP count = ", sum(fps_summary$count),"\n"),
    x = paste("total count = ", sum(fps_summary$count)),
    y = "Proportion\n"
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  # scale_fill_economist() +
  scale_x_discrete(position = "top") +
  basic_custom_theme()

fp_proportion_distribution

# Save to PDF
ggsave("output/plots/filled_pauses/fp_proportion_distribution.pdf", fp_proportion_distribution, device = cairo_pdf, width = 8, height = 5)
