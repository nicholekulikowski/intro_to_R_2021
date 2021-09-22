######################################################
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

# 1. Installing Packages- Using the RStudio interface, install the package "tidyverse".
# (Note- tidyverse is actually a family of packages, which we will be using all of Day 2)


# 2. Install the following packages using code: "readxl" and "lubridate"  (hint- use the function install.packages( ) )


# 3. Load all of the above packages into your library. Write your code below and run it.


# 4. Run the code below. Note- be sure to only run the line, not the entire script. 
#    Click on "mtcars" in your environment
data(mtcars)


# 5. The function colnames( ) returns the column names of a dataframe. Using colnames( ), what are the names of the
#    columns in mtcars? Write your code below.


# 6. Type View(mtcars) below and run it. What is this equivalent to?


# 7. Solve n(n+1)/2, where n = 100 (this is the sum of the first 100 integers)
# Define your variable below
n <- 
  
# Write your code below to solve. Use your variable, n, in your code.
  
  

################################################################################################################
#### STOP!- We will return to the main session. We will have time to complete the problems below at the end ####
################################################################################################################



#################### INSTRUCTIONS #############################
## Complete the problems below in the second breakout room. 
## We will return to the main session in 15 minutes.

# 6. What type is the object "mtcars"?

# 7. What type of vector is "cyl" in "mtcars"? Solve in two different ways. (Hint- remember the accessor)

# 8. Assign "cyl" to a new variable called "car_cyl".

# 9. What is the "length()" of car_cyl?

# 10. Load the dataset "us_rent_income" using the "data( )" function. How many rows and columns are there?

# 11. Using "us_rent_income", what was the average income in Massachusetts?

# 12. How many states had an average income above $40,000? What about above $30,000?

# 13. The function "sort( )" sorts a vector in increasing order. What was the highest income listed in "us_rent_income"?

# 14. The function "names( )" also gives column names. Use the "names()" function to find the column names of us_rent_income

# 15. Finally, load the dataset "infert" using the data function. Click on it in the environment.

# 16. Look at head() of "infert" to familiarize yourself with the data. Talk with your group on what each column means

# 17. What is the class( ) of infert$?

# 18. How many different age groups are in infert$education? (Hint- use levels()) 