## scripts/initialize_fonts.R

# Function to register fonts and enable showtext
initialize_fonts <- function() {
  # Register regular Charis SIL font
  font_add("charis", 
           regular = "/Users/leeannvidal/Library/Fonts/CharisSIL-R.ttf",
           bold = "/Users/leeannvidal/Library/Fonts/CharisSIL-B.ttf",
           italic = "/Users/leeannvidal/Library/Fonts/CharisSIL-I.ttf",
           bolditalic = "/Users/leeannvidal/Library/Fonts/CharisSIL-BI.ttf")
  
  # Register small caps version of Charis SIL
  font_add("charis_smallcaps", 
           regular = "/Users/leeannvidal/Library/Fonts/CharisSILR-CompactSmallCaps.ttf",
           bold = "/Users/leeannvidal/Library/Fonts/CharisSILB-CompactSmallCaps.ttf",
           italic = "/Users/leeannvidal/Library/Fonts/CharisSILI-CompactSmallCaps.ttf",
           bolditalic = "/Users/leeannvidal/Library/Fonts/CharisSILBI-CompactSmallCaps.ttf")
  
  # Enable showtext for font rendering
  showtext_auto()
}

# Call the function at the start of your script
initialize_fonts()