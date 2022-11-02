# FireDMs
Programmatically-defined disturbance matrices for the geospatial Carbon Budget Model

With severity mapping, a new approach to fire disturbanace matrices in the GCBM is required.

This repo creates DMs for CBM using a logical and programmatic technique that borrow from (1) field observations; (2) combustion physics and observations; (3) knowledge of fire ecology-related plant traits; and (4) broad distributions of forest species across Canadian ecozones.

The broad axioms of this framework are as follows:

1) DMs should be in terms of mortality, not survival		
2) Crown Fraction Burned (CFB) is a mass-based estimate of the portion of foliage consumed in flaming, and is inclusive of merchantable and submerchantable trees, both broadleaf and needleleaf		
3) Snags are inclusive of both those killed by prior fire as well as those killed by all other causes		
4) In submerchantable trees, mortality = CFB		
5) In submerchantable trees, mortality is <= 1		
6a) In merchantable stands, CFB < mortality		
	6b)Survival = 1 - mortality	
	6c) CFB < survival	
	6d) The girdled fraction of trees = mortality - CFB	
	6e) Survival <= 1 and also >= 0	

A single core logic module (i) reads an R list object that contains ecozone (i.e. relative abundance of spruce vs pine and resprouters vs non-resprouter broadleaf forest) and ecozone x severity-dependent variables. (ii) creates the DM as a list object (with each DM paired from->to as an row in the list object.

The DMs could be re-created per geospatial unit eventually, but otherwise are designed to be run annual when the median Drought Code of burning (from FireM3 hotspots) is known, as well as the relative proportion of differing forest types burned.

Subroutines:

0) Read user-inputted values relevant to various ecozones and severity levels (from csv to list?)

1a) Read (or create) ecozone-level summaries of distribution of traits related to fire (tap root vs shallow root; resprouter vs non-resprouter) based on (a) NFI GP distribution or better (b) user provided burned area polygons

1b) Compute median Drought Code values for all fires in ecozone either from (a) climatology or (b) as query against FireM3 data for a given year.

2) Compute the ecozone-specific DMs and store as list file


