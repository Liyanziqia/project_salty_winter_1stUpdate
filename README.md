Project summary: Salty Winter (1st Update):

An updated data journalism and visualization project analyzing road salt usage across New York City over the past decade, with correct data and measurements following data check.

Update Repository: project_salty_winter_1stUpdate
Read the updated story here: https://liyanziqia.github.io/project_salty_winter_1stUpdate/

This is a project for the Lede Program at Columbia University
Original Due Date: June 28, 2026. 
First Update Date: August 3, 2026.  

Original Repository: project_salty_winter 
https://github.com/Liyanziqia/project_salty_winter


##
Project Updates & Data Corrections:

Following feedback and consultation with the research team at the NYC Department of Sanitation (DSNY) in June/July 2026, two major analytical discrepancies from the initial project release were identified and resolved.  

1. Winter Season Date DefinitionInitial Logic Error: Previously, January through March were grouped into the prior calendar year while April remained in the current calendar year.  

This caused late-spring storms (such as an April 4, 2018 storm totaling 13,666 tons) to be misassigned to the 2018–2019 season instead of the 2017–2018 season.  

The Correction: DSNY defines a winter season as running continuously from autumn through spring.  . Following guidance from DSNY, storms occurring from January through April are assigned to the season starting the prior October.  

2. Salt Volume vs. Weight CalculationsInitial Assumption: 
Early visualizations assumed standard DSNY salt spreader trucks carry roughly 22 tons of salt per load.  
The Correction: DSNY measures salt loads by volume (cubic yards) rather than direct weight. 
Using parameters provided by the DSNY research team, total truckloads are now calculated using bulk density and spreader capacities.  

##
Methodology & WorkflowData Acquisition:

Fetched 224 storm-level records covering 2015–2016 through 2025–2026 directly from the NYC Department of Sanitation (DSNY) Salt Usage dataset via the Socrata API (tavr-zknk).  

Archived raw API output as df_salt_raw.csv.  .Data Cleaning & Type Casting:Parsed date_of_report strings to Pandas datetime objects.  

Converted total_tons from text strings to numeric values (pd.to_numeric).  

Derived winter_start and winter_season columns applying the October–April winter window rule.  

Analytical Aggregations:Grouped data by winter_season to compute total tonnage, volume in cubic yards, and spreader load counts.  .Exported processed outputs: df_salt_winter.csv, df_salt_winter_sorted by total tons.csv, and df_salt_winter_seasonal_loads.csv.  

Data Verification:
Summary calculations were verified with DSNY’s research team in June/July 2026.  

SNY noted that salt use varies by precipitation type, ground temperature, sunlight, and storm spacing—not solely snowfall inches.  

Data Visualizations:Generated exploratory bar charts in Python using Altair (alt.Chart). 

Designed custom truck vector pictogram graphics in Adobe Illustrator (1 truck icon = 500 spreader loads) for scrollytelling web components.  

##
Repository Structure
├── df_salt_raw.csv                     # Raw API response backup
├── df_salt_winter.csv                  # Cleaned storm dataset with winter season tags
├── df_salt_winter_sorted by total tons.csv # Season totals sorted by weight
├── df_salt_winter_seasonal_loads.csv   # Volume and truckload calculations
├── images/                             # Pictogram graphics and scrollytelling assets
│   ├── anno0.png
│   ├── anno1.png
│   ├── anno2.png
│   └── anno3.png
├── index.html                          # Interactive Scrollama.js scrollytelling page
└── notebook.ipynb                      # Complete Python data analysis and cleaning notebook

##
Tech Stack & DependenciesLanguage & Analysis: Python 3.13, Pandas, Requests.  

Exploratory Data Visualization: Altair, Vega-Lite.  Frontend Web Stack: HTML5, CSS3, JavaScript (Scrollama.js, D3.js, IntersectionObserver)Graphics: Adobe Illustrator. 



