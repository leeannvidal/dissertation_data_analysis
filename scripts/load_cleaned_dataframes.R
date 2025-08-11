
# Load main cleaned dfs from RDS files

coda_s <- readRDS("data/cleaned_data/coda_s_cleaned.rds")
fps <- readRDS("data/cleaned_data/fps_cleaned.rds")
pronouns <- readRDS("data/cleaned_data/pronouns_cleaned.rds")
subject_position <- readRDS("data/cleaned_data/subject_position_cleaned.rds")
subject_position_pronouns <- readRDS("data/cleaned_data/subject_position_pronouns_cleaned.rds")
general_subject_position <- readRDS("data/cleaned_data/general_subject_position_cleaned.rds")
liquids <- readRDS("data/cleaned_data/liquids_cleaned.rds")

# Load individual dfs for each PHONO_FORM for the Liquids
trill <- readRDS("data/cleaned_data/trill_cleaned.rds")
tap<- readRDS("data/cleaned_data/tap_cleaned.rds")
lateral<- readRDS("data/cleaned_data/lateral_cleaned.rds")

# Load covariation data rates

rates_all_variables <- readRDS("data/cleaned_data/rates_all_variables.rds")
rates_all_SIB <- readRDS("data/cleaned_data/rates_SIB_80speakers.rds")

#Load socio df

socio_df <- read.csv("/Users/leeannvidal/Desktop/Dissertation/data/dataframes/Social_Data/SIB_Socio_Anonymized.csv", stringsAsFactors = TRUE) # CLEAN & READY

DISSERTATION_SPEAKERS <- c("001PR", "004DR", "008PR", "011DR", "013DR", "018EL_DR", 
                           "025PR", "029DR", "032DR", "036DR", "038PR", "042DR", 
                           "043PR", "047PR", "048DR", "049PR", "051DR", "057PR", 
                           "059PR", "078PR", "079PR", "089DR")

#SUBSET MY SPEAKERS
socio_df_diss <-socio_df %>% 
  filter(SPEAKER %in% DISSERTATION_SPEAKERS)

#Load SIB
coda_s_SIB <- readRDS("data/cleaned_data/coda_s_cleaned_ALL_SIB.rds")
fps_SIB <- readRDS("data/cleaned_data/fps_cleaned_ALL_SIB.rds")
pronouns_SIB <- readRDS("data/cleaned_data/pronouns_cleaned_ALL_SIB.rds")
subject_position_SIB <- readRDS("data/cleaned_data/subject_position_cleaned_ALL_SIB.rds")
subject_position_pronouns_SIB <- readRDS("data/cleaned_data/subject_position_pronouns_cleaned_ALL_SIB.rds")
general_subject_position_SIB <- readRDS("data/cleaned_data/general_subject_position_cleaned_ALL_SIB.rds")