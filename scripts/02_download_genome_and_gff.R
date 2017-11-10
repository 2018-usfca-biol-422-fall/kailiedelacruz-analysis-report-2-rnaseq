#!/usr/bin/Rscript

# R Script to install the biomartr package (from Bioconductor) and then
# use it to download a reference genome, transcripts, and annotations
# for the human genome from NCBI RefSeq
# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 9, 2017

# Following suggestions here:
# https://www.biostars.org/p/1796/
# and here:
# https://github.com/ropensci/biomartr

# To install the library, run: source("http://bioconductor.org/biocLite.R")
# Then run: biocLite('biomartr')

biomartr::getGenome(db  = "refseq", organism = "Homo sapiens")
biomartr::getCDS(db  = "refseq", organism = "Homo sapiens")
biomartr::getRNA(db  = "refseq", organism = "Homo sapiens")
biomartr::getGFF(db  = "refseq", organism = "Homo sapiens")
