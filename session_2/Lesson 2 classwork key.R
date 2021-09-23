
# Lesson 2
## Objectives: 
## 1) Useful functions for Checking and cleaning data
#1a) Column names
#1b) Basic data checks
#1c) Data structure
#1d) Selecting specific data
## 2) Importing and exporting data

# Remember to clear your environment!

############ Build your dataset
x <- 14
a <- 5
b <- 6
c <- 17
v1 <- c(a,b,c,x,x) #  c() is a function to combine values into a vector. Show ?c and help tab 
v2 <- c(1,2,3,4,4)
v3 <- c("yes", "yes", "no", "yes", "yes") # talk about how we used defined values, numbers, and text. Discuss the differences and use of ""
v4 <- c(11,4,3,3,3)
df <- data.frame("Response"=v1, "Surveynumber"=v2, "Twosamples"=v3, "ID" = v4)
df$SampleState <- c("CO", "CA", NA, "WV", "WV") #We're adding another column to df.
df$Surveynumber <- paste("SN", df$Surveynumber, sep = "")
df$uid <- paste(df$Surveynumber, df$SampleState, df$ID, sep = "_")

df






###########################################################################################
#######Break 2b
# Make two new covariates columns with covariate1 equal to 4,3.5,32,56,NA and covariate2 equal to 1,5,2,5,1
# Answer:
df$covariate1 <- c(4,3.5,32,NA,NA)
df$covariate2 <- c(1,5,2,1,1)

#Using functions, identify the smallest and largest number for covariate1 and covariate2. HINT: Check out ?min.  
# Answer:
# min(df$covariate1) #NAs because we included an NA
# max(df$covariate1)#NAs because we included an NA
min(df$covariate1, na.rm = TRUE) 
max(df$covariate2, na.rm = TRUE)
min(df$covariate2)
max(df$covariate2)






###########################################################################################
#######Break 2c
#Using functions, identify how many of each covariate1 value there are.
#Answer
summary(as.factor(df$covariate1)) 

# Convert covariate1 into a character then back into a number
#Answer
df$covariate1 <- as.character(df$covariate1)
df$covariate1 # Always a good idea to check the values you're changing before and after.
df$covariate1 <- as.numeric(df$covariate1)
df$covariate1

# Convert covariate2 into a factor and then back to a number.
#Answer
df$covariate2
df$covariate2 <- as.factor(df$covariate2)
str(df)
df$covariate2 <- as.numeric(as.character(df$covariate2)) 
df$covariate2


###########################################################################################
##############
##Break 2d
##############
#Remove the duplicate line using unique and save as df1. [Hint- you can copy/paste from the code we just used!]
df1 <- unique(df)
df1

#Use any method to remove the df1 line of data with an NA and save the new dataset as df2.
df2<- subset(df1, is.na(covariate1)==FALSE)
df2

## Use both brackets and subset to look at the df1 surveys with covariate2 equal to 1 or 2.
# Answer:
df1[df1$covariate2<=2,]
subset(df1, df1$covariate2<=2)

# Use brackets to replace the NA with ND (for North Dakota) in the df2 SampleState.
# Answer:
df2[3,5]
df2[3,5] <- "ND"

df2





##########################################################################################
##############
##Break 2e
##############

#Make this new dataframe with new covariates.
newcov <- data.frame("uid"=c("SN1_CO_11", "SN2_CA_4","SN3_NA_3", "SN3_WV_3"), "New_Covariate"=c(3,4.6,0.603,50.09), "New_Covariate2" = 5:8)
newcov
str(newcov)  


# Use rbind to combine df2 with df. Using a function, how many rows do you have? Using a function, how many of each Response type do you have? HINT: You'll want to save the new dataframe and use summary().
rbind(df,df2)
nrow(rbind(df,df2)) #8
new <- rbind(df,df2)
summary(as.factor(new$Response)) #2 of each
# 5  6 14 17 
# 2  2  2  2 


# Merge df1 with newcov, keeping all the samples from both dataframes, then just keep all those samples from newcov. Save them both as new dataframes.

allmerge <- merge(df1, newcov, by = "uid", all = TRUE)
allmerge
xmerge <- merge(df1, newcov, by = "uid", all.x = TRUE)
xmerge

# For both of the merged datasets, identify the rows that did NOT match up.
# HINT: Use subset() and the fact that NAs are created in non-matching columns. 

subset(allmerge, is.na(allmerge$Response) == TRUE) # uid SN3_WV_3
subset(allmerge, is.na(allmerge$New_Covariate) == TRUE) # uid SN4_WV_3 

subset(xmerge, is.na(xmerge$Response) == TRUE) # NONE
subset(xmerge, is.na(xmerge$New_Covariate) == TRUE) # uid SN4_WV_3 



###########################################################################################
##Break 2f

# Save your df2 data as a csv named "Mydata_today'sdate_Lesson2" using the paste() function. 

write.csv(df2, paste("Mydata", Sys.Date(), "Lesson2.csv"))


# Save your df AND df1 AND df2 data as sheets in one excel. The excel should be named "Mydata_today'sdate_Lesson2" using the paste() function. Your sheets may be named anything you like.
# HINT: Open it up in excel to check that you did it.

write.xlsx(df, paste("Mydata", Sys.Date(), "Lesson2.xlsx"), sheetName = "df", append = TRUE)
write.xlsx(df1, paste("Mydata", Sys.Date(), "Lesson2.xlsx"), sheetName = "df1", append = TRUE)
write.xlsx(df2, paste("Mydata", Sys.Date(), "Lesson2.xlsx"), sheetName = "df2", append = TRUE)

# Use read.xlsx() to bring in your df2 data and save as a dataframe called cleandata


read.xlsx(df, paste("Mydata", Sys.Date(), "Lesson2.xlsx"), sheetName = "df")

