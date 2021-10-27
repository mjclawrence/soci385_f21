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


---
  
  
## Week 7
  
gss_subset <- gss_all |> 
  filter(year==2008 | year==2018) |> 
  select(year, hrs1, health, class, sex)


gss_get_marginals(varnames = c("health", "class"), data = gss_doc)


gss_subset <- gss_subset |> 
  mutate(health = factor(health,
                         labels = c("Excellent",
                                    "Good",
                                    "Fair",
                                    "Poor")),
         class = factor(class,
                        labels = c("Lower",
                                   "Working",
                                   "Middle",
                                   "Upper")))

years <- gss_which_years(gss_all, mntlhlth)

days <- gss_get_marginals(varnames = "mntlhlth", data = gss_doc)


days <- gss_all |> 
  filter(year==2018) |> 
  filter(age >= 25) |>
  filter(!is.na(mntlhlth)) |> 
  filter(!is.na(degree)) |> 
  select(id, mntlhlth, degree) |> 
  mutate(degree = factor(degree,
                         labels = c("Less than high school",
                                    "High school",
                                    "Some college",
                                    "College degree",
                                    "Grad/Prof degree")))

summary(days$mntlhlth)


t.test(days$mntlhlth, mu = 3, conf.level = .99)
t.test(days$mntlhlth[days$mntlhlth>0], mu = 7, conf.level = .95)

ci <- days |> 
  #filter(mntlhlth>0) |> 
  group_by(degree) |> 
  summarise(mean = mean(mntlhlth, na.rm=TRUE),
            sd = sd(mntlhlth, na.rm=TRUE),
            se = sd / sqrt(length(mntlhlth)),
            ll = mean - 1.96*se,
            ul = mean + 1.96*se) |> 
  ggplot(aes(x = degree, y = mean, ymin = ll, ymax = ul)) +
  geom_point() + geom_errorbar()


ci


test <- days |> 
  mutate(any = ifelse(mntlhlth>10, 1, 0),
         college = ifelse(str_detect(degree, "degree"), 1, 0))

addmargins(table(test$college, test$any))

prop.test(92, 810, p = .10, conf.level = .99)
prop.test(34, 479, p = .10, conf.level = .95)

write.csv(days, "data/assignment_05.csv", row.names = FALSE)

## Mental Health Example

- Does the mean number of days differ from 3 at 99% confidence level?
- Among respondents with any days of mental health, does the mean number of days differ from 7 at 95% confidence level?
- Consider respondents who have not completed college. Among these respondents, does the proportion with any mental health days differ from .10 at the 99% confidence level?
- Consider respondents who have completed college or more. Among these respondents, does the proportion with any mental health days differ from .10 at the 95% confidence level?
  
  
t.test(assignment_05$mntlhlth, mu = 3, conf.level = .99)

t.test(assignment_05$mntlhlth[assignment_05$mntlhlth>0], mu = 7, conf.level = .95)

assignment_05 <- assignment_05 |> 
  mutate(any = ifelse(mntlhlth>10, 1, 0),
         college = ifelse(str_detect(degree, "degree"), 1, 0))

addmargins(table(assignment_05$college, assignment_05$any))

prop.test(92, 810, p = .10, conf.level = .99)
prop.test(34, 479, p = .10, conf.level = .95)
