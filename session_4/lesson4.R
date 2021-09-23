## load packages
library(tidyverse) # this includes ggplot2!
library(lubridate) # datetime stuff
library(visdat)    # for looking at column types and missing data
library(ggpubr)    # for overlaying a normal distribution curve



# loading and looking at our data -----------------------------------------


## read in RDS file - this file type is specific to R and can hold just one R object
data_wide <- readRDS('./data/data_wide.rds')


## take a quick look at our data
head(data_wide)
glimpse(data_wide)

## convert from wide to long format
data_long <- data_wide %>% 
  pivot_longer(cols = pH:Hg, names_to='Name', values_to='Value')

## take a quick look at our data
head(data_wide)
glimpse(data_long)


# base R plotting ---------------------------------------------------------


## make some data and plot it
x <- c(1,2,3,4,5,6,7,8)
y <- c(6,3,18,9,24,12,15,21)

plot(x, y, xlab = 'x-axis label', ylab = 'y-axis label', xlim = c(0,9), ylim = c(0, 25))

## histogram of Organic Carbon
hist(x = data_wide$DOC, breaks = 10, 
     col = 'lightgreen', main = 'Histogram of Organic Carbon data')

## boxplot of DOC vs Site
boxplot(data_wide$DOC ~ data_wide$Site, 
        main = 'DOC at Reference vs Treated Sites')

## boxplot of DOC vs Treatment
boxplot(data_wide$DOC ~  data_wide$Treatment, 
        main = 'DOC by Time Period')

## add reference line for overall mean
abline(h = mean(data_wide$DOC, na.rm = TRUE), lty = 'dashed', lwd = 2, col = 'red')

## the visdat package lets us look at column types and missing data
visdat::vis_dat(data_wide, sort_type = FALSE)


# start of ggplot material ------------------------------------------------

library(ggplot2)

## Our first "ggplot"
ggplot(data_wide, aes(x = DOC))

## need to add geom layer!
ggplot(data = data_wide, aes(x = DOC)) + 
  geom_histogram()

## why did we get a warning?
sum(is.na(data_wide$DOC))

## set theme for all ggplots in the rest of the script
theme_set(theme_bw())

## change the color of bar borders to white,
##  number of bins to 20, and add a plot title
ggplot(data = data_wide, aes(x = DOC)) + 
  geom_histogram(color = 'white', bins = 20) +
  ggtitle('Histogram of Organic carbon (mg/L)')


# geom_point - scatterplots -----------------------------------------------

## make a scatterplot of the DOC and SO4 columns
ggplot(data_wide, aes(x = DOC, y = SO4)) + 
  geom_point() 

## try setting all the points to blue - doesn't work properly!
ggplot(data_wide, aes(x = DOC, y = SO4, colour = "blue")) + 
  geom_point()

## we need to set the col argument on the outside of the aes()
ggplot(data_wide, aes(x = DOC, y = SO4)) + 
  geom_point(col = 'blue')  # set all points to blue



# geom_point, geom_line - Time series -------------------------------------

## time series plot of alkalinity
ggplot(data_wide, aes(x = Date, y = Alkalinity)) + 
  geom_point()

## change point colors based on value in Treatment column
ggplot(data_wide, aes(x = Date, y = Alkalinity, color = Treatment)) + 
  geom_point()

## change point colors based on value in Site column
ggplot(data_wide, aes(x = Date, y = Alkalinity, color = Site)) + 
  geom_point()

## use a line plot instead of points
ggplot(data_wide, aes(x = Date, y = Alkalinity)) + 
  geom_line()

## use points and lines together!
ggplot(data_wide, aes(x = Date, y = Alkalinity)) + 
  geom_point() + 
  geom_line()

# geom_bar ----------------------------------------------------------------

## count number of Alkalinity observations
sum(data_long$Name == 'Alkalinity')

## count frequency of all analaytes
data_long %>%
  count(Name)

## bar chart showing how many rows for each analyte
ggplot(data_long, aes(y = Name)) + 
    geom_bar()

## is.na helps us check for missing values
is.na(c(3, NA, 2, NA, NA))    

## remove missing values, then count frequency of each analyte    
data_long %>%
  filter(!is.na(Value)) %>%
  count(Name)

## color bars by counts of missing/non-missing values for each analyte
ggplot(data_long, aes(y = Name, fill = is.na(Value))) + 
    geom_bar()


# geom_density ------------------------------------------------------------

## 1-d density plot of DOC values
ggplot(data = data_wide, aes(x = DOC)) + 
    geom_density(fill = 'blue')

## separate density curves for eacch Treatment period
ggplot(data = data_wide, aes(x = DOC, fill = Treatment)) + 
    geom_density()

## change transparency of curves so we can see them at same time
ggplot(data = data_wide, aes(x = DOC, fill = Treatment)) + 
    geom_density(alpha = 0.3)


# geom_boxplot ------------------------------------------------------------

## boxplot of all SO4 values, with gold fill
ggplot(data_wide, aes(y = SO4)) + 
  geom_boxplot(fill = 'gold')

## change border color to brown
ggplot(data_wide, aes(y = SO4)) + 
  geom_boxplot(fill = 'gold', color = 'brown')

## change fill color based on value in Site column
ggplot(data_wide, aes(x = Site, y = SO4, fill = Site)) + 
  geom_boxplot()


# Naming plots ------------------------------------------------------------

## make a bar plot and assign it to variable p1
p1 <- ggplot(data_long, aes(y = Name, fill = is.na(Value))) + 
  geom_bar(position = 'fill') +
  labs(x = 'Proportion of observations', y = 'Analyte')

## print our plot p1
p1

## add a title to p1
p1 + 
  ggtitle("This is a title")


# labels and legends -----------------------------------------------

## bar plot, with custom x- and y-axis labels
ggplot(data_long, aes(y = Name, fill = is.na(Value))) + 
  geom_bar(position = 'fill') +
  labs(x = 'Proportion of observations', y = 'Analyte')

## change the legend title to "Missing?"
ggplot(data_long, aes(y = Name, fill = is.na(Value))) + 
  geom_bar(position = 'fill') +
  labs(x = 'Proportion of observations', y = 'Analyte',
       fill = 'Missing?')


# facetting ---------------------------------------------------------------

## use facet_wrap to make panel of plots, one for each analyte
ggplot(data = data_long, aes(x = Date, y = Value, col = Treatment)) + 
  geom_point(alpha = 0.3) + 
  facet_wrap(~Name, scales='free')

## arrange into 3 columns of plots
ggplot(data = data_long, aes(x = Value, fill = Treatment)) + 
  geom_density(alpha = 0.3) + 
  facet_wrap(~Name, ncol = 3, scales = 'free')

## facet_grid: 2 dimensional arrangement of plots, by analyte and site
ggplot(data_long, mapping = aes(x = Date, y = Value, color = Treatment)) + 
  geom_point() + 
  theme_bw() + 
  facet_grid(Name ~ Site, scales = 'free_y') 



# Themes ------------------------------------------------------------------

## centering title with theme()
ggplot(data = data_wide, aes(x = DOC, fill = Treatment)) + 
  geom_density(alpha = 0.3) + 
  ggtitle("Now our title is centered!") +
  theme(plot.title = element_text(hjust = 0.5))


## combining themes - wrong order
ggplot(data = data_wide, aes(x = DOC, fill = Treatment)) +
  geom_density(alpha = 0.3) +
  ggtitle("Now our title is centered") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme_gray()

## combining themes - right order
ggplot(data = data_wide, aes(x = DOC, fill = Treatment)) +
  geom_density(alpha = 0.3) +
  ggtitle("Now our title is centered") +
  theme_gray()
  theme(plot.title = element_text(hjust = 0.5)) +


## manually change colors for missing and NA values
p_bar_manual <- ggplot(data_long, aes(y = Name, fill = is.na(Value))) + 
  geom_bar(position = 'fill') +
  labs(x = 'Proportion of observations', y = 'Analyte',
       title = "What % of each analyte's data is missing?") +
  scale_fill_manual(name = "Missing?", 
                    labels = c('TRUE' = 'Yes', 'FALSE'  = 'No'),
                    values = c('TRUE' = 'red', 'FALSE' = 'gray'))

## make histogram, apply log-transformation to x-axis
ggplot(data = data_wide) +
  geom_histogram(aes(x = SO4), bins = 20, fill = 'darkgreen', col = 'white') +
  scale_x_continuous(trans = 'log') +
  ggtitle('Log-transformed SO4 Values') 


?ggpubr::stat_overlay_normal_density

## convert y-axis from counts to density
ggplot(data = data_wide, aes(x = SO4, y = ..density..)) +
  geom_histogram( bins = 20, fill = 'darkgreen', col = 'white') +
  scale_x_continuous(trans = 'log') +
  ## add normal distn overlay - automatically computes mean and SD
  ggpubr::stat_overlay_normal_density(col = 'gold', lwd = 1.2) + 
  ggtitle('Log-transformed SO4 Values') 

# Coordinates -------------------------------------------------------------
 
## example with coord_flip
p_bar_manual + 
  coord_flip()

## original scatterplot
ggplot(data_wide, aes(x = DOC, y = SO4)) + 
  geom_point(col = 'blue') 

## example with coord_cartesian(expand = FALSE)
ggplot(data_wide, aes(x = DOC, y = SO4)) + 
  geom_point(col = 'blue')  +
  coord_cartesian(xlim = c(0, 20), ylim = c(1, 5), expand = FALSE)


# adding reference lines --------------------------------------------------


## facetted time series
p_facet2 <- 
  ggplot(data_long, mapping = aes(x = Date, y = Value, color = Treatment)) + 
  geom_point() + 
  theme_bw() + 
  facet_grid(Name ~ Site, scales = 'free_y') 

## add vertical lines at treatment period changes
p_facet2 +
 geom_vline(xintercept = ymd(c('2013-10-01','2014-02-28')), linetype = 'dashed')


# saving plots to files ---------------------------------------------------

# 1. Export buttons

# 2. create PNG image and store a plot in it

## ## check help page
?png

png(filename = "./img/plot_ex.png", width = 6, height = 4, res = 72)
p1
dev.off()

# 3. ggsave function
ggsave(filename = "./img/ggsave_ex.png", plot = p1,
       width = 6, height = 6, units = "in", dpi = 300)
