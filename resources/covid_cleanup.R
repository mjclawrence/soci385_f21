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


covid <- read_csv("data/covid.csv")
mobility <- read_csv("data/county_mobility.csv")

covid_mobility <- left_join(mobility, covid)

cor(covid_mobility$vaccine_rate, covid_mobility$mobility, 
    use = "complete")

plot(covid_mobility$vaccine_rate, covid_mobility$mobility)

summary(covid_mobility$vaccine_rate)


workplace <- read_csv("https://raw.githubusercontent.com/OpportunityInsights/EconomicTracker/main/data/Google%20Mobility%20-%20County%20-%20Daily.csv")

workplace_sub <- workplace |> 
  filter(month == 9 & year == 2021 & day == 30) |> 
  select(countyfips, gps_workplaces) |> 
  na_if(".") |> 
  mutate(gps_workplaces = as.numeric(gps_workplaces))

summary(workplace_sub$gps_workplaces)

hist(workplace_sub$gps_workplaces)

write.csv(workplace_sub, "data/county_work_time.csv",
          row.names = FALSE)
