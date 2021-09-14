#Jennifer Kuo August 2021
#script for plotting hike sites onto Washington map

#load packages
library(tidyverse)
library(usmap)
library(ggplot2)

#load data
df <- read.csv("2021-03-29_wta_hike_data.csv")



# part one: basic plotting ------------------------------------------------
#plots every hiking location onto map of Washington, ignoring other factors (e.g. traffic/popularity)

#format data to be compatible with the usmap package
plotdata <- df %>% 
     select(LONGITUDE,LATITUDE,RATING_COUNT) %>% 
     filter(!is.na(LONGITUDE) & !is.na(LATITUDE)) %>% 
     filter(LONGITUDE < 0)
colnames(plotdata) <- c("lon","lat","n_reviews")
plt_transformed <- usmap_transform(plotdata)

#plot map
plot_usmap("counties",
           include = c("WA"),
           labels = TRUE, label_color = "blue") + #fill = "yellow", alpha = 0.25, color = "orange", size = 2
     geom_point(data=plt_transformed, aes(x = lon.1, y = lat.1,alpha=n_reviews))


