install.packages("devtools")
devtools::install_github("UrbanInstitute/urbnmapr")
library(tidyverse)
library(urbnmapr)

#import data
preregister <- read.csv("preregister.csv", as.is = TRUE)

#join data with pre-existing dataset
register_cat <- right_join(get_urbn_map(map = "states", sf = TRUE),
                        preregister, by = "state_name")

#plot US states by preregistration categories
ggplot() +
  geom_sf(register_cat, mapping = aes(fill = factor(preregister)), 
          color = "#ffffff") +
  scale_fill_brewer(palette = "Greens") + 
  coord_sf(datum = NA) +
  labs(fill = "Preregistration Age", title = "Age of Voting Preregistration", 
       x = element_blank(), y = element_blank()) +
  geom_sf_text(data = get_urbn_labels(map = "states", sf = TRUE), 
               aes(label = state_abbv), size = 3)