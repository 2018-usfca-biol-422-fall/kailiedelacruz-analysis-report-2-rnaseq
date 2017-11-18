#!/usr/bin/Rscript

# This purpose of this R script is to read in all of the transcript counts
# made by sailfish individually on each sample, aggregate those counts (which
# are at the transcript level) to the gene level, normalize them based on
# length and read depth, and then build a table with rows as genes and columns
# as samples, with each cell being the normalized count for that gene in that
# sample. Then, we want to join in the two other metadata files we have,
# from SRA and from the supplementatry table from the original manuscript that
# has information like patient age and smoking behavior. We have to do some
# cleaning along the way, and the gathered (melted) output file is rather big
# so we only include interesting columns, and write out the output in compressed
# csv format as well as binary RData format

# package info and download:
# http://bioconductor.org/packages/release/bioc/html/tximport.html

## the basic approach is based around the
## instructions here:
## http://bioconductor.org/packages/release/bioc/vignettes/tximport/inst/doc/tximport.html

# set to TRUE to get some extra output to help troubleshoot
DEBUG <- FALSE

## install needed packages
## first thing get biocLite: source("https://bioconductor.org/biocLite.R")
## load the packages with: biocLite("tximport")
## load the packages with: biocLite("tximportData")

# Load packages
library("tximport")
library("readr")
library("tximportData")
library("tidyr")
library("dplyr")
library("tibble")

# Load the transcript to gene lookup table we constructed
# this needs to be tx ID, then gene ID
tx2gene <- read.table(paste0("./output/gene_name_lookup_files/",
                             "transcript_to_gene_lookup_2cols.txt"),
                      header = FALSE,
                      col.names =
                          c("TX-NAME", "GENE-NAME"))

# read in the SRA sample metadata table, downloaded from the SRA Run Selector
samples <- read.table("./data/metadata/ERP001058_SraRunTable.txt",
                      header = TRUE,
                      sep = "\t")

# Read in and add appropriate column names for the metadata on the patients
# taken from the supplemental information of the original study
sample_metadata <- read.table("./data/metadata/SuppTable1.csv",
                              header = TRUE,
                              sep = ",",
                              col.names = c("Subject_ID",
                                            "Age_at_diagnosis",
                                            "Gender",
                                            "Smoking_status",
                                            "Cancer_stage",
                                            "Cancer_RNA_quality",
                                            "Cancer_RNASeq",
                                            "Normal_RNASeq",
                                            "Normal_ExomeSeq",
                                            "FUSION",
                                            "LN_Mets",
                                            "X"),
                              stringsAsFactors = FALSE)

# Remove the columns we won't be using so we don't have to deal with them
sample_metadata <- sample_metadata[, !(names(sample_metadata) %in% c("FUSION",
                                                                      "LN_Mets",
                                                                      "X"))]

# recode the different values in each column to be more human-readable
sample_metadata_recoded  <- sample_metadata %>%
    mutate(Gender = recode(Gender,
                           "1" = "male",
                           "2" = "female"),
           Smoking_status = recode(Smoking_status,
                                   "0" = "never",
                                   "1" = "previously",
                                   "2" = "current",
                                   "3" = "unknown"),
           Cancer_RNA_quality = recode(Cancer_RNA_quality,
                                       "0" = "poor",
                                       "1" = "good",
                                       "NE" = "Not Extracted"),
           Cancer_RNASeq = recode(Cancer_RNASeq,
                                  "0" = "no",
                                  "1" = "yes"),
           Normal_RNASeq = recode(Normal_RNASeq,
                                  "0" = "no",
                                  "1" = "yes"),
           Normal_ExomeSeq = recode(Normal_ExomeSeq,
                                    "0" = "no",
                                    "1" = "yes")
           )

# construct vector of paths to each of the sailfish quant files to read in
# and add names so that the sample names get added to the constructed table
files <- file.path(".", "output", "sailfish_quants", samples$Run_s, "quant.sf")
names(files) <- samples$Run_s

# error out if the files don't exist
stopifnot(all(file.exists(files)))

# load in and summarize all of the sailfish files, join into a single
# table summarized by gene (instead of transcript) and scale counts
txi <- tximport(files,
                type = "sailfish",
                tx2gene = tx2gene,
                countsFromAbundance = "lengthScaledTPM")

# print out a peak at this dataset to make sure it's ok
if (DEBUG) {
  txi$counts[1:4, 1:4]
  str(txi$counts)
}

# build the final melted/gathered long format table that includes all the
# counts for all the samples, by gene, joined to the two metadata tables
# we read in previously, filter out any where we don't have good metadata on
# the patients, since for this analysis we want to look at those variables
# and then finally select out the columns of interest, discarding the rest
# which are largely redundant and make the file size unacceptably large
final_table <- txi$counts %>%
    as.data.frame() %>%
    rownames_to_column() %>%
    rename(GeneName = rowname) %>%
    gather(key = "Sample",
           value = "counts_lengthScaledTPM",
           -GeneName) %>%
    left_join(samples, by = c("Sample" = "Run_s")) %>%
    mutate_if(is.factor, as.character) %>%
    mutate(normal_or_cancer = ifelse(!is.na(unlist(
                                          lapply(Sample_Name_s,
                                                 function(x) strsplit(x, "_")[[1]][3]))),
                                     "normal", "cancer")) %>%
    mutate(sample_id_all = paste(unlist(
               lapply(Sample_Name_s,
                      function(x) paste(strsplit(x, "_")[[1]][1:2],
                                        collapse = "_"))))) %>%
    left_join(sample_metadata_recoded,
              by = c("sample_id_all" = "Subject_ID")) %>%
    filter(!is.na(Age_at_diagnosis)) %>%
    select(GeneName,
           Sample,
           counts_lengthScaledTPM,
           Sample_Name_s,
           normal_or_cancer,
           sample_id_all,
           Age_at_diagnosis,
           Gender,
           Smoking_status,
           Cancer_stage,
           Cancer_RNA_quality,
           Cancer_RNASeq,
           Normal_RNASeq,
           Normal_ExomeSeq)

# write out the final table in zipped form to save space and make it fit into
# GitHub's file size limits
write.csv(final_table,
      file = gzfile("./output/final_compiled_counts/joined_count_data.csv.zip"),
      row.names = FALSE)
# also save the tibble as an RData file, which will be much faster to read in
# later and doesn't require the computationally expensive decompression step
# this is where the analysis will begin, using dplyr and ggplot
save(final_table,
     file = "./output/final_compiled_counts/joined_count_data.RData")

# to keep going with differential expression analysis, the next step would
# be to move this data over into DESeq2 or edgeR to calculate differential
# expression and etc.

# some references for that:
# https://www.biostars.org/p/143458/
# http://www.gettinggeneticsdone.com/2015/12/tutorial-rna-seq-differential.html
