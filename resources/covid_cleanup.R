library(tidyverse)

covid <- read_csv("https://raw.githubusercontent.com/OpportunityInsights/EconomicTracker/main/data/COVID%20-%20County%20-%20Daily.csv.gz")

names(covid)

table(covid$year)

covid <- covid |> 
  filter(year == 2021 & month == 10 & day == 5) |> 
  select(countyfips, vaccine_rate, fullvaccine_rate)

write.csv(covid, "data/covid.csv", row.names = FALSE)

rate_na <- c(2060, 2105, 2164, 2282)

`%notin%` <- Negate(`%in%`)

covid <- covid |> 
  filter(countyfips %notin% rate_na)

test <- covid |> 
  filter(countyfips %in% rate_na) |> 
  na_if(".")

covid <- bind_rows(covid, test)

covid <- covid |> 
  mutate(vaccine_rate = as.numeric(vaccine_rate),
         fullvaccine_rate = as.numeric(fullvaccine_rate))

summary(covid)
