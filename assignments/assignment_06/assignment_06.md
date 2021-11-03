---
fontsize: 11pt
geometry: margin=1.0in
output: pdf_document
header-includes:
     - \usepackage{nopageno}
---



## SOCI 385 - Social Statistics
## Fall 2021
## Assignment 6

***This assignment is due via Canvas by 10:00 AM on Monday, November 8, 2021.***

***Please show all your code and write your responses in complete sentences as appropriate.***

This week you will continue practicing with significance tests for difference in means and proportions. The assignment requires the GSS data you began to clean in class on Wednesday. You are free (and encouraged!) to use the R shortcuts we learned in class. ***Use an alpha level of .05 for all the tests.***

The variables are:

`year`: The year the survey was completed, either 2008 or 2018

`hrs1`: Self-reported hours worked last week, from 1-89

`health`: Self-reported condition of health, coded "Excellent" "Good", "Fair", or "Poor"

`class`: Self-reported social class, coded "Lower class", "Working class", "Middle class", or "Upper class"

`sex`: Self-reported sex, coded "Female" or "Male"


### Questions

1. Finish cleaning the variables selected from the GSS. The notebook we used in class should help you. Note that you have to clean the `health` and `class` variables on your own.

2. Is there a significant difference in mean hours worked last week between respondents identifying with the lower class and respondents identifying with the working class? Why or why not?

3. Is there a significant difference in mean hours worked last week between respondents identifying with the lower class in the 2008 survey and respondents identifying with the lower class in the 2018 survey? Why or why not?

4. Is there a significant difference in the 2018 survey in the proportion of female respondents who report having excellent or good health (vs fair or poor health) and the proportion of male respondents who report having excellent or good health (vs fair or poor health)? Why or why not?

5. Is there a significant difference in the 2018 survey in the proportion of working class respondents who report having excellent health (vs fair or poor health) and the proportion of middle class respondents who report having excellent health (vs fair or poor health)? Why or why not?
