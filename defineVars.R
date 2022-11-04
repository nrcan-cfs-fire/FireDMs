#just starting to lay down some variable names

#level 0 - global vars - not nested, just a list on its own
library(tidyverse)


#populate the values first:
global.vars <- list(0.9, 0.01, 0.09, 0.77, 0.03, 0.21)
#then label names
names(global.vars) <- array(c("FlamingCO2","FlamingCO","FlamingCH4","SmoulderingCO2","SmoulderingCO","SmoulderingCH4"))

#DID NOT RUN:
#global.vars$FlamingCO2 #returns desired value as double

ecozones.list <- list("LA","TP","TSW","BSW","BP","P","TC","BC","PM","MC","HP","TSE","BSE")

#load an array of median DC values by ecozone (provided here hardcoded from Quinn Barber's dataframes of all Canadian hotspots from CWFIS 2002-2022):
Median.DC <- c(270,369,297,239,242,242,254,250,268,452,204,98,123)

# then the median forest floor load, minus an average litter value (provided here hardcoded from 10.1139/x2012-093):
Forest.Floor.Load <- c(1.7,15,1.7,8.8,9.8,9.8,8.31,8.31,15.2,6,7.9,1.7,10.9)

Forest.Floor.Load <- Forest.Floor.Load - 0.25 ### subtract average litter load (from 10.1139/cjfr-2016-0475)
Forest.Floor.consump.kg.m2 <- 0.016872*Median.DC^0.71*Forest.Floor.Load^0.671
Forest.Floor.consump.frac <- Forest.Floor.consump.kg.m2/Forest.Floor.Load


# start creating a simple list object per ecozone

BP <- list(ecozones.list[1],Median.DC[1],Forest.Floor.Load[1],Forest.Floor.consump.kg.m2[1],Forest.Floor.consump.frac[1])
names(BP) <- c("Ecozone.name","Median.DC.of.burning","Median.Forest.Floor.Load.kg.m2","Forest.Floor.consump.kg.m2","Forest.Floor.consump.frac")
BP$Ecozone.name <- c("BP")



#list of ecozone-specific terms (with and without severity dependence)
#first, import blank template that works for a single ecozone:
VarDefs.generic <- as.data.frame(read.csv("~/FireDMs/VarDefsGeneric.csv"))
VarDefs.generic <- VarDefs.generic[,1:7]

#then, replicate for each severity level*ecozone

#use slice from dplyr and each to replicate the template for each ecozone
VarDefs <- VarDefs.generic %>% slice(rep(1:n(), each = length(ecozones.list)))

#fill in ecozone names:
VarDefs$Ecozone <- rep(as.matrix(ecozones.list),times = nrow(VarDefs.generic))

#Once this is done and filled, load the canonical version: 
VarDefs <- read.csv("~/FireDMs/FireDMTableDefs.csv")




#sink-source DM list:
#first, import blank template that works for a single ecozone:
SourceSinkGeneric <- read.csv("~/FireDMs/SourceSinkGeneric.csv")


#then, replicate for each severity level*ecozone

#Once this is done and filled, load the canonical version: 
SourceSink <- read.csv("~/FireDMs/SourceSinkLong.csv")



#not run, just testing data frame loading:
#VarDefs$Variable.Name[2]
#VarDefs$Value[2]
# do I need to load each of these into the environment?  No, since I need to look up each per ecozone each time.....
# so each equation down below should be per ecozone and severity class when building the DM, don't want to load these into the environment itself

#template to query VarDefs, have to give ecozone and variable name each time (this is not severity class dependent):
#VarDefs$Value[VarDefs$Variable.Name == "SW.BW.frac.of.other" & VarDefs$Ecozone == "BP"]

#example of query for value as part of DM computation with severity dependence:
#VarDefs$Value[VarDefs$Variable.Name == "SW.CFB" & VarDefs$Ecozone == "BP" & VarDefs$SeverityClass == "Mod"]




## start loop:

ecozone <- c("BP") #loop this later on



# SW Merch to SW Merch (survival of conifers)
#simple example, just referencing the VarDefs csv there:
SourceSink$Value[SourceSink$Ecozone == "BP" & SourceSink$FluxID == 1 & SourceSink$SeverityClass == "Low"] <- 1 - (VarDefs$Value[VarDefs$Variable.Name == "SW.CFB" & VarDefs$Ecozone == "BP" & VarDefs$SeverityClass == "Low"])
SourceSink$Value[SourceSink$Ecozone == "BP" & SourceSink$FluxID == 1 & SourceSink$SeverityClass == "Mod"] <- 1 - (VarDefs$Value[VarDefs$Variable.Name == "SW.CFB" & VarDefs$Ecozone == "BP" & VarDefs$SeverityClass == "Mod"])
SourceSink$Value[SourceSink$Ecozone == "BP" & SourceSink$FluxID == 1 & SourceSink$SeverityClass == "High"] <- 1 - (VarDefs$Value[VarDefs$Variable.Name == "SW.CFB" & VarDefs$Ecozone == "BP" & VarDefs$SeverityClass == "High"])

#but, I'm not doing this easily across all three severity classes, no need to run it across each severity class as its own line....

## end loop
  
  # final step: once you have a list each built by ecozone, then build a higher-level list called "FireDM"
  FireDM <- list(LA,TP,TSW,BSW,BP,P,TC,BC,PM,MC,HP,TSW,BSE)

  #then, create a tabular DM for inspection, for a given ecozone and a given severity class:
  
