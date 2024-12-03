#installing lavaan package for SEM

#install.packages("lavaan")
library(lavaan)

#loading data 
proofofcon <- read.csv("~/Desktop/MSc EEB/WD/grantproposal/proofofcon.csv", stringsAsFactors = FALSE, header=TRUE, fileEncoding="latin1")

#a simple regression in lavaan, using a pathway from Klaus et al. 2021 
#pathway; "DOf is lower in lakes with longer stratification periods and stronger declines in oxygen concentrations"
 
path1 <- '
DOf ~ Strat + DeltaDO
'
fitpath1 <- sem(path1, data=proofofcon)
summary(fitpath1)

#testing lavaan with simple lm: results the same 
lmtest <- lm(DOf ~ Strat + DeltaDO, data=proofofcon)
summary(lmtest)

#now using lavaan to do multiple pathways simultaneously, not done in the paper 
#next pathway: stratification periods are longer in lakes with lower U10, in warmer lakes at lower elevation and latitude, and in lakes with larger zmax

paths2 <- '
DOf ~ Strat + DeltaDO
Strat ~ U10 + Lat + Lon + zmax
'
fitpaths2 <- sem(paths2, data=proofofcon)
summary(fitpaths2)

#doing all stated pathways from the paper simultaneously 
#next pathways...
  #DeltaDO is more negative with higher DOC 
  #U10 increases with lower tree canopies relative to lake surface area, and hence increases with Wc
  #DOC decreases with Wc
  #Wc increases with Ele and Lat

paths3 <- '
DOf ~ Strat + DeltaDO
Strat ~ U10 + Lat + Lon + zmax
DeltaDO ~ DOC
U10 ~ hc + Wc
DOC ~ Wc
Wc ~ Elevation + Lat 
'

fitpaths3 <- sem(paths3, data=proofofcon)
summary(fitpaths3)




