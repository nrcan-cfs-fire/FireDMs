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

This work is available under the Open Government Licence - Canada (http://open.canada.ca/en/open-government-licence-canada)

You are encouraged to use the Information that is available under this licence with only a few conditions.

Using Information under this licence

Use of any Information indicates your acceptance of the terms below.

The Information Provider grants you a worldwide, royalty-free, perpetual, non-exclusive licence to use the Information, including for commercial purposes, subject to the terms below.
You are free to:

Copy, modify, publish, translate, adapt, distribute or otherwise use the Information in any medium, mode or format for any lawful purpose.
You must, where you do any of the above:

Acknowledge the source of the Information by including any attribution statement specified by the Information Provider(s) and, where possible, provide a link to this licence.
If the Information Provider does not provide a specific attribution statement, or if you are using Information from several information providers and multiple attributions are not practical for your product or application, you must use the following attribution statement:
Contains information licensed under the Open Government Licence – Canada.

The terms of this licence are important, and if you fail to comply with any of them, the rights granted to you under this licence, or any similar licence granted by the Information Provider, will end automatically.

Exemptions
This licence does not grant you any right to use:

Personal Information;
third party rights the Information Provider is not authorized to license;
the names, crests, logos, or other official symbols of the Information Provider; and
Information subject to other intellectual property rights, including patents, trade-marks and official marks.

Non-endorsement
This licence does not grant you any right to use the Information in a way that suggests any official status or that the Information Provider endorses you or your use of the Information.

No Warranty
The Information is licensed “as is”, and the Information Provider excludes all representations, warranties, obligations, and liabilities, whether express or implied, to the maximum extent permitted by law.

The Information Provider is not liable for any errors or omissions in the Information, and will not under any circumstances be liable for any direct, indirect, special, incidental, consequential, or other loss, injury or damage caused by its use or otherwise arising in connection with this licence or the Information, even if specifically advised of the possibility of such loss, injury or damage.

Governing Law
This licence is governed by the laws of the province of Ontario and the applicable laws of Canada.

Legal proceedings related to this licence may only be brought in the courts of Ontario or the Federal Court of Canada.

Definitions
In this licence, the terms below have the following meanings:

"Information"
means information resources protected by copyright or other information that is offered for use under the terms of this licence.
"Information Provider"
means His Majesty the King in right of Canada.
“Personal Information”
means “personal information” as defined in section 3 of the Privacy Act, R.S.C. 1985, c. P-21.
"You"
means the natural or legal person, or body of persons corporate or incorporate, acquiring rights under this licence.

