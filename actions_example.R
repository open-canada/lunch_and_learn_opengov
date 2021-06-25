library(ckanr)

ckanr_setup(url="https://open.canada.ca/data")

coviddata<-package_search(q="COVID", rows="10000", as="table")


ID<-coviddata$results$id
title<-coviddata$results$title_translated$en
org<-coviddata$results$organization$title
covid_records<-data.frame(ID,title,org)


write.table(covid_records,file="example_table.csv",append=F,row.names = F,col.names = T, sep = ",")