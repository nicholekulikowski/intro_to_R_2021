#USGS and EPA dataset retrieval package
library(dataRetrieval) 

#click on "Packages" tab to see functions available in the dataRetrival package

#these are USGS sites upstream from Honnedaga Lake, NY 
sites <- c('0134277112', '0134277114')

#detailed location information about the sites
# readNWISsite(c('0134277112', '0134277114'))

#whatNWISdata displays the datasets available at each site
available <- whatNWISdata(siteNumber=c('0134277112', '0134277114'))
actual <- readNWISpCode(parameterCd = available$parm_cd) #interpret parameter codes
want <- c('00403', '00409','00681', '00945', '50287', '50285') #we want: pH, Alkalinity, DOC, DSO4, DHg and DMeHg
data <- readNWISqw(siteNumbers = sites, parameterCd=want) #get the data
codes <- readNWISpCode(parameterCd = unique(data$parm_cd)) #confirms that we got what we wanted, shows UNITS!

# Rename parm_cd variables

library(tidyverse)

data <- data %>% mutate(Analyte = recode(parm_cd,
                                 '00403' = 'pH',
                                 '00409' = 'Alkalinity',
                                 '00681' = 'DOC',
                                 '00945' = 'SO4',
                                 '50287' = 'Hg',
                                 '50285' = 'MeHg'))

data <- data %>% mutate(Site = recode(site_no, 
                                      '0134277112' = "Reference", 
                                      '0134277114' = "Treated"))

data1 <- data %>% dplyr::select(Site, Date=sample_dt, Time=sample_tm, Analyte, Result=result_va)


# Treatment periods based on time

data1$Treatment <- NA

library(lubridate)

data1$Treatment[ data1$Date < ymd('2013-10-1') ] <- 1
data1$Treatment[ data1$Date >= ymd('2013-10-1') ] <- 2
data1$Treatment [ data1$Date > ymd('2014-02-28') ] <- 3


data1$Treatment <- factor(data1$Treatment, levels = c(1, 2, 3), labels = c('Pre-Treatment', 'Transitional', 'Post-Treatment'), ordered=T)

# Exporting

setwd("~/Projects/intro_to_R_2021/session_3")
write.csv(data1, 'Simplified_long_format.csv')

imp <- read.csv('Simplified_long_format.csv')

# Wide data vs. Long data

data_wide <- data1 %>% pivot_wider(names_from = Analyte, values_from = Result)

# Exercise 1!!!!!

data_wide %>% pivot_longer(colnames(data_wide)[5:10], names_to='Name', values_to='Value')


# Summary Table

Table1 <- data1 %>% group_by(Site, Analyte, year(Date)) %>% 
  summarize(average=mean(Result), n=n())

install.packages("kableExtra")
library(kableExtra)

kable(Table1) %>% kable_styling(bootstrap_options = c('striped', 'hover'), full_width = F)


data1 %>% 
  group_by(Site, Analyte, year(Date)) %>%
    summarize(average=mean(Result), n=n()) %>% 
  kable() %>% 
  kable_styling(bootstrap_options = c('striped', 'hover'), full_width = F)

# Exercise 2

For each site, analyte, and month, generate the mean, standard deviation, maximum and minimum values, and the n-value.

Table2 <- data1 %>% 
  group_by(Site, Analyte, month(Date)) %>% 
  summarize(average=mean(Result, na.rm=T), 
            stdv=sd(Result, na.rm=T),
            max=max(Result, na.rm=T), 
            min=min(Result, na.rm=T), 
            n = n())
Table2
Table2 %>% kable() %>% 
  kable_styling(bootstrap_options = c('striped', 'hover'), full_width = F)

#Treatment 

Table5 <- data1 %>% 
  group_by(Treatment, Analyte, Site) %>% 
  summarize(average=mean(Result, na.rm=T), 
            stdv=sd(Result, na.rm=T),
            max=max(Result, na.rm=T), 
            min=min(Result, na.rm=T), 
            n = n())
Table5
Table5 %>% kable() %>% 
  kable_styling(bootstrap_options = c('striped', 'hover'), full_width = F)

## Basic Stats
# Linear Regression

colnames(data_wide)

reg1 <- lm(data=data_wide, Hg~DOC)
sreg1 <- summary(reg1)

broom::tidy(summary(reg1)) %>%
  kable() %>% 
  kable_styling(bootstrap_options = c('striped', 'hover'), full_width = F)

plot(reg1)

sreg1$residuals

# Generate a correlation

cor(x=data_wide$DOC, y=data_wide$MeHg, use = 'complete.obs')

# ANOVA

anova1 <- aov(data = data_wide, DOC~Treatment+Site+Treatment*Site)
summary(anova1)

# TukeyHSD

test <- TukeyHSD(anova1)
plot(test)

# ANOVA

install.packages("multcomp")
library(multcomp)
data_wide$TMT <- interaction(data_wide$Site, data_wide$Treatment)
aov2 <- aov(data=data_wide, DOC ~ TMT)
summary(aov2)


cntrMat <- rbind(
  "Main effect of Site"=c(1, 1, 1, -1, -1, -1),
  "(ref1-treat1)-(ref3-treat3)"=c(1, 0, -1, -1, 0, 1),
  "(ref1-treat1)-(ref2-treat2)"=c(1,  -1, 0, -1, 1, 0), 
  "(ref2-treat2)-(ref3-treat3)"=c(0, 1, -1, 0, -1, 1)
) 

glht(aov2, linfct=mcp(TMT=cntrMat), alternative="two.sided")
summary(glht(aov2, linfct=mcp(TMT=cntrMat), alternative ="two.sided")) # alternative='two.sided' is the default


