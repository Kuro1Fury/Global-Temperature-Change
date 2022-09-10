# Final Project

# Website url: https://kuro1fury.shinyapps.io/INFO-201-Final-Project/?_ga=2.136563056.1709431203.1662424615-38765987.1662424615

## Domain of interest
- Why are you interested in this field/domain?  

  People usually underestimate how their actions in daily life impact the climate and environment on earth. However, the consequences of climate change such as the extreme weather that happened last summer in Seattle truly influenced thousands of people. We humans all survive in this environment and depend on it to grow. By researching climate change through data, we could exploit the period when and how climate changed and the extent of these changes. We could determine what factors affected our climate and environment through this research. By correlating our outcomes from this project with the development of our society, we could reflect on the harmful actions we have conducted in the past and envoke people about the awareness of protecting the environment.

- What other examples of data driven projects have you found related to this domain (share at least 3)?

  [Global Warming](https://github.com/rosslh/IsEarthStillWarming.com)

  [Climate Change Visualization](https://github.com/AodhanSweeney/Climate-Change-Visualization)

  [Climate Change Analysis](https://github.com/moriahtaylor1/climate-change-analysis)

- What data-driven questions do you hope to answer about this domain (share at least 3)?

  - How did the industrial revolution in the 1920s affect the climate and environment in America?

  - Did regions with a greater increase in temperature have more natural disasters?

  - Which regions or countries did the climate changes happen most severely in the past 10 years?

## Finding Data

### Source 1

- Where did you download the data (e.g., a web URL)?  
  [Climate Change: Earth Surface Temperature Data
](https://www.kaggle.com/berkeleyearth/climate-change-earth-surface-temperature-data?select=GlobalLandTemperaturesByCity.csv)

- How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?  

  The dataset records the global land temperature in different regions all over the world since 1743. And there are 4 csv files that filter the data by city, country, major city, and state and one dataset that records the average land temperature by date.

  The source of the data is from Berkeley Earth, which is a Berkeley, California-based independent 501 non-profit organization focused on land temperature data analysis for climate science. The data is collected by technicians using mercury thermometers from a range of organizations including NOAA’s MLOST, NASA’s GISTEMP, and the UK’s HadCrut, and the author of these datasets repackaged the data from a newer compilation put together by the Berkeley Earth, which is affiliated with Lawrence Berkeley National Laboratory.

  (Since the dataset GlobalLandTemperaturesByCity.csv is 508MB which is over the Github upload limitation, it is only included in the zip file)



- How many observations (rows) are in your data?

  - GlobalLandTemperaturesByCity.csv: 8599212
  - GlobalLandTemperaturesByCountry.csv: 577462
  - GlobalLandTemperaturesByMajorCity.csv: 239177
  - GlobalLandTemperaturesByState.csv: 645675
  - GlobalTemperatures.csv: 3192


- How many features (columns) are in the data?

  - GlobalLandTemperaturesByCity.csv: 7
  - GlobalLandTemperaturesByCountry.csv: 4
  - GlobalLandTemperaturesByMajorCity.csv: 7
  - GlobalLandTemperaturesByState.csv: 5
  - GlobalTemperatures.csv: 9


- What questions (from above) can be answered using the data in this dataset?

  - Which regions(city, country, major city, state) did the highest land temperature take place?
  - How much does land temperature change in a particular region?
  - Which year does the average land temperature change most in the world?

### Source 2

- Where did you download the data (e.g., a web URL)?  
  [Global sea level data from 1993 to 2021](https://www.kaggle.com/kkhandekar/global-sea-level-1993-2021)

- How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?

  The data is scraped by the author from the global climate change department of NASA. NASA tracks the daily sea level data by calculating the average sea surface height measured by satellites.

- How many observations (rows) are in your data?  
  1048

- How many features (columns) are in the data?  
  9

- What questions (from above) can be answered using the data in this dataset?

	- How did the increase of sea level in the 2010s compared to the 2000s?

### Source 3

- Where did you download the data (e.g., a web URL)?  
[All Natural Disasters 1900-2021](https://www.kaggle.com/brsdincer/all-natural-disasters-19002021-eosdis)

- How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?

  These data were created by Baris Dincer and this author got the data resource from EOSDIS, a program founded by NASA and used to collect and manage the earth science data. NASA collected these data from satellites, aircraft, field measurements, and various other programs. These databases are about the global climate disaster that happened from 1900 to 2021. These data focus on the date the disaster happened, location, type, and other details about disasters.

- How many observations (rows) are in your data?  
  16127

- How many features (columns) are in the data?    
  45

- What questions (from above) can be answered using the data in this dataset?
  - Which country has had the greatest increase of natural disasters in the last decade?
