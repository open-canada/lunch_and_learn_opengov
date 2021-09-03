system("sudo apt-get install libcurl4-openssl-dev") #the github VM needs this

install.packages("ckanr") #you need to install the packages every time since it is a fresh container
install.packages(data.table)
library(ckanr)
library(data.table)

ckanr_setup(url="https://open.canada.ca/data")

coviddata<-package_search(q="COVID", rows="10000", as="table")


ID<-coviddata$results$id
title<-coviddata$results$title_translated$en
org<-coviddata$results$organization$title
covid_records<-data.table(ID,title,org)

setwd("/home/runner/work/lunch_and_learn_opengov/lunch_and_learn_opengov")

fwrite(covid_records,file="example_table.csv")
