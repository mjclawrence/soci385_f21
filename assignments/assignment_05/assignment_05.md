---
geometry: margin=1.0in
fontsize: 12pt
output: pdf_document
header-includes:
      - \usepackage{nopageno}
---

## SOCI 385 - Social Statistics
## Fall 2021
## Assignment 5

***This assignment is due via Canvas by 10:00 AM on Monday, November 1, 2021.***

***Please show all your code and write your responses in complete sentences as appropriate. Submit your knitted pdf and the R Markdown (.Rmd) file for your notebook. Remember to include your name in the header.***

This week you will continue practicing with hypothesis testing. The assignment requires the `assignment_05.csv` file which includes 1289 observations from the 2018 wave of the General Social Survey. There is no missing data. The three variables are:

`id`: A unique identifier for each respondent

`mntlhlth`: Self report of days of poor mental health in the past 30 days, from 0 - 30

`degree`: Respondent's highest level of completed education. Levels are: Less than high school, High school, Some college, College degree, and Grad/Prof degree


### Questions

1. Does the mean number of days of poor mental health differ from 3 at 99% confidence level?

2. Among respondents reporting any days of poor mental health, does the mean number of days differ from 7 at 95% confidence level?

3. Consider respondents who have not entered or completed college. Among these respondents, does the proportion with any mental health days differ from .10 at the 99% confidence level?

4. Consider respondents who have completed college or more. Among these respondents, does the proportion with any mental health days differ from .10 at the 95% confidence level?