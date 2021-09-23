
## read in dataset from main lesson
data_wide <- readRDS('./data/data_wide.rds')

## convert from wide to long format
data_long <- data_wide %>% 
  pivot_longer(cols = pH:Hg, names_to='Name', values_to='Value')


# Exercise Break 1: Base R Plotting -------------------------------------


## 1) Make a scatter plot of vectors x and y using the 'plot' function from base R.
x <- c(1,2,3,4,5,6,7,8)
y <- c(6,3,18,9,24,12,15,21)

## 2a) Now make a plot and change the value of 'pch' to 15. What shape are the points?

## 2b) Change the plot character to the letter 'R'. 

## 3) Make a histogram of the pH column from data_wide. Adjust the 'xlim' argument to 
## extend from 0 to 14. Add a vertical line at x = 7 using the abline function.



# Exercise Break 2: Geoms -------------------------------------------------


## geom_histogram

### 4a) Make a histogram of the Alkalinity column in data_wide. Change the colors 
### of the bars to blue and the binwidth to 50.

### 4b) Now use the max and min functions to find the range of values of Alkalinity. 
### Don't forget to specify na.rm = TRUE

## geom_bar

### 5a) Make a vertical bar chart using the Treatment variable in data_wide. 

### 5b) Make the same chart but with horizontal bar charts. 
### What different arguments are needed inside the aes?

### 5c) Change the outer border color of the bars to white, and let the inner bar
### fill take on a value using the Site column. Add a title to the plot that says
### "Bar chart showing # of observations by Treatment Period and Site".


## geom_density

### 6a) Make a 1-d density plot of the SO4 values. 

### 6b) Building on the previous plot, use the fill argument to change 
### the fill color to 'red'. 

### 6c) Use the fill argument to change the fill color based on the
### value in the Treatment column. Change the transparency to 0.1

## geom_point, geom_line

### 7a) make a scatterplot of the pH vs the SO4 values. Then make the same 
### plot, but switch the variables on the x and y axes.


### 7b) Make a time series plot of the SO4 values (Date on x-axis).


## geom_boxplot

### 8a) Make a boxplot of data_wide with Site on the x-axis and 
### Alkalinity on the y-axis.

### 8b) Make a boxplot of data_long with Name on the x-axis and 
### Value on the y-axis. Why is this a bad idea to plot? 


# Exercise Break 3: annotating ggplots -----------------------------------



## labelling

### 9) Make a time series plot of DOC and color the points by Site. 
## Using the labs() function, change the x-axis label to 'Year' and
## the color label to 'Location'.

## titles and subtitles

## 10a) Using ggtitle, add a title to p_time_series that reads 'Time series of Alkalinity'.
p_time_series <- ggplot(data_wide, aes(x = Date, y = Alkalinity)) + 
  geom_point()

## 10b) Add a line to p_time_series to change the font size of the title.
## using theme(plot.title = element_text(size = 28)).

## 10c) Take p_time series and move the legend to the bottom,
## using the legend.position argument in theme

## 10d) Take p_time series and remove,
## using the legend.position argument in theme


## 11) Take our boxplot from 8a) and add a blue horizontal reference 
## line at y = 0 using geom_vline. 

# Challenge problems ------------------------------------------------------

## A) Look at the help page for the element_text() function (?element_text)
## Figure out how to change the font size to 16, the font color ('color' argument) to 'darkgreen',
## and move the title to the right side ('hjust' argument) of the plot.


### B) Create a time series plot of Date on x-axis and 
### Alkalinity on the y-axis using both geom_point and geom_line.
### Change the colors based on the Treatment AND Site columns, 
### Hint: look up the interaction() function


