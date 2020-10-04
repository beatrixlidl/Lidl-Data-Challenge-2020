# Lidl-Data-Challenge-2020
Analyzing Proposition 18 for the UC Davis DataLab CA Election 2020 Data Challenge.

## Description
CA Proposition 18 would allow 17 year olds who will be 18 by the time of the general election to vote in primaries and special elctions. This project attempts to show which counties will be most affected by the passing of this propostion. This project identifies counties that have high concentrations of 17 year olds and/or where young people's political party registration doesn't match the county's broader voting population. 

## Contributors
Beatrix Lidl and Bruce Lidl

## Data Sources & Definitions
[National Context of 17 Year Old Primary Voting](https://www.ncsl.org/research/elections-and-campaigns/primaries-voting-age.aspx) - From the National Conference of State Legislatures.

[CA County Boundaries](https://data.ca.gov/dataset/ca-geographic-boundaries/resource/b0007416-a325-4777-9295-368ea6b710e6) - From the California Department of Technology, "California County boundaries in shapefile format from the US Census Bureau's 2016 MAF/TIGER database."

[County Population by Age](http://www.dof.ca.gov/Forecasting/Demographics/Projections/) - From the Demographic Research Unit of the California Department of Finance, projected county populations from 2010 to 2060, broken down by age. 

[Pre-Registration by County and Registration by County, October 22, 2018](https://www.sos.ca.gov/elections/report-registration/15-day-gen-2018) - From the California Secretary of State's office, the report of voter registration broken down by county from October 22, 2018. 

## Repository Architecture
data-clean - contains cleaned versions of data from above sources

data-original - contains original data downloaded from above sources

final_visualizations - contains .png files of maps created in code

prop_18_map_making.R - R script used to create map visualizations
State-Map_clean.R - R script used to make US state context map
Preregister-Map_clean.R - R script used to make US preregisteration context map
