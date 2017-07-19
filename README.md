# R

In this repository, we share the R codes and related files of an untargeted metabolomics study in our team.
as the following steps, data analysis process can be performed.

## Code

* Data normalization, transformation, scaling and cleansing are included in metaX.R. Univariant and Multivariant 
analysis are also performed by metaX.R using metaX package.
* Heatmap of interested features was drawn by heatmap.R.
* Boxplot of interested features was drawn by boxplot.R.
* feature selection using random forest method and ROC analysis were performed using metaXROC.R.

## Files

* The measurement files were peak extraction informations.
* identification files were identification result of all features.
* result.rds files were part of the output of metaX.R.
* sample_list files were the run order of LC-MS.
* PA, PC, PI, and LysoPC files were our interested features.
* Features-norm file was the intensity of interested features.
