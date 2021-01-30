library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(dashBootstrapComponents)
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

slider_recognition <- function(prog_exp__val){
  if (prog_exp__val == 1) {
    exp_range <- '< 1 years'
  } else if (prog_exp__val == 2) {
      exp_range <- '1-2 years'
  } else if (prog_exp__val == 3) {
      exp_range <- '3-5 years'
  } else if (prog_exp__val == 4) {
      exp_range <- '5-10 years'
  } else if (prog_exp__val == 5) {
      exp_range <- '10-20 years'
  } else {
      exp_range <- '20+ years'
    }
  exp_range
}

ml_data <- ml_data %>%
  mutate(selected_ml_method = case_when(selected_ml_method=="Dense Neural Networks (MLPs, etc)" ~ "Dense Neural Networks",
                                         selected_ml_method=="Gradient Boosting Machines (xgboost, lightgbm, etc)" ~ "Gradient Boosting Machines",
                                         selected_ml_method=="None" ~ "I do not use ML Methods",
                                          TRUE ~ selected_ml_method))
 

app = Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

app$layout(
  dbcContainer(
    list(
      dbcRow(
        htmlH1('Data Science Decision Aid Dashboard',
               style=list('color' = '#2E4053', 'background-color' = '#CACFD2')
        )
      ),
      dbcRow(
        htmlP('This dashboard has the objective of informing Data Science students, professionals and even prospects (future possible Data Sciences professionals
           the worldwide state of the art regarding most used programming languages,machine learning methods, the recommended programs to learn first with a 
           considerable aggregated value (for prospects),and yearly income of different job titles.',
           #style=list('color' = '#D6ED17FF', 'background-color' = '#606060FF')
        )
      ),
      dbcRow(
        list(
          dbcCol(
            list(htmlLabel('Programming Experience'),
                 dccSlider(
                   id = "prog_exp",
                   min = 1,
                   max = 6,
                   marks = list(
                     "1" = "< 1 years",
                     "2" = "1-2 years",
                     "3" = "3-5 years",
                     "4" = "5-10 years",
                     "5" = "10-20 years",
                     "6" = "+20 years"),
                   value = 1)
            )
          ),
          dbcCol(
            list(htmlLabel('Job Title'),
                 dccDropdown(
                   id = "role_select",
                   options = purrr::map(roles, function(roles) list(label = roles, value = roles)),
                   value = "Data Scientist")
            )
          )
        )
      ),
      htmlBr(),
      htmlBr(),
      dbcRow(
        list(
          dbcCol(
            list(
              dccGraph(id = 'lang_plot')
            )
          ,md=5),
          dbcCol(
            list(
              dccGraph(id = 'ML_plot')
            )
          ,md=7)
        )
      ),
      htmlBr(),
      dbcRow(
        list(
          dbcCol(
            list(
              dccGraph(id = 'Rec_lang_count_plot')
            )
          ),
          dbcCol(
            list(
              htmlBr(),
              htmlBr(),
              htmlBr(),
              htmlBr(),
              htmlBr(),
              htmlBr(),
              #htmlLabel('Median Yearly Salary'),
              dbcCard(list(htmlBr(),
                           htmlH4("Median Yearly Salary($)", style = list('text-align' = 'center')),
                           dbcCardBody(id = 'median_salary')), color = "warning", style = list('text-align' = 'center',
                                                                                               'font-size' = '22px',
                                                                                               'height' = '18vh'))
            )
          ,md=4)
        )
      )
    )))
    

app$callback(
  list(output('lang_plot', 'figure')),
  list(input('role_select', 'value'),
       input('prog_exp', 'value')),
  function(role, prog_exp) {
    exp_range <- slider_recognition(prog_exp)
    lang_plot <- lang_data %>%
      filter(Q5 == role & Q6 == exp_range) %>%
      ggplot((aes(x = forcats::fct_infreq(selected_lang)))) +
        geom_bar()+
        coord_flip() +
        xlab("") +
        ylab("Counts") +
        theme_classic() +
        ggtitle("Most Used Programming Languages") +
      theme(
        plot.title = element_text(size = 13, face = "bold"),
        axis.text = element_text(size = 7),
        axis.title = element_text(size = 10))
    list(ggplotly(lang_plot))
    }
)

app$callback(
  list(output('ML_plot', 'figure')),
  list(input('role_select', 'value'),
       input('prog_exp', 'value')),
  function(role, prog_exp) {
    exp_range <- slider_recognition(prog_exp)
    ml_plot <- ml_data %>%
      filter(Q5 == role & Q6 == exp_range) %>%
      ggplot((aes(x = forcats::fct_infreq(selected_ml_method)))) +
      geom_bar()+
      coord_flip() +
      ggtitle("Most Used ML Methods") +
      xlab("") +
      ylab("Counts") +
      theme_classic() +
      theme(
        plot.title = element_text(size = 13, face = "bold"),
        axis.text = element_text(size = 7),
        axis.title = element_text(size = 10))
    list(ggplotly(ml_plot))
  }
)

app$callback(
  list(output('Rec_lang_count_plot', 'figure')),
  list(input('role_select', 'value'),
       input('prog_exp', 'value')),
  function(role, prog_exp) {
    exp_range <- slider_recognition(prog_exp)
    general_processed_plot <- general_processed_data %>%
      filter(Q5 == role & Q6 == exp_range) %>%
      ggplot((aes(y = Q8, x = Q4))) +
      geom_count() +
      coord_flip() +
      ggtitle("Level of Education vs. Recommended Programs to Learn") +
      xlab("") +
      ylab("") +
      theme_classic() +
      scale_x_discrete(labels=c("Bachelor´s Degree", "Doctoral Degree", "Prefer not to Answer", "Master´s Degree",
                                "Some Professional Degree", "No Professional Degree")) +
  
      theme(
        plot.title = element_text(size = 13, face = "bold"),
        axis.text = element_text(size = 7),
        axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
        axis.title = element_text(size = 10))
    list(ggplotly(general_processed_plot))
  }
)

app$callback(
  list(output('median_salary', 'children')),
  list(input('role_select', 'value'),
       input('prog_exp', 'value')),
  function(role, prog_exp){
    exp_range <- slider_recognition(prog_exp)
    data <- general_processed_data %>%
      filter(Q5 == role & Q6 == exp_range)
    obtained_salary <- paste(as.character(median(data$lower, na.rm=TRUE)), "-",as.character(median(data$higher, na.rm=TRUE)), " (USD)")
    list(obtained_salary)
  }
)



#app$run_server(debug = T)
app$run_server(host = '0.0.0.0')
# try
