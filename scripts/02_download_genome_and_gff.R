# Script to install the biomartr package and then use
# it to download a reference genome and annotations
# for the human genome from NCBI RefSeq 

# Following suggestions here:
# https://www.biostars.org/p/1796/
# and here:
# https://github.com/ropensci/biomartr

# source("http://bioconductor.org/biocLite.R")
# biocLite('biomartr')

biomartr::getGenome(db  = "refseq", organism = "Homo sapiens")
biomartr::getCDS(db  = "refseq", organism = "Homo sapiens")
biomartr::getRNA(db  = "refseq", organism = "Homo sapiens")
biomartr::getGFF(db  = "refseq", organism = "Homo sapiens")

