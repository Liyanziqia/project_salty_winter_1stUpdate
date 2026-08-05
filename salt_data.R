# load required package
library(tidyverse)

# fetch dsny salt usage data via socrata api (csv format)
api_url <- "https://data.cityofnewyork.us/resource/tavr-zknk.csv?$limit=5000"
salt_data <- read_csv(api_url)

# save raw data to a local csv file
write_csv(salt_data, "dsny_salt_usage_raw.csv")

# look at the data
View(salt_data)

colnames(salt_data)

# clean dates and create winter season using base R functions
salt_cleaned <- salt_data %>% # create a new df named salt_cleaned from salt_data
  mutate( # add or modify columns in the df
    date_clean = as.Date(date_of_report), # convert date_of_report into an R date format
    year = as.numeric(format(date_clean, "%Y")), # extract the four-digit year as a number
    month = as.numeric(format(date_clean, "%m")), # extract the month number (1 to 12) as a number
    tons = as.numeric(total_tons), # convert total_tons to a numeric type
    winter_season = if_else( # check a condition to assign the correct winter season label
      month >= 1 & month <= 4, # check if the storm date falls between january and april
      paste0(year - 1, "–", year), # assign to previous year - current year if january through april
      paste0(year, "–", year + 1) # assign to current year - next year if may through december
    ) # close the if_else statement
  ) %>% # pass the modified dataset into the next function
  filter(!is.na(tons)) # remove rows where the salt tonnage value is missing or blank

# look at the new df

# look at the data
View(salt_cleaned)

colnames(salt_cleaned)

# group by winter season and sum total salt tonnage
seasonal_summary <- salt_cleaned %>% # create a new df named seasonal_summary from salt_cleaned
  group_by(winter_season) %>% # group the rows by winter season
  summarise(total_tons = sum(tons, na.rm = TRUE)) %>% # calculate total salt tons for each season
  arrange(winter_season) # sort the seasons in chronological order

# view the seasonal totals
View(seasonal_summary) 

# save seasonal_summary to a local csv file
write_csv(seasonal_summary, "seasonal_summary_R.csv") # corrected salt_data to seasonal_summary

# turn off scientific notation globally in r
options(scipen = 999) # prevents r from converting large numbers to formats like 5e+05

# load the scales package to format axis labels
library(scales) 

# create the bar chart with formatted y-axis numbers
ggplot(seasonal_summary, aes(x = winter_season, y = total_tons)) + # set x and y axes
  geom_col(fill = "#1f73a7") + # draw column bars
  scale_y_continuous(labels = scales::comma) + # format y-axis values with commas instead of scientific notation
  labs( # set chart labels
    x = "Winter Season", # label for x-axis
    y = "Total Salt Used (Tons)", # label for y-axis
    title = "NYC DSNY Road Salt Usage by Winter Season" # title for chart
  ) +
  theme_minimal() + # apply a clean minimal visual theme
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # rotate x-axis text 45 degrees