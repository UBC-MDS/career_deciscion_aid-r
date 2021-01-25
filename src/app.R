library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(tidyverse)
library(here)
library(plotly)

# Loading Data Sets
lang_data <- read_csv(here('data/Processed/lang_barplot_data.csv'))

roles <- lang_data %>%
  filter(Q5 != "Student" & Q5 != "Other" & Q5 != "Currently not employed" ) %>%
  select(Q5) %>%
  distinct(Q5) %>%
  pull()

app = Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

app$layout(htmlDiv(
  list(
    dccGraph(figure = ggplotly(lang_plot)),
    dccGraph(id = 'lang_plot'),
    dccDropdown(
      id = "role_select",
      options = purrr::map(roles, function(roles) list(label = roles, value = roles)),
      value = "Data Scientist"),
    htmlDiv(id='widget-3'))))

app$run_server(debg = T)

# Call back to lang bar graph- currently not working
app$callback(
  list(output('lang_plot', 'figure')),
  list(input('role_select', 'value')),
  function(role) {
    lang_plot <- lang_data %>%
      filter(Q5 == "Data Scientist") %>%
      ggplot((aes(x = forcats::fct_infreq(selected_lang)))) +
        geom_bar()+
        coord_flip() +
        xlab("") +
        ylab("") +
        theme_classic()
      ggplotly(lang_plot)
    }
)

# Code used for debugging- trying to see if issue is with callback
app$callback(
 list(output('widget-3', 'children')),
 list(input('role_select', 'value')),
 function(input_val){
   input_val
 }
)



