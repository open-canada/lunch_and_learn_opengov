### BASIC INTRO TO ADOBEANALYTICSR FOR LUNCH & LEARN ###

#Install our package
install.packages("adobeanalyticsr")
library(adobeanalyticsr)

## Do the Authentication Process
#Service Canada will create the Adobe Console API Project - or tell you which one to connect to

#Create an .Renviron file with the API info they provide to you.
# that file should look like:
# AW_CLIENT_ID = "ac79XXXXXXX6485d9fd6XXXXXXXXXXXX"
# AW_CLIENT_SECRET = "p8e-XXXXXXXXXXXXXXXXXXXXXXX-XXXxXTv--"
# AW_COMPANY_ID = "canada5"
# AW_REPORTSUITE_ID = "canadalivemain"

aw_token() #download you aa.outh file and authenticate with the system
#this will open a browser, then you need to login with your system credentials, and it will give you a token to paste into the console

get_me() #verify your connection

#see what features are in the system for you to access
#IMO this is better to access from the user manual provided

dims_table<-aw_get_dimensions()

aw_get_metrics()

aw_get_segments()

metrics_table<-aw_get_metrics()

## now we can start pulling some data
## aw_freeform_table will be the function we use to get data

# Lets see what the top pages on Canada.ca were for August

topPages<-aw_freeform_table(
  date_range = c("2021-08-01", "2021-08-31"),
  company_id = Sys.getenv("AW_COMPANY_ID"),
  rsid = Sys.getenv("AW_REPORTSUITE_ID"),
  dimensions = c("evar11"), #evar11 is page_title
  metrics = c("pageviews","visits"),
  top = c(20)
)

# Lets see what departments had the most views on Canada.ca for August

topDepts<-aw_freeform_table(
  date_range = c("2021-08-01", "2021-08-31"),
  company_id = Sys.getenv("AW_COMPANY_ID"),
  rsid = Sys.getenv("AW_REPORTSUITE_ID"),
  dimensions = c("evar14"), #evar14.1 is department content owner
  metrics = c("pageviews","visits"),
  top = c(20)
)


#lets see the same for themes

topTheme<-aw_freeform_table(
  date_range = c("2021-08-01", "2021-08-31"),
  company_id = Sys.getenv("AW_COMPANY_ID"),
  rsid = Sys.getenv("AW_REPORTSUITE_ID"),
  dimensions = c("evar16"), #evar16 is theme
  metrics = c("pageviews","visits"),
  top = c(20)
)

#lets check which pages had the longest time on page

topTime<-aw_freeform_table(
  date_range = c("2021-08-01", "2021-08-31"),
  company_id = Sys.getenv("AW_COMPANY_ID"),
  rsid = Sys.getenv("AW_REPORTSUITE_ID"),
  dimensions = c("evar11"), #evar14.1 is department content owner
  metrics = "itemtimespent",
  top = c(20)
)

#lets see the number of pageviews for content in each language

topLang<-aw_freeform_table(
  date_range = c("2021-08-01", "2021-08-31"),
  company_id = Sys.getenv("AW_COMPANY_ID"),
  rsid = Sys.getenv("AW_REPORTSUITE_ID"),
  dimensions = c("evar5"), #evar14.1 is department content owner
  metrics = "pageviews",
  top = c(20)
)

#then we can use our general R skills to analyze the data
barplot(topLang$pageviews, names.arg = topLang$evar5)
