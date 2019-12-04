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

# Reading the database for my thesis, where I want to generate a summary for the qualitative 
# variables of my common bottlenose dolphins DNA samples

install.packages(c("ggspatial", "sf", "rnaturalearth", "rnaturalearthdata"))

library("rnaturalearth")
library("rnaturalearthdata")
library("sf")
library("ggspatial")
library("dplyr")
library("tidyr")
library("ggplot2")
library("reshape2")
library("rgeos")

dir.create("bottle")

bottle <- read.csv("Thesis Carnero.csv", header = T, sep = ",")

head(bottle)

# Application of the appropriate data storage structure:list, data frame, matrix or array --------

class(bottle)
# It is already a data.frame.
nrow(bottle)
names(bottle)


# Example of indexing and subsetting -----------------------------------------------------
variables <- c("Lab_ID","Collection.Date", "Group","Latitude","Longitude","Tissue_Source",
               "DNA.Quality", "Extraction.Date")
variables

# creating a new object with all the variables I need to subset from the original data base

bottle.1 <- bottle[variables]
head(bottle.1)


# Custom operator to find how many days have passed between collection and extraction dates-----------------------

`%days%` <- function(x, y) {
  paste0('',as.Date(x, format="%m/%d/%Y") - as.Date(y, format="%m/%d/%Y")," days", sep = "")}

bottle.1$Extraction.Date%days%bottle.1$Collection.Date

"09/15/2004"%days%"8/02/2004"

# Summarizing -------------------------------------------------------------

#Summarize data to find NAs

bottle.1 %>% select(everything()) %>% summarise_all(funs(sum(is.na(.))))

# find if any variable has NA

# According with this, none of the variables present NA 

# Reshaping data with 'melt' and/or 'dcast'  ------------------------------

#Convert some variables into factors

bottle_quality = bottle.1 %>%
  mutate_at(vars(Group,
                 Tissue_Source,
                 DNA.Quality), 
            funs(factor))

bottle_quality[1:2] <- lapply(bottle_quality[1:2], as.character)

# A map of showing the geographic location where the data was collected --------

world = ne_countries(scale = "medium", returnclass = "sf")
class(world)

ggplot(data = world) +
  geom_sf() +
  annotation_scale(location = "bl", width_hint = 0.5) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.75, "in"), pad_y = unit(0.8, "in"),
                         style = north_arrow_fancy_orienteering) +
  coord_sf(xlim = c(-82, -80.5), ylim = c(30.5,31.8)) +
  geom_point(data=bottle_quality, aes(x=Longitude, y=Latitude), color="red", size=2, alpha=0.5)+
  labs(y= "Latitude", x = "Longitude")

# Custom function(s)  -----------------------------------------------------
#I implemented the previous graph into a function

Mapbottle = function(x) { 
  botplot=ggplot(data = world) +
    geom_sf() +
    geom_point(data=x, aes_string(x=x$Longitude, y=x$Latitude), color="red", size=2, alpha=0.5)+
    annotation_scale(location = "bl", width_hint = 0.5) +
    annotation_north_arrow(location = "bl", which_north = "true", 
                           pad_x = unit(0.75, "in"), pad_y = unit(0.8, "in"),
                           style = north_arrow_fancy_orienteering) +
    coord_sf(xlim = c(min(x$Longitude)-0.3, max(x$Longitude)+0.3), ylim = c(min(x$Latitude)-0.3, 
                                                                            ax(x$Latitude)+0.3))+
    labs(y= "Latitude", x = "Longitude")
    print(botplot)
}

Mapbottle(bottle.1)

# 'for loop'  -------------------------------------------------------------
#Use a loop to graph each level of Group variable. I will save and export each graph into my directory

places = unique(bottle.1$Group)

dir.create("bottle")

for(i in seq_along(levels(bottle.1$Group))){
    data=subset(bottle.1, Group==places[i])
    Mapbottle(data)
    ggsave(filename = paste0('bottle/',places[i],'.png',sep = ""),
    units = 'in',
         dpi = 300)
   dev.off()
}


#Summarize data according two factors

dcast( bottle_quality, DNA.Quality ~ Group , length)


dcast( bottle_quality, DNA.Quality ~ Tissue_Source , length)



# Histogram plot  ---------------------------------------------------------
# Point, bar, or line plot (whichever makes the most sense)  --------------
# 'ggplot' with at least 2 geoms (e.g. point, bar, tile) --------
# use one of the 'scale_' geoms, and adjusting the theme of the plot

bottle_quality %>% 
  select_if(is.factor) %>% 
  gather %>% 
  ggplot(aes(x = value)) + geom_bar() +
  facet_wrap(~key, scales = 'free') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
ggsave(filename = 'bottle/hbottle.png')


# Exporting data set  -----------------------------------------------------
write.csv(bottle_quality, "newbottle.csv")

