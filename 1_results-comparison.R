# #!/usr/bin/env Rscript 

# Shane Crinion / shanecrinion@gmail.com / s.crinion1@nuigalway.ie
# 13-12-2022
# This script compares rare variant burden analysis results from SCHEMA to UK Biobank rare variant studies for chronotype measurment

# PROCESSES & OUTPUTS
# - 1. compare rare variant results
# ├── import summary stats from SCHEMA and extract the 32 sig hits
# ├── import summary stats from UKBiobank exome study
# ├── extract SCHEMA genes from UK Biobank and determine significance with  p-val threshold of 0.05/32
# ├── merge all stats to one table
# output: table of overlapping genes implicated in schizophrenia and two chronotype phenotypes (morning and evening person)

# DATASETS
# Gene based burden study results
# ├── SCHEMA (https://schema.broadinstitute.org/results)
# ├── UK Biobank chronotype
# ├── - Definitely a morning person (UKB data field 1180) (Gene-based burden) https://www.ebi.ac.uk/gwas/studies/GCST90081559
# ├── - Definitely an evening person (UKB data field 1180) (Gene-based burden) https://www.ebi.ac.uk/gwas/studies/GCST90081562


# LIBRARIES
library(stringr)
library(readr)
library(dplyr)

# - 1. compare rare variant results
# ├── import summary stats from SCHEMA and extract the 32 sig hits
schema <- read.csv('~/Downloads/meta_results_2022_12_13_11_34_37.csv')
schema[c(1:32),] # all sig
schema_genes <- schema$Gene[1:32]

# ├── import summary stats from UKBiobank exome study
ukb_morning <- read.table('~/Downloads/GCST90081559_buildGRCh38.tsv.gz',  encoding="UTF-8", header = T)
ukb_evening <- read.table('~/Downloads/GCST90081562_buildGRCh38.tsv.gz',  encoding="UTF-8", header = T)

# extract gene names for comparison
ukb_morning$ensembl <- gsub("(?<=\\()[^()]*(?=\\))(*SKIP)(*F)|.", "", ukb_morning$Name, perl=T)
ukb_morning$ensembl <- gsub("(?<=\\()[^()]*(?=\\))(*SKIP)(*F)|.", "", ukb_morning$Name, perl=T)

# ├── extract SCHEMA genes from UK Biobank and determine significance with  p-val threshold of 0.05/32
sig_overlap_morning <- ukb_morning[(ukb_morning$ensembl %in% schema_genes) & ukb_morning$p_value < 0.05/32,] # 1 sig - ANKRD12, ENSG00000101745
sig_overlap_evening <- ukb_evening[(ukb_evening$ensembl %in% schema_genes) & ukb_evening$p_value < 0.05/32,] 

# ├── merge all stats to one table
sig_schema <- schema[schema$Gene=="ENSG00000101745",]
names(sig_overlap_morning) <- paste0(names(sig_overlap_morning), "_ukb")
names(sig_schema) <- paste0(names(sig_schema), "_schema")
results <- full_join(sig_schema, sig_overlap_morning, by=c("Gene_schema"="ensembl_ukb"))
write.csv(x = results, 'gene_based_burden_schema_ukb_overlap.csv')

