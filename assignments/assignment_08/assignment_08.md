---
geometry: margin=1.0in
fontsize: 12pt
header-includes:
      - \usepackage{nopageno}
output: pdf_document
---

## SOCI 385 - Social Statistics
## Fall 2019
## Assignment 8

***This assignment is due via Canvas by 12:00 PM on Monday, December 2, 2019.***

***Please show all your code and write your responses in complete sentences as appropriate. Submit your knitted pdf and the R Markdown (.Rmd) file for your notebook. Remember to include your name in the header.***

This week you will continue practicing with multiple regression and interaction terms. The assignment requires the `midd_survey.csv` file we used in class on Thursday. Special thanks to Professor Peggy Nelson for sharing these results from her Fall 2011 survey of Middlebury students!

The variables you will use for this assignment are:

`find_partner`: Answers to the question, "Where do you think you are most likely to find a marriage or long-term partner(s)?" Possible responses are: Family, Friends, Graduate School, Job/Career, Middlebury, None, Other

`gender`: Respondent's self-reported gender. Possible responses are: Male, Female, Other

`housing`: Answers to the question, "Where do you live this semester?" Possible responses are: Dorm, House, Off Campus


### Questions

1. Create a new binary variable identifying respondents who think they are most likely to find a marriage or long-term partner at Middlebury with a 1 and everyone else with a 0. What is the mean of this new variable, and what does that value represent?

2. Regress the binary variable you created in #1 on gender, and interpret the coefficients.

3. Add type of housing as a control variable to the model, and interpret the coefficients.

4. Add an interaction between gender and type of housing to the model, and interpret the coefficients.

5. Save the predicted values from the model in #4. Create a table with `group_by()` and `summarize()` showing how the predicted values differ by gender and housing type. Interpret any interesting results.
