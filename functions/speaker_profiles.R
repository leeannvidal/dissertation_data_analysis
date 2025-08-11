# Load necessary libraries
library(dplyr)
library(stringr) # For capitalizing pseudonyms

#Load socio
socio_df <- read.csv("/Users/leeannvidal/Desktop/Dissertation/data/dataframes/Spanish_In_Boston_PR_DR_Socio_Spreadsheet.csv")

# socio_df <- read.csv("/Users/leeannvidal/Desktop/SIB_Extraction/Spanish_in_Boston_Master_Spreadsheet.csv")

#Drop columns from socio df
socio_df <- select(socio_df, c(SPEAKER, PSEUDONYM:PERCENT_DOMAINS_USE_SPAN_LITTLE))

#Create dummy variable with only my speakers

DISSERTATION_SPEAKERS <- c("001PR", "004DR", "008PR", "011DR", "013DR", "018EL_DR", 
                           "025PR", "029DR", "032DR", "036DR", "038PR", "042DR", 
                           "043PR", "047PR", "048DR", "049PR", "051DR", "057PR", 
                           "059PR", "078PR", "079PR", "089DR")

#SUBSET MY SPEAKERS
dissertation_speakers <-socio_df %>% 
  filter(SPEAKER %in% DISSERTATION_SPEAKERS)

# # Specify the range of column indices you want
start_col <- 5
end_col <- 112
# 
# # Print the column names within the range
# colnames(liquids)[start_col:end_col]

# Loop through the selected range of columns
for (col in colnames(dissertation_speakers)[start_col:end_col]) {
  cat("\nColumn:", col, "\n")
  
  if (is.factor(dissertation_speakers[[col]])) {
    cat("Levels:", levels(dissertation_speakers[[col]]), "\n")
  } else {
    cat("Unique values:", unique(dissertation_speakers[[col]]), "\n")
  }
}


# Function to format a list with "and" before the last item
format_list_with_and <- function(items) {
  if (length(items) == 1) {
    return(items)
  } else if (length(items) == 2) {
    return(paste(items, collapse = " and "))
  } else {
    return(paste0(paste(items[-length(items)], collapse = ", "), ", and ", items[length(items)]))
  }
}

# Function to generate a speaker profile
generate_speaker_profile <- function(person) {
  profile <- c()
  
  # Ensure PSEUDONYM starts with a capital letter
  pseudonym <- str_to_title(person$PSEUDONYM)
  
  # Convert COUNTRY_OF_ORIGIN to Nationality
  nationality <- ifelse(person$COUNTRY_OF_ORIGIN == "pr", "Puerto Rican",
                        ifelse(person$COUNTRY_OF_ORIGIN == "dr", "Dominican",
                               # ifelse(person$COUNTRY_OF_ORIGIN == "el", "Salvadoran",
                                      ifelse(person$COUNTRY_OF_ORIGIN == "el_dr", "Dominican-Salvadoran", NA)))#)
  
  
  # Convert IMMIGRATION_CATEGORY
  immigration_category <- ifelse(person$IMMIGRATION_CATEGORY == "recent_arrival", "recently arrived",
                                 ifelse(person$IMMIGRATION_CATEGORY == "est_immigrant", "established",
                                        ifelse(person$IMMIGRATION_CATEGORY == "us_born", "US Born", NA)))
  
  # First paragraph
  profile <- c(profile, paste0(pseudonym, " is a ", person$AGE, "-year-old ",
                               immigration_category, " ", nationality, " ", person$SEX, ". ",
                               ifelse(person$PLUS == 100,
                                      paste0("They have spent ", person$PLUS, "\\% of their life in the U.S."),
                                      paste0("They arrived in the U.S. at the age of ", person$AOA, 
                                             " and have spent ", person$PLUS, "\\% of their life in the U.S."))))
  
  
  # # Basic Demographics
  # if (!is.na(person$JOB_US)) {
  #   profile <- c(profile, paste0("At the time of the interview, they worked as a ", person$JOB_US, "."))
  # }
  # if (!is.na(person$JOB_COUNTRY_OF_ORIGIN)) {
  #   profile <- c(profile, paste0("Previously, they worked as a ", person$JOB_COUNTRY_OF_ORIGIN, " in their place of origin."))
  # }
  
  # Basic Demographics - Job in the U.S.
  if (!is.na(person$JOB_US)) {
    job_us <- ifelse(person$JOB_US == "student", "a student",
                     ifelse(person$JOB_US == "painter_driver", "a painter and driver",
                            ifelse(person$JOB_US == "salesperson", "a salesperson",
                                   ifelse(person$JOB_US == "missionary", "a missionary",
                                          ifelse(person$JOB_US == "teacher", "a teacher",
                                                 ifelse(person$JOB_US == "supervisor", "a supervisor",
                                                        ifelse(person$JOB_US == "carpenter", "a carpenter",
                                                               ifelse(person$JOB_US == "nonprofit_employee", "a nonprofit employee",
                                                                      ifelse(person$JOB_US == "account_manager", "an account manager",
                                                                             ifelse(person$JOB_US == "engineer", "an engineer",
                                                                                    ifelse(person$JOB_US == "construction", "in construction",
                                                                                           ifelse(person$JOB_US == "food_service", "in the food service industry", NA))))))))))))

    if (!is.na(job_us)) {
      if (person$JOB_US == "student") {
        profile <- c(profile, "At the time of the interview, they were a student.")
      } else {
        profile <- c(profile, paste0("At the time of the interview, they worked ", 
                                     ifelse(person$JOB_US %in% c("construction", "food_service"), "", "as "), 
                                     job_us, "."))
      }
    }
  }
  
  # Basic Demographics - Job in Country of Origin
  if (!is.na(person$JOB_COUNTRY_OF_ORIGIN) && person$JOB_COUNTRY_OF_ORIGIN != "student") {
    job_origin <- ifelse(person$JOB_COUNTRY_OF_ORIGIN == "government_employee", "a government employee",
                                ifelse(person$JOB_COUNTRY_OF_ORIGIN == "salesperson", "a salesperson",
                                       ifelse(person$JOB_COUNTRY_OF_ORIGIN == "missionary", "a missionary",
                                              ifelse(person$JOB_COUNTRY_OF_ORIGIN == "accountant", "an accountant",
                                                     ifelse(person$JOB_COUNTRY_OF_ORIGIN == "engineer", "an engineer",
                                                            ifelse(person$JOB_COUNTRY_OF_ORIGIN == "marketing", "in marketing", NA))))))

if (!is.na(job_origin)) {
  profile <- c(profile, paste0("Previously, they worked ",
                               ifelse(person$JOB_COUNTRY_OF_ORIGIN == "marketing", "", "as "), 
                               job_origin, " in their place of origin."))
}
  }
  
  
  # Education
  education_place <- ifelse(person$WHERE_EDUCATION == "outside_us", "outside the US",
                            ifelse(person$WHERE_EDUCATION == "us", "in the US",
                                   ifelse(person$WHERE_EDUCATION == "mixed", "in both the US and outside", NA)))
  
  if (!is.na(education_place)) {
    profile <- c(profile, paste0("They were educated ", education_place, "."))
  }
  if (!is.na(person$EDUCATION_LEVEL)) {
    profile <- c(profile, paste0("The highest level of education completed was ", person$EDUCATION_LEVEL, "."))
  }
  if (!is.na(person$SOCIAL_CLASS)) {
    profile <- c(profile, paste0("They consider themselves ", person$SOCIAL_CLASS, " class."))
  }
  


  # # Language Acquisition
  # How they learned their second language (Move this section to the top)
  learn_sources <- c()
  if (!is.na(person$LEARNED_L2_SCHOOL) && person$LEARNED_L2_SCHOOL == "yes") learn_sources <- c(learn_sources, "school")
  if (!is.na(person$LEARNED_L2_TV) && person$LEARNED_L2_TV == "yes") learn_sources <- c(learn_sources, "TV")
  if (!is.na(person$LEARNED_L2_FAMILY) && person$LEARNED_L2_FAMILY == "yes") learn_sources <- c(learn_sources, "family")
  
  # English and Spanish Acquisition
  if (!is.na(person$LEARNED_FIRST)) {
    if (person$LEARNED_FIRST == "simultaneous") {
      if (length(learn_sources) > 0) {
        learned_text <- paste0("They learned both English and Spanish at the same time through ", format_list_with_and(learn_sources), ".")
      } else {
        learned_text <- "They learned both English and Spanish at the same time."
      }
      profile <- c(profile, learned_text)  # Store learned_text immediately
    } else {
      learned_text <- paste0("They learned ", str_to_title(person$LEARNED_FIRST), " as their first language.")
      profile <- c(profile, learned_text)
    }
  }
  
  # Age of second language acquisition and how they learned it
  if (!is.na(person$AGE_LEARNED_L2)) {
    if (!is.na(person$LEARNED_FIRST) && person$LEARNED_FIRST != "simultaneous" && length(learn_sources) > 0) {
      profile <- c(profile, paste0("They acquired their second language at the age of ", person$AGE_LEARNED_L2, " through ", format_list_with_and(learn_sources), "."))
    } else {
      profile <- c(profile, paste0("They acquired their second language at the age of ", person$AGE_LEARNED_L2, "."))
    }
  } else if (!is.na(person$LEARNED_FIRST) && person$LEARNED_FIRST != "simultaneous" && is.na(person$AGE_LEARNED_L2) && length(learn_sources) > 0) {
    # NEW CONDITION: If no age is given but learning sources exist
    profile <- c(profile, paste0("They acquired their second language through ", format_list_with_and(learn_sources), "."))
  }
  
  # Language Knowledge
  if (!is.na(person$LANG_KNOW_MORE)) {
    knowledge_text <- ifelse(person$LANG_KNOW_MORE == "both", 
                             "They report that they know both English and Spanish equally.", 
                             paste0("They report that they know ", str_to_title(person$LANG_KNOW_MORE), " better."))
    profile <- c(profile, knowledge_text)
  }
  
  if (!is.na(person$LANG_LIKE_MORE)) {
    preference_text <- ifelse(person$LANG_LIKE_MORE == "both", 
                              "They like speaking both English and Spanish equally.", 
                              paste0("They prefer speaking ", str_to_title(person$LANG_LIKE_MORE), "."))
    profile <- c(profile, preference_text)
  }
  
  if (!is.na(person$ENG_PROF)) {
    eng_prof <- ifelse(person$ENG_PROF == "very_good", "very good", person$ENG_PROF)
    profile <- c(profile, paste0("Their English proficiency is ", eng_prof, "."))
  }
  
  if (!is.na(person$SPAN_PROF)) {
    span_prof <- ifelse(person$SPAN_PROF == "very_good", "very good", person$SPAN_PROF)
    profile <- c(profile, paste0("Their Spanish proficiency is ", span_prof, "."))
  }
  
  # Treat 0 values as missing (NA)
  PERCENT_INTL_BOTH <- ifelse(is.na(person$PERCENT_INTL_BOTH) || person$PERCENT_INTL_BOTH == 0, NA, person$PERCENT_INTL_BOTH)
  PERCENT_INTL_SPAN_ONLY <- ifelse(is.na(person$PERCENT_INTL_SPAN_ONLY) || person$PERCENT_INTL_SPAN_ONLY == 0, NA, person$PERCENT_INTL_SPAN_ONLY)
  PERCENT_INTL_ENG_ONLY <- ifelse(is.na(person$PERCENT_INTL_ENG_ONLY) || person$PERCENT_INTL_ENG_ONLY == 0, NA, person$PERCENT_INTL_ENG_ONLY)
  
  # Function to format percentage with LaTeX escape
  latex_percent <- function(value) {
    if (!is.na(value)) return(paste0(value, "\\%"))
    return(NA)
  }
  
  if (!is.na(PERCENT_INTL_BOTH) && !is.na(PERCENT_INTL_SPAN_ONLY) && !is.na(PERCENT_INTL_ENG_ONLY)) {
    language_use <- paste0("They report using only English with interlocutors ", latex_percent(PERCENT_INTL_ENG_ONLY), " of the time, ",
                           "only Spanish ", latex_percent(PERCENT_INTL_SPAN_ONLY), " of the time, and a mix of both languages ",
                           latex_percent(PERCENT_INTL_BOTH), " of the time.")
  } else if (!is.na(PERCENT_INTL_SPAN_ONLY) && !is.na(PERCENT_INTL_ENG_ONLY)) {
    language_use <- paste0("They report using only English with interlocutors ", latex_percent(PERCENT_INTL_ENG_ONLY), " of the time ",
                           "and only Spanish ", latex_percent(PERCENT_INTL_SPAN_ONLY), " of the time.")
  } else if (!is.na(PERCENT_INTL_BOTH) && !is.na(PERCENT_INTL_ENG_ONLY)) {
    language_use <- paste0("They report using only English with interlocutors ", latex_percent(PERCENT_INTL_ENG_ONLY), " of the time ",
                           "and a mix of both English and Spanish ", latex_percent(PERCENT_INTL_BOTH), " of the time.")
  } else if (!is.na(PERCENT_INTL_BOTH) && !is.na(PERCENT_INTL_SPAN_ONLY)) {
    language_use <- paste0("They report using only Spanish with interlocutors ", latex_percent(PERCENT_INTL_SPAN_ONLY), " of the time ",
                           "and a mix of both English and Spanish ", latex_percent(PERCENT_INTL_BOTH), " of the time.")
  } else if (!is.na(PERCENT_INTL_ENG_ONLY)) {
    language_use <- paste0("They report using only English with interlocutors ", latex_percent(PERCENT_INTL_ENG_ONLY), " of the time.")
  } else if (!is.na(PERCENT_INTL_SPAN_ONLY)) {
    language_use <- paste0("They report using only Spanish with interlocutors ", latex_percent(PERCENT_INTL_SPAN_ONLY), " of the time.")
  } else if (!is.na(PERCENT_INTL_BOTH)) {
    language_use <- paste0("They report using a mix of both English and Spanish with interlocutors ", latex_percent(PERCENT_INTL_BOTH), " of the time.")
  }
  
  # Add to profile if there is a valid sentence
  if (length(language_use) > 0) {
    profile <- c(profile, language_use)
  }
  
  # Language Ideologies
  if (!is.na(person$ETHN_IF_ENG_ONLY)) {
    ethn_statement <- ifelse(person$ETHN_IF_ENG_ONLY == "yes", 
                             paste0("They believe that it is possible to be ", nationality, " and only speak English."), 
                             paste0("They believe that it is not possible to be ", nationality, " and only speak English."))
    profile <- c(profile, ethn_statement)
  }
  
  if (!is.na(person$AMER_IF_SPAN_ONLY)) {
    amer_statement <- ifelse(person$AMER_IF_SPAN_ONLY == "yes", 
                             "They believe that it is possible to be American and only speak Spanish.", 
                             "They believe that it is not possible to be American and only speak Spanish.")
    profile <- c(profile, amer_statement)
  }
  
  # Opinions on Bilingual Education
  if (!is.na(person$BILNG_ED_OPIN)) {
    profile <- c(profile, paste0("Their opinion on bilingual education is ", person$BILNG_ED_OPIN, "."))
  }
  
  # Bilingual Services Opinions
  bilingual_support <- c()
  bilingual_against <- c()
  
  if (!is.na(person$BILNG_SERV_DRIVE)) {
    if (person$BILNG_SERV_DRIVE == "pro") bilingual_support <- c(bilingual_support, "driver’s license exams")
    if (person$BILNG_SERV_DRIVE == "against") bilingual_against <- c(bilingual_against, "driver’s license exams")
  }
  if (!is.na(person$BILNG_SERV_VOTE)) {
    if (person$BILNG_SERV_VOTE == "pro") bilingual_support <- c(bilingual_support, "voting booths")
    if (person$BILNG_SERV_VOTE == "against") bilingual_against <- c(bilingual_against, "voting booths")
  }
  if (!is.na(person$BILNG_SERV_MEDICAL)) {
    if (person$BILNG_SERV_MEDICAL == "pro") bilingual_support <- c(bilingual_support, "medical services")
    if (person$BILNG_SERV_MEDICAL == "against") bilingual_against <- c(bilingual_against, "medical services")
  }
  
  if (length(bilingual_support) > 0 && length(bilingual_against) == 0) {
    profile <- c(profile, paste0("They support bilingual services in ", format_list_with_and(bilingual_support), "."))
  } else if (length(bilingual_against) > 0 && length(bilingual_support) == 0) {
    profile <- c(profile, paste0("They are against bilingual services in ", format_list_with_and(bilingual_against), "."))
  } else if (length(bilingual_support) > 0 && length(bilingual_against) > 0) {
    profile <- c(profile, paste0("They support bilingual services in ", format_list_with_and(bilingual_support), 
                                 " and are against bilingual services in ", format_list_with_and(bilingual_against), "."))
  }
  
  # Spanish Maintenance & Ideologies
  if (!is.na(person$USE_SAME_SPAN)) {
    profile <- c(profile, ifelse(person$USE_SAME_SPAN == "yes", 
                                 "They believe that Spanish speakers in Boston should maintain their national group's Spanish.", 
                                 "They believe that Spanish speakers in Boston should not maintain their national group's Spanish."))
  }
  
  if (!is.na(person$NO_USE_DIFF_SPAN)) {
    profile <- c(profile, ifelse(person$NO_USE_DIFF_SPAN == "yes", 
                                 "They believe that Spanish speakers in Boston should avoid unfamiliar words for other Spanish speakers.", 
                                 "They believe that Spanish speakers in Boston should not avoid unfamiliar words for other Spanish speakers."))
  }
  
  if (!is.na(person$LEARN_CASTELLANO)) {
    profile <- c(profile, ifelse(person$LEARN_CASTELLANO == "yes", 
                                 "They believe that Spanish speakers in Boston should learn Castilian Spanish.", 
                                 "They believe that Spanish speakers in Boston should not learn Castilian Spanish."))
  }
  
  if (!is.na(person$TEACH_ETHN_SPAN)) {
    profile <- c(profile, ifelse(person$TEACH_ETHN_SPAN == "yes", 
                                 "They believe that their Spanish should be taught in schools.", 
                                 "They believe that their Spanish should not be taught in schools."))
  }
  
  if (!is.na(person$KEEP_SPAN)) {
    profile <- c(profile, "They believe that US Spanish speakers should maintain their Spanish.")
    
    if (!is.na(person$KEEP_SPAN_IMPT)) {
      importance_text <- ifelse(person$KEEP_SPAN_IMPT == "important", 
                                "They believe that it is important that US Spanish speakers maintain their Spanish.",
                                ifelse(person$KEEP_SPAN_IMPT == "very_important", 
                                       "They believe that it is very important that US Spanish speakers maintain their Spanish.",
                                       "They believe that it is not important that US Spanish speakers maintain their Spanish."))
      profile <- c(profile, importance_text)
    }
  }
  
  # National Identification Preferences
  identification_responses <- c()
  nationalities <- c("Colombian" = person$LIKE_SIM_CO, "Cuban" = person$LIKE_SIM_CU, 
                     "Dominican" = person$LIKE_SIM_DR, "Guatemalan" = person$LIKE_SIM_GU, 
                     "Mexican" = person$LIKE_SIM_ME, "Puerto Rican" = person$LIKE_SIM_PR, 
                     "Salvadoran" = person$LIKE_SIM_EL, "Peruvian" = person$LIKE_SIM_PU)
  
  nationalities <- nationalities[!is.na(nationalities)]  # Remove NAs
  
  if (length(nationalities) > 0) {
    indifferent <- names(nationalities)[nationalities == "indifferent"]
    dislike <- names(nationalities)[nationalities == "dislike"]
    like <- names(nationalities)[nationalities == "like"]
    
    preference_parts <- c()
    
    if (length(indifferent) > 0) {
      preference_parts <- c(preference_parts, paste0("be indifferent if someone identified them as ", format_list_with_and(indifferent)))
    }
    if (length(dislike) > 0) {
      preference_parts <- c(preference_parts, paste0("dislike being identified as ", format_list_with_and(dislike)))
    }
    if (length(like) > 0) {
      preference_parts <- c(preference_parts, paste0("like being identified as ", format_list_with_and(like)))
    }
    
    if (length(preference_parts) > 1) {
      profile <- c(profile, paste0("They said they would ", paste(preference_parts, collapse = " and "), "."))
    } else {
      profile <- c(profile, paste0("They said they would ", preference_parts, "."))
    }
  }
  # Spanish Dialect Perception
  dialect_responses <- c()
  dialects <- c("Colombians" = person$CO_SPAN_DIFF, "Dominicans" = person$DR_SPAN_DIFF, "Guatemalan" = person$GU_SPAN_DIFF, 
                "Mexicans" = person$ME_SPAN_DIFF, "Puerto Ricans" = person$PR_SPAN_DIFF, 
                "Salvadorans" = person$EL_SPAN_DIFF, "Peruvians" = person$PU_SPAN_DIFF)
  
  dialects <- dialects[!is.na(dialects)]  # Remove NAs
  
  if (length(dialects) > 0) {
    different <- names(dialects)[dialects == "yes"]
    not_different <- names(dialects)[dialects == "no"]
    
    if (length(different) > 0 && length(not_different) == 0) {
      profile <- c(profile, paste0("They think that the Spanish spoken by ", format_list_with_and(different), " is different."))
    } else if (length(not_different) > 0 && length(different) == 0) {
      profile <- c(profile, paste0("They think that the Spanish spoken by ", format_list_with_and(not_different), " is not different."))
    } else if (length(different) > 0 && length(not_different) > 0) {
      profile <- c(profile, paste0("They think that the Spanish spoken by ", format_list_with_and(different), 
                                   " is different but believe that the Spanish spoken by ", 
                                   format_list_with_and(not_different), " is not different."))
    }
  }
  
  # if (!is.na(person$RETURN_OR_STAY)) {
  #   profile <- c(profile, paste0("When asked about their future plans, they indicated they would ", person$RETURN_OR_STAY, " their place of origin."))
  # }
  
  return(paste(profile, collapse = " "))
}


generate_all_profiles <- function(df) {
  for (i in 1:nrow(df)) {
    cat("\n--------------------------------------------------\n")
    cat(generate_speaker_profile(df[i, ]))
    cat("\n--------------------------------------------------\n")
  }
}

# Run the function to generate all profiles
generate_all_profiles(dissertation_speakers)