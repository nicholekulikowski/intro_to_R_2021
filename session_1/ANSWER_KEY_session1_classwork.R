######################################################
######              ANSWER KEY                  ######
###### Intro to R Workshop: Session 1 Classwork ######
######                 9/22/2021                ######
######################################################

###############################################################
#################### INSTRUCTIONS #############################
## Complete the following questions in your breakout rooms.
## You can code directly into this script.
## We will return to the main session in 15 minutes. 
## Don't be afraid to ask others for help!
###############################################################

# 1. Navigate on the top to "Tools", "Install Packages", type and search "tidyverse", click the "install" button

# 2. 
install.packages("readxl")
install.packages("lubridate") 
#OR!!!!
install.packages(c("readxl", "lubridate"))

# 3.
library(tidyverse)
library(readxl)
library(lubridate)

# 4. 
data(mtcars)


# 5. 
colnames(mtcars)

# 6.
View(mtcars) #this is equivalent to clicking on the object "mtcars" in the Environment

# 7. 
n <- 100
n*(n+1)/2

  

################################################################################################################
#### STOP!- We will return to the main session. We will have time to complete the problems below at the end ####
################################################################################################################




# 6. a dataframe OR a tibble 

# 7.
class(mtcars$cyl)
str(mtcars) #you can look at the object in the console and see it's numeric

# 8.
car_cyl <- mtcars$cyl

# 9.
length(car_cyl)

# 10.
library(tidyverse) # if you haven't already
data(us_rent_income)
str(us_rent_income) #There are 104 rows and 5 columns, there are many ways to get this answer str() os just one way

# 11. 
View(us_rent_income) #$34,498

# 12.
length(which(us_rent_income$estimate > 40000)) # 1 state: this is much easier to do in tidyverse we will learn tomorrow
length(which(us_rent_income$estimate > 30000)) # 20 states

# 13.
sort(us_rent_income$estimate) #$43,198

# 14. 
names(us_rent_income)

# 15. 
data(infert)

# 16.
head(infert)

# 17. 
class(infert) #the dollar sign was a mistake on my end- if you said NA or error because you used a $, you are also correct

# 18. 
levels(infert$education) # 3 age groups
#the question above was supposed to be "what is the class of infert$education", which would have made this easier