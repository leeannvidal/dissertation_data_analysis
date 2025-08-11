# load_dataframes.R

# Load the data frames directly from their respective paths

liquids <- read.csv("/Users/leeannvidal/Desktop/Dissertation/data/dataframes/aggregates/liquids_master_df_LVC_dissertation.csv", stringsAsFactors = TRUE) # CLEAN & READY

s <- read.csv("/Users/leeannvidal/Desktop/Dissertation/data/dataframes/Dissertation_Masters/s_dissertation_df.csv", stringsAsFactors = TRUE) # CLEAN & READY

fps <- read.csv("/Users/leeannvidal/Desktop/Dissertation/data/dataframes/Dissertation_Masters/fps_dissertation_df.csv", stringsAsFactors = TRUE) # CLEAN & READY

pronouns <- read.csv("/Users/leeannvidal/Desktop/Dissertation/data/dataframes/Dissertation_Masters/pronouns_dissertation_df.csv", stringsAsFactors = TRUE) # CLEAN & READY

subject_position <- read.csv("/Users/leeannvidal/Desktop/Dissertation/data/dataframes/Dissertation_Masters/sub_pos_dissertation_df.csv", stringsAsFactors = TRUE) # CLEAN & READY
