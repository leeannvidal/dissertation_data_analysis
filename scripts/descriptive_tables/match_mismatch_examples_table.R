
## Filter and prepare the data

unique(liquids$SURF_FORM)
unique(liquids$PHONETIC_PHONOLOGICAL_AGREEMENT)

# Add an ID column for reference
mis_match_examples_tbl <- liquids %>%
  mutate(id = row_number()) %>%
  # Select relevant columns
  select(HOSTWORD, PHONO_FORM, SURF_FORM, PHONETIC_PHONOLOGICAL_AGREEMENT) %>%
  # Randomly sample a specified number of rows
  sample_n(size = 10)

print(mis_match_examples_tbl)
# shortstack{\textsc{Host} \\ \textsc{Word}}  & 
#   \shortstack{\textsc{Phonological} \\ \textsc{Form}} & 
#   \shortstack{\textsc{Surface} \\ \textsc{Form}} & 
#   \shortstack{\textsc{Match/} \\ \textsc{Mismatch}} \\

# Create and save the LaTeX table
mis_match_examples_tbl %>%
  kbl("latex", booktabs = TRUE, escape = FALSE, 
      align = c("c", "c", "c", "c"), 
      # caption = "Example of Acoustic Descriptions", label = "acoustic", 
      col.names = c(
        "\\shortstack{\\textsc{Host} \\\\ \\textsc{Word}}",
        "\\shortstack{\\textsc{Phono} \\\\ \\textsc{Form}}",
        "\\shortstack{\\textsc{Surface} \\\\ \\textsc{Form}}",
        "\\shortstack{\\textsc{Match/} \\\\ \\textsc{Mismatch}}"
      )) %>%
  kable_styling(latex_options = c("striped"), font_size = 8) %>%
  column_spec(1:2, width = "10em") %>%
  column_spec(3:4, width = "8em") %>%
  # footnote(fixed_small_size = T, general = c("\\emph{Source:} {Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers}"),
           # threeparttable=T) %>% 
  save_kable(file = "output/tables/descriptive/mis_match_examples_tbl.tex")