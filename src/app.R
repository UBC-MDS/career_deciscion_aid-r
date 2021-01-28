library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(tidyverse)
library(here)
library(plotly)

# Loading Data Sets
lang_data <- read_csv(here('data/Processed/lang_barplot_data.csv'))
ml_data <- read_csv(here('data/Processed/ml_barplot_data.csv'))
general_processed_data <- read_csv(here('data/Processed/general_processed_data.csv'))


roles <- lang_data %>%
  filter(Q5 != "Student" & Q5 != "Other" & Q5 != "Currently not employed" ) %>%
  select(Q5) %>%
  distinct(Q5) %>%
  pull()

app = Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

app$layout(htmlDiv(
  list(
    dccGraph(id = 'lang_plot'),
    dccDropdown(
      id = "role_select",
      options = purrr::map(roles, function(roles) list(label = roles, value = roles)),
      value = "Data Scientist"),
    dccGraph(id = 'ML_plot'),
    dccGraph(id = 'Rec_lang_count_plot')
    )))

# Call back to lang bar graph- currently not working
app$callback(
  list(output('lang_plot', 'figure')),
  list(input('role_select', 'value')),
  function(role) {
    print(role)
    lang_plot <- lang_data %>%
      filter(Q5 == role) %>%
      ggplot((aes(x = forcats::fct_infreq(selected_lang)))) +
        geom_bar()+
        coord_flip() +
        xlab("") +
        ylab("") +
        theme_classic()
    list(ggplotly(lang_plot))
    }
)

app$callback(
  list(output('ML_plot', 'figure')),
  list(input('role_select', 'value')),
  function(role) {
    print(role)
    ml_data <- ml_data %>%
      filter(Q5 == role) %>%
      ggplot((aes(x = forcats::fct_infreq(selected_ml_method)))) +
      geom_bar()+
      coord_flip() +
      xlab("") +
      ylab("") +
      theme_classic()
    list(ggplotly(ml_data))
  }
)

app$callback(
  list(output('Rec_lang_count_plot', 'figure')),
  list(input('role_select', 'value')),
  function(role) {
    print(role)
    general_processed_data <- general_processed_data %>%
      filter(Q5 == role) %>%
      ggplot((aes(x = Q8, y = Q4))) +
      geom_count()+
      coord_flip() +
      xlab("") +
      ylab("") +
      theme_classic()
    list(ggplotly(general_processed_data))
  }
)



app$run_server(debug = T)

