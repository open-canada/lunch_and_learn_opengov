library(ckanr)
# library(dplyr)


######get list of ckan instances ##################

servers()


############
ckan_info(url = "catalog.data.gov")

######setup the right URL for the portal #####
ckanr_setup(url="https://open.canada.ca/data")


########## search for something ############

package_search(q="COVID")

################ get a list of datasets ###############

mylist<-package_list()
################ get a list of orgs ###############

organization_list()

################ get org metadata ###############
NRCan<-organization_show("9391E0A2-9717-4755-B548-4499C21F917B")
NRCan<-organization_show("9391E0A2-9717-4755-B548-4499C21F917B", as="list") # default as=list
NRCan<-organization_show("9391E0A2-9717-4755-B548-4499C21F917B", as="json")
NRCan<-organization_show("9391E0A2-9717-4755-B548-4499C21F917B", as="table")

################ get metadata on datasets ###############

my_metadata<-lapply(mylist,package_show) #some datasets


package_show(mylist[[12]], as="table") #1 dataset

package_show("00000d1c-2567-4f51-a08b-d11c3413f829", as="json") #1 dataset



############### Looking at extracting features from the covid datasets as a DF ####


coviddata<-package_search(q="COVID", rows="10000", as="table")

View(coviddata[["results"]])

ID<-coviddata$results$id
title<-coviddata$results$title_translated$en
org<-coviddata$results$organization$title
covid_records<-data.frame(ID,title,org)
View(covid_records)

write.table(covid_records,file="example_table.csv",append=F,row.names = F,col.names = T, sep = ",")

############ lets get all the datasets from one department #################


organization_list(as="table") #find department name

dept_data<-package_search(q="COVID", fq= 'owner_org:2ABCCA59-6C57-4886-99E7-85EC6C719218', rows="10000", as="table")
#understanding the structure of the metadata is important to be able to do filter queries. 

print(dept_data$results)


#################actions section###############

#lets take our example of the table of covid records and write that as a table.

write.table(covid_records,file="example_table.csv",append=F,row.names = F,col.names = T, sep = ",")

#very easy to do that, but what If I want this to be automatically refreshed every morning?
