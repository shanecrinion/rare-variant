# #!/usr/bin/env Rscript 

# Shane Crinion / shanecrinion@gmail.com / s.crinion1@nuigalway.ie
# 14-12-2022
# This script combines results from gene based rare variant burden analysis from the 4 chronotype phenotypes into two (morning and evening chronotype)

# PROCESSES & OUTPUTS
# - 1. import results from rare burden studies from UK Biobank and perform a meta-analysis turn 4 chronotype phenotypes into two (morning and evening)
# ├── download and import data from GWAS catalog
# ├── perform meta-analysis
# output: table with new meta statistics
# - 2. explore overlap between SCHEMA and UKB gene based studies 
# ├── import SCHEMA results
# ├── identify overlap
# output: table identifying overlapping significant results from both


# DATASETS
# Gene based burden study results
# ├── SCHEMA (https://schema.broadinstitute.org/results)
# ├── UK Biobank chronotype
# ├── - Definitely a morning person (UKB data field 1180) (Gene-based burden) https://www.ebi.ac.uk/gwas/studies/GCST90081559
# ├── - Definitely an evening person (UKB data field 1180) (Gene-based burden) https://www.ebi.ac.uk/gwas/studies/GCST90081562
# ├── - More a morning than evening person (UKB data field 1180) (Gene-based burden) https://www.ebi.ac.uk/gwas/studies/GCST90081560
# ├── - More an evening than a morning person (UKB data field 1180) (Gene-based burden) https://www.ebi.ac.uk/gwas/studies/GCST90081561


# LIBRARIES
library(stringr)
library(readr)
library(dplyr)

# ├── import summary stats from UKBiobank gene based study
ukb_morning <- read.table('~/Downloads/GCST90081559_buildGRCh38.tsv.gz',  encoding="UTF-8", header = T)
ukb_evening <- read.table('~/Downloads/GCST90081562_buildGRCh38.tsv.gz',  encoding="UTF-8", header = T)
ukb_more_morning <- read.table('~/Downloads/GCST90081560_buildGRCh38.tsv.gz',  encoding="UTF-8", header = T)
ukb_more_evening <- read.table('~/Downloads/GCST90081561_buildGRCh38.tsv.gz',  encoding="UTF-8", header = T)

# extract gene names for comparison
ukb_morning$ensembl <- gsub("(?<=\\()[^()]*(?=\\))(*SKIP)(*F)|.", "", ukb_morning$Name, perl=T)
ukb_evening$ensembl <- gsub("(?<=\\()[^()]*(?=\\))(*SKIP)(*F)|.", "", ukb_evening$Name, perl=T)
ukb_more_morning$ensembl <- gsub("(?<=\\()[^()]*(?=\\))(*SKIP)(*F)|.", "", ukb_more_morning$Name, perl=T)
ukb_more_evening$ensembl <- gsub("(?<=\\()[^()]*(?=\\))(*SKIP)(*F)|.", "", ukb_more_evening$Name, perl=T)

# ├── perform meta-analysis
# using material from https://www.mv.helsinki.fi/home/mjxpirin/GWAS_course/material/GWAS9.html


