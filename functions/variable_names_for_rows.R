# This is so that I can just call this once and the tables can replace the names correctly without having to do it more than once
# Modify as needed
# Define a named vector where the names are the original variables, and the values are the desired labels
variable_names <- c(
  # individual variable names without levels
  "(Intercept)" = "Intercept",
  "LOG_LEX_FREQ_DF_N" = " Log Lexical Frequency",
  "MS_PER_SYLL_SCALED" = " Milliseconds per Syllable",
  "PLUS" = "PLUS",
  "~" = "\\\\textasciitilde",
  "PERCENT_INTL_ENG_ONLY" = "% English Only w Interlocutors", ### Visuals
  "PERCENT_INTL_SPAN_ONLY" = "% Spanish Only w Interlocutors", ### Visuals
  # "PERCENT_INTL_ENG_ONLY" = " \\% English Only w Interlocutors", ## LaTeX tables
  # "PERCENT_INTL_SPAN_ONLY" = " \\% Spanish Only w Interlocutors", ## LaTeX tables
  "COUNTRY_OF_ORIGIN" = " Country of Origin",
  "IMMIGRATION_CATEGORY" = " Immigration Category",
  "PREV_SOUND_CATEGORY" = " Previous Sound Category",
  "FOLL_SOUND_CATEGORY" = " Following Sound Category",
  "POS_WORD" = " Position in Word",
  "POS_SYL" = " Position in Syllable",
  "SYL_TYPE" = " Syllable Type",
  "STRESS" = " Stress",
  "SEX" = " Sex",
  "AGE" = " Age",
  # Variables with Reference Categories; continuous variables excluded as they are already covered in the previous
  "COUNTRY_OF_ORIGINpr" = "Country of Origin \\footnotesize\\emph{(ref:DR)} \\\\ \\-\\hspace{0.3cm} Puerto Rico",
  "PREV_SOUND_CATEGORYpause" = "Previous Sound Category \\footnotesize\\emph{(ref:cons)} \\\\ \\-\\hspace{0.3cm} Pause",
  "PREV_SOUND_CATEGORYvowel" = " \\-\\hspace{0.3cm} Vowel",
  "FOLL_SOUND_CATEGORYpause" = "Following Sound Category \\footnotesize\\emph{(ref:cons)} \\\\ \\-\\hspace{0.3cm} Pause",
  "FOLL_SOUND_CATEGORYvowel" = " \\-\\hspace{0.3cm} Vowel",
  "POS_WORDinternal" = "Position in Word \\footnotesize\\emph{(ref:initial)} \\\\ \\-\\hspace{0.3cm} Internal",
  "POS_WORDfinal" = " \\-\\hspace{0.3cm} Final",
  "POS_SYLcoda" = "Position in Syllable \\footnotesize\\emph{(ref:onset)} \\\\ \\-\\hspace{0.3cm} Coda",
  "SYL_TYPEclosed" = "Syllable Type \\footnotesize\\emph{(ref:open)} \\\\ \\-\\hspace{0.3cm} Closed",
  "STRESSunstressed" = "Stress \\footnotesize\\emph{(ref:stressed)} \\\\ \\-\\hspace{0.3cm} Unstressed",
  "SEXmale" = "Sex \\footnotesize\\emph{(ref:female)} \\\\ \\-\\hspace{0.3cm} Male",
  # #  variable names with levels (for statistical models) ; continuous variables excluded as they are already covered in the previous
  # "COUNTRY_OF_ORIGINpr" = " Country of Origin: PR",
  # "COUNTRY_OF_ORIGINdr" = " Country of Origin: DR",
  # "PREV_SOUND_CATEGORYpause" = " Previous Sound Category: pause",
  # "PREV_SOUND_CATEGORYvowel" = " Previous Sound Category: vowel",
  # "PREV_SOUND_CATEGORYconsonant" = " Previous Sound Category: consonant",
  # "FOLL_SOUND_CATEGORYpause" = " Following Sound Category: pause",
  # "FOLL_SOUND_CATEGORYvowel" = " Following Sound Category: vowel",
  # "FOLL_SOUND_CATEGORYconsonant" = " Following Sound Category: consonant",
  # "POS_WORDinternal" = " Position in Word: internal",
  # "POS_WORDinitial" = " Position in Word: initial",
  # "POS_WORDfinal" = " Position in Word: final",
  # "POS_SYLonset" = " Position in Syllable: onset",
  # "POS_SYLcoda" = " Position in Syllable: coda",
  # "SYL_TYPEopen" = " Syllable Type: open",
  # "SYL_TYPEclosed" = " Syllable Type: closed",
  # "STRESSstressed" = " Stress: stressed",
  # "STRESSunstressed" = " Stress: unstressed",
  # "SEXfemale" = " Sex: female",
  # "SEXmale" = " Sex: male",
  "IMMIGRATION_CATEGORYest_immigrant" = " Immigration Cat: Established Immigrant",
  "IMMIGRATION_CATEGORYrecent_arrival" = " Immigration Cat: Recent Arrival",
  "IMMIGRATION_CATEGORYus_born" = " Immigration Cat: US Born"
)

#NAMES FOR SUMMARY TABLES
# Define a named vector where the names are the original variables, and the values are the desired labels
variable_names_summary_tables <- c(
  "SPEAKER" = "Speaker",
  "PSEUDONYM" = "Pseudonym",
  "SEX" = "Sex",
  "AGE" = "Age",
  "COUNTRY_OF_ORIGIN" = "Country of Origin",
  "AOA" = "AOA",
  "N_YRS_US" = "Years in US",
  "N_YRS_BOS" = "Years in Boston",
  "PLUS" = "PLUS",
  "SOCIAL_CLASS" = "Social Class",
  "EDUCATION_LEVEL" = "Education Level",
  "IMMIGRATION_CATEGORY" = "Immigration Category",
  "PERCENT_INTL_BOTH" = "\\% English \\& Spanish",
  "PERCENT_INTL_SPAN_ONLY" = "\\% Spanish Only",
  "PERCENT_INTL_ENG_ONLY" = "\\% English Only",
  "RATE_MISMATCH_ALL_LIQUIDS" = "All Liquids",
  "RATE_MISMATCH_TAP" = "Tap",
  "RATE_MISMATCH_TAP_SUBSET" = "/\\textfishhookr/ - [l]",
  "RATE_MISMATCH_TRILL" = "Trill",
  "RATE_MISMATCH_TRILL_SUBSET" = "/r/ - [$ \\underset{\\text{˔}}{\\text{r}} $]",
  "RATE_MISMATCH_LATERAL" = "Lateral",
  "RATE_MISMATCH_LATERAL_SUBSET" = "/l/ - [ɫ]",
  "RATE_MISMATCH_CODA_S" = "Coda /s/",
  "RATE_DELETION_CODA_S" = "Deletion Coda /s/",
  "RATE_CENTRALIZED_FPS" = "Centralized FPs",
  "RATE_PRONOUNS_PRESENT" = "Pronouns Present",
  "RATE_PREVERBAL_PRONOUNS" = "Preverbal Pronouns",
  "RATE_GEN_PREVERBAL_SUBJECTS" = "Gen Preverbal Subjects",
  "RATE_ALL_PREVERBAL_SUBJECTS" = "Preverbal Subjects"
)


# NAMES FOR SUMMARY TABLES
variable_names_summary_tables_latex <- c(
  "SPEAKER" = "\\textsc{Speaker}",
  "PSEUDONYM" = "\\textsc{Pseudonym}",
  "SEX" = "\\textsc{Sex}",
  "AGE" = "\\textsc{Age}",
  "COUNTRY_OF_ORIGIN" = "\\textsc{Country of Origin}",
  # "AOA" = "\\textsc{Age of Arrival}",
  "AOA" = "\\textsc{AOA}",
  "N_YRS_US" = "\\textsc{Years in US}",
  "N_YRS_BOS" = "\\textsc{Years in Boston}",
  "PLUS" = "\\textsc{PLUS}",
  "SOCIAL_CLASS" = "\\textsc{Social Class}",
  "EDUCATION_LEVEL" = "\\textsc{Education Level}",
  "IMMIGRATION_CATEGORY" = "\\textsc{Immigration Category}",
  "PERCENT_INTL_BOTH" = "\\textsc{\\% English \\& Spanish}",
  "PERCENT_INTL_SPAN_ONLY" = "\\textsc{\\% Spanish Only}",
  "PERCENT_INTL_ENG_ONLY" = "\\textsc{\\% English Only}",
  "RATE_MISMATCH_ALL_LIQUIDS" = "\\textsc{All Liquids}",
  "RATE_MISMATCH_TAP" = "\\textsc{Tap}",
  "RATE_MISMATCH_TAP_SUBSET" = "/\\textfishhookr/ - [l]",
  "RATE_MISMATCH_TRILL" = "\\textsc{Trill}",
  "RATE_MISMATCH_TRILL_SUBSET" = "/r/ - [$ \\underset{\\text{˔}}{\\text{r}} $]",
  "RATE_MISMATCH_LATERAL" = "\\textsc{Lateral}",
  "RATE_MISMATCH_LATERAL_SUBSET" = "/l/ - [ɫ]",
  "RATE_MISMATCH_CODA_S" = "\\textsc{Coda /s/}",
  "RATE_DELETION_CODA_S" = "\\textsc{Deletion Coda /s/}",
  "RATE_CENTRALIZED_FPS" = "\\textsc{Centralized FPs}",
  "RATE_PRONOUNS_PRESENT" = "\\textsc{Pronouns Present}",
  "RATE_PREVERBAL_PRONOUNS" = "\\textsc{Preverbal Pronouns}",
  "RATE_GEN_PREVERBAL_SUBJECTS" = "\\textsc{Gen Preverbal Subjects}",
  "RATE_ALL_PREVERBAL_SUBJECTS" = "\\textsc{All Preverbal Subjects}"
)


# NAMES FOR SUMMARY TABLES
variable_names_summary_tables_latex_shortstack <- c(
  "SPEAKER" = "\\textsc{Speaker}",
  "PSEUDONYM" = "\\textsc{Pseudonym}",
  "SEX" = "\\textsc{Sex}",
  "AGE" = "\\textsc{Age}",
  "COUNTRY_OF_ORIGIN" = "\\shortstack{\\textsc{Country} \\\\ \\textsc{of Origin}}",
  "REGIONAL_ORIGIN" = "\\shortstack{\\textsc{Regional} \\\\ \\textsc{Origin}}",
  "AOA" = "\\textsc{AOA}",
  # "AOA" = "\\shortstack{\\textsc{Age of} \\\\ \\textsc{Arrival}}",
  "N_YRS_US" = "\\shortstack{\\textsc{Years} \\\\ \\textsc{in US}}",
  "N_YRS_BOS" = "\\shortstack{\\textsc{Years} \\\\ \\textsc{in Boston}}",
  "SOCIAL_CLASS" = "\\shortstack{\\textsc{Social} \\\\ \\textsc{Class}}",
  "EDUCATION_LEVEL" = "\\shortstack{\\textsc{Education} \\\\ \\textsc{Level}}",
  "PLUS" = "\\textsc{PLUS}",
  "IMMIGRATION_CATEGORY" = "\\shortstack{\\textsc{Immigration} \\\\ \\textsc{Category}}",
  "PERCENT_INTL_BOTH" = "\\shortstack{\\textsc{\\% English} \\\\ \\textsc{\\& Spanish}}",
  "PERCENT_INTL_SPAN_ONLY" = "\\shortstack{\\textsc{\\% Spanish} \\\\ \\textsc{Only}}",
  "PERCENT_INTL_ENG_ONLY" = "\\shortstack{\\textsc{\\% English} \\\\ \\textsc{Only}}",
  
  # Mismatch rates formatted on two lines
  "RATE_MISMATCH_ALL_LIQUIDS" = "\\shortstack{\\textsc{All Liquids} \\\\ \\textsc{Mismatch}}",
  "RATE_MISMATCH_TAP" = "\\shortstack{\\textsc{Tap} \\\\ \\textsc{Mismatch}}",
  "RATE_MISMATCH_TAP_SUBSET" = "\\shortstack{/\\textfishhookr/ - [l] \\\\ \\textsc{Mismatch}}",
  "RATE_MISMATCH_TRILL" = "\\shortstack{\\textsc{Trill} \\\\ \\textsc{Mismatch}}",
  "RATE_MISMATCH_TRILL_SUBSET" = "\\shortstack{/r/ - [$ \\underset{\\text{˔}}{\\text{r}} $] \\\\ \\textsc{Mismatch}}",
  "RATE_MISMATCH_LATERAL" = "\\shortstack{\\textsc{Lateral} \\\\ \\textsc{Mismatch}}",
  "RATE_MISMATCH_LATERAL_SUBSET" = "\\shortstack{/l/ - [ɫ] \\\\ \\textsc{Mismatch}}",
  "RATE_MISMATCH_CODA_S" = "\\shortstack{\\textsc{Coda /s/} \\\\ \\textsc{Mismatch}}",
  
  # Other two-word variable names split properly
  "RATE_DELETION_CODA_S" = "\\shortstack{\\textsc{Deletion} \\\\ \\textsc{Coda /s/}}",
  "RATE_CENTRALIZED_FPS" = "\\shortstack{\\textsc{Centralized} \\\\ \\textsc{FPs}}",
  "RATE_PRONOUNS_PRESENT" = "\\shortstack{\\textsc{Pronouns} \\\\ \\textsc{Present}}",
  "RATE_PREVERBAL_PRONOUNS" = "\\shortstack{\\textsc{Preverbal} \\\\ \\textsc{Pronouns}}",
  "RATE_GEN_PREVERBAL_SUBJECTS" = "\\shortstack{\\textsc{Gen Preverbal} \\\\ \\textsc{Subjects}}",
  "RATE_ALL_PREVERBAL_SUBJECTS" = "\\shortstack{\\textsc{Preverbal} \\\\ \\textsc{Subjects}}"
)







