
# scripts/visuals/liquids/all_liquids/create_label_with_count_for_main_liquids_df.R

# Create a label that includes total counts for the each liquid so that it can be used in the labels when faceting
liquids$PHONO_LABEL_W_COUNT  <- AddNameStat(liquids, "PHONO_FORM", "SURF_FORM", stat = "count")

liquids <- liquids %>% 
  relocate(PHONO_LABEL_W_COUNT, .after = PHONO_FORM)