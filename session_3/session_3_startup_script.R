#USGS and EPA dataset retrieval package
install.packages("dataRetrieval")
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