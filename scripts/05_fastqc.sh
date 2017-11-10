#!/bin/bash

# Run fastqc on all fastq files and save output to output dir, using 86 threads
# ...still takes a long time
# Naupaka Zimmerman
# nzimmerman@usfca.ed
# November 9, 2017

# Installation instructions and download of latest versions availablehere:
# https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
# NOTE: needs Java

fastqc data/raw_data/fastq/*.fastq --outdir output/fastqc -t 86
