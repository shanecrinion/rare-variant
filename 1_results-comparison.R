# #!/usr/bin/env Rscript 

# Shane Crinion / shanecrinion@gmail.com / s.crinion1@nuigalway.ie
# 13-12-2022
# This script compares rare variant burden analysis results from SCHEMA to UK Biobank rare variant studies for chronotype measurment

# PROCESSES & OUTPUTS
# - compare rare variant results
# ├── import summary stats from SCHEMA and extract the 32 sig hits
# ├── import summary stats from UKBiobank exome study
# ├── extract SCHEMA genes from UK Biobank and determine significance with  p-val threshold of 0.05/32
# ├── merge results to one table
# output: two tables of overlapping genes implicated in schizophrenia and two chronotype phenotypes (morning and evening person)

# DATASETS
# Gene based burden study results
# ├── SCHEMA (https://schema.broadinstitute.org/results)
# ├── UK Biobank chronotype
# ├── - Definitely a morning person (UKB data field 1180) (Gene-based burden) https://www.ebi.ac.uk/gwas/studies/GCST90081559
# ├── - Definitely an evening person (UKB data field 1180) (Gene-based burden) https://www.ebi.ac.uk/gwas/studies/GCST90081562

