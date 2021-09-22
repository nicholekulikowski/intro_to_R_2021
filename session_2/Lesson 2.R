
# Lesson 2 "Organizing our data" Objectives: 
# a) Column names
# b) Basic data checks
# c) Data structure
# d) Selecting specific data
# e) Importing and exporting data


##################################################################################
#Our data
##################################################################################
# Clear your environment

x <- 14
x
a <- 5
b <- 6
c <- 17
v1 <- c(a,b,c,x,x) #  c() is a function to combine values into a vector.  
v1
v2 <- c(1,2,3,4,4)

yes <- "yes" #note that you cannot create a value starting with a number [1w <- "r" or 17 <- 20] w1 <- "r" would be fine though. 
yes
v3 <- c(yes, yes, "no", yes, yes) 
v3
v4 <- c(11,4,3,3,3)
df <- data.frame(v1, v2, v3, as.factor(v4)) #dataframe() is a function
df
#####################################################################################
##### Organizing our data
#####################################################################################

## 2a) Columns

# Like most things in R, there are multiple ways to have the right column names.
colnames(df) # Function to identify  our column names.
str(colnames(df)) #The result is a vector.
colnames(v2)
v2

# We can fix the names at the end
# We can define the column names as a vector and then use that vector to rename the columns. However, this takes two lines of code, so we would probably only do it this way if we were going to use cnames elsewhere.
cnames <- c("Response", "Surveynumber", "Twosamples", "ID") #Note that we created a vector!
colnames(df) <- cnames
df

df <- data.frame(v1, v2, v3, as.factor(v4)) #re-creating our dataframe.
df
colnames(df) <- c("Response", "Surveynumber", "Twosamples", "ID") #in one line
colnames(df)
df


# # The default names are what the vectors were called, so we could have named the vectors exactly what we wanted the columns to be named.
Response <- c(a,b,c,x,x)
Surveynumber <- c(1,2,3,4,4)
df2 <- data.frame(Response, Surveynumber)
df2
rm(df2)
# # 

# We can create column names for the data as we make the dataframe
df2 <- data.frame("Response"=v1, "Surveynumber"=v2, "Twosamples"=v3, "ID" = v4)
df2
rm(df2)


## Once we have good column names, we can easily select by our new column names by the accessors 
df
df$Response 


## Get rid of objects in your environment that were mistakes or you don't need going forward.
rm(cnames)
# rm(a,b,c,x)
# Why may you want to keep some "old" data? You may want to have old versions saved along the way to revert to if you make a mistake or troubleshoot. It's a good idea to keep the data you imported so you don't have to re-import. 




###############################################
## 2b) How can we check our data?
###############################################
## These checks can be done with any object.
df #prints the object
print(df) #prints the object
str(x)
str(v1)
str(df) #structure
dim(df) #dimension [row, column]
nrow(df) #number of rows. ncol() is also helpful

min(df$Response) #look at the smallest and largest numbers in specific columns
head(df) #prints the first five lines of your dataframe. Tail prints the last five lines.

View(df) #View outside of the console. #Or you can click on the table icon in the Global Environment.

df$Surveynumber #We should not have any duplicates- how can we check for that?
unique(df$Surveynumber)

unique(df) #we can check the entire dataframe for a duplicate now. It must be EXACTLY the same. 
nrow(unique(df)) == nrow(df) # Result is TRUE  or FALSE # FALSE means that we have a duplicate row.
nrow(unique(df$Surveynumber)) == nrow(df$Surveynumber) # Error
length(unique(df$Surveynumber)) == length(df$Surveynumber) #Length tells us how long the vector is.

# You often want to check for NA data. You may want to
#  - Remove rows or columns with NAs. It could be bad data, or NAs can cause issues with running certain functions.
#  - Identify the missing data to fill it in.

df
df$SampleState <- c("CO", "CA", NA, "WV", "WV") #We're adding another column of States to df.
df

# is.na is a function for identifying NAs. You can't just use  == or !=
df$SampleState == NA 

is.na(df$SampleState) 
is.na(df)
sum(is.na(df$SampleState)) #How many NAs do we have?

length(df[is.na(df)==TRUE]) #How many NAs in the dataframe? We'll learn more about [] later

#####################
## Break 2b
####################
# Make two new covariates columns with covariate1 equal to 4,3.5,32,56,NA and covariate2 equal to 1,5,2,5,1
# Using functions, identify the smallest and largest number for covariate1 and covariate2. HINT: Check out ?min.
#####################


##########################################
####### 2c) Data structure 
##########################################
str(df)
#What is is a factor and why may we want (or not want) data to be stored that way?


#Convert the Survey number to a character, then back to a number
df$Surveynumber
df$Surveynumber <- as.character(df$Surveynumber)
df$Surveynumber
df$Surveynumber <- as.numeric(df$Surveynumber)
df$Surveynumber

#convert the ID column from a factor to a number ## Be careful!
df$ID
as.numeric(df$ID) ## Not correct
df$ID <- as.character(df$ID)
head(df$ID) # Always a good idea to check the values you're changing before and after.
df$ID <- as.numeric(df$ID)
head(df$ID)

#or in one line
df$ID <- as.numeric(as.character(df$ID)) 


# Summary is a good data check to run both when importing data and as you're manipulating your data.
summary(df$ID)
summary(as.factor(df$ID)) #gives you the number of occurrences 
summary(as.factor(df$SampleState)) # Another way to see if there are NAs

# Also checkout table() and ftable()


#In our dataset, the ID number and Survey numbers should NEVER be used as a number. Instead, the Surveynumber is a unique identifier for each survey, and ID represents the person who collected the sample. 
df$ID <-as.character(df$ID)
# df$Surveynumber <- as.character(df$Surveynumber) 
str(df)

# Additionally, we can make this clearer by adding something to the data in the columns
df$Surveynumber <- paste("SN", df$Surveynumber, sep = "") #This function is concatenate in excel.

#If we wanted to make a unique ID based on multiple columns, we can combine multiple existing columns using paste()
df$uid <- paste(df$Surveynumber, df$SampleState, df$ID, sep = "_")
df$uid # Each row should be unique to reflect an individual observation. You can have duplicate rows but from different observations.

##############
##Break 2c
##############
# Using a function, identify how many of each covariate1 values there are.
# Convert covariate1 into a character then back into a number. 
# Convert covariate2 into a factor and then back to a number.


##########################################
#2d) Selecting specific data
##########################################
# To select or exclude specific rows/columns, we can use the subset function or []. 
?subset
colnames(df)
subset(df, subset = Response >10) #You don't have to include the "subset = "
subset(df, ID == 3)
#need to put quotes around characters NOT numbers

subset(df, subset = Twosamples == "yes", select = c("Twosamples", "Surveynumber", "Response")) # We use the select option to select individual columns. Essentially the subset gives the rows and the select gives the columns. As a reminder, you don't have to include either the "subset = " or "select = "

subset(df, is.na(df$SampleState)==FALSE) #Let's remove that line with the missing sample state
df #remember that without saving it back into an object, we have just printed the information
df1 <- subset(df, is.na(df$SampleState)==FALSE)
df1
rm(df1)

##selecting specific rows and columns using []
df
df[1,3] #[row, column]
df[1] #[row, column] <- do not recommend

df[,1] #[row, column] - Leaving it empty means everything
df[1,] #[row, column]

df[1:3,2:3] #[row, column] - remember 1:3 is the same as c(1,2,3)
df[c(1,3:4),2:3] #[row, column]

## You can use negatives to EXCLUDE 
df[-1,] #[row, column]
df[-1,-1:3] #[row, column]## error! Do not do this!
df[-c(1:2),-c(2)] #[row, column]  

# Selecting specific rows
df[df$Response>10,] #same as subset(df, subset = Response >10)

# Vectors don't have rows and columns
v1
v1[1,] #Error
v1[2]


#Renaming just one column 
colnames(df)
colnames(df$ID) <- "ID_surveyor" ## error! Do not do this!
df$ID #Not a dataframe with a colname.
colnames(df)
colnames(df)[4]
colnames(df)[4] <- "ID_surveyor"
colnames(df)


## How can we get rid of that duplicate line?
df

#We can use unique.
df1 <- unique(df)
df1
rm(df1)

# What row and columns do we want to remove? We want to remove the entire ROW 5 vector
# BE VERY CAREFUL with this method. You can end up removing more rows then you intend if you run the line of code again.
df
df[5,] #[row, column] #check that you're removing the right line! 

df[1:4,] # You can select the rows you're keeping.
df1 <- df[1:4,] #You can select the rows you're keeping. Save as a new dataframe.
df1
rm(df1)
df[-c(5),] #But it's better to just identify the one line you're deleting
df1 <- df[-c(5),] 
# rm(df1)


##############
##Break 2d
##############
# Remove the duplicate line and save as df1. [Hint- you can copy/paste from the code we just used!]
# Use any method to remove the df1 line of data with an NA and save the new dataset as df2
# Use both brackets and subset to look at the df1 surveys with covariate2 equal to 1 or 2.
# Use brackets to replace the NA with ND (for North Dakota) in the SampleState.



########################################
# 2e) combining data in base R.
########################################

df1
df2

# rbind and cbind combine dataframes.
rbind(df1,df2) # We're adding df2 as new rows to df1. 
#remember to save as a new dataframe, if you want to keep it.

cbind(df,v1) #We're adding df to v1. They MUST have the same number of rows.

#Merge is very helpful when you want to combine dataframes based on particular column values.
colnames(df1)
colnames(df2)
merge(df1,df2, by.x = "uid", by.y ="uid", all = TRUE) 
merge(df1,df2, by ="uid", all = TRUE)# same as above

merge(df1,df2, by ="uid", all.y = TRUE) # Keeping all the df2 rows with matches to df1

merge(df1,df2, by ="uid") # Keeping all the rows with matches.


##############
##Break 2e
##############
#Make this new dataframe with new covariates.
newcov <- data.frame("uid"=c("SN1_CO_11", "SN2_CA_4","SN3_NA_3", "SN3_WV_3"), "New_Covariate"=c(3,4.6,0.603,50.09), "ID" = c(5:8))
newcov
str(newcov)  
# Use rbind() to combine df2 with df. Using a function, how many rows do you have? Using a function, how many of each Response type do you have? HINT: You'll want to save the new dataframe and use summary().



# Merge df1 with newcov, keeping all the samples from both dataframes, then just keep all those samples from newcov. Save them both as new dataframes.


# For both of the merged datasets, identify the rows that did NOT match up.
# HINT: Use subset() and the fact that NAs are created in non-matching columns. 



########################################
# 2f) Importing and exporting data
########################################

### You can save your new dataframe to csv or excel!
getwd()
# If you save a csv or excel from R, it will overwrite any existing document with the same name.
write.csv(df1, "Data.csv")
write.csv(df, "Data.csv")

## You can create a name that has the date information
cname <- paste("Data", Sys.Date(), ".csv", sep = "") #Sys.time() also exists
cname
write.csv(df1, cname)


test<- read.csv(cname)
test
rm(test)
test<- read.csv(paste("Data", Sys.Date(), ".csv", sep = "")) #or in one line
test

######################
### We want to write to Excel. 

?xlsx # To find out information about a package
library(xlsx) #remember to load your package

?write.xlsx # look at the function information
excelname <- paste("C:/Users/sdeeley/OneDrive - Environmental Protection Agency (EPA)/Intro to R/Lesson2/",Sys.Date(), "alldata.xlsx", sep = "_") #Creating an object so we don't have to write every time below AND so we can alter only this line if we want to reuse this code later.
excelname

write.xlsx(df1, excelname, sheetName = "df1")
write.xlsx(df, excelname, sheetName = "df") # Error! 

write.xlsx(df1, excelname, sheetName = as.character(Sys.Date()), append = TRUE)
write.xlsx(df1, excelname, sheetName = as.character(Sys.Date()), append = TRUE) #If we try to write over the tab we'll get an error
#You will have an error if you have it open when you try to write to it.

######################
##Break 2f
######################
# Save your df2 data as a csv named "Mydata_today'sdate_Lesson2" using the paste() function. 



# Save your df AND df1 aND df2 data as sheets in one excel. The excel should be named "Mydata_today'sdate_Lesson2" using the paste() function. Your sheets may be named anything you like.
# HINT: Open it up in excel to check that you did it.



# Use read.xlsx() to bring in your df2 data and save as a dataframe called cleandata






