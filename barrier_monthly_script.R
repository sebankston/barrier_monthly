library(tidyverse)
library(sf)
library(leaflet)
library(leaflet.extras)
library(googlesheets)
library(janitor)
library(htmlwidgets)
library(lubridate)

all_sheets <- as_tibble(gs_ls())

streams_list <- all_sheets %>% filter(str_detect(.$sheet_title, pattern = "inventory")) %>% group_by(sheet_title)

sheet_titles <- streams_list$sheet_title

all_data <- map(sheet_titles, ~ gs_title(.x) %>% gs_read(ws = "Sheet1") %>% clean_names()) %>% set_names(nm = sheet_titles)

<<<<<<< HEAD
bar_sum <- all_data %>% map_df(., ~.x %>% group_by(barrier_type, date_assessed) %>% summarize(count = n()), .id = "id") %>% ungroup()
=======
barrier_summary <- all_data %>% map_df(., ~.x %>% group_by(barrier_type) %>% summarize(count = n()) 
, .id = "id") 

barrier_summary <- barrier_summary %>% rename(stream = id)

View(barrier_summary)
>>>>>>> 93b1891d58fc6d0bd2876e6d2aa9f23f05936742

bar_sum_current <- bar_sum %>% rename(stream = id) %>% mutate(date_assessed = mdy(date_assessed)) %>% filter(month(date_assessed) == month(Sys.Date())) %>% group_by(stream, barrier_type) %>% summarize(total = sum(count))

View(bar_sum_current)

