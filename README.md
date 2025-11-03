# FireDMs
Programmatically-defined fire disturbance matrices for the Carbon Budget Model for the Canadian Forest Sector
(https://natural-resources.canada.ca/climate-change/climate-change-impacts-forests/carbon-budget-model)

##Project Description

With severity mapping, a new approach to fire disturbanace matrices in the GCBM is required.  This repo creates DMs for CBM using a logical and programmatic technique that borrow from (1) field observations; (2) combustion physics and observations; (3) knowledge of fire ecology-related plant traits; and (4) broad distributions of forest species across Canadian ecozones.

##Usage Example

(info on RMD)

The file https://github.com/nrcan-cfs-fire/FireDMs/blob/main/GMD/FireDMTableDefs.csv is populated by an outside process that uses field observations of fire ecosystem impacts from Composite Burn Index plots, stratified by severity class and ecozone to populated values (typically median values from a severity class * ecozone combination).


The actual CBM-CFS3 compatible fire DM outputs are here: https://github.com/nrcan-cfs-fire/FireDMs/blob/main/GMD/FireDM-currents.csv (can change that name as needed).  The format is one long file, aggregating all DM source-sink pairs across all ecozones as one large and simple text file for portability.

Contribution Guidelines

At the moment, with this manuscript in review, please limit outside contributions to bugs or issues in the issues tracker.

Licence Info



