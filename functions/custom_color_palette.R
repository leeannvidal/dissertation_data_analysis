# Create Custom color palette with website colors
custom_green_palette <- c(
  "#7FACA2",
  # "#8ABBAF",  # Seafoam Green (alternative version "#97B8AB") too light not enough contrast
  "#35413C",  # Even Darker Super Dark Green
  "#9a4f41",  # Dark Red
  "#737373",  # Dark Grey Autumn
  "#B0D8C9",  # Mint Green
  "#50625A",  # Super Dark Green
  # "#6B8278",  # Dark Sage Green
  "#f1be48",  # Yellow Gold
  # "#E8F5E9",  # Light Green
  "#D7E7DD", # muted light green
  "#F5F5F5"   # Light Grey
)
  
# library(colorblindcheck)
# 
# # Check if the custom palette is colorblind-friendly
# palette_check <- colorblindcheck::palette_check(custom_green_palette)
# 
# # View the results of the palette check
# print(palette_check)
# 
# # Visualize the palette for different types of color blindness
# colorblindcheck::palette_plot(custom_green_palette)

show_col(custom_green_palette)
# 
# # Economist color palette as a vector for direct comparison
# economist_palette <- c(
#   "#6794a7", # Light Blue
#   "#014d64", # Dark Blue
#   "#9a4f41", # Dark Red
#   "#edbb8a", # Light Red
#   "#76c0c1", # Light Green
#   "#01a2d9", # Bright Blue
#   "#f1be48"  # Yellow/Gold
# )
# 
# # Display the Economist color palette
# scales::show_col(economist_palette)
# 
# # Display your custom green palette
# scales::show_col(custom_green_palette)
# # "Sage Green" = "#849F97",         # Medium green get rid of