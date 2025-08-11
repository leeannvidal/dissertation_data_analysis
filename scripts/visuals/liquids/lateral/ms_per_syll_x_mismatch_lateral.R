# scripts/visuals/liquids/lateral/ms_per_syll_x_mismatch_lateral.R


#  Boxplot Comparing Speech Rate for Matches vs. Mismatches
ggplot(lateral, aes(x = PHONETIC_PHONOLOGICAL_AGREEMENT, y = MS_PER_SYLL)) +
  geom_boxplot() +
  labs(
    x = "Phonetic/Phonological Agreement", 
    y = "Speech Rate (ms per syllable)\n", 
    title = "Mean Speech Rate of /l/ by \nPhonetic/Phonological Agreement\n",
    caption = "Data Source: Spanish in Boston Corpus \n Vidal-Covas Dissertation") +
  # theme_minimal()
  basic_custom_theme()


# Density Plot to Compare Distributions
ggplot(lateral, aes(x = MS_PER_SYLL, fill = PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_density(alpha = 0.5) +
  labs(x = "Speech Rate (ms per syllable)\n", y = "Density\n", fill = "Agreement") +
  basic_custom_theme()

# Scatter Plot with Jitter

ggplot(lateral, aes(x = PHONETIC_PHONOLOGICAL_AGREEMENT, y = MS_PER_SYLL)) +
  geom_jitter(width = 0.2) +
  labs(x = "Phonetic/Phonological Agreement", y = "Speech Rate (ms per syllable)\n") +
  basic_custom_theme()


# Separate Histograms for Each Category
ggplot(lateral, aes(x = MS_PER_SYLL, fill = PHONETIC_PHONOLOGICAL_AGREEMENT)) +
  geom_histogram(aes(y = ..density..), alpha = 0.5, position = "identity", bins = 30) +
  labs(x = "Speech Rate (ms per syllable)\n", y = "Frequency\n", fill = "Agreement") +
  basic_custom_theme()


# Faceted Histograms
ggplot(lateral, aes(x = MS_PER_SYLL)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black") +
  facet_wrap(~ PHONETIC_PHONOLOGICAL_AGREEMENT) +
  labs(x = "Speech Rate (ms per syllable)\n", y = "Frequency\n") +
  basic_custom_theme()








speech_rate_mismatch_lateral