# functions/basic_custom_theme.R

# Function: basic_custom_theme
# Description: Applies a consistent visual style to ggplot2 graphics using the Economist theme as a base.
# 

basic_custom_theme <- function() {
  theme_economist() +  # Base theme from the Economist style, which provides a clean, professional look.
    theme(
      text = element_text(family="charis"),  # Sets the default font for all text elements to regular "charis".
      plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "cm"),  # Adds margins around the plot; each side gets 0.5 cm.
      plot.title = element_text(size = 28, face = "bold", hjust = 0.5),  # Styles the plot title: larger size, bold, and centered horizontally.
      plot.subtitle = element_text(size = 26, family = "charis_smallcaps", face = "bold", hjust = 0.5),  # Styles the subtitle: size, bold, and centered horizontally.
      plot.caption = element_text(size = 22, hjust = 1),  # Styles the plot caption: smaller size, aligned to the right.
      axis.title.x = element_text(margin = margin(t = 0.5, b = 0.5, unit = "cm"), size = 26, family = "charis_smallcaps"),  # Styles the x-axis title: adds top and bottom margin, sets text size and small caps for x-axis title.
      axis.title.y = element_text(margin = margin(t = 0.5, b = 0.5, unit = "cm"), size = 26, family = "charis_smallcaps"),  # Styles the y-axis title: adds top and bottom margin, sets text size and small caps for y-axis title.
      axis.text = element_text(size = 26),  # Sets the size of the axis text labels.
      legend.position = "none",  # Removes the legend from the plot.
      panel.background = element_rect(fill = "#D7E7DD", color = NA),  # Change background color inside the plot panel
      plot.background = element_rect(fill = "#D7E7DD", color = NA)   # Change entire plot background
      # plot.background = element_rect(fill = "gray90")       # Change entire plot background
      # legend.background = element_rect(fill = "lightyellow") # Change legend background
    )
}

custom_theme_AIC_tables <- function() {
  theme_economist() +  # Base theme from the Economist style, which provides a clean, professional look.
    theme(
      text = element_text(family="charis"),  # Sets the default font for all text elements to regular "charis".
      plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "cm"),  # Adds margins around the plot; each side gets 0.5 cm.
      plot.subtitle = element_text(size = 18, family = "charis_smallcaps", face = "bold", hjust = 0.5),  # Styles the subtitle: size, bold, and centered horizontally.
      plot.caption = element_text(size = 18, hjust = 1),  # Styles the plot caption: smaller size, aligned to the right.
      axis.title.x = element_text(margin = margin(t = 0.5, b = 0.5, unit = "cm"), size = 18, family = "charis_smallcaps"),  # Styles the x-axis title: adds top and bottom margin, sets text size and small caps for x-axis title.
      axis.title.y = element_text(margin = margin(t = 0.5, b = 0.5, unit = "cm"), size = 18, family = "charis_smallcaps"),  # Styles the y-axis title: adds top and bottom margin, sets text size and small caps for y-axis title.
      axis.text = element_text(size = 18),  # Sets the size of the axis text labels.
      panel.background = element_rect(fill = "#D7E7DD", color = NA),  # Change background color inside the plot panel
      plot.background = element_rect(fill = "#D7E7DD", color = NA),   # Change entire plot background
      plot.title = element_text(hjust = 0.5, vjust = -102, face = "plain", size = 18),
      legend.position = "inside",
      legend.position.inside = c(.85, .2),
      legend.box.background = element_rect(color="#7FACA2", fill = "#7FACA2"),
      legend.text = element_text(size = 14, 
                                 color = "white",
                                 hjust = 0.5,
                                 vjust = 0.5), 
      legend.title = element_text(size = 14, 
                                  color = "white",
                                  hjust = 0.5,
                                  vjust = 0.5) ### Keep it like this bc it saves perfectly
    ) 
}

likert_custom_theme <- function() {
  theme_economist() +  # Base theme from the Economist style, which provides a clean, professional look.
    theme(
      text = element_text(family="charis"),  # Sets the default font for all text elements to regular "charis".
      plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "cm"),  # Adds margins around the plot; each side gets 0.5 cm.
      plot.title = element_text(size = 22, face = "bold", hjust = 0.5),  # Styles the plot title: larger size, bold, and centered horizontally.
      plot.subtitle = element_text(size = 18, family = "charis_smallcaps", hjust = 0.5),  # Styles the subtitle: size, bold, and centered horizontally.
      plot.caption = element_text(size = 18, hjust = 1),  # Styles the plot caption: smaller size, aligned to the right.
      axis.title.x = element_text(margin = margin(t = 0.5, b = 0.5, unit = "cm"), size = 18, family = "charis_smallcaps"),  # Styles the x-axis title: adds top and bottom margin, sets text size and small caps for x-axis title.
      axis.title.y = element_text(margin = margin(t = 0.5, b = 0.5, unit = "cm"), size = 18, family = "charis_smallcaps"),  # Styles the y-axis title: adds top and bottom margin, sets text size and small caps for y-axis title.
      axis.text = element_text(size = 18),  # Sets the size of the axis text labels.
      panel.background = element_rect(fill = "#D7E7DD", color = NA),  # Change background color inside the plot panel
      plot.background = element_rect(fill = "#D7E7DD", color = NA),   # Change entire plot background,
      # legend.position = "inside",
      # legend.position.inside = c(.85, .2),
      # legend.position = "none"  # Removes the legend from the plot.
      legend.position = "bottom",
      legend.box.background = element_rect(color="#7FACA2", fill = "#7FACA2"),
      legend.text = element_text(size = 14, 
                                 color = "white",
                                 hjust = 0.5,
                                 vjust = 0.5), 
      legend.title = element_text(size = 14, 
                                  color = "white",
                                  hjust = 0.5,
                                  vjust = 0.5) ### Keep it like this bc it saves perfectly
    )
}

# ### Unchanged
# basic_custom_theme <- function() {
#   theme_economist() +  # Base theme from the Economist style, which provides a clean, professional look.
#     theme(
#       text = element_text(family="charis"),  # Sets the default font for all text elements to regular "charis".
#       plot.margin = margin(0.5, 0.5, 0.5, 0.5, unit = "cm"),  # Adds margins around the plot; each side gets 0.5 cm.
#       plot.title = element_text(size = 20, face = "bold", hjust = 0.5),  # Styles the plot title: larger size, bold, and centered horizontally.
#       plot.subtitle = element_text(size = 18, family = "charis_smallcaps", face = "bold", hjust = 0.5),  # Styles the subtitle: size, bold, and centered horizontally.
#       plot.caption = element_text(size = 12, hjust = 1),  # Styles the plot caption: smaller size, aligned to the right.
#       axis.title.x = element_text(margin = margin(t = 0.5, b = 0.5, unit = "cm"), size = 18, family = "charis_smallcaps"),  # Styles the x-axis title: adds top and bottom margin, sets text size and small caps for x-axis title.
#       axis.title.y = element_text(margin = margin(t = 0.5, b = 0.5, unit = "cm"), size = 18, family = "charis_smallcaps"),  # Styles the y-axis title: adds top and bottom margin, sets text size and small caps for y-axis title.
#       axis.text = element_text(size = 18),  # Sets the size of the axis text labels.
#       legend.position = "none"  # Removes the legend from the plot.
#     )
# }