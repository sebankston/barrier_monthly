library(tidyverse)
library(sf)
library(leaflet)
library(leaflet.extras)
library(googlesheets)
library(janitor)
library(htmlwidgets)

all_sheets <- as_tibble(gs_ls())

streams_list <- all_sheets %>% filter(str_detect(.$sheet_title, pattern = "inventory")) %>% group_by(sheet_title)

sheet_titles <- streams_list$sheet_title

all_data <- map(sheet_titles, ~ gs_title(.x) %>% gs_read(ws = "Sheet1") %>% clean_names()) %>% set_names(nm = sheet_titles)

