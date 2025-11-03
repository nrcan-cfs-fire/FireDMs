# FireDMs
Severity-informed fire disturbance matrices for the Carbon Budget Model for the Canadian Forest Sector
(https://natural-resources.canada.ca/climate-change/climate-change-impacts-forests/carbon-budget-model)

## Project Description

With severity mapping as part of Canada's National Burned Area Composite (https://cwfis.cfs.nrcan.gc.ca/datamart/metadata/nbac), a new approach to fire disturbanace matrices in the CBM is required.  This repo creates DMs for CBM using a logical and programmatic technique that borrow from (1) field observations; (2) combustion physics and observations; (3) knowledge of fire ecology-related plant traits; and (4) broad distributions of forest species across Canadian ecozones.

## Usage Example

The R Markdown code used to compile the in review manuscript in Geoscientific Model Development (GMD) is available here: https://github.com/nrcan-cfs-fire/FireDMs/blob/main/GMD/FireDMs.Rmd

And as a compiled pdf at https://github.com/nrcan-cfs-fire/FireDMs/blob/main/GMD/FireDMs.pdf

### Modelling Inputs
The file https://github.com/nrcan-cfs-fire/FireDMs/blob/main/GMD/FireDMTableDefs.csv is populated by an outside process that uses field observations of fire ecosystem impacts from Composite Burn Index plots, stratified by severity class and ecozone to populated values (typically median values from a severity class * ecozone combination).

During the knitr compiling process, the actual CBM-CFS3 compatible fire DM outputs are produced here: https://github.com/nrcan-cfs-fire/FireDMs/blob/main/GMD/FireDM-currents.csv.   The format is one long file, aggregating all DM source-sink pairs across all ecozones as one large and simple text file for portability.

## Contribution Guidelines

At the moment, with this manuscript in review, please limit outside contributions to bugs or issues in the issues tracker.

## Licence Info



