## Load the Libraries #####
install.packages(c("osmdata", "magrittr", "dplyr","ggmap", "lubridate","leaflet", "worldcloud","RcolorBrewer","plotly","tidyverse","sf","tmap"))

library(lubridate)
library(ggmap)
library(leaflet)
library(wordcloud)
library(RColorBrewer)
library(plotly)
library(tidyverse)
library(sf)
library(tmap)
library(osmdata)

## Attached the Dataset #########
attach(NYC_Collisions)

df = NYC_Collisions

## View the dataset #####
View(NYC_Collisions)
colnames(NYC_Collisions)
summary(NYC_Collisions)

## Time Series Analysis ####
### Distributions of the accidents vs time ######
#### Convert Date and Time Column to relavent format ####
df$Data = as.Date(df$Date, format("%Y-%m-%d"))
df$Time = hms::as_hms(df$Time)

#### Extract the relavent Content from the data ####
df$Year = year(df$Date)
df$Month = month(df$Date)
df$Date = date(df$Date)
df$Day_Of_Week = wday(df$Date, label = TRUE)
df$Hour = hour(df$Time)

#### Distribution of Hourly Collisions ####

#Count the Hourly Collisions
distribution_hours = df|>
  count(Hour)

distribution_hours # for check the pipe

ggplot(distribution_hours, aes(x = Hour , y = n))+
  geom_line(color = rainbow(1), size = 2)+
  geom_point(color = "blue", size = 2) +
  labs (title = "Hourly Collisions Distribution",
        x = "Hour of the day",
        y = "Collisions Count")+
  scale_x_continuous(breaks = seq(0, 24, by = 4), limits = c(0, 24))+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#### Distribution of Daily Collisions #####

#Count the Daily Collisions
distribution_day = df|>
  count(Day_Of_Week)

ggplot(distribution_day, aes(x = Day_Of_Week, y = n, fill = Day_Of_Week))+
  geom_bar(stat = "identity" , color = rainbow(7))+
  labs(title = "Daily Collisions Distributions",
       x = "Day of the Week", 
       y = "Collisions Count")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#### Distribution of Monthly Collisions #####

# Extract month as a number (1 to 12)
df$Month = month(df$Date)

# Convert month number to ordered factor with month names
df$Month = factor(df$Month, 
                  levels = 1:12, 
                  labels = c("January", "February", "March", "April", 
                             "May", "June", "July", "August", 
                             "September", "October", "November", "December"),
                  ordered = TRUE)

#Count the Monthly Collisions
distribution_month = df |>
  count(Month)


ggplot(distribution_month, aes(x = Month, y = n, fill = Month)) +
  geom_bar(stat = "identity") +
  labs(title = "Monthly Collisions Distributions",
       x = "Month of the year",
       y = "Number of Collisions") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1))

colnames(NYC_Collisions)



nyc_bbox <- c(left = -74.2591, bottom = 40.4774, right = -73.7004, top = 40.9176)

# Download street data for NYC
nyc_streets <- opq(bbox = nyc_bbox) %>%
  add_osm_feature(key = "highway") %>%
  osmdata_sf()

# Extract the lines (streets) from the data
nyc_streets_lines <- nyc_streets$osm_lines
nyc_streets_lines

# Plot the NYC streets
tm_shape(nyc_streets_lines) +
  tm_lines(col = "black", lwd = 0.5) +
  tm_layout(main.title = "New York City Streets", 
            main.title.size = 1.2,
            bg.color = "white")

# Install and load the tigris package
install.packages("tigris")
library(tigris)

# Download NYC borough boundaries
nyc_boroughs <- counties(state = "NY", cb = TRUE) %>%
  filter(NAME %in% c("New York", "Kings", "Queens", "Bronx", "Richmond"))

# Plot the map with borough boundaries
tm_shape(nyc_streets_lines) +
  tm_lines(col = "black", lwd = 0.5) +
  tm_shape(nyc_boroughs) +
  tm_borders(col = "red", lwd = 2) +
  tm_layout(main.title = "New York City Streets with Borough Boundaries", 
            main.title.size = 1.2,
            bg.color = "white")
# Install and load the tigris package
install.packages("tigris")
library(tigris)

# Download NYC borough boundaries
nyc_boroughs <- counties(state = "NY", cb = TRUE) %>%
  filter(NAME %in% c("New York", "Kings", "Queens", "Bronx", "Richmond"))

# Plot the map with borough boundaries
tm_shape(nyc_streets_lines) +
  tm_lines(col = "black", lwd = 0.5) +
  tm_shape(nyc_boroughs) +
  tm_borders(col = "red", lwd = 2) +
  tm_layout(main.title = "New York City Streets with Borough Boundaries", 
            main.title.size = 1.2,
            bg.color = "white")



