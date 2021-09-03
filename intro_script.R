#### Part 1: ckanr ####

install.packages(ckanr)
install.packages(data.table)
library(ckanr)
library(data.table) # It is suggested to always by default use data.table instead of data.frame
                    # The code will be faster, easier to read, and you will not need dplyr, which is verrry slow.
# library(dplyr)

######get list of ckan instances ##################

servers()

ckan_info(url = "catalog.data.gov")
ckan_info(url = "https://open.canada.ca/data")

###### setup the right URL for the portal #####

ckanr_setup(url="https://open.canada.ca/data")
# By default this opens Ontario data - as it the "best vanilla version of ckan"

########## search for something ############

package_search(q="COVID")

################ get a list of datasets ###############

mylist<-package_list();
mylist

################ get a list of orgs ###############

organization_list()
organization_list(as="json")

################ get org metadata ###############

if (F) { # It's good practice to put related code chunks in if(). E.g. this chunk may not run 
  NRCan<-organization_show("9391E0A2-9717-4755-B548-4499C21F917B")
  NRCan<-organization_show("9391E0A2-9717-4755-B548-4499C21F917B", as="list") # default as=list
  NRCan<-organization_show("9391E0A2-9717-4755-B548-4499C21F917B", as="json")
  NRCan<-organization_show("9391E0A2-9717-4755-B548-4499C21F917B", as="table")
  
}

################ get metadata on datasets ###############

my_metadata<-lapply(mylist,package_show) #some datasets
my_metadata

package_show(mylist[[12]], as="table") #1 dataset
package_show("00000d1c-2567-4f51-a08b-d11c3413f829", as="json") #1 dataset

############### Looking at extracting features from the covid datasets as a DT ####

coviddata<-package_search(q="COVID", rows="10000", as="table")

str(coviddata)
View(coviddata)
View(coviddata[["results"]])

ID<-coviddata$results$id
title<-coviddata$results$title_translated$en
org<-coviddata$results$organization$title
covid_records<-data.table(ID,title,org)

covid_records
View(covid_records)

write.table(covid_records,file="example_table.csv",append=F,row.names = F,col.names = T, sep = ",")


#### Part 2:  See also https://github.com/PatLittle/OpenGov_R_Scripts ####

############ lets get all the datasets from one department #################


organization_list(as="table") #find department name

dept_data<-package_search(q="COVID", fq= 'owner_org:2ABCCA59-6C57-4886-99E7-85EC6C719218', rows="10000", as="table")
#understanding the structure of the metadata is important to be able to do filter queries. 

print(dept_data$results)


################# actions section ###############

# lets take our example of the table of covid records and write that as a table.

#write.table(covid_records,file="example_table.csv",append=F,row.names = F,col.names = T, sep = ",")
fwrite(covid_records,file="example_table.csv")

# very easy to do that, but what If I want this to be automatically refreshed every morning?
# proceed to actions_example.R

