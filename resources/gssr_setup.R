library(tidyverse)
library(gssr)
data("gss_doc")
data("gss_all")


gss_doc %>% filter(id == "educ") %>%
  select(properties) %>%
  unnest(cols = c(properties))


gss_myvars <- gss_all %>%
  select(id, year, educ, agekdbrn)

summary(gss_myvars)

gss_doc %>% filter(id == "agekdbrn") %>%
  select(description)

gss_subset <- gss_all %>%
  filter(year>=2008 & !is.na(agekdbrn) & !is.na(educ) & educ>=8 & agekdbrn>9) %>%
  select(id, year, educ, agekdbrn, race, hispanic) |>
  mutate(racehisp = ifelse(hispanic>1, 4, race),
         racehisp = factor(racehisp,
                           labels = c("White", "Black",
                                      "Other", "Hispanic"))) |>
         select(-c(race, hispanic)) |>
  filter(!is.na(racehisp))

summary(gss_subset)

write.csv(gss_subset, "data/gss_week3.csv", row.names = FALSE)

table(gss_subset$agekdbrn, exclude = NULL)
table(gss_subset$year)

summary(gss_subset$agekdbrn)

sort(table(gss_subset$agekdbrn[gss_subset$educ<=12]), 
     decreasing = TRUE)

prop.table(table(gss_subset$educ))

df2 <- gss_subset %>%
  filter(educ>=16)

summary(df2$agekdbrn)


## Assignment 3

gss_get_marginals(varnames = "workhr", data = gss_doc)

gss_subset <- gss_all |> 
  filter(year>=2008) |> 
  select(id, hrs1, class, race, hispanic, region) |> 
  mutate(racehisp = ifelse(hispanic>1, 4, race),
         racehisp = factor(racehisp,
                           labels = c("White", "Black",
                                      "Other", "Hispanic")),
         class = ifelse(class==0 | class>4, NA, class),
         class = factor(class,
                        labels = c("Lower", "Working", "Middle", "Upper")),
         region = ifelse(region %in% 3:4, 3,
                         ifelse(region %in% 5:7, 5,
                                ifelse(region >= 8, 8, region))),
         region = factor(region,
                         labels = c("New England",
                                    "Middle Atlantic",
                                    "Midwest",
                                    "South", 
                                    "West"))) |>
  select(-c(race, hispanic)) |>
  drop_na()

summary(gss_subset)

write.csv(gss_subset, "data/assignment_03.csv", row.names = FALSE)

## PS 1

gss_all %>%
  gss_which_years(c(polviews, joindem, attrally, 
                    spkrac)) %>%
  print(n = Inf)

gss_subset <- gss_all |> 
  filter(year==2014) |> 
  select(id, age, sex, race, hispanic, 
         educ, degree, class, polviews,
         spkrac, 
         joindem, attrally, signdpet, avoidbuy,
         cntctgov, polfunds, usemedia, interpol) |> 
  mutate(racehisp = ifelse(hispanic>1, 4, race),
         racehisp = factor(racehisp,
                           labels = c("White", "Black",
                                      "Other", "Hispanic")),
         class = ifelse(class==0 | class>4, NA, class),
         class = factor(class,
                        labels = c("Lower", "Working", "Middle", "Upper"))) |>
  select(-c(race, hispanic))

## Week 7

gss_subset <- gss_all |> 
  filter(year>=2010) |> 
  select(id, year, childs, chldidel, parsol, kidssol) |> 
  filter(parsol<=5) |> 
  filter(kidssol<=5) |> 
  filter(childs<=6) |> 
  filter(chldidel<=6) |> 
  mutate(parsol = factor(parsol,
                         labels = c("Much Better",
                                    "Somewhat Better",
                                    "About The Same",
                                    "Somewhat Worse",
                                    "Much Worse")),
         kidssol = factor(kidssol,
                          labels = c("Much Better",
                                     "Somewhat Better",
                                     "About The Same",
                                     "Somewhat Worse",
                                     "Much Worse")))

write.csv(gss_subset, "data/gss_week7.csv", row.names = FALSE)
