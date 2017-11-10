## Based on instructions here:
## http://bioconductor.org/packages/release/bioc/vignettes/tximport/inst/doc/tximport.html

## install needed packages
## source("https://bioconductor.org/biocLite.R")
## biocLite("tximport")
## biocLite("tximportData")

## tx2gene <- df[, 2:1]  # tx ID, then gene ID

library("tximport")
library("readr")
library("tximportData")
library("tidyr")
library("dplyr")
library("tibble")

tx2gene <- read.table("./transcript_to_gene_lookup_2cols.txt",
                      header = FALSE,
                      col.names =
                          c("TX-NAME", "GENE-NAME"))

samples <- read.table("./data/metadata/ERP001058_SraRunTable.txt",
                      header = TRUE,
                      sep = "\t")

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

sample_metadata <- sample_metadata[ , !(names(sample_metadata) %in% c("FUSION",
                                                                      "LN_Mets",
                                                                      "X"))]

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

summary(sample_metadata_recoded)

sample_metadata_recoded %>%
    mutate_if(is.character, as.factor) %>%
    summary()

files <- file.path("output", "sailfish_quants", samples$Run_s, "quant.sf")

names(files) <- samples$Run_s

all(file.exists(files))

txi <- tximport(files,
                type = "sailfish",
                tx2gene = tx2gene,
                countsFromAbundance = "lengthScaledTPM")

names(txi)

txi$counts[1:4, 1:4]

str(txi$counts)

final_table <- txi$counts %>%
    as.data.frame() %>%
    rownames_to_column() %>%
    rename(GeneName = rowname) %>%
    gather(key = "Sample",
           value = "counts_lengthScaledTPM",
           -GeneName) %>%
    left_join(samples, by = c("Sample" = "Run_s")) %>%
    left_join(sample_metadata_recoded,
              by = c("Sample_Name_s" = "Subject_ID")) %>%
    filter(!is.na(Age_at_diagnosis)) %>%
    select(GeneName,
           Sample,
           counts_lengthScaledTPM,
           Sample_Name_s,
           Age_at_diagnosis,
           Gender,
           Smoking_status,
           Cancer_stage,
           Cancer_RNA_quality,
           Cancer_RNASeq,
           Normal_RNASeq,
           Normal_ExomeSeq)

write.csv(final_table,
          file = gzfile("./output/final_compiled_counts/joined_count_data.csv.zip"),
          row.names = FALSE)

save(final_table,
     file = "./output/final_compiled_counts/joined_count_data.RData")
