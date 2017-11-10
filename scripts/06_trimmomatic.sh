#!/bin/bash

# trim paired end reads in parallel
# Info on the Trimmomatic tool available here:
# http://www.usadellab.org/cms/index.php?page=trimmomatic
# https://github.com/timflutre/trimmomatic

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 6, 2017

# call script like so: "bash 06_trimmomatic.sh data/fastq/*_1.fastq"
# meant to run for paired reads based on name of forward
# read (ends in "_1.fastq"), which determines how variants of output are
# determined

# requires TruSeq3-PE.fa file with Illumina adapters to be in the directory
# this file is in the 'misc' folder for this project
# this set of parameters is a bit stricter than the defaults
# e.g. we're trimming any reads that drop below 20 in a window size of 4
# defaults are to trim at 15 - this was based on evaluation of fastqc output
# of several dozen files in the project, which had not-outstanding QC scores
for file in "$@"; do
	TrimmomaticPE -threads 8 -basein $file \
		-baseout data/trimmed/$(basename -s _1.fastq $file).trim.fastq \
		ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 \
		SLIDINGWINDOW:4:20 MINLEN:50 &
done
