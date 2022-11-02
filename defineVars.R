#just starting to lay down some variable names

#level 0 - global vars - not nested, just a list on its own


#populate the values first:
global.vars <- list(0.9, 0.01, 0.09, 0.77, 0.03, 0.21)
#then label names
names(global.vars) <- array(c("FlamingCO2","FlamingCO","FlamingCH4","SmoulderingCO2","SmoulderingCO","SmoulderingCH4"))

#DID NOT RUN:
#global.vars$FlamingCO2 #returns desired value as double

#import generic list of source-sink equations
SourceSink <- read.csv("~/FireDMs/SourceSinkLong.csv")
  
  #then here, since we can't import equations (or don't want to), start spelling out each flux:

#softwood merch


  
  # final step: once you have a list each built by ecozone, then build a higher-level list called "FireDM"
  FireDM <- list("LA","TP","TSW","BSW","BP","P","TC","BC","PM","MC","HP","TSE","BSE")
  
