install.packages("devtools")
devtools::install_github("UrbanInstitute/urbnmapr")
library(tidyverse)
library(urbnmapr)

#import data
read.csv("states_17.csv", header = TRUE)

#join data with pre-existing dataset
state_cat <- right_join(get_urbn_map(map = "states", sf = TRUE),
                       states_17, by = "state_name")

#plot US states by primary voting age minimum
ggplot() +
  geom_sf(state_cat, mapping = aes(fill = already_enacted), color = "#ffffff") +
  scale_fill_brewer(palette = "Greens") + 
  coord_sf(datum = NA) +
  labs(fill = element_blank(), title = "States with 17 Year Old Primary Voting", 
       x = element_blank(), y = element_blank()) +
  geom_sf_text(data = get_urbn_labels(map = "states", sf = TRUE), 
               aes(label = state_abbv), size = 3)