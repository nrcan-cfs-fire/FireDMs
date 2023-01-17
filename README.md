# FireDMs
Programmatically-defined fire disturbance matrices for the geospatial Carbon Budget Model

See pdf summary of project so far: https://github.com/nrcan-cfs-fire/FireDMs/blob/main/FireDMS.pdf

Summary Presentation is here: https://041gc-my.sharepoint.com/:p:/g/personal/daniel_thompson_nrcan-rncan_gc_ca/EbAvLIlDK6BCiFe7O-VvU9MBnt5mPgOR7qGvJtFW1qJFbA?e=qkG0Oe

The actual GCM-compatible fire DM outputs are here: https://github.com/nrcan-cfs-fire/FireDMs/blob/main/SourceSinkGeneric.csv (can change that name as needed).  The format is one long file, aggregating all DM source-sink pairs across all ecozones as one large and simple text file for portability.

The file https://github.com/nrcan-cfs-fire/FireDMs/blob/main/FireDMTableDefs.csv is populated by an outside process that uses field observations of fire ecosystem impacts from Composite Burn Index plots, stratified by severity class and ecozone to populated values (typically median values from a severity class * ecozone combination).

With severity mapping, a new approach to fire disturbanace matrices in the GCBM is required.

This repo creates DMs for CBM using a logical and programmatic technique that borrow from (1) field observations; (2) combustion physics and observations; (3) knowledge of fire ecology-related plant traits; and (4) broad distributions of forest species across Canadian ecozones.

The broad axioms of this framework are as follows:

1) DMs should be in terms of mortality, not survival		
2) Crown Fraction Burned (CFB) is a mass-based estimate of the portion of foliage consumed in flaming, and is inclusive of merchantable and submerchantable trees, both broadleaf and needleleaf		
3) Snags are inclusive of both those killed by prior fire as well as those killed by all other causes		
4) In submerchantable trees, mortality = CFB		
5) In submerchantable trees, mortality is <= 1

6) In merchantable stands, CFB < mortality		
7) Survival = 1 - mortality	
8) CFB < survival	
9) The girdled fraction of trees = mortality - CFB	
10) Survival <= 1 and also >= 0	


Note that https://github.com/nrcan-cfs-fire/FireDMs/blob/main/VarDefsGeneric.csv is depreciated from an earlier process, and builds the DMs generically using non-field derived values, and is useful for testing but otherwise integral to the process.


