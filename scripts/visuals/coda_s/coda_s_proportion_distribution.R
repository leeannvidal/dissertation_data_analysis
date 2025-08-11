# coda_s_proportion_distribution.R

# Load necessary functions
# source("functions/basic_custom_theme.R")

# Summarize data
coda_s_summary <- coda_s %>%
  group_by(PHONETIC_PHONOLOGICAL_AGREEMENT) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count))

# Create the plot
coda_s_match_proportion_distribution <- ggplot(coda_s_summary, aes(x=PHONETIC_PHONOLOGICAL_AGREEMENT, y=proportion, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_bar(stat="identity") +
  geom_label(
    aes(label=paste("Count: ", count, "\n(", percent(proportion), ")", sep="")),
    position=position_stack(vjust=0.5),
    color="white",
    family = "charis"
  ) +
  scale_y_continuous(labels=scales::percent) +
  labs(
    title = "What is the proportional Phonetic/Phonological \n Agreement for coda /s/?",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
    # x = paste("Total coda /s/ count = ", sum(coda_s_summary$count),"\n"),
    x = paste("total count = ", sum(coda_s_summary$count)),
    y = "Proportion\n"
  ) +
  scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  # scale_fill_economist() +
  scale_x_discrete(position = "top") +
  basic_custom_theme()

coda_s_match_proportion_distribution

# Save to PDF
ggsave("output/plots/coda_s/coda_s_match_proportion_distribution.pdf", coda_s_match_proportion_distribution, device = cairo_pdf, width = 8, height = 5)
