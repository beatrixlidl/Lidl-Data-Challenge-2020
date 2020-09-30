setwd("~/Documents/data_project_2020")
# load packages
library(tidyverse)
library(janitor)
library(sf)
library(tmap)

# load geometries data and rename county name column to match other dataset
counties <- st_read("CA_Counties/CA_Counties_TIGER2016.shp")
counties <- counties %>% 
  rename(County = NAMELSAD)

# load population data and clean
age_data <- read_csv("p2_Age_1yr_Nosup.csv")
age_data <- row_to_names(age_data, row_number = 2)
age_data$Age <- as.numeric(as.character(age_data$Age))
age_data <- age_data %>% 
  remove_empty("cols")
## note on population numbers: estimates 2010-2019, projections 2020-2057

# create dataset of # of 17 year olds in each county
seventeen_data <- age_data %>% 
  filter(Age == 17)

# create dataset of voting age population in each county
voting_age_data <- age_data %>% 
  filter(Age >= 17)

# create total # of people of voting age in each county in 2018
voting_age_total_2018 <- aggregate(voting_age_data$'2018', by=list(County=voting_age_data$County), FUN = sum)

# create percentage of voting age population that is 17 years old
seventeen_data <- seventeen_data %>% 
  mutate(pct_17_2018 = seventeen_data$'2018'/voting_age_total_2018$x)

# add said percentage to geometries data set
tocounties <- seventeen_data %>% 
  select(County, pct_17_2018)
counties <- merge(counties, tocounties, by = "County", all.x = TRUE)

# map 17 y.o. % of voting age population
tmap_mode("plot") 
tm_shape(counties) +
  tm_polygons("pct_17_2018", id = "County",
              palette = "Greens", , style = "cont", title = "Legend") +
  tm_layout(legend.outside = TRUE, main.title = "% of voting age ")

# save above map as html
ca_map <- tm_shape(counties) +
  tm_polygons("pct_17_2018", id = "County",
              palette = "Greens", , style = "cont", title = "Legend") +
  tm_layout(legend.outside = TRUE, main.title = "% of voting age ")
tmap_mode("view")
tmap_last()
tmap_save(ca_map, "ca_map.html")

# load 2018 voter registration data
voter_r_2018 <- read_csv("county_voter_registration_2018.csv")

# create percentage of Democratic voters and Republican voters
voter_r_2018 <- voter_r_2018 %>% 
  mutate( dem_pct = voter_r_2018$Democratic/voter_r_2018$`Total Registered`,
          repub_pct = voter_r_2018$Republican/voter_r_2018$`Total Registered`)

# add to geometries dataset
voter_r_2018 <- voter_r_2018 %>% 
  rename(NAME = County)
tocounties2 <- voter_r_2018 %>% 
  select(NAME, dem_pct, repub_pct)
counties <- merge(counties, tocounties2, by = "NAME", all.x = TRUE)

# map Democratic %
tmap_mode("plot") 
tm_shape(counties) +
  tm_polygons("dem_pct", id = "County",
              palette = "Blues", style = "fixed",
              breaks = c(0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6),
              title = "Legend") +
  tm_layout(legend.outside = TRUE, main.title = "% of voters registered as Democrat")

# map Republican %
tmap_mode("plot") 
tm_shape(counties) +
  tm_polygons("repub_pct", id = "County",
              palette = "Reds", style = "fixed",
              breaks = c(0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6),
              title = "Legend") +
  tm_layout(legend.outside = TRUE, main.title = "% of voters registered as Republican")


  
  
  
  