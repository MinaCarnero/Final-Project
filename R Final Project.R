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

# bottle <- gbif("tursiops","truncatus*", geo = T, download = T)

bottle

# Saving the data base in my directory

bottle <- read.csv("bottle.csv", header = T)

head(bottle)

# Application of the appropriate data storage structure:list, data frame, matrix or array --------

class(bottle)

# It is already a data.frame.

# Example of indexing and subsetting -----------------------------------------------------

ncol(bottle)
names(bottle)

# From the 189 columns in the original data base, eah containing different variables,
# I will select 8 variables to create a new data base and apply all the functions that 
# have been requested for this project.

# 8 Variables:

# 1."acceptedScientificName": there are 6 options, but I only need Tursiops truncatus (Montagu, 1821)

# 2."basisOfRecord": different ways to record this scientific data
              # Fossil_Specimen
              # Human_Observation
              # Living_Observation
              # Machine_Observation
              # Material_Sample
              # Observation
              # Preserved_Specimen
              # Unknown : those individuals with this type of record will not be considered

# 3."behavior": e.g. Bowriding, breaching, feeding, migrating, playing ...

# 4."country": Country where the sighting occurred

# 5."depth": It is the depth where the dolphin was spotted only by human observation.
          # For that case, depth = 0 or NA were not considered

# 6."lat": Latitude 

# 7."lon": Longitude

# 8."year": Year of sighting or the year the sample was collected


# Since we only need data of Tursiops truncatus (Montagu,1821), we need to subset this from 
# the original data base

scientific.name <- subset(bottle, acceptedScientificName =="Tursiops truncatus (Montagu, 1821)")

head(scientific.name)

# Now that there are no values in the columns of the rest of scientific names, we still need to 
# delete the names of the variables. Using "levels", we will know how many different factors 
# we have in that column "scientific names"

levels(scientific.name$acceptedScientificName)

scientific.name$acceptedScientificName <- droplevels(scientific.name$acceptedScientificName)

levels(scientific.name$acceptedScientificName)

# creating a new object with all the vaariables I need to subset from the original data base

variables <- c("scientific.name","basisOfRecord","behavior","country","depth","lat","lon","year")

variables

# creating the new data base as data frame

bottle.1 <- subset(bottle, variables)


?subset

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

























