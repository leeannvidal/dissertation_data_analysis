# scripts/visuals/liquids/all_liquids/liquids_distribution_surface_forms.R

# levels(liquids$PHONO_LABEL_W_COUNT)
# install.packages("tidytext")
# library(tidytext)

  # Calculate counts for each combination of SURF_FORM, PHONO_LABEL_W_COUNT, and PHONETIC_PHONOLOGICAL_AGREEMENT
  liquids_reordered <- liquids %>%
    group_by(PHONO_LABEL_W_COUNT, SURF_FORM, PHONETIC_PHONOLOGICAL_AGREEMENT) %>%
    summarise(count = n(), .groups = "drop") %>%
    arrange(PHONO_LABEL_W_COUNT, count, .desc = TRUE) %>%
    # 3. Add order column of row numbers
    mutate(order = row_number())
  
  # Plot using the reordered SURF_FORM within each facet
  liquid_distribution_surface_forms <- liquids_reordered%>%
    ggplot(aes(x= order, y = count, fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) + #fct_rev reverses the order that coordflip fucks up
    geom_bar(stat = "identity") +  # Use manually calculated counts for y
    geom_label(aes(label = count),  # Label bars with counts
               size = 6,            
               # vjust = 0.25,  # Adjust vertical position of the label (can change to fit better)
               hjust = .9,   # Adjust horizontal position (align center by default)
               fontface = "bold",
               color = "white", 
               family = "charis",
               show.legend = F) + #remove the random a from the legend color
    facet_wrap(~factor(PHONO_LABEL_W_COUNT, c("/ɾ/: n = 3871", "/r/: n = 857", "/l/: n = 2626")), scales = "free", strip.position = "top", drop = TRUE) +
    labs(
      title = "What are the Surface Forms for each Phoneme?",
      caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
      x = "Surface Phone",
      y = "count",
      fill = NULL) + #fill changes legend label/ change to color if using color instead of fill
    # coord_flip() +
    coord_flip(clip = "off") +
    scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
    # Add categories to axis
    scale_x_continuous(
      breaks = liquids_reordered$order,
      labels = liquids_reordered$SURF_FORM,
      position = "top",
      expand = c(0,0)
    ) +
    basic_custom_theme()+  
    theme(    
      axis.text.x = element_text(angle = 270, hjust = 0, vjust = 0.5), # Rotate the x-axis text and adjust alignment
      plot.margin = margin(0.5, 0.5, 0.5, 1, unit = "cm"),  # Adds 2 cm to the left and right margins, and 0.5 cm to the top and bottom.
      legend.position = "inside",
      legend.position.inside = c(.15, .15),
      legend.box.background = element_rect(color="#7FACA2", fill = "#7FACA2"),
      legend.text = element_text(size = 18, 
                                 color = "white",
                                 hjust = 0.5,
                                 vjust = 0.5),
      strip.text = element_text(size = 22) # Adjust font size and style of facet labels
    ) +
    # # Override legend point size
    guides(fill = guide_legend(override.aes = list(size = 3)))# Smaller points in legend
  
  liquid_distribution_surface_forms
  
  # Save to PDF
  ggsave("output/plots/liquids/all_liquids/liquid_distribution_surface_forms.pdf", liquid_distribution_surface_forms, device = cairo_pdf, width = 14, height = 7)
  
  
  
  # #Raw Counts Surface Forms
  # liquid_distribution_surface_forms <- liquids%>%
  #   ggplot(aes(x= forcats::fct_rev(SURF_FORM), fill=PHONETIC_PHONOLOGICAL_AGREEMENT)) + #fct_rev reverses the order that coordflip fucks up
  #   geom_bar() +
  #   geom_label(stat='count', #add count to bar
  #              aes(label=..count..), #geom_label adds the box around the number / can change to geom_text for no bar or geom_repel for bar with extra space
  #              size = 3,
  #              color = "white",
  #              show.legend = F) + #remove the random a from the legend color
  #   # geom_text(stat='count', aes(label=..count..), hjust = 1, nudge_y = -.15, size = 3, color = "white") + #add count to bar
  #   # facet_wrap(~PHONO_LABEL_W_COUNT, scales = "free", strip.position = "top", drop = TRUE)+
  #   facet_wrap(~factor(PHONO_LABEL_W_COUNT, c("/ɾ/: n = 3883", "/r/: n = 857", "/l/: n = 2632")), scales = "free", strip.position = "top", drop = TRUE) +
  # labs(
  #   title = "What are the Surface Forms for each Phoneme?\n",
  #   caption = "Data Source: Spanish in Boston Corpus \n Vidal Covas' Dissertation Speakers",
  #   x = "Surface Phone\n",
  #   y = "count",
  #   fill = "") + #fill changes legend label/ change to color if using color instead of fill
  #   coord_flip(clip = "off") +
  #   scale_fill_manual(values = custom_green_palette) +  # Custom fill palette
  #   # scale_fill_economist() +
  #   scale_x_discrete(position = "top") +
  #   basic_custom_theme()+
  #   theme(
  #     axis.text.x = element_text(angle = 270, hjust = 0, vjust = 0.5), # Rotate the x-axis text and adjust alignment
  #     legend.position = "bottom",
  #     legend.text = element_text(size = 14),
  #     legend.title = element_text(size = 14))
  # 
  # liquid_distribution_surface_forms
  