# FINAL R PROJECT
# Romina Carnero Huaman


# Project + Github repository ---------------------------------------------

# Name of the Github repository: Final Project
# Name of the Project: Final-Project
# Name of the script: R Final Project

# Version Control ---------------------------------------------------------

# Some evidence of version control:
# I created an object (a) which was a sequence from 1 to 100, and then I deleted it. I made a comment
# about this and other modifications in the text as well. All these changes are going to be 
# highlighted in red if you delete something and in green if you add something (it should be the 
# latest version of your work). This is visible when you hit commit after saving the script. 
# Then, after making a comment and hitting commit, you hit push and you will be able to see the 
# new version of your script in your file saved in your Github repository: Final Project

a <- c(1:100)
rm(a)

# Reading-in data ---------------------------------------------------------

# Downloading the data base of Common bottlenose dolphins from GBIF

# GBIF (Global Biodiversity Information Facility) is an international network 
# and research infrastructure funded by the world’s governments and aimed at 
# providing anyone, anywhere, open access to data about all types of life on Earth.


library(dismo)

bottle <- gbif("tursiops","truncatus*", geo = T, download = T)

bottle

# Saving the data base in my directory

write.csv(bottle, "bottle.csv")

# Application of the appropriate data storage structure:list, data frame, matrix or array --------

class(bottle)

# It is already a data.frame.

# Example of indexing -----------------------------------------------------

ncol(bottle)

# From the 189 columns in the original data base, eah containing different variables,
# I will select 8 variables to create a new data base and apply all the functions that 
# have been requested for this project.

# 8 Variables:

# 1."acceptedScientificName" 
# 2."basisOfRecord"
# 3."behavior" 
# 4."country" 
# 5."depth"   
# 6."lat"  
# 7."lon" 
# 8."year" 

names(bottle)

scientific.name <- subset(bottle, acceptedScientificName =="Tursiops truncatus (Montagu 1821))

?subset

fields <- # aqui iran las 8 columnas

bottle.1 <- # esta sera la nueva base de datos. subseteare usando fields


# Subsetting --------------------------------------------------------------


# Ordering  ---------------------------------------------------------------


# Summarizing -------------------------------------------------------------


# Merge or Join data frames  ----------------------------------------------


# Custom function(s)  -----------------------------------------------------


# Custom operator(s)  -----------------------------------------------------


#  ‘if else’ statement ----------------------------------------------------


# Reshaping data with ‘melt’ and/or ‘dcast’  ------------------------------


# ‘for loop’  -------------------------------------------------------------


# ‘ddply’ -----------------------------------------------------------------


# Histogram plot  ---------------------------------------------------------


# Point, bar, or line plot (whichever makes the most sense)  --------------


# ‘ggplot’ with at least 2 geoms (e.g. point, bar, tile) --------

# use one of the ‘scale_’ geoms, and adjusting the theme of the plot


# A map of showing the geographic location where the data was coll --------



# Exporting data set  -----------------------------------------------------


# Exporting and saving figures from ggplot  -------------------------------

























