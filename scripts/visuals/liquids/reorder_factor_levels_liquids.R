# scripts/visuals/liquids/reorder_factor_levels_liquids.R

# #re-order factor levels

# liquids$SURF_FORM <- factor(liquids$SURF_FORM, levels=c("[ɾ]", "[r]", "[r̝]", "[ɹ]", "[ɽ]", "[l]", "[ɫ]", "[x]", "[v]", "[ð]", "[i]", "[h]", "[ʔ]", "[∅]"))
# liquids$SURF_FORM_TYPE <- factor(liquids$SURF_FORM_TYPE, levels = c("rhotic", "lateral", "neutralization"))
# unique(liquids$SURF_FORM)

liquids$POS_SYL<- factor(liquids$POS_SYL, levels = c("onset", "coda"))
liquids$POS_WORD <- factor(liquids$POS_WORD, levels = c("initial", "internal", "final"))
liquids$SYL_TYPE <- factor(liquids$SYL_TYPE, levels = c("open", "closed"))
liquids$STRESS<- factor(liquids$STRESS, levels = c("stressed", "unstressed"))
liquids$WORD_CLASS <-  factor(liquids$WORD_CLASS, levels = c("noun", "verb", "determiner", "adjective", "conjunction", "adverb", "preposition", "pronoun"))