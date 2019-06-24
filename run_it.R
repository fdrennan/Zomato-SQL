library(RPostgreSQL)
library(tidyverse)
library(dbplyr)
library(DBI)

# GRAB DATA FROM HERE https://www.kaggle.com/shrutimehta/zomato-restaurants-data
# kaggle datasets download -d shrutimehta/zomato-restaurants-data

system('sudo pg_ctlcluster 9.5 main start')
con <- dbConnect(PostgreSQL(),
                 dbname   = '',
                 host     = '',
                 port     = ,
                 user     = '',
                 password = '')

# zomato <- read_csv('zomato.csv') %>%
#   mutate(id = row_number()) %>%
#   select(id, everything())
# 
# write_csv(zomato, 'zomato.csv')

dbExecute(con, sql(read_file('sql/1.create_zomato.sql')))
dbExecute(con, "copy zomato from '/home/ubuntu/projects/zomato/zomato.csv' delimiter ',' csv header ;")
dbExecute(con, sql(read_file('sql/2.main_table.sql')))
dbExecute(con, sql(read_file('sql/3.ratings.sql')))
dbExecute(con, sql(read_file('sql/4.ratings_text.sql')))
dbExecute(con, sql(read_file('sql/5.cuisines.sql')))
dbExecute(con, sql(read_file('sql/6.restaraunt_type.sql')))
dbExecute(con, sql(read_file('sql/7.dishes.sql')))

cuisines <- tbl(
  con, in_schema('public', 'cuisines')
) %>% collect

  
