# Milestone 1 - Dashboard proposal

Group Member: Santiago Rugeles Schoonewolff, Jacob McFarlane, Yuyan Guo

### Section 1: Motivation and Purpose

 Our role: Data scientist research team

 Target audience: Anyone who is interested in looking for a job in data science, machine learning and computer science field.(Potentially including all MDS students)

 Data science and computer science starts to get really popular in recent years. Such popularity attracts more people to join and even transfer into this field without knowing too much about it. In fact, data science and computer science is a very large and complex field with various career options, such as data analyst, soft engineer etc. Those different career choices can have completely different concentrataion and skill requirements. Therefore, we propose buliding a public available data visualization app to allow people to visually explore the current job market for data science and computer science in more details to indentify the main difference between those occupations. Our app will show the average salary, and the distribution of required programming and machine learning skills across different jobs in the field. It will also allow audience to explore the job market more by filtering on more variables together but not only job title, such as the year of experience, education level. 

### Section 2: Description of the data

 We will be visualizing a dataset of the Kaggle Machine Learning & Data Science Survey for 2020, which includes 20,036 responses/individuals. Each response has 39 associated variables melted in more than 300 columns that are corresponding to 39 questions in the survey, as the responses to multiple selection questions were split into multiple columns (with one column per answer choice). The variables describe the individuals who are currently in the data science and computer science fields(`education(Q4)`, `gender(Q2)`, `age(Q4)`), their current role(`job_title(Q5)`), thier salary range(`compensation(Q24)`), the tools they used on a regular basis(`programming_language(Q7)`, `IDE(Q9)`, `data_visualization_libraries(Q14)`,  `business_intelligence(Q31)`, `primary_tool(Q38)`), and machine learning tools/algorithms they used on a regular basis(`machine_learning_framework(Q16)`, `machine_learning_algorithm(Q17)`).

### Section 3: Research questions and usage scenarios

Questions:

Which programming languages/machine learning framework are most commonly used in which fields?   
	
Which fields pay the best?   
	
Among different years of experience and different fields, how most commly used data science skills and salary differentiate?   
	
Usage Scenario:

Jim is a student in a Data Science program. He's interested in becoming a Machine Learning engineer but not entirely sure which frameworks and programming languages are most common. He's looked at a few job postings, but he wants to get a big picture so he can better allocate his time. Jim uses our dashboard and sees that among frameworks TensorFlow is the most used among Machine Learning Engineers. SQL, surprisingly, is a programming language that many use on a regular basis. Since he feels a little shaky on his SQL he decides to allocate more of his time to the deepening his SQL and lands his dream job.