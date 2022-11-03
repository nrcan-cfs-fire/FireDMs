#just starting to lay down some variable names

#level 0 - global vars - not nested, just a list on its own


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




#import generic list of source-sink equations
SourceSink <- read.csv("~/FireDMs/SourceSinkLong.csv")

#then, import the variable definitions:

VarDefs <- read.csv("~/FireDMs/FireDMTableDefs.csv")

#not run, just testing data frame loading:
#VarDefs$Variable.Name[2]
#VarDefs$Value[2]
# do I need to load each of these into the environment?  No, since I need to look up each per ecozone each time.....
# so each equation down below should be per ecozone and severity class when building the DM, don't want to load these into the environment itself

#template to query VarDefs, have to give ecozone and variable name each time:
#VarDefs$Value[VarDefs$Variable.Name == "SW.BW.frac.of.other" & VarDefs$Ecozone == "BP"]






  
  #then here, since we can't import equations (or don't want to), start spelling out each flux:

### do this in a loop, for each ecozone:

#softwood merch




  
  # final step: once you have a list each built by ecozone, then build a higher-level list called "FireDM"
  FireDM <- list(LA,TP,TSW,BSW,BP,P,TC,BC,PM,MC,HP,TSW,BSE)
  
