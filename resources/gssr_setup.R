library(tidyverse)
library(gssr)
data("gss_doc")
data("gss_all")



gss_subset <- gss_all %>%
  filter(year>=2008 & !is.na(agekdbrn)) %>%
  select(id, year, educ, agekdbrn)

table(gss_subset$agekdbrn, exclude = NULL)
table(gss_subset$year)

summary(gss_subset$agekdbrn)

sort(table(gss_subset$agekdbrn[gss_subset$educ<=12]), 
     decreasing = TRUE)

prop.table(table(gss_subset$educ))

df2 <- gss_subset %>%
  filter(educ>=16)

summary(df2$agekdbrn)
