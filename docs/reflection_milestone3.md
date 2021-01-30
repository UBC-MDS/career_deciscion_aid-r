# Reflection of the Worked Done and Goals Achieved in Milestone 3

## Widgets and Interactivity:

The dashboard created in R currently provides the options of filtering both by programming experience and Job Title, being able to change in real time between the most used machine learning methods, programming languages and the recommended languages to learn given the education level, of the people filtered with the specifications entered in the widgets. All the graphs are interactive as they are saves as ggplotly figures. It is important to mention that the experience being used for the queries is not the job experience in the competitive and professional Data Science Field but their programming experience overall. Unfortunately, Kaggle´s survey never asked the interviewed Data Science community for their professional experience, so we cannot count with this information. 

## R Language Dashboard Usage:

We present three graphs and two cards in the body of our dashboard. Clockwise from the top left, a bar chart displays the most commonly used programming languages among respondents to the survey. Another bar plot plots the frequency with which respondents mentioned machine learning paradigms. Below that bar chart, we present a count plot of languages respondents to the survey recommend learning broken up by the respondents level of education. To the right of the count plot we indicate the median highest and median lowest salary given in the ranges.Fortunately, the importation provided by the dashboard is clear, straightforward and insightful. The plots are interactive, allowing any used to visualize a specific count by clicking in a bar or a point.

Moreover, developing the dashboard in R presented some difficulties, these are:
* Most of the source code is developed specifically for Python. Furthermore, some applications, like the cards, work differently, and there is not enough information for the troubleshooting.
* The slider structure specified does not work efficiently with "debug = True"", forcing us to use a different specification for its values.
  

## Limitations and Future Work:

The current dashboard has an acceptable functionality, and its simplicity makes it usable for anyone interested in the topic. Nonetheless, there´s still not enough interactivity for the user to identify the exact information he/she may want, for example: "How popular is the Data Science field and its variance in my county, and how much money can I hope to obtain given my current or future expected profile". Having this into consideration, our goal in Milestone 4, apart from fulfilling the goals specified in the instructions are:

* Give the possibility of filter the information by country (if there is no information about that country it will go into the "other" category).
* Present a visual aid (map) of the count of surveyants by country.
* Improve the overall aesthetic and layout of the dashboard, for it to look more interactive and professional.
